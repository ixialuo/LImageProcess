//
//  ViewController.swift
//  NinePictureDemo
//
//  Created by XiaLuo on 16/8/28.
//  Copyright © 2016年 Hangzhou Gravity Cyber Info Corp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    //MARK: - 按钮的点击方法
    @IBAction func btnAction(sender: UIButton) {
        
        switch sender.tag {
        case 1:
            break
        case 2:
            performSegueWithIdentifier("xToNinePicture", sender: nil)
        case 3:
            performSegueWithIdentifier("xToDazibao", sender: nil)
        case 4:
            break
        default:
            break
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

