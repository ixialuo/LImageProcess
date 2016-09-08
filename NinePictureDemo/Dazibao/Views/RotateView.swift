//
//  RotateView.swift
//  NinePictureDemo
//
//  Created by XiaLuo on 16/8/30.
//  Copyright © 2016年 Hangzhou Gravity Cyber Info Corp. All rights reserved.
//
import UIKit

class RotateView: UIView {

    override func drawRect(rect: CGRect) {
        
        UIColor.yellowColor().setFill()
        UIRectFill(rect)
        
        UIColor.redColor().setStroke()
        let rect = CGRectMake(10, 10, UIScreen.mainScreen().bounds.width-20, UIScreen.mainScreen().bounds.height-20-64)
        UIRectFrame(rect)
        
        //drawTriangle()
        
    }
    
    //MARK: - 绘制图片
    func drawPicture() {
        let image = UIImage(named: "dandelion")
        image?.drawInRect(CGRectMake(20, 20, UIScreen.mainScreen().bounds.width-40, UIScreen.mainScreen().bounds.width-40))
        
        let s = "美丽的图片"
        let font = UIFont.systemFontOfSize(34)
        let style = NSMutableParagraphStyle()
        style.alignment = .Center
        
        let attr = [NSFontAttributeName: font, NSParagraphStyleAttributeName: style]
        //(s as NSString).drawAtPoint(CGPointMake(UIScreen.mainScreen().bounds.width/2, 20), withAttributes: attr)
        let rect1 = CGRectMake(40, 40, UIScreen.mainScreen().bounds.width-80, 70)
        (s as NSString).drawInRect(rect1, withAttributes: attr)
    }
    
    //MARK: - 绘制三角形
    func drawTriangle() {
        
        let context = UIGraphicsGetCurrentContext()
//        CGContextMoveToPoint(context, WIDTH/2, 40)
//        CGContextAddLineToPoint(context, WIDTH/2+120, 208)
//        CGContextAddLineToPoint(context, WIDTH/2-120, 208)
//        CGContextClosePath(context)
//        UIColor.blueColor().setStroke()
//        CGContextDrawPath(context, .Stroke)
        
        for i in 0...6 {
            
            let scale: CGFloat = sqrt(3.0)/2
            let a: CGFloat = 20.0/sqrt(3.0)
            let b: CGFloat = a*scale

            

            let path = CGPathCreateMutable()
            CGPathMoveToPoint(path, nil, WIDTH/2, 40+CGFloat(i)*20)
            CGPathAddLineToPoint(path, nil, WIDTH/2+120-CGFloat(i)*sqrt(3.0)*b, 240.0*scale-CGFloat(i)*b)
            CGPathAddLineToPoint(path, nil, WIDTH/2-120+CGFloat(i)*sqrt(3.0)*b, 240.0*scale-CGFloat(i)*b)
            CGContextAddPath(context, path)
            CGContextClosePath(context)
            
            CGContextSetRGBStrokeColor(context, 1, 0, 1, 1)
            CGContextSetRGBFillColor(context, 1, 1, 0, 1)
            
            CGContextSetLineWidth(context, 2)
            CGContextSetLineCap(context, .Butt)
            CGContextSetLineJoin(context, .Round)
            
            
            
            let lengths: [CGFloat] = [3, 5, 8]
            CGContextSetLineDash(context, 0, lengths, 1)
            
            //        let color = UIColor.grayColor().CGColor
            //        CGContextSetShadowWithColor(context, CGSizeMake(2, 2), 0.8, color)
            
            CGContextDrawPath(context, .FillStroke)
        }
        
        
        
        
    }

}
