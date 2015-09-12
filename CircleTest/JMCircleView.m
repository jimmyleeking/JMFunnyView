//
//  UICicleView.m
//  CircleTest
//
//  Created by 李剑明 on 9/11/15.
//  Copyright © 2015 handos. All rights reserved.
//

#import "JMCircleView.h"
#import "JMMathUtil.h"
#define PI 3.14159265358979323846


static inline float radians(double degrees) { return degrees * PI / 180; }



@interface JMCircleView()
@property (nonatomic,assign) CGPoint centerPoint;
@property (nonatomic,assign) CGPoint clickedPoint;
@property (nonatomic,assign) BOOL isDrawClickedPoint;
@property (nonatomic,assign) BOOL isClickEvent;
@property (nonatomic,assign) CGFloat startAngle;
@property (nonatomic,assign) CGPoint prePoint;
@property (nonatomic,assign) BOOL isHiddenInnerCircle;



@end

@implementation JMCircleView

@synthesize centerPoint,clickedPoint,prePoint;
@synthesize isDrawClickedPoint;
@synthesize isClickEvent;
@synthesize startAngle;

-(instancetype)initWithFrame:(CGRect)frame{
    self=[super initWithFrame:frame];
     if(self)
     {
         self.opaque=NO;
         self.backgroundColor = [UIColor clearColor];
         self.innerCircleColor=[UIColor whiteColor];
     }
     return self;
}

-(void)setHiddenInnerCircle:(BOOL)isHidden{
    self.isHiddenInnerCircle=isHidden;
    [self setNeedsDisplay];
}


-(void)drawSector:(UIColor *)color startPoint:(CGPoint)startPoint startPie:(CGFloat)pieStart capacityPie:(CGFloat)pieCapacity{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);

    //CGContextSetRGBFillColor(context, 1.0, 0.0, 0.0, 1.0);
    //设置画笔颜色：黑色
    
    CGContextSetRGBStrokeColor(context, 1, 1, 1, 0);
    //设置画笔线条粗细
    CGContextSetLineWidth(context, 0.6);
    
    CGFloat startX=startPoint.x;
    CGFloat startY=startPoint.y;
    
    //扇形参数
    double radius=centerPoint.x;//半径

    int clockwise=0;//0=逆时针,1=顺时针
    
    //逆时针画扇形
    CGContextMoveToPoint(context, startX, startY);
    CGContextAddArc(context, startX, startY, radius, radians(pieStart), radians(pieStart+pieCapacity), clockwise);
    CGContextClosePath(context);
    CGContextDrawPath(context, kCGPathEOFillStroke);

}

-(void)drawRect:(CGRect)rect{
    
    centerPoint.x=rect.size.width/2;
    centerPoint.y=centerPoint.x;
    [self drawAllSector];
    if(self.innerCircleRadius<=0)
    {
        self.innerCircleRadius=rect.size.width/4;;
    }
    
    if(!self.isHiddenInnerCircle)
    {
        
        CGFloat startX=centerPoint.x-self.innerCircleRadius;
        CGFloat startY=centerPoint.y-self.innerCircleRadius;
        UIBezierPath *innerCirclePath=[UIBezierPath bezierPathWithOvalInRect:CGRectMake(startX, startY, self.innerCircleRadius*2, self.innerCircleRadius*2)];
        [self.innerCircleColor setFill];
        [[UIColor whiteColor]setStroke];
        [innerCirclePath fill];
        [innerCirclePath stroke];
    }
   
    
    
    //    if(isDrawClickedPoint)
    //    {
    //        CGFloat pointR=5;
    //        UIBezierPath *clickPointPath=[UIBezierPath bezierPathWithOvalInRect:CGRectMake(clickedPoint.x-pointR, clickedPoint.y-pointR, pointR*2, pointR*2)];
    //        [[UIColor blueColor]setFill];
    //        [clickPointPath fill];
    //    }
    //


    

    
  
}

//绘制所有扇区
-(void)drawAllSector{
    
    if(self.sectorColorArray)
    {
        
     
        double sectorStartAngle=startAngle;
        
        double divideAngle=360/self.sectorColorArray.count;
        for(int i=0;i<[self.sectorColorArray count];i++)
        {
            UIColor *color=[self.sectorColorArray objectAtIndex:i];
            double angle=sectorStartAngle+i*divideAngle;
            [self drawSector:color  startPoint:centerPoint startPie:angle capacityPie:divideAngle];
        }
    }
    
}





-(void)touchesBegan:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
    
    prePoint=[self processPoint:touches];
    clickedPoint=prePoint;
    isClickEvent=YES;
    
    [self setNeedsDisplay];
}

-(CGPoint)processPoint:(nonnull NSSet<UITouch *> *)touches{
    
    UITouch *touch=[touches anyObject];
    CGPoint point=[touch locationInView:self];
    if([self isInnerCircle:point])
    {
        clickedPoint=point;
        isDrawClickedPoint=YES;
        
    }else{
        isDrawClickedPoint=NO;
    }
    return point;
    
}

-(void)touchesMoved:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{
    
    
    CGPoint currentPoint=[self processPoint:touches];
    CGFloat angle=angleBetweenThreePoints(currentPoint, centerPoint, prePoint);
    double xVariance=[self getVariance:prePoint.x  second:currentPoint.x];
    double yVariance=[self getVariance:prePoint.y second:currentPoint.y];

    if(xVariance>yVariance)
    {
        if((currentPoint.x-prePoint.x)>=0)
        {
            if(currentPoint.y>centerPoint.y){
                 angle=-angle;
            }
            
        
            
        }else{
            if(currentPoint.y<centerPoint.y)
            {
                angle=-angle;
            }
        }

        
    }else{
        
        if((currentPoint.y-prePoint.y)>=0){

            if(currentPoint.x<=centerPoint.x)
            {
                angle=-angle;
            }
            
            
        }else{
            
            if(currentPoint.x>centerPoint.x)
            {
                angle=-angle;
            }
        }
        
        
       
    }
    startAngle+=angle;
    
    startAngle=startAngle-((int)(startAngle/360))*360;
    prePoint=currentPoint;

     isClickEvent=NO;
    [self setNeedsDisplay];
   
}




-(void)touchesEnded:(nonnull NSSet<UITouch *> *)touches withEvent:(nullable UIEvent *)event{

    UITouch *touch=[touches anyObject];
    CGPoint point=[touch locationInView:self];
    
    isDrawClickedPoint=NO;
    
    if(isClickEvent&&[self isInnerCircle:point]){
        
        int index=[self clickedInZoneIndex:point];
        NSLog(@"在哪一个区域%d",index);
        [self.delegate didClickZoneIndex:index];
    }
    
    [self setNeedsDisplay];
}


-(double)getVariance:(double)first second:(double)second{
    double ave=(second+first)/2;
    double variance=sqrt((first-ave)*(first-ave)+(second-ave)*(second-ave));
    return variance;
}


-(int)clickedInZoneIndex:(CGPoint)point{
    
    CGPoint pointStart=CGPointMake(centerPoint.x+10, centerPoint.y);
    double currentAngle=angleBetweenThreePoints(pointStart, centerPoint, point);
    int index=0;
    if(point.y<centerPoint.y)
    {
        currentAngle=360-currentAngle;
        
    }
    double roundAngle=currentAngle-startAngle;
    roundAngle=roundAngle-((int)(roundAngle/360))*360;
    if(roundAngle<0)
    {
        roundAngle+=360;
    }
    double divideAngle=360/self.sectorColorArray.count;
    index=((int)(fabs((int)(roundAngle)/divideAngle)))%self.sectorColorArray.count;
    
    return index;
}

//是否在内部圆中
-(BOOL)isInnerCircle:(CGPoint)point{
    
    CGFloat distanceR=distanceBetweenPoints(point, centerPoint);
    if(distanceR<centerPoint.x)
    {
        
        if(distanceR<self.innerCircleRadius)
        {
            //距离不在内圆,不做处理
            
        }else{
            //距离在之间,定位为不同的controller
            return YES;
            
        }
        
    }
    return FALSE;
}





@end
