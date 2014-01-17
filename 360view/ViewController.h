#import <UIKit/UIKit.h>

@interface ViewController : UIViewController 
{
    UIImageView *imageView;//展示图片
    CGPoint startPoint;//触摸的起始点
    CGPoint currentPoint;//手指移动到的点（时时改变）
    NSInteger imageIndex;//当前显示的图片index
}

@property (nonatomic,assign) CGPoint startPoint;
@property (nonatomic,assign) CGPoint movingPoint;
@property (nonatomic,assign) NSInteger imageIndex;
@property (nonatomic,retain) UIImageView *imageView;

@end
