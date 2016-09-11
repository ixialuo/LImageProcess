//
//  NinePictureViewController.swift
//  NinePictureDemo
//
//  Created by XiaLuo on 16/8/29.
//  Copyright © 2016年 Hangzhou Gravity Cyber Info Corp. All rights reserved.
//

import UIKit

var imgArray = [UIImage]()
var saveImg = UIImage()
var text: String?
var textColor: UIColor?
var shapeImg: UIImage?

class NinePictureViewController: UIViewController {

    @IBOutlet weak var imgVBgV: UIView!
    @IBOutlet weak var imgVBgVH: NSLayoutConstraint!
    @IBOutlet weak var functionBgV: UIView!
    @IBOutlet weak var barView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        automaticallyAdjustsScrollViewInsets = false

        imgVBgV.addSubview(imagesBgView)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        functionBgV.addSubview(backgroundView)
    }
    
    //MARK: - 返回按钮的方法
    @IBAction func backAction(sender: UIBarButtonItem) {
        navigationController?.popViewControllerAnimated(true)
    }
    
    //MARK: - 保存按钮的方法
    @IBAction func saveAction(sender: UIBarButtonItem) {
        
        imgArray.insert(UIImage(named: "star")!, atIndex: 0)
        imgArray.append(UIImage(named: "end")!)
        UIGraphicsBeginImageContext(imgVBgV.bounds.size)
        imgVBgV.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let viewImg = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        imgArray.append(viewImg)
        
        var aImgArray = [UIImage]()
        let watermark = UIImage(named: "watermark")!
        let asize = watermark.size
        let imgRect = CGRectMake(0, 0, asize.width, asize.height)
        for img in imgArray {
            UIGraphicsBeginImageContext(imgRect.size)
            watermark.drawInRect(imgRect)
            img.drawInRect(CGRectMake(0, (asize.height-asize.width)/2, asize.width, asize.width))
            let elementImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            aImgArray.append(elementImage)
            imgArray.removeAtIndex(0)
        }
        
        imgArray = aImgArray
        savePictureNext()
    }
    
    //MARK: - 功能按钮的方法
    @IBAction func functionBtnsAction(sender: UIButton) {
        
        barView.frame.size.width = sender.frame.width
        barView.center.x = sender.center.x
        
        for view in functionBgV.subviews {
            view.removeFromSuperview()
        }
        
        switch sender.tag {
        case 1:
            functionBgV.addSubview(backgroundView)
            
        case 2:
            functionBgV.addSubview(wordView)
            
        case 3:
            functionBgV.addSubview(shapeView)

        default:
            break
        }
    }
    
    lazy var imagesBgView: ImagesBgView = {
        self.imgVBgVH.constant = 3*imgVWidth+2*imgVSpace
        let _imagesBgView = ImagesBgView.init(frame: self.imgVBgV.bounds, imgVBgVHeight: self.imgVBgVH)
        return _imagesBgView
    }()
    
    lazy var backgroundView: BackgroundView = {
        let _backgroundView = BackgroundView.init(frame: self.functionBgV.bounds, imgVBgView: self.imagesBgView)
        return _backgroundView
    }()
    
    lazy var wordView: WordView = {
        let _wordView = WordView.init(frame: self.functionBgV.bounds, imgVBgView: self.imagesBgView)
        return _wordView
    }()
    
    lazy var shapeView: ShapeView = {
        let _shapeView = ShapeView.init(frame: self.functionBgV.bounds, imgVBgView: self.imagesBgView)
        return _shapeView
    }()

    //MARK: - 保存图片到相册
    func savePictureNext() {
        if imgArray.count > 0 {
            let image = imgArray[0]
            UIImageWriteToSavedPhotosAlbum(image, self, #selector(NinePictureViewController.image(_:didFinishSavingWithError:contextInfo:)), nil)
        }
    }
    
    func image(image: UIImage, didFinishSavingWithError error: NSError?, contextInfo: AnyObject) {
        if error != nil {
            print(error)
            return
        } else {
            imgArray.removeAtIndex(0)
            if imgArray.count == 0 {
                let alertVc = UIAlertController.init(title: "", message: "图片保存已保存至相册！", preferredStyle: .Alert)
                presentViewController(alertVc, animated: true, completion: {
                    gDelay(time: 1, task: {
                        alertVc.dismissViewControllerAnimated(true, completion: nil)
                    })
                })
            }
            print("image is saved")
        }
        savePictureNext()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
