//
//  ShapeView.swift
//  NinePictureDemo
//
//  Created by XiaLuo on 16/9/8.
//  Copyright © 2016年 Hangzhou Gravity Cyber Info Corp. All rights reserved.
//

import UIKit

class ShapeView: UIView {

    let btnWidth: CGFloat = 60*PROPORTION_BASIC6P
    let btnHorSpace = (WIDTH-60*PROPORTION_BASIC6P*4)/5
    let btnImgArray = ["btn-bai","btn-love", "btn-baidu"]
    
    var imgVBgV = UIView()
    var lastBtn = UIButton()

    init(frame: CGRect, imgVBgView: UIView) {
        super.init(frame: frame)
        
        imgVBgV = imgVBgView
        
        initBottomView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - 初始化下方按钮
    private func initBottomView() {
        let btnVerSpace: CGFloat = (frame.height-btnWidth*3)/4
        for i in 0...0 {
            for j in 0..<btnImgArray.count {
                let btn = UIButton.init(frame: CGRectMake(btnHorSpace+(btnWidth+btnHorSpace)*CGFloat(j), btnVerSpace+(btnWidth+btnVerSpace)*CGFloat(i), btnWidth, btnWidth))
                btn.setBackgroundImage(UIImage.init(named: btnImgArray[i*4+j]), forState: .Normal)
                btn.tag = i*4+j
                btn.addTarget(self, action: #selector(ShapeView.functionBtnsAction(_:)), forControlEvents: .TouchUpInside)
                addSubview(btn)
            }
        }
    }
    
    //MARK: - 功能详细按钮的方法
    func functionBtnsAction(btn: UIButton) {
        
        lastBtn.layer.cornerRadius = 0
        lastBtn.layer.borderWidth = 0
        btn.layer.cornerRadius = 3
        btn.layer.borderColor = UIColor.init(rgba: "#666666").CGColor
        btn.layer.borderWidth = 2
        lastBtn = btn
        
        shapeImg = UIImage(named: "shape-\(btn.tag)")
        imgArray = saveImg.separateImageAndDescripetionAndShape(byX: 3, andY: 3, descripetion: nil, shapeImage: shapeImg, textColor: textColor)!
        for i in 0..<imgVBgV.subviews.count {
            (imgVBgV.viewWithTag(100+i) as! UIImageView).image = imgArray[i]
        }
    }

}
