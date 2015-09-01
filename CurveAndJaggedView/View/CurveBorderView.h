//
//  CurveBorderView.h
//  OcSwift
//
//  Created by 李文龙 on 15/8/31.
//  Copyright © 2015年 李文龙. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, CurveBorderType) {
    kCurveBorderTypeJagged, //锯齿
    kCurveBorderTypeCurve,  //波浪线
    kCurveBorderTypeNone
};

typedef NS_ENUM(NSUInteger, CurveBorderDirection) {
    kCurveBorderDirectionHorizontal,//水平
    kCurveBorderDirectionVertical,  //垂直
    kCurveBorderDirectionAll        //All
};

@interface CurveBorderView : UIView

@property (nonatomic, assign) CurveBorderType curveBorderType;
@property (nonatomic, assign) CurveBorderDirection curveBorderDirection;

@property (nonatomic, assign) NSUInteger jaggedEdgeHorizontalVertexDistance;
@property (nonatomic, assign) NSUInteger jaggedEdgeVerticalVertexDistance;

@property (nonatomic, assign) CGFloat borderWidth;

@property (nonatomic, strong) UIColor *strokeColor;

@property (nonatomic, strong) UIColor *fillColor;

- (instancetype)initWithFrame:(CGRect)frame
         curveBorderType:(CurveBorderType)curveBorderType
      curveBorderDirection:(CurveBorderDirection)curveBorderDirection;


- (void)setCurveBorderType:(CurveBorderType)curveBorderType
        curveBorderDirection:(CurveBorderDirection)curveBorderDirection;;

@end
