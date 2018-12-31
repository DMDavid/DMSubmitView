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

        //submit button Did Click
        - (void)submitViewButtonDidClick;

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

        //setup show
        - (void)setupSubmitViewTitle:(NSString *)title;

        //setup label font
        - (void)setupSubmitViewFont:(UIFont *)font;

        //setup label text color
        - (void)setupSubmitViewTextColor:(UIColor *)textColor;

        //setup subview button color,
        //default is [UIColor colorWithRed:33.0/255.0 green:197.0/255.0 blue:131.0/255.0 alpha:1]
        - (void)setupSubmitViewButtonColor:(UIColor *)buttonColor;

        //setup subview button blod color,
        //default is [UIColor colorWithRed:172.0/255.0 green:172.0/255.0 blue:172.0/255.0 alpha:1]
        - (void)setupSubmitViewButtonBlodColor:(UIColor *)blodColor;
         
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



