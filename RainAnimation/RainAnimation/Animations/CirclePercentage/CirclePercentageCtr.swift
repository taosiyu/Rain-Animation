//
//  CirclePercentageCtr.swift
//  RainAnimation
//
//  Created by apple on 2017/7/28.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

class CirclePercentageCtr: UIViewController {
    
    lazy var cvc = TSYCirclePercentageVIew.init(frame:CGRect(x: 50, y: 50, width: 150, height: 150))

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "比例图"
        self.view.backgroundColor = UIColor.white
        //比例图
        cvc.drawCircleWithPercent(percent: 80.0, duration: 2.0, lineWidth: 5.0, clockwise: true, lineCap: kCALineCapRound, backgroundCircleStrokeColor: UIColor.gray, strokeColor: UIColor.yellow, animatedColors: nil, topCircleRadiusOffset: 3,circleType:.CircularType)
        view.addSubview(cvc)
        cvc.center = CGPoint(x: self.view.center.x, y: self.view.center.y - 100)
        cvc.startAnimation()
        
        
        //比例图
        let cvc2 = TSYCirclePercentageVIew.init(frame:CGRect(x: 50, y: 50, width: 150, height: 150))
        cvc2.drawCircleWithPercent(percent: 60.0, duration: 2.0, lineWidth: 5.0, clockwise: true, lineCap: kCALineCapRound, backgroundCircleStrokeColor: UIColor.black, strokeColor: UIColor.blue, animatedColors: nil, topCircleRadiusOffset: 3,circleType:.CircleType)
        view.addSubview(cvc2)
        cvc2.center = CGPoint(x: self.view.center.x, y: self.view.center.y + 100)
        cvc2.startAnimation()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
