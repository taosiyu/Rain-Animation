//
//  ThreeDBlockCtr.swift
//  RainAnimation
//
//  Created by apple on 2017/7/28.
//  Copyright © 2017年 apple. All rights reserved.
//

import UIKit

class ThreeDBlockCtr: UIViewController {
    
    private var blockView:_DBlockView = {
        let vc = _DBlockView.init(frameWidth: 200)
        return vc
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "3DBlock"
        self.blockView.frame = self.view.bounds
        self.blockView.backgroundColor = UIColor.gray
        self.view.addSubview(self.blockView)
        self.blockView.show()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
