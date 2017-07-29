//
//  RainCircleLoadingCtr.swift
//  RainAnimation
//
//  Created by apple on 2017/7/28.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

class RainCircleLoadingCtr: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "加载动画"
        self.view.backgroundColor = UIColor.white
        
        //第三个loading
        let loadView = TSYCircleLoading(frame: CGRect(x: 250, y: 30, width: 100, height: 100))
        loadView.center = self.view.center
        view.addSubview(loadView)

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
