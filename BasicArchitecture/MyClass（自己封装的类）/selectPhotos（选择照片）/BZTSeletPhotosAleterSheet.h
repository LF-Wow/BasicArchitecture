//
//  BZTSeletPhotosAleterSheet.h
//  TYZJ
//
//  Created by apple on 2017/5/8.
//  Copyright © 2017年 周君. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^selectPhotosBlock)(NSArray<UIImage *> *imageArray);
@interface BZTSeletPhotosAleterSheet : NSObject

/** 图片数组*/
@property (nonatomic, copy)selectPhotosBlock selectPhotosBlock;

+ (instancetype)shareConfigWithMaxImagesCount:(NSInteger)imagesCount;

@end
