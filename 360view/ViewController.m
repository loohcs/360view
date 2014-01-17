#import "ViewController.h"

//kShouldMoveWidth可用来控制移动速度,当移动10像素时更换图片
#define kShouldMoveWidth 10
//最后一张图片的名字为xxxxxx50.png
#define kImageMaxIndex 50
//第一张图片的名字为xxxxxxx0.png
#define kImageMinIndex 0
//图片名称，不包含索引和扩展名
#define kImageNamePrefix @"op11_x101_"

@implementation ViewController
@synthesize startPoint;
@synthesize movingPoint;
@synthesize imageIndex;
@synthesize imageView;

//记录手指移动的起始点
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch=[touches anyObject];
    startPoint = [touch locationInView:self.view];
}

//记录手指移动过程中的点，并跟起始点相减，当移动距离达到10像素时切换图片
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch=[touches anyObject];
    currentPoint = [touch locationInView:self.view];
    
    //计算移动的距离
    CGFloat movingDistance = startPoint.x - currentPoint.x;
    //向左移动
    if (movingDistance > 0) {
        //移动距离大于10像素时一会将显示下一张图片，并且将起始点设置为当前移动到的这个点，便于下次计算
        if (movingDistance > kShouldMoveWidth) {
            imageIndex++;
            startPoint.x = currentPoint.x;
        }
    }
    //向右移动
    else {
        //移动距离大于10像素时一会将显示上一张图片......
        if (-movingDistance > kShouldMoveWidth) {
            imageIndex--;
            startPoint.x = currentPoint.x;
        }
    }
    //下面的两个if语句的作用是使图片可以循环播放
    if(imageIndex > kImageMaxIndex) {
        imageIndex = kImageMinIndex;
    }
    
    if(imageIndex < kImageMinIndex) {
        imageIndex = kImageMaxIndex;
    }
    //根据上面修改的imageIndex得到图片名称
	NSString *currentImageName = @"";
	if (imageIndex < 10) {
        currentImageName = [[NSString alloc] initWithFormat:@"%@%@%d",kImageNamePrefix,@"0",imageIndex];
	}
	else {
        currentImageName = [[NSString alloc] initWithFormat:@"%@%d",kImageNamePrefix,imageIndex]; 
	}
    //改变当前显示图片
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:currentImageName ofType:@"png"];
    [currentImageName release];
	UIImage *currentImage = [UIImage imageWithContentsOfFile:imagePath];
	[self.imageView setImage:currentImage];	
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    imageIndex = 0;
    NSString *startImageName = [[NSString alloc] initWithFormat:@"%@%@",kImageNamePrefix,@"00.png"]; 
    //默认显示第一张图片
    UIImageView *temp = [[UIImageView alloc] initWithFrame:CGRectMake(0, 70, 1024, 654)];
    [temp setImage:[UIImage imageNamed:startImageName]];
    self.imageView = temp;
    [startImageName release];
    [temp release];
    [self.view addSubview:self.imageView];

}

- (void)viewDidUnload {
    [super viewDidUnload];
    self.imageView = nil;
}

- (void)dealloc {
    [imageView release];
    [super dealloc];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

@end
