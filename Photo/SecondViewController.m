//
//  SecondViewController.m
//  Photo
//
//  Created by lanou on 13-8-26.
//  Copyright (c) 2013年 MRfan826. All rights reserved.
//

#import "SecondViewController.h"
#define kCGRect CGRectMake(0, 0, 320, 460)
#define kNumber 9
@interface SecondViewController ()

@end

@implementation SecondViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {      
    }
    return self;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    flag = self.temp;
    self.navigationItem.title = [NSString stringWithFormat:@"第%d张图片",flag+1];
	self.view.backgroundColor = [UIColor blackColor];
    scroll = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    scroll.pagingEnabled = YES;
    scroll.delegate = self;
    scroll.contentSize = CGSizeMake(320*3, 460);
    scroll.contentOffset = CGPointMake(320, 0);
    [self.view addSubview:scroll];
    
    firstView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
    if (flag == 0) {
        [self initImageViewWithFrame:kCGRect next:8 ScrollView:firstView];
    }else {
        [self initImageViewWithFrame:kCGRect next:flag-1 ScrollView:firstView];
    }
    secondView = [[UIScrollView alloc] initWithFrame:CGRectMake(320, 0, 320, 460)];

    [self initImageViewWithFrame:kCGRect next:flag ScrollView:secondView];
 
    thirdView = [[UIScrollView alloc] initWithFrame:CGRectMake(640, 0, 320, 460)];
    if (flag == 8) {
        [self initImageViewWithFrame:kCGRect next:0 ScrollView:thirdView];
    }else {
        [self initImageViewWithFrame:kCGRect next:flag+1 ScrollView:thirdView];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"123");
    if (scroll.contentOffset.x <= 160 ) {
        self.navigationItem.title = [NSString stringWithFormat:@"第%d张图片",(flag-1+9)%9+1];
    }else if(scroll.contentOffset.x >= 480) {
        self.navigationItem.title = [NSString stringWithFormat:@"第%d张图片",(flag+1)%9+1];
    }
    if (scroll.contentOffset.x >= 640 || scroll.contentOffset.x <= 0) {
        _current = scrollView.contentOffset.x / 320;
        switch (_current) {
            case 0:
                [self turnRight];
                break;
            case 1:
                break;
            case 2:
                [self turnLeft];
                break;
            default:
                break;
        }
        scrollView.contentOffset = CGPointMake(320, 0);
    }
}
#pragma mark - 往右移,显示左边的图片
- (void)turnRight {
    flag--;
    UIScrollView *tempScrollView;
    tempScrollView = firstView;
    CGRect temp = firstView.frame;
    firstView.frame = secondView.frame;
    secondView.frame = thirdView.frame;
    thirdView.frame = temp;
    firstView = thirdView;
    thirdView = secondView;
    secondView = tempScrollView;
    NSInteger next = (flag-1+kNumber)%kNumber;
    [self initImageViewWithScrollView:firstView next:next];
    flag = next+1;
}
#pragma mark - 往左移,显示右边的图片
- (void)turnLeft {
    flag++;
    UIScrollView *tempScrollView;
    tempScrollView = firstView;
    CGRect temp = firstView.frame;
    firstView.frame = thirdView.frame;
    thirdView.frame = secondView.frame;
    secondView.frame = temp;
    firstView = secondView;
    secondView = thirdView;
    thirdView = tempScrollView;
    NSInteger next = (flag+1)%kNumber;
    [self initImageViewWithScrollView:thirdView next:next];
    flag = next-1;
}
#pragma mark - 初始化ImageVIew方法
- (void)initImageViewWithScrollView:(UIScrollView *)scrollView next:(NSInteger)next {
    UIImageView *imageView = [scrollView.subviews objectAtIndex:0];
    NSString *imageName = [NSString stringWithFormat:@"%d.jpg",next];
    NSString *path = [[NSBundle mainBundle] pathForResource:imageName ofType:nil];
    imageView.image = [UIImage imageWithContentsOfFile:path];
}
#pragma mark - 初始化ImageVIew方法
- (void)initImageViewWithFrame:(CGRect)frame next:(NSInteger)next ScrollView:(UIScrollView *)scrollView {
    
    UIImageView *imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
    NSString *imageName = [NSString stringWithFormat:@"%d.jpg",next];
    NSString *path = [[NSBundle mainBundle] pathForResource:imageName ofType:nil];
    imageView1.image = [UIImage imageWithContentsOfFile:path];
    imageView1.userInteractionEnabled = YES;
    [scrollView addSubview:imageView1];
    [scroll addSubview:scrollView];
    [imageView1 release];
}
- (void)dealloc {
    [scroll release];
    [firstView release];
    [secondView release];
    [thirdView release];
    [super dealloc];
}
@end