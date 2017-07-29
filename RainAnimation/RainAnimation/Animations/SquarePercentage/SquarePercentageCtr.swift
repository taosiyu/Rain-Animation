//
//  SquarePercentageCtr.swift
//  RainAnimation
//
//  Created by apple on 2017/7/28.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

class SquarePercentageCtr: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "柱状图"
        self.view.backgroundColor = UIColor.white
        
        let w = (self.view.bounds.width - 40*4)/5.0
        
        for i in 0...4 {
            let SquareView = TSYSquarePercentageVIew.init(frame: CGRect(x: w*(CGFloat(i+1))+CGFloat(i)*40.0, y: 130, width: 40, height: 200), style: .BarChartStyle1, width: 0)
            view.addSubview(SquareView)
            var color = UIColor.yellow
            if i == 2 {
                color = UIColor.green
            }
            if i == 3 {
                color = UIColor.blue
            }
            SquareView.showWithData(topString: "收益", centerString: "收益", bottomString: "预期收益", percent: Int64(10*i), topColor: color)
        }
        
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
