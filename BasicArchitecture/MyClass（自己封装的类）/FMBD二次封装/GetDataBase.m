//
//  GetDataBase.m
//  SQ
//
//  Created by wangze on 14-3-24.
//  Copyright (c) 2014年 wangze. All rights reserved.
//

#import "GetDataBase.h"
#import "AssignToObject.h"

@implementation GetDataBase

@synthesize fmdb;
@synthesize fmrs;

static GetDataBase *dataBase = nil;

//得到数据库，单例的数据库
+ (GetDataBase *)shareDataBase
{
    if (!dataBase)
    {
        @synchronized(self)
        {
            if (!dataBase)
            {
                dataBase = [[GetDataBase alloc] init];
                NSString *dbPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Documents/ZJData.db"];
                NSLog(@"===%@===", dbPath);
                dataBase.fmdb = [FMDatabase databaseWithPath:dbPath];
                if (![dataBase.fmdb open])
                {
                    dataBase = nil;
                }
            }
        }
    }
    else //防止数据库被删除后就不能创建新的数据库了
    {
        //相当于创建数据库文件
        if (![dataBase.fmdb open])
        {
            dataBase = nil;
        }
    }
    return dataBase;
}


//判断表格是否存在
- (BOOL)isExistTable:(NSString *)className andTableNameSuffix:( NSString *)suffix
{
    BOOL value = NO;
    if ([fmdb tableExists:[self reallyTableName:className andTableNameSuffix:suffix]])
    {
        value = YES;
        NSLog(@"%@存在", [self reallyTableName:className andTableNameSuffix:suffix]);
    }
    return value;
}

//根据对象中的某个字段判断是否在数据库中存在
- (BOOL)isExistTable:(NSString *)className andTableNameSuffix:( NSString *)suffix andObject:(id)object andObjectAtIndex:(int)index
{
    BOOL value = NO;
    
    NSMutableString *sqlString = [NSMutableString string];
    NSString *propertyStr = [[AssignToObject propertyKeysWithString:className] objectAtIndex:index];
    [sqlString appendString:[NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@ = ?", [self reallyTableName:className andTableNameSuffix:suffix], propertyStr]];
    NSString *valueStr = [object valueForKey:propertyStr];
    dataBase.fmrs = [fmdb executeQuery:sqlString, valueStr];
    while ([fmrs next])
    {
        value = YES;
    }
    return value;
}

//根据对象中的两个字段判断是否在数据库中存在
- (BOOL)isTwoExistTable:(NSString *)className andTableNameSuffix:( NSString *)suffix andObject:(id)object andObjectAtIndex:(int)index andObjectAtIndex:(int)index1
{
    BOOL value = NO;
    
    NSMutableString *sqlString = [NSMutableString string];
    
    NSMutableArray *arr =[AssignToObject propertyKeysWithString:className];
    NSString *tempStr = [NSString stringWithFormat:@"SELECT * FROM %@ WHERE %@ = ? AND %@ = ?", [self reallyTableName:className andTableNameSuffix:suffix], [arr objectAtIndex:index], [arr objectAtIndex:index1]];
    [sqlString appendString:tempStr];
    
    NSString *str1 = [object valueForKey:[arr objectAtIndex:index]];
    NSString *str2 = [object valueForKey:[arr objectAtIndex:index1]];
    dataBase.fmrs = [fmdb executeQuery:sqlString, str1, str2];
    while ([fmrs next])
    {
        value = YES;
    }
    return value;
}


#pragma mark - 创建表格

//创建表格（会自动加上id作为主键）
- (void)CreateTableID:(NSString *)className andTableNameSuffix:( NSString *)suffix
{
    NSMutableString *sqlString = [NSMutableString string];
    [sqlString appendString:[NSString stringWithFormat:@"CREATE TABLE %@", [self reallyTableName:className andTableNameSuffix:suffix]]];
    [sqlString appendString:@"("];
    
    for (NSString *string in [AssignToObject propertyKeysWithString:className])
    {
        [sqlString appendString:string];
        [sqlString appendString:@", "];
    }
    [sqlString appendString:@"primaryId integer primary key autoincrement"];
    [sqlString appendString:@")"];
    NSLog(@"%@",sqlString);
    
    [fmdb executeUpdate:sqlString];
}

//获取真正的表名
- (NSString *)reallyTableName:(NSString *)className andTableNameSuffix:(NSString *)suffix
{
    if (suffix)
    {
        return [NSString stringWithFormat:@"%@%@",className,suffix];
    }
    return className;
}

//执行插入操作时，把model中的属性和值放到一个字典中。
- (BOOL)insertRecorderDataWithTableName:(NSString *)className andTableNameSuffix:( NSString *)suffix andModel:(id)object
{
    BOOL value = NO;
    
    BOOL exist = [[GetDataBase shareDataBase].fmdb tableExists:[self reallyTableName:className andTableNameSuffix:suffix]];
    if (!exist)
    {
        //如果数据库表不存在就先创建一个数据库表。
        [[GetDataBase shareDataBase] CreateTableID:className andTableNameSuffix:suffix];
    }
    
    NSMutableDictionary *dicData = [[NSMutableDictionary alloc] initWithCapacity:1];
    
    for (NSString *propertyStr in [AssignToObject propertyKeysWithString:className])
    {
        if ([object valueForKey:propertyStr])
        {
            [dicData setObject:[object valueForKey:propertyStr] forKey:propertyStr];
        }
    }
    
    NSLog(@"%@", dicData);
    
    //添加数据
    value = [[GetDataBase shareDataBase] InsertRecorderDataWithTableName:className andTableNameSuffix:( NSString *)suffix valuesDictionary:dicData];
    
    return value;
}

//通过Model数组建表
- (BOOL)insertRecorderDataWithTableName:(NSString *)className andTableNameSuffix:( NSString *)suffix andModelArray:(NSArray *)arr
{
    BOOL value = NO;
    
    BOOL exist = [[GetDataBase shareDataBase].fmdb tableExists:[self reallyTableName:className andTableNameSuffix:suffix]];
    if (!exist)
    {
        //如果数据库表不存在就先创建一个数据库表。
        [[GetDataBase shareDataBase] CreateTableID:className andTableNameSuffix:suffix];
    }
    
    //开启事务避免批量数据插入时候卡顿的情况
    [[[GetDataBase shareDataBase] fmdb] beginTransaction];
    
    for (id object in arr)
    {
        NSMutableDictionary *dicData = [[NSMutableDictionary alloc] initWithCapacity:1];
        
        for (NSString *propertyStr in [AssignToObject propertyKeysWithString:className])
        {
            if ([object valueForKey:propertyStr])
            {
                [dicData setObject:[object valueForKey:propertyStr] forKey:propertyStr];
            }
        }
        
        //添加数据
        value = [[GetDataBase shareDataBase] InsertRecorderDataWithTableName:className andTableNameSuffix:( NSString *)suffix valuesDictionary:dicData];
    }
    
    //事务开启后要有提交操作才能完整执行整个事务。
    [[[GetDataBase shareDataBase] fmdb] commit];
    
    return value;
}

- (BOOL)insertRecorderDataWithTableName:(NSString *)className andTableNameSuffix:( NSString *)suffix andDictionaryArray:(NSArray *)arr
{
    BOOL value = NO;
    
    //开启事务避免批量数据插入时候卡顿的情况
    [[[GetDataBase shareDataBase] fmdb] beginTransaction];
    
    for (NSMutableDictionary *dic in arr)
    {
        //添加数据
        value = [[GetDataBase shareDataBase] InsertRecorderDataWithTableName:className andTableNameSuffix:( NSString *)suffix valuesDictionary:dic];
    }
    
    //事务开启后要有提交操作才能完整执行整个事务。
    [[[GetDataBase shareDataBase] fmdb] commit];
    
    return value;
}


//把上个方法中的字典数据插入数据库
- (BOOL)InsertRecorderDataWithTableName:(NSString *)className andTableNameSuffix:( NSString *)suffix valuesDictionary:(NSMutableDictionary *)dic
{
    BOOL exist = [[GetDataBase shareDataBase].fmdb tableExists:[self reallyTableName:className andTableNameSuffix:suffix]];
    if (!exist)
    {
        //如果数据库表不存在就先创建一个数据库表。
        [[GetDataBase shareDataBase] CreateTableID:className andTableNameSuffix:( NSString *)suffix];
    }
    
    NSMutableString *sqlString = [NSMutableString string];
    [sqlString appendString:[NSString stringWithFormat:@"INSERT INTO %@", [self reallyTableName:className andTableNameSuffix:suffix]]];
    [sqlString appendString:@" ("];
    NSArray *array = [dic allKeys];
    for (NSString *string in array)
    {
        [sqlString appendString:string];
        [sqlString appendString:@","];
    }
    [sqlString deleteCharactersInRange:NSMakeRange([sqlString length] - 1, 1)];
    [sqlString appendString:@") VALUES ("];
    for (int i = 0; i < [array count]; ++i)
    {
        [sqlString appendString:@"?,"];
    }
    [sqlString deleteCharactersInRange:NSMakeRange([sqlString length]-1, 1)];
    [sqlString appendString:@")"];
    

    NSMutableArray *arr = [[NSMutableArray alloc] initWithCapacity:1];
    
    NSArray *allValusArr = [dic allValues];
    for (int i = 0; i < allValusArr.count; i++)
    {
        id obj = allValusArr[i];
        
        if (![obj isKindOfClass:[NSString class]])
        {
            obj = [NSString stringWithFormat:@"%@", obj];
        }
        [arr addObject:obj];
        
    }
    
    if ([fmdb executeUpdate:sqlString withArgumentsInArray:arr])
    {
        return YES;
    }
    return NO;
}


#pragma mark - 删除记录
//删除记录
- (void)DeleteRecordDataWithTableName:(NSString *)className andTableNameSuffix:( NSString *)suffix andDictionary:(NSMutableDictionary *)keyDic
{
    NSMutableString *sqlString = [NSMutableString string];
    [sqlString appendString:[NSString stringWithFormat:@"DELETE FROM %@ WHERE %@ LIKE ?", [self reallyTableName:className andTableNameSuffix:suffix], [[keyDic allKeys] objectAtIndex:0]]];
    
    NSInteger j = [[keyDic allKeys] count];
    
    if (j > 1)
    {
        for (int i = 1; i < j; ++i) {
            NSString *strKey = [[keyDic allKeys] objectAtIndex:i];
            
            [sqlString appendString:[NSString stringWithFormat:@" AND %@ LIKE ?", strKey]];
        }
    }
    
    [fmdb executeUpdate:sqlString withArgumentsInArray:[keyDic allValues]];
}


-(void)DeleteRecordFromTableName:(NSString *)className andTableNameSuffix:( NSString *)suffix
{
    NSString *sqlString = [NSString stringWithFormat:@"DELETE FROM %@", [self reallyTableName:className andTableNameSuffix:suffix]];
    [fmdb executeUpdate:sqlString];
}

#pragma mark - 修改记录

//修改记录
- (void)ModifyRecorderData:(NSString *)className andTableNameSuffix:( NSString *)suffix andNewDictionary:(NSMutableDictionary *)dic andOriginDictionary:(NSMutableDictionary *)keyDic;
{
    NSMutableString *sqlString = [NSMutableString string];
    [sqlString appendString:[NSString stringWithFormat:@"UPDATE %@ SET ",[self reallyTableName:className andTableNameSuffix:suffix]]];
    NSInteger m = [[dic allKeys] count];
    for (int i = 0; i < m; i++)
    {
        [sqlString appendString:[[dic allKeys] objectAtIndex:i]];
        [sqlString appendString:@" = ?, "];
        
    }
    [sqlString deleteCharactersInRange:NSMakeRange([sqlString length] - 2, 2)];
    
    [sqlString appendString:@" WHERE "];
    
    NSInteger j = [[keyDic allKeys] count];
    for (int i = 0; i < j; i++)
    {
        [sqlString appendString:[[keyDic allKeys] objectAtIndex:i]];
        [sqlString appendString:@" LIKE ? "];
        [sqlString appendString:@"AND "];
    }
    [sqlString deleteCharactersInRange:NSMakeRange([sqlString length] - 4, 4)];
    
    NSMutableArray *mutableArr = [[NSMutableArray alloc] initWithCapacity:1];
    for (NSString *str in [dic allValues])
    {
        [mutableArr addObject:str];
    }
    for (NSString *str in [keyDic allValues])
    {
        [mutableArr addObject:str];
    }
    
    [fmdb executeUpdate:sqlString withArgumentsInArray:mutableArr];
}


#pragma mark - 获取记录

- (NSMutableArray *)GetRecorderDataWithTableName:(NSString *)className andTableNameSuffix:( NSString *)suffix from:(NSString *)fromIdStr to:(NSString *)toIdStr
{
    //from 是指从哪个主键开始查询， to 是指查询到哪个主键结束。
    NSMutableArray *returnArray = [[NSMutableArray alloc] initWithCapacity:1];
    NSMutableString *sqlString = [NSMutableString string];
    
    [sqlString appendString:[NSString stringWithFormat:@"SELECT * FROM %@ WHERE id > ? AND id <= ?", [self reallyTableName:className andTableNameSuffix:suffix]]];
    dataBase.fmrs = [fmdb executeQuery:sqlString,fromIdStr,toIdStr];
    
    while ([fmrs next])
    {
        id user = [AssignToObject reflectDataFromOtherObject:fmrs
                                                andObjectStr:className];
        [returnArray addObject:user];
    }
    return returnArray;
}

//获取记录
- (NSMutableArray *)GetRecorderDataForTwoWithTableName:(NSString *)className andTableNameSuffix:( NSString *)suffix andDicitonary:(id)keyDic
{
    NSMutableArray *returnArray = [[NSMutableArray alloc] initWithCapacity:1];
    
    NSMutableString *sqlString = [NSMutableString string];
    [sqlString appendString:[NSString stringWithFormat:@"SELECT * FROM %@ WHERE ",[self reallyTableName:className andTableNameSuffix:suffix]]];
    
    NSInteger j = [[keyDic allKeys] count];
    for (int i = 0; i < j; i++)
    {
        [sqlString appendString:[[keyDic allKeys] objectAtIndex:i]];
        [sqlString appendString:@" LIKE ? "];
        [sqlString appendString:@"AND "];
    }
    [sqlString deleteCharactersInRange:NSMakeRange([sqlString length] - 4, 4)];
    
    
    dataBase.fmrs = [fmdb executeQuery:sqlString withArgumentsInArray:[keyDic allValues]];
    
    while ([fmrs next])
    {
        id user = [AssignToObject reflectDataFromOtherObject:fmrs
                                                andObjectStr:className];
        [returnArray addObject:user];
    }
    
    return returnArray;
}

//根据数据库的表名称查询数据库表中所有的数据对象
-(NSMutableArray *)GainTableRecoderID:(NSString *)className andTableNameSuffix:( NSString *)suffix
{
    NSMutableArray *returnArray = [[NSMutableArray alloc] initWithCapacity:1];
    NSMutableString *sqlString = [NSMutableString string];
    [sqlString appendString:[NSString stringWithFormat:@"SELECT * FROM %@", [self reallyTableName:className andTableNameSuffix:suffix]]];
    dataBase.fmrs = [fmdb executeQuery:sqlString];
    
    while ([fmrs next])
    {
        id user = [AssignToObject reflectDataFromOtherObject:fmrs
                                                andObjectStr:className];
        [returnArray addObject:user];
    }
    return returnArray;
}

@end
