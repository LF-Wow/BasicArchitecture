//
//  GetDataBase.h
//  SQ
//
//  Created by wangze on 14-3-24.
//  Copyright (c) 2014年 wangze. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "FMDatabaseAdditions.h"

@interface GetDataBase : NSObject

@property(nonatomic, strong) FMDatabase *fmdb;
@property(nonatomic, strong) FMResultSet *fmrs;

//得到数据库，单例的数据库
+ (GetDataBase *)shareDataBase;

//判断表格是否存在（className是表名）
- (BOOL)isExistTable:(NSString *)className andTableNameSuffix:( NSString *)suffix;

//根据对象中的一个字段判断是否在数据库中存在
- (BOOL)isExistTable:(NSString *)className andTableNameSuffix:( NSString *)suffix andObject:(id)object andObjectAtIndex:(int)index;

//根据对象中的两个字段判断是否在数据库中存在
- (BOOL)isTwoExistTable:(NSString *)className andTableNameSuffix:( NSString *)suffix andObject:(id)object andObjectAtIndex:(int)index andObjectAtIndex:(int)index;

#pragma mark - 创建表格
//创建表格（会自动加上id作为主键,fieldArray是字段）
- (void)CreateTableID:(NSString *)className andTableNameSuffix:( NSString *)suffix;

#pragma mark - 插入记录
//以model的形式请求插入用户数据
- (BOOL)insertRecorderDataWithTableName:(NSString *)className andTableNameSuffix:( NSString *)suffix  andModel:(id)object;

//以model数组的形式请求插入用户数据
- (BOOL)insertRecorderDataWithTableName:(NSString *)className andTableNameSuffix:( NSString *)suffix andModelArray:(NSArray *)arr;

//以字典数组的形式请求插入用户数据
- (BOOL)insertRecorderDataWithTableName:(NSString *)className andTableNameSuffix:( NSString *)suffix andDictionaryArray:(NSArray *)arr;

//插入记录k
- (BOOL)InsertRecorderDataWithTableName:(NSString *)className andTableNameSuffix:( NSString *)suffix valuesDictionary:(NSMutableDictionary *)dic;


#pragma mark - 删除记录
//删除记录(dic中包含了关键字段)
- (void)DeleteRecordDataWithTableName:(NSString *)className andTableNameSuffix:( NSString *)suffix andDictionary:(NSMutableDictionary *)dic;

//删除一个表中所有信息
-(void)DeleteRecordFromTableName:(NSString *)className andTableNameSuffix:( NSString *)suffix;

#pragma mark - 修改记录
//修改记录
- (void)ModifyRecorderData:(NSString *)className andTableNameSuffix:( NSString *)suffix andNewDictionary:(NSMutableDictionary *)dic andOriginDictionary:(NSMutableDictionary *)keyDic;


#pragma mark - 获取记录
- (NSMutableArray *)GetRecorderDataWithTableName:(NSString *)className andTableNameSuffix:( NSString *)suffix from:(NSString *)fromIdStr to:(NSString *)toIdStr;

- (NSMutableArray *)GetRecorderDataForTwoWithTableName:(NSString *)className andTableNameSuffix:( NSString *)suffix andDicitonary:(id)keyDic;

//返回数据库表中所有的数据对象
-(NSMutableArray *)GainTableRecoderID:(NSString *)className andTableNameSuffix:( NSString *)suffix;


@end
