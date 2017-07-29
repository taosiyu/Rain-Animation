//
//  TSYCirclePercentageVIew.swift
//  TSYCirclePercentageVIew
//
//  Created by ncm on 2016/12/19.
//  Copyright © 2016年 ncm. All rights reserved.
//

import UIKit
import Foundation

//MARK:******* 圆弧 结束角度 *******
let hCircularStartAngle = CGFloat.init(-M_PI - M_PI_4)
let hCircularEndAngle   = CGFloat.init(M_PI_4)

//MARK:******* 圆开始角度 *******
let hCircleStartAngle   = CGFloat.init(-M_PI - M_PI_2)
let hCircleEndAngle     = CGFloat.init(M_PI_2)

//MARK:可以选择画图的类型，全圆还是4/5的圆
enum circleType:Int {
    /// 圆弧类型
    case CircularType = 0
    /// 圆
    case CircleType  = 1
}


/// 画图表
class TSYCirclePercentageVIew: UIView {
    var backgroundLayer:CAShapeLayer!
    var circle:CAShapeLayer!
    var duration: CGFloat   = 1.0
    var centerPoint: CGPoint!
    var percentLabel : UILabel!
    var radius: CGFloat     = 0
    var topCircleRadius : CGFloat = 0
    var lineWidth : CGFloat = 1
    var clockwise           = false
    var percent : CGFloat   = 0
    var lineCap             = kCALineCapRound// kCALineCapButt, kCALineCapRound, kCALineCapSquare
    var colors              = [CGColor]()
    var type = circleType.CircularType
    var unit : String = ""
    
    var breakPercentChange: Bool = false
    var intervalTime : Int64 = 0
    var labelContentA =  [NSMutableAttributedString]() //显示数据的图表
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundLayer = CAShapeLayer.init()
        self.layer.addSublayer(self.backgroundLayer)
        self.circle          = CAShapeLayer.init()
        self.layer.addSublayer(self.circle)
        self.percentLabel    = UILabel()
        self.percentLabel.frame = CGRect(x: 0, y: bounds.size.height*0.5-15, width: self.bounds.size.width, height: 30)
        self.percentLabel.textColor = UIColor.black
        self.percentLabel.textAlignment = .center
        self.percentLabel.font = UIFont.init(name: "DINCondensedC", size: 24)
        self.addSubview(self.percentLabel)
        self.centerPoint     = CGPoint(x:frame.width/2,y:frame.height/2)
        self.setupSubViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:设置约束
    func setupSubViews() {

        self.addConstraint(NSLayoutConstraint(item: self.percentLabel, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.centerX, multiplier: 1.0, constant: 0.0))
        
        self.addConstraint(NSLayoutConstraint(item: self.percentLabel, attribute: NSLayoutAttribute.centerY, relatedBy: NSLayoutRelation.equal, toItem: self, attribute: NSLayoutAttribute.centerY, multiplier: 1.0, constant: 5.0))
        
    }
    
    
    //MARK: 画圆的操作(半圆)
    ///
    /// - Parameters:
    ///   - percent: 百分比
    ///   - duration: 动画时间
    ///   - lineWidth: 边缘线宽
    ///   - clockwise: ？
    ///   - lineCap: 线类型
    ///   - backgroundCircleStrokeColor: 基础背景颜色
    ///   - strokeColor: 填充线颜色
    ///   - animatedColors: 动画线颜色
    ///   - percentStyle: 圆类型
    func drawCircleWithPercent(percent: CGFloat,duration: CGFloat,lineWidth: CGFloat,clockwise: Bool,lineCap: String,backgroundCircleStrokeColor: UIColor,strokeColor: UIColor,animatedColors: [UIColor]?,topCircleRadiusOffset: CGFloat,circleType:circleType) {
        
        if duration>0 {
            self.duration  = duration
        }
        
        self.percent   = percent
        self.lineWidth = lineWidth
        self.clockwise = clockwise
        let minWidth   = min(self.frame.size.width, self.frame.size.height)
        self.radius    = (minWidth - lineWidth)/2
        self.centerPoint = CGPoint(x:self.frame.size.width / 2 - self.radius, y:self.frame.size.height / 2 - self.radius);
        self.lineCap   = lineCap
        self.colors.removeAll()
        
        if let tempColors =  animatedColors{
            for color in tempColors{
                self.colors.append(color.cgColor)
            }
        }else{
            self.colors.append(strokeColor.cgColor)
        }
        
        self.type = circleType
        //画圆
        self.setupBackgroundLayerWithStrokeColor(StrokeColor: backgroundCircleStrokeColor)
        self.setupCircleLayerWithStrokeColorRadiusOffSet(strokeColor: strokeColor,topCircleRadiusOffset:topCircleRadiusOffset)
        self.setupPercentLabel()
        
    }
    
    
    //MARK: 设置图表背景
    ///
    /// - Parameter StrokeColor: 颜色
    func setupBackgroundLayerWithStrokeColor(StrokeColor: UIColor) {
        
        let startAngle = self.startAngleEndAngle(type: self.type).startAngle
        let endAngle   = self.startAngleEndAngle(type: self.type).endAngle
        
        self.backgroundLayer.path               = UIBezierPath(arcCenter: CGPoint(x:self.radius, y:self.radius), radius: self.radius, startAngle: startAngle, endAngle: endAngle, clockwise: true).cgPath
        
        self.backgroundLayer.fillColor          = UIColor.clear.cgColor
        self.backgroundLayer.strokeColor        = StrokeColor.cgColor
        self.backgroundLayer.shouldRasterize    = true
        self.backgroundLayer.rasterizationScale = 2 * UIScreen.main.scale
        self.backgroundLayer.lineCap            = self.lineCap
        self.backgroundLayer.position           = self.centerPoint
        self.backgroundLayer.lineWidth          = self.lineWidth
    }
    
    
    func setupCircleLayerWithStrokeColorRadiusOffSet(strokeColor: UIColor,topCircleRadiusOffset:CGFloat) {
        
        let startAngel = self.startAngleEndAngle(type: self.type).startAngle
        var tempPercent : CGFloat = 0
        
        if self.unit == "%" || self.unit.isEmpty{
            tempPercent = self.percent
        } else {
            tempPercent = 0
        }
        let endAngle                   = self.calculateToValueWithPercent(percent: tempPercent)
        self.circle.path               = UIBezierPath.init(arcCenter: CGPoint(x:self.radius,y:self.radius), radius: self.radius + topCircleRadiusOffset, startAngle: startAngel, endAngle: endAngle, clockwise: self.clockwise).cgPath
        self.circle.position           = self.centerPoint
        self.circle.fillColor          = UIColor.clear.cgColor
        self.circle.strokeColor        = strokeColor.cgColor
        self.circle.lineCap            = self.lineCap
        self.circle.lineWidth          = self.lineWidth
        self.circle.shouldRasterize    = true
        self.circle.rasterizationScale = 2 * UIScreen.main.scale
    }
    
    
    //MARK:计算角度
    ///
    /// - Parameter type: 圆的类型
    /// - Returns: 返回计算后的元祖
    func startAngleEndAngle(type: circleType) -> (startAngle: CGFloat,endAngle: CGFloat) {
        if type == .CircleType{
            return (hCircleStartAngle,hCircleEndAngle)
        } else if type == .CircularType{
            return (hCircularStartAngle,hCircularEndAngle)
        } else {
            return (0,0)
        }
    }
    
    func calculateToValueWithPercent(percent: CGFloat) -> CGFloat {
        
        if self.type == .CircularType{
            return  CGFloat.init(Double.init(hCircularStartAngle) + Double.init(percent) * 3 * Double.init(M_PI_2)/100)
        }else if self.type == .CircleType {
            return  CGFloat.init(Double.init(hCircleStartAngle) + Double.init(percent) * 4 * Double.init(M_PI_2)/100)
        }else{
            return 0
        }
    }

    func setupPercentLabel() {
        
        let interval: CGFloat = self.duration/(self.percent == 0 ? 1.0  :  self.percent)
        var tempValue: Int = 0
        self.labelContentA.removeAll()
        while tempValue <= Int.init(self.percent) {
            self.labelContentA.append(self.valueToDisplay(valueStr: "\(tempValue)"))
            tempValue += 1
        }
        self.intervalTime =  NSNumber.init(value: (Float.init(Double.init(interval) *  1000000000.0))).int64Value
        self.displayAttributeStr()
    }
    
    //用来显示字体动画用的
    func displayAttributeStr(){
        
        if self.labelContentA.count <= 0 {
            return
        } else {
            
            self.percentLabel.attributedText = self.labelContentA[0]
            self.labelContentA.remove(at: 0)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()+0.005, execute: {
                DispatchQueue.main.async {
                    self.displayAttributeStr()
                }
            })
        }
    }
    

}


//MARK:动画
extension TSYCirclePercentageVIew{
    
    func startAnimation() -> Void {
        self.drawBackgroundCircle()
        self.drawCircle()
    }
    
    func drawBackgroundCircle() -> Void {
        self.backgroundLayer.removeAllAnimations()
    }
    
    
    
    func drawCircle() -> Void {
        
        self.circle.removeAllAnimations()
        let drawAnimation      = CABasicAnimation.init(keyPath: "strokeEnd")
        drawAnimation.duration =  Double.init(self.duration)
        drawAnimation.repeatCount = 1.0
        drawAnimation.fromValue = 0
        drawAnimation.toValue = 1.0
        drawAnimation.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseInEaseOut)
        self.circle.add(drawAnimation, forKey: "drawCircleAnimation")
        
        
        let colorsAnimation = CAKeyframeAnimation.init(keyPath: "strokeColor")
        colorsAnimation.values = self.colors
        colorsAnimation.calculationMode = kCAAnimationCubicPaced
        colorsAnimation.fillMode = kCAFillModeForwards
        colorsAnimation.isRemovedOnCompletion = false
        colorsAnimation.duration = Double.init(self.duration)
        self.circle.add(colorsAnimation, forKey: "strokeColor")
    }
    
    
    func valueToDisplay(valueStr: String ) -> NSMutableAttributedString {
        
        let timeString = valueStr
        var attributeString1 = NSMutableAttributedString()
        var attributeString2 = NSMutableAttributedString()
        guard let attr:UIFont = UIFont.boldSystemFont(ofSize: 15) else {
            return attributeString1
        }

        attributeString1 = NSMutableAttributedString.init(string: timeString, attributes: [NSFontAttributeName:attr,NSBackgroundColorAttributeName:UIColor.white])
        attributeString2 = NSMutableAttributedString.init(string: "%", attributes: [NSFontAttributeName:attr,NSBackgroundColorAttributeName:UIColor.white])
        attributeString1.append(attributeString2)

        self.percentLabel.attributedText = attributeString1
        return attributeString1
    }
    
}
































