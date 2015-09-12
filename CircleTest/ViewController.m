//
//  ViewController.m
//  CircleTest
//
//  Created by 李剑明 on 9/11/15.
//  Copyright © 2015 handos. All rights reserved.
//

#import "ViewController.h"
#import "JMCircleView.h"
#import "JMMathUtil.h"
@interface ViewController ()<JMCircleViewDelegate>

@property (assign) NSInteger kHeight;
@property (assign) NSInteger kWidth;


@end

@implementation ViewController
@synthesize kHeight;
@synthesize kWidth;

- (void)viewDidLoad {
    [super viewDidLoad];

            NSArray *colorArray=[NSArray arrayWithObjects:
                                   [UIColor colorWithRed:214.0/255.0 green:19.0/255.0 blue:33.0/255.0 alpha:1],//read
                                    [UIColor colorWithRed:63.0/255.0 green:183.0/255.0 blue:55.0/255.0 alpha:1],//green
                                 [UIColor colorWithRed:51.0/255.0 green:111.0/255.0 blue:183.0/255.0 alpha:1],
                              
                                 [UIColor colorWithRed:240.0/255.0 green:186.0/255.0 blue:20.0/255.0 alpha:1],nil
                                 ];
    
    CGRect screenRect=[UIScreen mainScreen].bounds;
    JMCircleView *circleView=[[JMCircleView alloc]initWithFrame:CGRectMake(0, 20, screenRect.size.width, screenRect.size.width)];
    circleView.innerCircleRadius=screenRect.size.width/6;
    circleView.sectorColorArray=colorArray;
    circleView.delegate=self;
    [self.view addSubview:circleView];
      
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)didClickZoneIndex:(int)index{

    self.lb_info.text=[NSString stringWithFormat:@"You click %i zone",index];
}

@end
