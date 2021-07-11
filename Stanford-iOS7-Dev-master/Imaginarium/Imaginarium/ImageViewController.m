//
//  ImageViewController.m
//  Imaginarium
//
//  Created by Mark Lewis on 16-1-20.
//  Copyright (c) 2016年 TechLewis. All rights reserved.
//

#import "ImageViewController.h"

@interface ImageViewController ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIImage *image;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *spinner;

@end

@implementation ImageViewController


- (void)setScrollView:(UIScrollView *)scrollView
{
    _scrollView = scrollView;
    _scrollView.delegate = self;
    _scrollView.maximumZoomScale = 2.0;
    _scrollView.minimumZoomScale = 0.3;
    // 可能segue跳转的时候，scrollView的outlet没有建立好，跳转发生时scrollView还是nil
    self.scrollView.contentSize = self.image? self.image.size : CGSizeZero;
}

// implementation delegate method
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}

- (void)setImageURL:(NSURL *)imageURL
{
    _imageURL = imageURL;
    
    [self startDownloadingImage];
    // 代码会阻塞主线程
    // self.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:self.imageURL]];
}

- (void)startDownloadingImage
{
    if(self.imageURL)
    {
        // start task
        [self.spinner startAnimating];
        NSURLRequest *request = [NSURLRequest requestWithURL:self.imageURL];
        NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration ephemeralSessionConfiguration];
        NSURLSession *session = [NSURLSession sessionWithConfiguration:configuration];
        
        NSURLSessionDownloadTask *task = [session downloadTaskWithRequest:request
                                        completionHandler:^(NSURL *locationFile, NSURLResponse *response, NSError *error) {
                                            
                                            // important
                                            // 如果下载时间太久，必须要检查request的URL和用户目前选择的一致
                                            if (!error)
                                            {
                                                if ([request.URL isEqual:self.imageURL])
                                                {
                                                    NSData *imageData = [NSData dataWithContentsOfURL:locationFile];
                                                    [self performSelectorOnMainThread:@selector(setImage:) withObject:[UIImage imageWithData:imageData] waitUntilDone:NO];
                                                    // 这行代码与performSelectorOnMainThread效果相似
                                                    // dispatch_async(dispatch_get_main_queue(), ^{self.image = [UIImage imageWithData:imageData];});
                                                }
                                            }
                                            else
                                            {
                                                // 提示失败信息
                                            }
                                        }];
        
        // 要记得恢复挂起的task
        [task resume];
    }
}


#pragma mark - lazy initialization
- (UIImageView *)imageView
{
    if(!_imageView) _imageView = [[UIImageView alloc] init];
    return _imageView;
}

// 没有用@synthesize 合成实例变量，因为没有用到iVar
- (UIImage *)image
{
    return self.imageView.image;
}

- (void)setImage:(UIImage *)image
{
    self.imageView.image = image;
    [self.imageView sizeToFit];
    self.scrollView.contentSize = self.image? self.image.size : CGSizeZero;
    // 代码可能有问题，如果image是nil，给结构体赋值nil会有未定义的行为
    //self.scrollView.contentSize = self.imageView.bounds.size;
    
    // stop animation
    [self.spinner stopAnimating];
}

#pragma mark - ViewController Lifecycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.scrollView addSubview:self.imageView];
    self.imageURL = [NSURL URLWithString:@"http://images.ifanr.cn/wp-content/uploads/2016/01/20150610053722474.jpg"];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
