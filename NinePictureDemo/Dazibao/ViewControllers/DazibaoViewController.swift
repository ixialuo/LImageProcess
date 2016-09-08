//
//  DazibaoViewController.swift
//  NinePictureDemo
//
//  Created by XiaLuo on 16/8/30.
//  Copyright © 2016年 Hangzhou Gravity Cyber Info Corp. All rights reserved.
//

import UIKit

class DazibaoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        automaticallyAdjustsScrollViewInsets = false
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    //MARK: - 返回按钮的方法
    @IBAction func backBtnAction(sender: UIBarButtonItem) {
        navigationController?.popViewControllerAnimated(true)
    }

    //MARK: - 保存按钮的方法
    @IBAction func saveBtnAction(sender: UIBarButtonItem) {
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
