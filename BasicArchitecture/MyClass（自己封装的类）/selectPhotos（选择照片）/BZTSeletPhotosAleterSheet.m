//
//  BZTSeletPhotosAleterSheet.m
//  TYZJ
//
//  Created by apple on 2017/5/8.
//  Copyright © 2017年 周君. All rights reserved.
//

#import "BZTSeletPhotosAleterSheet.h"
#import <TZImagePickerController.h>
#import "MMPopup.h"

static NSInteger count = 1;
static BZTSeletPhotosAleterSheet *sheet;

@interface BZTSeletPhotosAleterSheet ()< UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@end

@implementation BZTSeletPhotosAleterSheet

+ (instancetype)shareConfigWithMaxImagesCount:(NSInteger)imagesCount
{
    count = imagesCount;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sheet = [BZTSeletPhotosAleterSheet new];
    });
    [sheet selectPhotosViewShow];
    return sheet;
}



- (void)selectPhotosViewShow
{
    MMPopupItemHandler block = ^(NSInteger index){
        
        switch (index) {
            case 0:
            {
                if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
                {
                    UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
                    imagePickerController.delegate = self;
                    imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
                    [[ToolsObject getCurrentVC] presentViewController:imagePickerController animated:YES completion:nil];
                }
                else
                {
                    [[[UIAlertView alloc] initWithTitle:@"无法打开摄像头" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil] show];
                }
            }
                break;
            case 1:
            {
                TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:count delegate:nil];
                
                imagePickerVc.naviBgColor = UIColorFromRGB(themColor);
                __weak typeof(self) weakSelf = self;
                [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos,NSArray *assets,BOOL isSelectOriginalPhoto){
                    weakSelf.selectPhotosBlock(photos);
                }];
                [[ToolsObject getCurrentVC] presentViewController:imagePickerVc animated:YES completion:nil];
                
            }
                break;
            default:
                break;
        }
    };
    
    NSArray *items =
    @[MMItemMake(@"拍照", MMItemTypeNormal, block),
      MMItemMake(@"手机相册", MMItemTypeNormal, block)];
    
    MMSheetView *sheetView = [[MMSheetView alloc] initWithTitle:nil
                                                          items:items];
    [sheetView show];
}

//告诉委托,用户选择了一个静态图像或电影。
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    //让选中的图片代替程序中的ImageView，通过键值对
    UIImage *image = [info objectForKey:@"UIImagePickerControllerEditedImage"];
    
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera)
    {
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    }
    
    self.selectPhotosBlock(@[image]);
    
    [[ToolsObject getCurrentVC] dismissViewControllerAnimated:YES completion:nil];
}

//点击取消执行的动作。
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [[ToolsObject getCurrentVC] dismissViewControllerAnimated:YES completion:nil];
}


@end
