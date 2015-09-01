//
//  ViewController.m
//  CurveAndJaggedView
//
//  Created by 李文龙 on 15/9/1.
//  Copyright (c) 2015年 李文龙. All rights reserved.
//

#import "ViewController.h"
#import "CurveBorderView.h"

@interface ViewController ()
{
    
}
@property (weak, nonatomic) IBOutlet CurveBorderView *curveView1;
@property (weak, nonatomic) IBOutlet CurveBorderView *curveView2;
@property (weak, nonatomic) IBOutlet CurveBorderView *curveView3;
@property (weak, nonatomic) IBOutlet CurveBorderView *curveView4;


@end

@implementation ViewController

#pragma mark - Private Method

- (void)initDatas
{
    
}

- (void)initViews
{
    _curveView1.fillColor = self.view.backgroundColor;
    [_curveView1  setCurveBorderType:kCurveBorderTypeJagged curveBorderDirection:kCurveBorderDirectionAll];
    _curveView1.strokeColor = [UIColor redColor];
    
    _curveView2.fillColor = self.view.backgroundColor;
    [_curveView2  setCurveBorderType:kCurveBorderTypeJagged curveBorderDirection:kCurveBorderDirectionVertical];
    
    _curveView3.fillColor = self.view.backgroundColor;
    [_curveView3  setCurveBorderType:kCurveBorderTypeCurve curveBorderDirection:kCurveBorderDirectionVertical];
    
    _curveView4.fillColor = self.view.backgroundColor;
    [_curveView4  setCurveBorderType:kCurveBorderTypeCurve curveBorderDirection:kCurveBorderDirectionHorizontal];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initDatas];
    [self initViews];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
