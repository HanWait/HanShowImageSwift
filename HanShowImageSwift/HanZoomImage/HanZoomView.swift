//
//  HanZoomView.swift
//  HanShowImageSwift
//
//  Created by Han on 2019/2/13.
//  Copyright © 2019年 Han. All rights reserved.
//

import UIKit

class HanZoomView: UIView {
    private var imageArr:[UIImage]?
    private var imageURLArr:[String]?
    private var countLabel:UILabel!
    private var index = 0
    /// 当前默认展示第一页 0 表示第一页
    var selectIndex:NSInteger = 0
    
    /// 展示图片
    ///
    /// - Parameter imageArr: 图片数组
    func showImagesWithImageArray(imageArr:[UIImage]?){
        self.imageArr = imageArr
        if imageArr?.count == 0{
            return
        }
        self.createScrollViewWithImage(imageArr: imageArr!)
        self.createCountLabel()
    }
    
    /// 展示URL图片
    ///
    /// - Parameter imageURLArr: 图片地址数组
    func showImagesWithImageURLArray(imageURLArr:[String]?){
        self.imageURLArr = imageURLArr
        if imageURLArr?.count == 0{
            return
        }
        self.createScrollViewWithURL(urlArr: imageURLArr!)
        self.createCountLabel()
    }
    
    
    private func createScrollViewWithImage(imageArr:[UIImage]){
        let sc = UIScrollView.init(frame: self.bounds)
        sc.showsVerticalScrollIndicator = false
        sc.showsHorizontalScrollIndicator = false
        sc.isPagingEnabled = true
        sc.delegate = self
        self.addSubview(sc)
        
        
        sc.contentSize = CGSize.init(width: self.bounds.size.width * CGFloat(imageArr.count), height: self.bounds.size.height)
        
        sc.contentOffset = CGPoint.init(x: self.bounds.size.width * CGFloat(self.selectIndex), y: 0)
        
        for (i,image) in imageArr.enumerated()  {
            let hanSC = HanZoomScrollView.init(frame: CGRect.init(x: self.bounds.size.width * CGFloat(i), y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
            hanSC.image = image
            sc.addSubview(hanSC)
            
        }
    }
    
    
    private func createScrollViewWithURL(urlArr:[String]){
        let sc = UIScrollView.init(frame: self.bounds)
        sc.showsVerticalScrollIndicator = false
        sc.showsHorizontalScrollIndicator = false
        sc.isPagingEnabled = true
        sc.delegate = self
        self.addSubview(sc)
        
        
        sc.contentSize = CGSize.init(width: self.bounds.size.width * CGFloat(urlArr.count), height: self.bounds.size.height)
        
        sc.contentOffset = CGPoint.init(x: self.bounds.size.width * CGFloat(self.selectIndex), y: 0)
        
        for (i,url) in urlArr.enumerated()  {
            let hanSC = HanZoomScrollView.init(frame: CGRect.init(x: self.bounds.size.width * CGFloat(i), y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
            hanSC.url = url
            sc.addSubview(hanSC)
            
        }
    }
    
    private func createCountLabel(){
        let lable = UILabel.init(frame: CGRect.init(x: 15, y: self.frame.height - 30, width: self.frame.width - 30, height: 20))
        lable.text = "1/1)"
        if self.imageArr != nil{
            lable.text = "\(self.selectIndex + 1)/\(self.imageArr?.count ?? 1)"
        }else if self.imageURLArr != nil{
            lable.text = "\(self.selectIndex + 1)/\(self.imageURLArr?.count ?? 1)"
        }
        
        lable.textColor = UIColor.white
        lable.textAlignment = .right
        self.addSubview(lable)
        
        self.countLabel = lable
    }
    
}

extension HanZoomView:UIScrollViewDelegate{
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.index = Int(round(scrollView.contentOffset.x / scrollView.frame.size.width))
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let scrollIndex = Int(round(scrollView.contentOffset.x / scrollView.frame.size.width))
        
        if scrollIndex != self.index {
            let hanZoomView:HanZoomScrollView = scrollView.subviews[self.index] as! HanZoomScrollView
            hanZoomView.changegContentSize(zoomScale:1.0)
            self.index = scrollIndex
        }
        if self.imageArr != nil{
            self.countLabel.text = "\(self.index + 1)/\(self.imageArr?.count ?? 1)"
        }else if self.imageURLArr != nil{
            self.countLabel.text = "\(self.index + 1)/\(self.imageURLArr?.count ?? 1)"
        }
        
        
    }
}
