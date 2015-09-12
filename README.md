# JMFunnyView
这是我做的一些有趣的iOS视图控件集合

##JMCircleView

一个可以可旋转，区域点击的圆盘视图。


![demo](https://raw.githubusercontent.com/jimmyleeking/JMFunnyView/master/DemoShowRes/JMCircle.gif)

###How to use


<code>
<pre>
//初始化需要分块的颜色数组，有多少种代表分多少块
NSArray *colorArray=[NSArray arrayWithObjects:
                                   [UIColor colorWithRed:214.0/255.0 green:19.0/255.0 blue:33.0/255.0 alpha:1],//read
                                    [UIColor colorWithRed:63.0/255.0 green:183.0/255.0 blue:55.0/255.0 alpha:1],//green
                                 [UIColor colorWithRed:51.0/255.0 green:111.0/255.0 blue:183.0/255.0 alpha:1],
                              
                                 [UIColor colorWithRed:240.0/255.0 green:186.0/255.0 blue:20.0/255.0 alpha:1],nil
                                 ];
//初始化View                              
JMCircleView *circleView=[[JMCircleView alloc]initWithFrame:CGRectMake(0, 20, screenRect.size.width, screenRect.size.width)];  

//设置内部圆的半径      
circleView.innerCircleRadius=screenRect.size.width/6;
//设置内部圆颜色的分块
circleView.sectorColorArray=colorArray;
//代理委托方法，用于响应点击色块的事件：
//index:点击色块的序号
//didClickZoneIndex:(int)index
circleView.delegate=self;
</pre>
</code>


