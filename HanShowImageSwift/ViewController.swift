//
//  ViewController.swift
//  HanShowImageSwift
//
//  Created by Han on 2019/2/12.
//  Copyright © 2019年 Han. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var scrollView:UIScrollView = {
        let sc = UIScrollView.init(frame: self.view.bounds)
        sc.backgroundColor = UIColor.red
        sc.contentSize = self.imageView.frame.size;
        sc.delegate = self
        return sc
    }()
    private lazy var imageView:UIImageView = {
        let image = UIImage.init(named: "6")
        let iv = UIImageView.init(image: UIImage.init(named: "6"))
        return iv
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.addSubview(self.scrollView)
        self.scrollView.addSubview(self.imageView)
        self.setZoomScale()
        
        
        let btn = UIButton.init(frame: CGRect.init(x: 0, y: 40, width: 100, height: 30))
        btn.backgroundColor = UIColor.blue
        btn.addTarget(self, action: #selector(btnClicked), for: .touchUpInside)
        self.view.addSubview(btn)
    }
    
    @objc func btnClicked(){
        let vc = ViewController1()
        self.present(vc, animated: true, completion: nil)
    }
    
    
    func setZoomScale() {
        let widthScale = self.scrollView.frame.width/self.imageView.frame.width
        let heightScale = self.scrollView.frame.height/self.imageView.frame.height
        self.scrollView.minimumZoomScale = min(widthScale, heightScale)
    }

}

extension ViewController:UIScrollViewDelegate{
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return self.imageView
    }
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        let horizontalPadding = self.imageView.frame.width < scrollView.frame.width ? (scrollView.frame.size.width - self.imageView.frame.size.width)/2.0 : 0.0
        let verticalPadding = self.imageView.frame.height < scrollView.frame.height ? (scrollView.frame.size.height - self.imageView.frame.size.height)/2.0 : 0.0
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.1)
        scrollView.contentInset = UIEdgeInsets.init(top: verticalPadding, left: horizontalPadding, bottom: verticalPadding, right: horizontalPadding)
        UIView.commitAnimations()
    }
}
