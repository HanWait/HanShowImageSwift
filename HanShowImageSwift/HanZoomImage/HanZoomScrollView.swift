//
//  HanZoomScrollView.swift
//  HanShowImageSwift
//
//  Created by Han on 2019/2/13.
//  Copyright © 2019年 Han. All rights reserved.
//

import UIKit

class HanZoomScrollView: UIScrollView {
    
    private var imageView:UIImageView!
    var image:UIImage?{
        didSet{
            if image != nil{
                self.createImagView(image: image!)
                self.setZoomScale()
            }
        }
    }
    var url:String?{
        didSet{
            if url != nil{

                self.createImagView(image: UIImage.init(named: "4") ?? UIImage())
                DispatchQueue.global().async {
                    let data = NSData.init(contentsOf: URL.init(string: self.url!)!)
                    if data == nil{
                        DispatchQueue.main.async {
                            self.createImagView(image: UIImage.init(named: "4") ?? UIImage())
                            self.setZoomScale()
                        }
                        
                        
                        return
                    }
                    let image = UIImage.init(data: data! as Data)
                    
                    if image == nil{
                        DispatchQueue.main.async {
                            self.createImagView(image: UIImage.init(named: "44") ?? UIImage())
                            self.setZoomScale()
                        }
                        return
                    }
                    DispatchQueue.main.async {
                        self.createImagView(image: image!)
                        self.setZoomScale()
                    }
                }
                
                /*
                 ============= 如果想用 SDWebImage 注释上边的代码  改为下面的 ============
                 self.createImagView(image: UIImage())
                 self.setZoomScale()
                 
                 */

            }
        }
    }
    private var normalHeight:CGFloat = 0.0{
        didSet{
            if (imageView != nil){
                imageView.bounds = CGRect.init(x: 0, y: 0, width: normalWidth, height: normalHeight)
                imageView.center = CGPoint.init(x: self.bounds.size.width/2 , y: self.bounds.size.height/2)
            }
        }
    }
    private var normalWidth:CGFloat = 0.0{
        didSet{
            if (imageView != nil){
                imageView.bounds = CGRect.init(x: 0, y: 0, width: normalWidth, height: normalHeight)
                imageView.center = CGPoint.init(x: self.bounds.size.width/2 , y: self.bounds.size.height/2)
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.showsVerticalScrollIndicator = false
        self.showsHorizontalScrollIndicator = false
        self.zoomScale = 1.0
        self.backgroundColor = .black
        self.delegate = self
        
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    /// 创建imageView
    func createImagView(image:UIImage) {

        
        if self.imageView == nil{
            self.imageView = UIImageView()
            
            self.imageView?.isUserInteractionEnabled = true
            self.addSubview(self.imageView!)
            
            let moreTap = UITapGestureRecognizer.init(target:self, action: #selector(handleMoreTap(tap:)))
            moreTap.numberOfTapsRequired =  2//触发响应的点击次数
            self.imageView?.addGestureRecognizer(moreTap)
        }
       
        let size = image.getImageSize(view:self)
        self.imageView?.bounds = CGRect.init(x: 0, y: 0, width: size.width, height: size.height)
        self.imageView?.center = CGPoint.init(x: self.bounds.size.width/2 , y: self.bounds.size.height/2)
        
        self.imageView?.image = image
        
        self.contentSize = self.imageView?.bounds.size ?? CGSize.zero
        
        self.normalWidth = self.contentSize.width
        self.normalHeight = self.contentSize.height
        
        
      
      /*
         ============= 如果想用 SDWebImage 注释上边的代码  改为下面的 ============
         
         
        if self.imageView == nil{
            self.imageView = UIImageView()
            
            self.imageView?.isUserInteractionEnabled = true
            self.addSubview(self.imageView!)
            
            let moreTap = UITapGestureRecognizer.init(target:self, action: #selector(handleMoreTap(tap:)))
            moreTap.numberOfTapsRequired =  2//触发响应的点击次数
            self.imageView?.addGestureRecognizer(moreTap)
        }
        if self.url != nil {
            self.imageView?.sd_setImage(with: URL.init(string: self.url!)!, placeholderImage: UIImage.init(named: "datadpload_photos"), options: [], completed: { (image1, error, cacheMemoryOnly, url) in
                if error == nil{
                    let size = image1?.getImageSize(view:self) ?? CGSize.zero
                    self.imageView?.bounds = CGRect.init(x: 0, y: 0, width: size.width, height: size.height)
                    self.imageView?.center = CGPoint.init(x: self.bounds.size.width/2 , y: self.bounds.size.height/2)
                    
                    self.imageView?.image = image1
                    
                    self.contentSize = self.imageView?.bounds.size ?? CGSize.zero
                    
                    self.normalWidth = self.contentSize.width
                    self.normalHeight = self.contentSize.height
                }
            })
        }else{
            let size = image.getImageSize(view:self)
            self.imageView?.bounds = CGRect.init(x: 0, y: 0, width: size.width, height: size.height)
            self.imageView?.center = CGPoint.init(x: self.bounds.size.width/2 , y: self.bounds.size.height/2)
            
            self.imageView?.image = image
            
            self.contentSize = self.imageView?.bounds.size ?? CGSize.zero
            
            self.normalWidth = self.contentSize.width
            self.normalHeight = self.contentSize.height
        }
         */

        
    }
    
    /// 双击
    @objc private func handleMoreTap(tap:UITapGestureRecognizer) {
      
        
        if self.zoomScale < 2{
            self.changegContentSize(zoomScale: 2.0)
        }else{
            self.changegContentSize(zoomScale: 1.0)
        }
    }

    /// 设置比例
    private func setZoomScale() {
        let widthScale = self.frame.width/self.imageView.frame.width
        let heightScale = self.frame.height/self.imageView.frame.height
        self.minimumZoomScale = min(widthScale, heightScale)
        self.maximumZoomScale = 4.0
    }
    
    /// 按照比例更改 ContentSize
     func changegContentSize(zoomScale:CGFloat){
        self.zoomScale = zoomScale
        let horizontalPadding = self.imageView.frame.width < self.frame.width ? (self.frame.size.width - self.imageView.frame.size.width)/2.0 : 0.0
        let verticalPadding = self.imageView.frame.height < self.frame.height ? (self.frame.size.height - self.imageView.frame.size.height)/2.0 : 0.0
        let imageScaleWidth = zoomScale * self.normalWidth
        let imageScaleHeight = zoomScale * self.normalHeight
        
        var padding:CGFloat = 0.0
        if imageScaleWidth < self.frame.width{
            padding = (self.frame.width - imageScaleWidth)/2.0
            let paddingY = (self.frame.height - imageScaleHeight)/2.0
            
            if imageScaleHeight < self.frame.height{
                self.imageView.frame = CGRect.init(x: padding, y: paddingY, width: imageScaleWidth, height: imageScaleHeight)
            }else{
                self.imageView.frame = CGRect.init(x: padding, y: verticalPadding, width: imageScaleWidth, height: imageScaleHeight)
            }
            
            
        }else{
            self.imageView.frame = CGRect.init(x: horizontalPadding , y: verticalPadding, width: imageScaleWidth, height: imageScaleHeight)
        }
        
        
    }

}

extension HanZoomScrollView:UIScrollViewDelegate{
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        self.changegContentSize(zoomScale: scrollView.zoomScale)
    }
}
