//
//  CurveBorderView.m
//  OcSwift
//
//  Created by 李文龙 on 15/8/31.
//  Copyright © 2015年 李文龙. All rights reserved.
//

#import "CurveBorderView.h"

typedef NS_ENUM(NSUInteger, BorderPosition) {
    kBorderPositionTop,
    kBorderPositionBottom,
    kBorderPositionLeft,
    kBorderPositionRight
};

#define DefaultFillColor   [UIColor lightGrayColor]
#define DefaultStrokeColor [UIColor grayColor]

static CGFloat   DefaultBorderWidth = 0.50f;
static NSInteger DefaultJaggedEdgeHorizontalVertexDistance = 4;
static NSInteger DefaultJaggedEdgeVerticalVertexDistance = 3;

@implementation CurveBorderView

-(instancetype)initWithFrame:(CGRect)frame curveBorderType:(CurveBorderType)curveBorderType curveBorderDirection:(CurveBorderDirection)curveBorderDirection
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor    = [UIColor clearColor];
        _curveBorderType       = kCurveBorderTypeCurve;
        _curveBorderDirection    = kCurveBorderDirectionHorizontal;
    }
    return self;
}

-(void)setCurveBorderType:(CurveBorderType)curveBorderType curveBorderDirection:(CurveBorderDirection)curveBorderDirection
{
    _curveBorderType       = curveBorderType;
    _curveBorderDirection    = curveBorderDirection;
    [self setNeedsDisplay];
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
    [super drawRect:rect];
    UIColor *strokeColor  = self.strokeColor ?: DefaultStrokeColor;
    CGFloat borderWidth = self.borderWidth ?: DefaultBorderWidth;
    [self drawCurveBorderDirection:self.curveBorderDirection type:self.curveBorderType strokeColor:strokeColor borderWidth:borderWidth];
}

- (void)drawCurveBorderDirection:(CurveBorderDirection)direction
                           type:(CurveBorderType)type
                    strokeColor:(UIColor *)strokeColor
                    borderWidth:(CGFloat)borderWidth
{
    
    void (^drawBorder)(BorderPosition borderPosition)=^(BorderPosition borderPosition){
        
        if (borderPosition == kBorderPositionTop||borderPosition==kBorderPositionBottom)
        {
            UIBezierPath *path = [UIBezierPath bezierPath];
            path.lineWidth = borderWidth;
            NSInteger x = 0;
            NSInteger y = (borderPosition == kBorderPositionTop) ? borderWidth : CGRectGetHeight(self.frame) - borderWidth;
            [path moveToPoint:CGPointMake(x, y)];
            NSUInteger verticalDisplacement = self.jaggedEdgeVerticalVertexDistance ?: DefaultJaggedEdgeVerticalVertexDistance;
            NSUInteger horizontalDisplacement = self.jaggedEdgeHorizontalVertexDistance ?: DefaultJaggedEdgeHorizontalVertexDistance;
            
            verticalDisplacement *= (borderPosition == kBorderPositionTop) ? +1 : -1;
            
            BOOL shouldMoveUp = YES;
            while (x <= CGRectGetWidth(self.frame)) {
                x += horizontalDisplacement;
                if (type == kCurveBorderTypeJagged) {
                    if (shouldMoveUp) {
                        y += verticalDisplacement;
                    }
                    else
                    {
                        y -= verticalDisplacement;
                    }
                    [path addLineToPoint:CGPointMake(x, y)];
                }else if (type == kCurveBorderTypeCurve){
                    
                    NSInteger newY = y+verticalDisplacement;
                    if (shouldMoveUp)
                    {
                        newY += verticalDisplacement;
                    }
                    else
                    {
                        newY -= verticalDisplacement;
                    }
                    [path addQuadCurveToPoint:CGPointMake(x, y+verticalDisplacement) controlPoint:CGPointMake(x-horizontalDisplacement/2.0, newY)];
                }
                shouldMoveUp = !shouldMoveUp;
            }
            CGFloat offSet = 2 * borderWidth;
            x = CGRectGetWidth(self.frame) + offSet;
            y = (borderPosition == kBorderPositionTop) ? -offSet : CGRectGetHeight(self.frame) + offSet;
            [path addLineToPoint:CGPointMake(x,y)];
            x = -offSet;
            [path addLineToPoint:CGPointMake(x, y)];
            [strokeColor setStroke];
            [self drawBezierPath:path];
            
        }else if(borderPosition == kBorderPositionLeft||borderPosition==kBorderPositionRight){
            
            UIBezierPath *path = [UIBezierPath bezierPath];
            path.lineWidth = borderWidth;
            NSInteger y = 0;
            NSInteger x = (borderPosition == kBorderPositionLeft) ? borderWidth : CGRectGetWidth(self.frame) - borderWidth;
            [path moveToPoint:CGPointMake(x, y)];
            NSUInteger verticalDisplacement = self.jaggedEdgeVerticalVertexDistance ?: DefaultJaggedEdgeVerticalVertexDistance;
            NSUInteger horizontalDisplacement = self.jaggedEdgeHorizontalVertexDistance ?: DefaultJaggedEdgeHorizontalVertexDistance;
            
            verticalDisplacement *= (borderPosition == kBorderPositionLeft) ? +1 : -1;
            
            BOOL shouldMoveUp = YES;
            while (y <= CGRectGetHeight(self.frame)) {
                 y += horizontalDisplacement;
                if (type == kCurveBorderTypeJagged) {
                    if (shouldMoveUp) {
                        x += verticalDisplacement;
                    }
                    else
                    {
                        x -= verticalDisplacement;
                    }
                    [path addLineToPoint:CGPointMake(x, y)];
                }else if (type == kCurveBorderTypeCurve){
                    
                    NSInteger newX = x+verticalDisplacement;
                    if (shouldMoveUp)
                    {
                        newX += verticalDisplacement;
                    }
                    else
                    {
                        newX -= verticalDisplacement;
                    }
                    [path addQuadCurveToPoint:CGPointMake(x+verticalDisplacement, y) controlPoint:CGPointMake(newX , y-horizontalDisplacement/2.0)];
                }
                shouldMoveUp = !shouldMoveUp;
            }
            CGFloat offSet = 2 * borderWidth;
            y = CGRectGetHeight(self.frame) + offSet;
            x = (borderPosition == kBorderPositionLeft) ? -offSet : CGRectGetWidth(self.frame) + offSet;
            [path addLineToPoint:CGPointMake(x,y)];
            y = -offSet;
            [path addLineToPoint:CGPointMake(x, y)];
            [strokeColor setStroke];
            [self drawBezierPath:path];
        }
    };
    
    if (direction == kCurveBorderDirectionHorizontal)
    {
        drawBorder(kBorderPositionTop);
        drawBorder(kBorderPositionBottom);
    }
    else if(direction == kCurveBorderDirectionVertical)
    {
        drawBorder(kBorderPositionLeft);
        drawBorder(kBorderPositionRight);
    }
    else if(direction == kCurveBorderDirectionAll)
    {
        drawBorder(kBorderPositionTop);
        drawBorder(kBorderPositionBottom);
        drawBorder(kBorderPositionLeft);
        drawBorder(kBorderPositionRight);
    }
}

- (void)drawBezierPath:(UIBezierPath *)path
{
    UIColor *fillColor = self.fillColor ?: DefaultFillColor;
    [fillColor setFill];
    [path closePath];
    [path fill];
    [path stroke];
}

@end
