# DMSubmitView



[![License MIT](https://img.shields.io/badge/license-MIT-green.svg?style=flat)](https://github.com/DMDavid/SubmitView/blob/master/LICENSE)&nbsp;

## A submit progress Hud view

### CocoaPods

1. Add `pod 'DMSubmitView'` to your Podfile.
2. Run `pod install` or `pod update`.


## rendering:
效果图:
 ![image](https://github.com/DMDavid/SubmitView/blob/master/SubmitView/rendering.gif)


## How to use

1. init view

        _sub = [[SubmitView alloc] initWithFrame:CGRectMake(0, 0, 300, 60)];
        _sub.center = self.view.center;
        _sub.delegate = self;
        [self.view addSubview:_sub];
        
2. update progress 

       [self.sub updateProgressViewWitCurrenthData:currentCount totalData:totalCount];
       
       
       
## Main mothods

### DMSubmitView

          @protocol DMSubmitViewDelegate <NSObject>
          @optional
          //the view is start show progress view call back
          - (void)submitViewStartShowProgressViewStatus;

          @end

          @interface DMSubmitView : UIView

          //delegaet
          @property (nonatomic, weak) id <DMSubmitViewDelegate> delegate;

          //current progress float
          @property (nonatomic, assign, readonly) CGFloat currentProgressFloat;

          //current total float
          @property (nonatomic, assign, readonly) CGFloat totalProgressFloat;

          //update pregress view
          //更新进度
          - (void)updateProgressViewWitCurrenthData:(CGFloat)currentData totalData:(CGFloat)totalData;

         
## DMProgressView

* also you can use circle progress for your porject 


          @protocol DMProgressViewDelegate <NSObject>
          @optional
          // the progress circle is completion call back
          - (void)progressViewCompletionCallBack;

          @end

          @interface DMProgressView : UIView

          //line width
          @property(nonatomic, assign) CGFloat arcLineWith;

          //delegate
          @property (nonatomic, weak) id <DMProgressViewDelegate> delegate;

          /*
           *  init
           */
          - (DMProgressView *)initWithProgressViewWithFrame:(CGRect)frame
                                                  timeout:(CGFloat)timeout
                                                   radius:(CGFloat)radius
                                                layerWith:(CGFloat)layerWith;

          /*
           *  更新进度
           */
          - (void)updateProgressViewWitCurrenthData:(CGFloat)currentData totalData:(CGFloat)totalData;



