//
//  SecondViewController.h
//  Photo
//
//  Created by lanou on 13-8-26.
//  Copyright (c) 2013年 MRfan826. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecondViewController : UIViewController<UIScrollViewDelegate> {
    UIScrollView *scroll;
    UIScrollView *firstView;
    UIScrollView *secondView;
    UIScrollView *thirdView;
    NSInteger _current;
    NSInteger flag;
}
@property (nonatomic, assign) NSInteger temp;
@end
