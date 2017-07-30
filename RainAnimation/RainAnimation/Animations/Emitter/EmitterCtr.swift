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
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func getImageWithColor(color:UIColor)->UIImage{
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
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
