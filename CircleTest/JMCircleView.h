//
//  UICicleView.h
//  CircleTest
//
//  Created by 李剑明 on 9/11/15.
//  Copyright © 2015 handos. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol JMCircleViewDelegate <NSObject>

@optional

-(void)didClickZoneIndex:(int)index;

@end

@interface JMCircleView : UIView

@property (nonatomic,strong) UIColor *innerCircleColor;
@property (nonatomic,assign) CGFloat innerCircleRadius;
@property (nonatomic,copy) NSArray *sectorColorArray;
@property (nonatomic) id<JMCircleViewDelegate> delegate;


-(void)setHiddenInnerCircle:(BOOL)isHidden;

@end
