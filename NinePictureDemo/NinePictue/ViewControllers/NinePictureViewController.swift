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
var picScale: CGFloat = 0.5

class NinePictureViewController: UIViewController {

    @IBOutlet weak var imgVBgV: UIView!
    @IBOutlet weak var imgVBgVH: NSLayoutConstraint!
    @IBOutlet weak var functionBgV: UIView!
    @IBOutlet weak var barView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //添加调节文字的大小的输入框
        let tap = UITapGestureRecognizer(target: self, action: #selector(NinePictureViewController.tapAction))
        tap.numberOfTapsRequired = 4
        tap.numberOfTouchesRequired = 1
        view.addGestureRecognizer(tap)

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

    
    func tapAction() {
        let alertVc = UIAlertController(title: "九格切图", message: "请输入文字所占的百分比", preferredStyle: .Alert)
        alertVc.addTextFieldWithConfigurationHandler { (textFiled) in
            textFiled.placeholder = "请输入50~100间的整数"
        }
        let cancelAction = UIAlertAction(title: "取消", style: .Cancel, handler: nil)
        alertVc.addAction(cancelAction)
        let certainAction = UIAlertAction(title: "确定", style: .Destructive) { (action) in
            let textTf = (alertVc.textFields?.first)! as UITextField
            guard Double(textTf.text!) >= 50.0 && Double(textTf.text!) <= 100.0 else {
                let alert = UIAlertController.init(title: "", message: "请输入合理的整数", preferredStyle: .Alert)
                self.presentViewController(alert, animated: true, completion: {
                    gDelay(time: 1, task: {
                        alert.dismissViewControllerAnimated(true, completion: nil)
                    })
                })
                return
            }
            picScale = CGFloat(Double(textTf.text!)!/100)
            imgArray = saveImg.separateImageAndDescripetionAndShape(byX: 3, andY: 3, descripetion: text, shapeImage: shapeImg, textColor: textColor)!
            for i in 0..<self.imagesBgView.subviews.count {
                (self.imgVBgV.viewWithTag(100+i) as! UIImageView).image = imgArray[i]
            }
        }
        alertVc.addAction(certainAction)
        presentViewController(alertVc, animated: true, completion: nil)
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
