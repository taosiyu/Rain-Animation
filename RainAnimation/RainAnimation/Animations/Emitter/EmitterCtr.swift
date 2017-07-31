//
//  EmitterCtr.swift
//  RainAnimation
//
//  Created by apple on 2017/7/30.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit
import QuartzCore

class EmitterCtr: UIViewController {
    
    private var containerView:UIView = {
        let vc = UIView.init()
        return vc
    }()
    
    private var sunLayer:CAShapeLayer = {
        let vc = CAShapeLayer.init()
        return vc
    }()
    
    private var snowLayer:CAShapeLayer = {
        let vc = CAShapeLayer.init()
        return vc
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.white
        self.title = "🌰特效"
        
        self.containerView.frame = self.view.bounds
        self.view.addSubview(self.containerView)

        self.setupEmitter()
    }
    
    //粒子效果
    private func setupEmitter(){
        //1.太阳
        self.sunLayer.backgroundColor = UIColor.red.cgColor
        self.sunLayer.frame = CGRect(x: 50, y: 80, width: 100, height: 100)
        self.sunLayer.cornerRadius = 50
        self.sunLayer.shadowColor = UIColor.gray.cgColor
        self.sunLayer.shadowOffset = CGSize(width: 2, height: 2)
        self.sunLayer.shadowOpacity = 0.7
        self.containerView.layer.addSublayer(self.sunLayer)
        
        let emitter1 = CAEmitterLayer.init()
        emitter1.frame = self.sunLayer.frame
        self.containerView.layer.addSublayer(emitter1)
        emitter1.renderMode = kCAEmitterLayerAdditive //重叠加亮效果
        emitter1.emitterPosition = CGPoint(x: 50, y: 60)
        
        let cell = CAEmitterCell.init()
        cell.contents = self.getImageWithColor(color: UIColor.red).cgImage
        cell.birthRate = 150
        cell.lifetime = 5
        cell.color = UIColor(red: 1, green: 0.5, blue: 0.1, alpha: 1).cgColor
        cell.alphaSpeed = -0.4
        cell.velocity = 50
        cell.velocityRange = 50
        cell.emissionRange = CGFloat(Double.pi * 2.0)
        emitter1.emitterCells = [cell]
        
        //2.下雪
        let emitter2 = CAEmitterLayer.init()
        emitter2.frame = CGRect(x: 150, y: 200, width: 210, height: 120)
        self.containerView.layer.addSublayer(emitter2)
        emitter2.renderMode = kCAEmitterLayerOutline
        emitter2.emitterShape = kCAEmitterLayerLine
        emitter2.emitterPosition = CGPoint(x: 150, y: 80)
        emitter2.emitterSize = CGSize(width: 160, height: -20)
        let cell2 = CAEmitterCell.init()
        cell2.birthRate		= 1.0
        cell2.lifetime		= 120.0
        cell2.velocity		= -10
        cell2.velocityRange = 10
        cell2.yAcceleration = 2
        cell2.emissionRange = CGFloat(0.5 * Double.pi)
        cell2.spinRange		= CGFloat(0.25 * Double.pi)
        cell2.contents		= UIImage.init(named: "snow")?.cgImage
        cell2.color         = UIColor.lightGray.cgColor
        
        self.snowLayer.contents = UIImage.init(named: "yun")?.cgImage
        self.snowLayer.frame = CGRect(x: 150, y: 200, width: 230, height: 130)
        self.snowLayer.cornerRadius = 50
        self.snowLayer.shadowColor = UIColor.white.cgColor
        self.snowLayer.shadowOffset = CGSize(width: 2, height: 2)
        self.snowLayer.shadowOpacity = 0.7
        self.containerView.layer.addSublayer(self.snowLayer)
        
        emitter2.emitterCells = [cell2]
        
        
        //3.烟花
        let emitter3 = CAEmitterLayer.init()
        emitter3.renderMode = kCAEmitterLayerAdditive
        emitter3.emitterMode = kCAEmitterLayerOutline
        emitter3.emitterShape = kCAEmitterLayerLine
        emitter3.emitterPosition = CGPoint(x: self.containerView.layer.bounds.width*0.5, y: self.containerView.layer.bounds.height)
        emitter3.emitterSize = CGSize(width: self.containerView.layer.bounds.width*0.5, height: 0)
        emitter3.seed = (arc4random()%100)+1
        
        let rocket = CAEmitterCell()
        rocket.birthRate		= 1.0
        rocket.emissionRange	= CGFloat(0.25 * Double.pi)
        rocket.velocity			= 280
        rocket.velocityRange	= 100
        rocket.yAcceleration	= 75
        rocket.lifetime			= 1.02
        rocket.contents			= self.getImageWithColor(color: UIColor.black, width: 20).cgImage
        rocket.scale			= 0.2
        rocket.color			= UIColor.red.cgColor
        rocket.greenRange		= 1.0
        rocket.redRange			= 1.0
        rocket.blueRange		= 1.0
        rocket.spinRange		= CGFloat(Double.pi)
        
        let cell3 = CAEmitterCell()
        cell3.birthRate			= 1.0
        cell3.velocity			= 0
        cell3.scale				= 2.5
        cell3.redSpeed			= cell3.redSpeed-1.5
        cell3.blueSpeed			= cell3.blueSpeed+1.5
        cell3.greenSpeed		= cell3.greenSpeed+1.0
        cell3.lifetime			= 0.35
        
        
        let cell4 = CAEmitterCell()
        cell4.birthRate			= 400
        cell4.velocity			= 125
        cell4.emissionRange		= CGFloat(2.0*Double.pi)
        cell4.yAcceleration		= 75
        cell4.lifetime			= 3
        cell4.contents			= self.getImageWithColor(color: UIColor.brown, width: 20).cgImage
        cell4.scaleSpeed		= cell4.scaleSpeed-0.2
        cell4.greenSpeed		= cell4.greenSpeed-0.1
        cell4.redSpeed			= 0.4
        cell4.blueSpeed			= cell4.blueSpeed-0.1
        cell4.alphaSpeed		= cell4.alphaSpeed-0.25
        cell4.spin				= CGFloat(2.0*Double.pi)
        cell4.spinRange			= CGFloat(2.0*Double.pi)
        
        emitter3.emitterCells = [rocket]
        rocket.emitterCells = [cell3]
        cell3.emitterCells = [cell4]
        self.containerView.layer.addSublayer(emitter3)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func getImageWithColor(color:UIColor,width:CGFloat=0)->UIImage{
        var rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        if width > 0{
           rect = CGRect(x: 0, y: 0, width: width, height: width)
        }
        UIGraphicsBeginImageContext(rect.size)
        let context = UIGraphicsGetCurrentContext()
        context!.setFillColor(color.cgColor)
        context!.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image!
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


//MARK:这里是一些属性的介绍
//alphaRange:  一个粒子的颜色alpha能改变的范围；
//
//alphaSpeed:粒子透明度在生命周期内的改变速度；
//
//birthrate：粒子参数的速度乘数因子；
//
//blueRange：一个粒子的颜色blue 能改变的范围；
//
//blueSpeed: 粒子blue在生命周期内的改变速度；
//
//color:粒子的颜色
//
//contents：是个CGImageRef的对象,既粒子要展现的图片；
//
//contentsRect：应该画在contents里的子rectangle：
//
//emissionLatitude：发射的z轴方向的角度
//
//emissionLongitude:x-y平面的发射方向
//
//emissionRange；周围发射角度
//
//emitterCells：粒子发射的粒子
//
//enabled：粒子是否被渲染
//
//greenrange: 一个粒子的颜色green 能改变的范围；
//
//greenSpeed: 粒子green在生命周期内的改变速度；
//
//lifetime：生命周期
//
//lifetimeRange：生命周期范围
//
//magnificationFilter：不是很清楚好像增加自己的大小
//
//minificatonFilter：减小自己的大小
//
//minificationFilterBias：减小大小的因子
//
//name：粒子的名字
//
//redRange：一个粒子的颜色red 能改变的范围；
//
//redSpeed; 粒子red在生命周期内的改变速度；
//
//scale：缩放比例：
//
//scaleRange：缩放比例范围；
//
//scaleSpeed：缩放比例速度：
//
//spin：子旋转角度
//
//spinrange：子旋转角度范围
//
//style：不是很清楚：
//
//velocity：速度
//
//velocityRange：速度范围
//
//xAcceleration:粒子x方向的加速度分量
//
//yAcceleration:粒子y方向的加速度分量
//
//zAcceleration:粒子z方向的加速度分量
