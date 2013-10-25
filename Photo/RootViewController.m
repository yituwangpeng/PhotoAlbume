//
//  RootViewController.m
//  Photo
//
//  Created by lanou on 13-8-26.
//  Copyright (c) 2013年 MRfan826. All rights reserved.
//

#import "RootViewController.h"
#import "ImageView.h"
#import "SecondViewController.h"
@interface RootViewController ()

@end

@implementation RootViewController
static int flag = 0;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.view.backgroundColor = [UIColor greenColor];
    self.navigationItem.title = @"Photo";
    NSInteger x = 10;
    NSInteger y = 30;
    for (int i = 0; i < 3; i++) {
        for (int j = 0; j < 3; j++) {
            [self initImageViewWithFrame:CGRectMake(x, y, 80, 100) flag:flag];
            flag++;
            x += 110;
        }
        x = 10;
        y += 120;
    }
}
#pragma mark - 初始化ImageView
- (void)initImageViewWithFrame:(CGRect)frame flag:(NSInteger)flag{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doTap:)];
    ImageView *imageView = [[ImageView alloc] initWithFrame:frame];
    NSString *imageName = [NSString stringWithFormat:@"%d.jpg",flag];
    NSString *path = [[NSBundle mainBundle] pathForResource:imageName ofType:nil];
    imageView.title = flag;
    [imageView addGestureRecognizer:tap];
    imageView.userInteractionEnabled = YES;
    imageView.image = [UIImage imageWithContentsOfFile:path];
    [self.view addSubview:imageView];
    [tap release];
    [imageView release];
}
#pragma mark -  tap方法
- (void)doTap:(UITapGestureRecognizer *)tap {
    SecondViewController *second = [[SecondViewController alloc] init];
    ImageView *imageView = (ImageView *)tap.view;
    second.temp = imageView.title;
    [self.navigationController pushViewController:second animated:YES];
    [second release];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end







