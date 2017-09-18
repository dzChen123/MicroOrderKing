//
//  MKNewGoodsController.m
//  MicroOrderKing
//
//  Created by 陈徳柱 on 17/7/31.
//  Copyright © 2017年 陈徳柱. All rights reserved.
//

#import "QiniuSDK.h"

#import "MKNewGoodsController.h"

#import "MKNewGoodsInfoView.h"

#import "MKOrderCellModel.h"

@interface MKNewGoodsController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end

@implementation MKNewGoodsController
{
    MKGoodsPicView *picView;
    MKNewGoodsInfoView *infoView;
    UIButton *saveButn;
    
    BOOL isEdit;
    UIImagePickerController *imagePickerController;
    NSString *smLogo;
    //UIImage *goodsImage;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    smLogo = @"";
    if (![self.topTitle isEqualToString:@"新增商品"]) {
        isEdit = YES;
    }
    
    WS(ws)
    
    picView.uploadEventBlock =^(){
        [ws goToPhotoLibrary];
    };
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
    if (isEdit) {
        [self loadEditionInfo];
    }
}

- (void)CreatView {
    smLogo = @"";
    picView = [[MKGoodsPicView alloc] init];
    infoView = [[MKNewGoodsInfoView alloc] init];
    saveButn = [[UIButton alloc] init];
    [picView setImage:[UIImage imageNamed:@"comManImg"]];
    
    [self addSubview:picView];
    [self addSubview:infoView];
    [self addSubview:saveButn];
}

- (void)updateViewConstraints {
    
    WS(ws)
    
    [picView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(ws.view);
        make.top.mas_equalTo(ws.topView.mas_bottom);
    }];
    
    [infoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(ws.view);
        make.top.mas_equalTo(picView.mas_bottom).offset(15 * autoSizeScaleH);
    }];

    [saveButn setTitle:[self.topTitle isEqualToString:@"新增商品"] ? @"保存" : @"修改" forState:UIControlStateNormal];
    [saveButn addTarget:self action:@selector(saveClick) forControlEvents:UIControlEventTouchUpInside];
    [saveButn setTitleColor:customWhite forState:UIControlStateNormal];
    saveButn.titleLabel.font = FONT(16);
    saveButn.backgroundColor = themeGreen;
    [saveButn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.mas_equalTo(ws.view);
        make.height.mas_equalTo(45 * autoSizeScaleH);
    }];
    
    [super updateViewConstraints];
}

- (void)loadEditionInfo {
    NSMutableDictionary *plist = [[NSMutableDictionary alloc] init];
    [AFNetWorkingUsing httpGet:[NSString stringWithFormat:@"goods/%@/edit",_goodsId] params:plist success:^(id json) {
        MKGoodsInfoModel *model = [MKGoodsInfoModel mj_objectWithKeyValues:[json objectForKey:@"data"]];
        [infoView setData:model];
        NSString *urlStr = [model.imgUrl stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        [picView setImageWithURL:urlStr];
    } fail:^(NSError *error) {
        
    } other:^(id json) {
        [self.hud showTipMessageAutoHide:@"商品信息加载失败"];
    }];
}

- (void)saveClick {
    NSString *name,*price,*unit,*number;
    NSArray *infoArr = [infoView getGoodsInfo];
    name = infoArr[0];
    price = infoArr[1];
    unit = infoArr[2];
    number = infoArr[3];
    if (!name.length) {
        [self.hud showTipMessageAutoHide:@"请输入商品名"];
        return;
    }
    if (!price.length) {
        [self.hud showTipMessageAutoHide:@"请输入价格"];
        return;
    }
    if (!unit.length) {
        [self.hud showTipMessageAutoHide:@"请输入商品单位"];
        return;
    }
    if (!number.length) {
        [self.hud showTipMessageAutoHide:@"请输入库存"];
        return;
    }
    NSMutableDictionary *plist = [[NSMutableDictionary alloc] init];
    [plist setObject:name forKey:@"name"];
    [plist setObject:price forKey:@"price"];
    [plist setObject:unit forKey:@"unit"];
    [plist setObject:number forKey:@"number"];
    if (smLogo.length > 0) {
        [plist setObject:smLogo forKey:@"sm_logo"];
    }
    if (isEdit) {
        //[plist setObject:@"" forKey:@"sm_logo"];
        [AFNetWorkingUsing httpPut:[NSString stringWithFormat:@"goods/%@",_goodsId] params:plist success:^(id json) {
            [self.hud showTipMessageAutoHide:@"修改成功"];
            [self.navigationController popViewControllerAnimated:YES];
        } fail:^(NSError *error) {
            
        } other:^(id json) {
            [self.hud showTipMessageAutoHide:[json objectForKey:@"msg"]];
        }];
    }else{
        [AFNetWorkingUsing httpPost:@"goods" params:plist success:^(id json) {
            
            [self.hud showTipMessageAutoHide:@"添加成功"];
            
            [self.navigationController popViewControllerAnimated:YES];
            
        } fail:^(NSError *error) {
            
        } other:^(id json) {
            
            [self.hud showTipMessageAutoHide:[json objectForKey:@"msg"]];
        
        }];
    }
}

- (void)goToPhotoLibrary {
    imagePickerController = [[UIImagePickerController alloc] init];
    imagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    imagePickerController.delegate = self;
    imagePickerController.allowsEditing = YES;
    [self presentViewController:imagePickerController animated:YES completion:nil];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [imagePickerController dismissViewControllerAnimated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info{
    [self saveImage:info[UIImagePickerControllerOriginalImage]];
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void)saveImage:(UIImage *)img {
    NSData *imageData;
    if (UIImagePNGRepresentation(img) == nil) {
        imageData = UIImageJPEGRepresentation(img, 1.0);
    } else {
        imageData = UIImagePNGRepresentation(img);
    }
    [self.hud showWaitHudWithMessage:@"储存中"];
    NSMutableDictionary *plist = [[NSMutableDictionary alloc] init];
    [AFNetWorkingUsing httpGet:@"user/upload/qiniuToken" params:plist success:^(id json) {
        NSDictionary *dic = [json objectForKey:@"data"];
        NSString *token = [dic objectForKey:@"token"];
        NSString *key = [[self GetRandomStr] stringByAppendingString:@".png"];
        QNUploadManager *upLoadManager = [[QNUploadManager alloc] init];
        [upLoadManager putData:imageData key:key token:token complete:^(QNResponseInfo *info, NSString *key, NSDictionary *resp) {
            smLogo = key;
            [self.hud hideAnimated:YES];
            [self.hud showTipMessageAutoHide:@"图片上传成功"];
            [picView setImage:img];
        } option:nil];
    } fail:^(NSError *error) {
        [self.hud hideAnimated:YES];
    } other:^(id json) {
        [self.hud hideAnimated:YES];
        [self.hud showTipMessageAutoHide:[json objectForKey:@"msg"]];
    }];
}

-(NSString *)GetRandomStr{                       //获取13位随机字符串+当前时间作为key
    NSString *result = [[NSString alloc]init];
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:@"YYYY-MM-dd-HH:mm:ss-"];
    result = [formatter stringFromDate:currentDate];
    for (int i = 0 ; i < 13; i ++ ) {
        int figure = (arc4random()%26) + 97;
        char c = figure;
        NSString *temp = [NSString stringWithFormat:@"%c",c];
        result = [NSString stringWithFormat:@"%@%@",result,temp];
    }
    [result dataUsingEncoding:NSUTF8StringEncoding];
    return result;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
