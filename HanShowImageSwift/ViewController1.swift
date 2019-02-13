//
//  ViewController1.swift
//  HanShowImageSwift
//
//  Created by Han on 2019/2/13.
//  Copyright © 2019年 Han. All rights reserved.
//

import UIKit

class ViewController1: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let showView = HanZoomView.init(frame: self.view.bounds)
        self.view.addSubview(showView)

//        showView.showImagesWithImageURLArray(imageURLArr: ["http://upload-images.jianshu.io/upload_images/3410393-f40a8a763aa2d0cf.jpeg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240","http://upload-images.jianshu.io/upload_images/3410393-f40a8a763aa2d0cf.jpeg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240","http://upload-images.jianshu.io/upload_images/3410393-f40a8a763aa2d0cf.jpeg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240","http://upload-images.jianshu.io/upload_images/3410393-f40a8a763aa2d0cf.jpeg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240","http://upload-images.jianshu.io/upload_images/3410393-f40a8a763aa2d0cf.jpeg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240","http://upload-images.jianshu.io/upload_images/3410393-f40a8a763aa2d0cf.jpeg?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240"])
        
    showView.showImagesWithImageArray(imageArr: [UIImage.init(named: "1") ?? UIImage(),UIImage.init(named: "2") ?? UIImage(),UIImage.init(named: "3") ?? UIImage(),UIImage.init(named: "4") ?? UIImage(),UIImage.init(named: "5") ?? UIImage(),UIImage.init(named: "7") ?? UIImage(),UIImage.init(named: "6") ?? UIImage()])
        
        
        let btn = UIButton.init(frame: CGRect.init(x: 0, y: 40, width: 100, height: 30))
        btn.backgroundColor = UIColor.blue
        btn.addTarget(self, action: #selector(btnClicked), for: .touchUpInside)
        self.view.addSubview(btn)
    }
    
    @objc func btnClicked(){
        self.dismiss(animated: true, completion: nil)
    }
    

}
