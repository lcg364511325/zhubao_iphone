//
//  customtailor.m
//  zhubao_iphone
//
//  Created by johnson on 14-9-17.
//  Copyright (c) 2014年 SUNYEARS___FULLUSERNAME. All rights reserved.
//

#import "customtailor.h"
#import "AppDelegate.h"
#import "decorateView.h"

@interface customtailor ()

@end

@implementation customtailor

@synthesize fpicimg;
@synthesize spicimg;
@synthesize tpicimg;
@synthesize texttureText;
@synthesize weightText;
@synthesize mainweiText;
@synthesize maincountText;
@synthesize fitweiText;
@synthesize fitcountText;
@synthesize sizeText;
@synthesize fontText;
@synthesize texttureTView;

@synthesize pdSView;
@synthesize pdetailView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

//-(void)viewWillAppear:(BOOL)animated
//{
//    [self resetdata:nil];
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //设置scrollview属性
    [pdSView addSubview:pdetailView];
    pdSView.contentSize=CGSizeMake(320, pdetailView.frame.size.height);
    pdSView.showsHorizontalScrollIndicator=NO;//不显示水平滑动线
    pdSView.showsVerticalScrollIndicator=YES;//不显示垂直滑动线
    pdSView.scrollEnabled=YES;
    
    
    texttureText.userInteractionEnabled=YES;
    textturelist=[[NSArray alloc] initWithObjects:@"18K黄", @"18K白",
                  @"18K双色", @"18K玫瑰金", @"PT900", @"Pt950", @"PD950",nil];
    texttureText.text=@"18K黄";
    
    weightText.keyboardType=UIKeyboardTypeDecimalPad;
    mainweiText.keyboardType=UIKeyboardTypeDecimalPad;
    maincountText.keyboardType=UIKeyboardTypeDecimalPad;
    fitweiText.keyboardType=UIKeyboardTypeDecimalPad;
    fitcountText.keyboardType=UIKeyboardTypeDecimalPad;
    sizeText.keyboardType=UIKeyboardTypeDecimalPad;
    
    
}

// 材质下拉框
- (IBAction)mianselect:(id)sender
{
    texttureTView.frame=CGRectMake(52, 231, 97, 134);
    texttureTView.hidden=NO;
}

-(float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [textturelist count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *TableSampleIdentifier = @"TableSampleIdentifier";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:
                             TableSampleIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleDefault
                reuseIdentifier:TableSampleIdentifier];
    }
    
    NSUInteger row = [indexPath row];
    cell.textLabel.text = [textturelist objectAtIndex:row];
    cell.textLabel.font=[UIFont systemFontOfSize:12.0f];
    cell.textLabel.textColor=[UIColor colorWithRed:102.0f/255.0f green:102.0f/255.0f blue:102.0f/255.0f alpha:1.0f];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *rowString = [textturelist objectAtIndex:[indexPath row]];
    texttureText.text=rowString;
    texttureTView.hidden=YES;
}


//点击其他地方隐藏tableview
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    UITouch *touch = [touches anyObject];
    CGPoint pt = [touch locationInView:self.view];
    //点击其他地方消失
    if (!CGRectContainsPoint([texttureTView frame], pt)) {
        //to-do
        texttureTView.hidden=YES;
    }
    
    [texttureText resignFirstResponder];
    [weightText resignFirstResponder];
    [mainweiText resignFirstResponder];
    [maincountText resignFirstResponder];
    [fitweiText resignFirstResponder];
    [fitcountText resignFirstResponder];
    [sizeText resignFirstResponder];
    [fontText resignFirstResponder];
    oldframe=self.view.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
}

//重置数据
-(IBAction)resetdata:(id)sender
{
    texttureText.text=@"18K黄";
    weightText.text=nil;
    mainweiText.text=nil;
    maincountText.text=nil;
    fitweiText.text=nil;
    fitcountText.text=nil;
    sizeText.text=nil;
    fontText.text=nil;
    fpicimg.image=[UIImage imageNamed:@"imagec"];
    spicimg.image=[UIImage imageNamed:@"imagef"];
    tpicimg.image=[UIImage imageNamed:@"imagez"];
    pic1=nil;
    pic2=nil;
    pic3=nil;
}


//确认定制
-(IBAction)orderOfGoods:(id)sender
{
    if (!pic1 && !pic2 && !pic3) {
        NSString *rowString =@"至少要选择一张图片！";
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
        return;
    }
    NSString * pgoldtypett=[NSString stringWithFormat:@"%@",texttureText.text];
    
    
    sqlService * sql=[[sqlService alloc] init];
    AppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
    buyproduct * entity=[[buyproduct alloc]init];
    entity.producttype=@"9";
    entity.customerid=myDelegate.entityl.uId;
    entity.photos=pic1;
    entity.photom=pic2;
    entity.photob=pic3;
    entity.pgoldtype=pgoldtypett;
    
    entity.pcount=@"1";
    entity.pweight=weightText.text;
    entity.Dia_Z_weight=mainweiText.text;
    entity.Dia_Z_count=maincountText.text;
    entity.Dia_F_weight=fitweiText.text;
    entity.Dia_F_count=fitcountText.text;
    entity.psize=sizeText.text;
    entity.pdetail=fontText.text;
    buyproduct *successadd=[sql addToBuyproduct:entity];
    if (successadd) {
        [_mydelegate performSelector:@selector(refleshBuycutData)];
        NSString *rowString =@"成功加入购物车！";
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
        
    } else{
        NSString *rowString =@"加入购物车失败！";
        UIAlertView * alter = [[UIAlertView alloc] initWithTitle:@"提示" message:rowString delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
        [alter show];
    }
}

//选择图片
- (IBAction)chooseImage:(id)sender {
    
    UIActionSheet *sheet;
    
    sheet = [[UIActionSheet alloc] initWithTitle:@"选择" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"取消" otherButtonTitles:@"从相册选择", nil];
    
    sheet.tag = 255;
    [sheet showInView:[UIApplication sharedApplication].keyWindow];
    UIButton * btn=(UIButton *)sender;
    pictag=[btn tag];
}

#pragma mark - 保存图片至沙盒
- (void) saveImage:(UIImage *)currentImage withName:(NSString *)imageName
{
    
    NSData *imageData = UIImageJPEGRepresentation(currentImage, 0.5);
    // 获取沙盒目录
    
    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
    
    // 将图片写入文件
    
    [imageData writeToFile:fullPath atomically:NO];
}

#pragma mark - image picker delegte
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	[picker dismissViewControllerAnimated:YES completion:^{}];
    
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    NSString *fullPath =nil;
    //记录文件
    
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[[NSDate date] timeIntervalSince1970]];
    if (pictag==0) {
        NSString *pic1name=[NSString stringWithFormat:@"%@1.png",timeSp];
        [self saveImage:image withName:pic1name];
        
        fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:pic1name];
        pic1=fullPath;
    }
    else if (pictag==1)
    {
        NSString *pic2name=[NSString stringWithFormat:@"%@2.png",timeSp];
        [self saveImage:image withName:pic2name];
        
        fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:pic2name];
        pic2=fullPath;
    }
    else if (pictag==2){
        
        NSString *pic3name=[NSString stringWithFormat:@"%@3.png",timeSp];
        [self saveImage:image withName:pic3name];
        
        fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:pic3name];
        pic3=fullPath;
    }
    
    UIImage *savedImage = [[UIImage alloc] initWithContentsOfFile:fullPath];
    
    isFullScreen = NO;
    if (pictag==0) {
        [fpicimg setImage:savedImage];
        
        fpicimg.tag = 100;
    }else if (pictag==1)
    {
        [spicimg setImage:savedImage];
        
        spicimg.tag = 100;
    }else if (pictag==2){
        [tpicimg setImage:savedImage];
        
        tpicimg.tag = 100;
    }
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
	[self dismissViewControllerAnimated:YES completion:^{}];
}


#pragma mark - actionsheet delegate
-(void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 255) {
        
        NSUInteger sourceType = 0;
        
        // 判断是否支持相机
        if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            
            switch (buttonIndex) {
                case 0:
                    // 取消
                    return;
                case 1:
                    // 相册
                    sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                    break;
                    
                case 2:
                    // 相机
                    sourceType = UIImagePickerControllerSourceTypeCamera;
                    break;
            }
        }
        else {
            if (buttonIndex == 0) {
                
                return;
            } else {
                sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            }
        }
        // 跳转到相机或相册页面
        UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
        
        imagePickerController.delegate = self;
        
        imagePickerController.allowsEditing = YES;
        
        imagePickerController.sourceType = sourceType;
        
        
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            
            UIPopoverController *popover = [[UIPopoverController alloc] initWithContentViewController:imagePickerController];
            popoverController = popover;
            [popoverController presentPopoverFromRect:CGRectMake(0, 0, 300, 300) inView:self.view permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
            
        } else {
            [self presentViewController:imagePickerController animated:YES completion:^{}];
        }
        
    }
}


-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    frame = textField.frame;
    if (oldframe.origin.y!=frame.origin.y) {
        int offset = frame.origin.y + 32 - (self.view.frame.size.height - 216.0);//键盘高度216
        
        NSTimeInterval animationDuration = 0.30f;
        [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
        [UIView setAnimationDuration:animationDuration];
        
        //将视图的Y坐标向上移动offset个单位，以使下面腾出地方用于软键盘的显示
        if(offset > 0)
            self.view.frame = CGRectMake(0.0f, -offset, self.view.frame.size.width, self.view.frame.size.height);
        
        [UIView commitAnimations];
        oldframe=frame;
    }
}

-(void)textFieldDidEndEditing:(UITextField *)textField
{
    if (oldframe.origin.y!=frame.origin.y) {
        self.view.frame =CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
