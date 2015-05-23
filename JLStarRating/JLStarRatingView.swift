//
//  JLStarRatingView.swift
//  JLStarRating
//
//  Created by Aimy on 5/23/15.
//  Copyright (c) 2015 Aimy. All rights reserved.
//

import UIKit

@IBDesignable
public class JLStarRatingView: UIView {

    // MARK: 星星数量
    @IBInspectable var starCount: NSInteger = 5 {
        didSet {
            self.initialSetup()
        }
    }

    // MARK: 未选中星星的图片样式
    @IBInspectable var emptyImage: UIImage = UIImage() {
        didSet {
            self.initialSetup()
        }

    }

    // MARK: 选中的星星图片样式
    @IBInspectable var fillImage: UIImage = UIImage() {
        didSet {
            self.initialSetup()
        }
    }

    // MARK: 星星分值
    @IBInspectable var progress: CGFloat = 0 {
        didSet {
            if progress > CGFloat(self.starCount) {
                progress = CGFloat(self.starCount)
            }
            else if progress < 0 {
                progress = 0
            }

            self.initialSetup()
        }
    }

    // MARK: 手势
    public override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        let touch: UITouch = touches.first as! UITouch
        let point: CGPoint = touch.locationInView(self)
        self.progress = point.x / (self.frame.size.width / CGFloat(self.starCount))
    }

    public override func touchesMoved(touches: Set<NSObject>, withEvent event: UIEvent) {
        let touch: UITouch = touches.first as! UITouch
        let point: CGPoint = touch.locationInView(self)
        self.progress = point.x / (self.frame.size.width / CGFloat(self.starCount))
    }

    //  MARK: 画
    func initialSetup() {

        for subview in self.subviews {
            subview.removeFromSuperview()
        }

        for var i = 0; i < starCount; i++ {
            //背景图片view
            var size: CGSize = emptyImage.size
            size = CGSize(width: size.width / UIScreen.mainScreen().scale, height: size.height / UIScreen.mainScreen().scale)

            let frame = CGRectMake(CGFloat(i) * size.width, (self.bounds.height - size.height) / 2, size.width, size.height)

            var fillPercent = self.progress - CGFloat(i);
            var imageView = self.createStar(frame, fillPercent:fillPercent);
            addSubview(imageView);
        }

        self.invalidateIntrinsicContentSize()
    }

    // MARK: 创建星星
    func createStar(frame: CGRect, var fillPercent: CGFloat) -> UIImageView {

        if fillPercent > 1 {
            fillPercent = 1
        }

        if fillPercent < 0 {
            fillPercent = 0
        }

        //背景图片view
        var imageView: UIImageView = UIImageView(image: emptyImage)
        imageView.frame = frame

        let imageWidth = fillImage.size.width / UIScreen.mainScreen().scale
        let imageHeight = fillImage.size.height / UIScreen.mainScreen().scale
        let scale = UIScreen.mainScreen().scale

        //用高亮image做覆盖
        if fillPercent > 0 {
            let layer = CALayer()
            var imageRef = CGImageCreateWithImageInRect(fillImage.CGImage , CGRectMake(-imageWidth * scale * (1 - fillPercent), 0, imageWidth * scale, imageHeight * scale));
            layer.contents = imageRef
            layer.frame = CGRectMake(0, 0, imageWidth * fillPercent, imageHeight)
            imageView.layer.addSublayer(layer)
        }

        return imageView
    }

    // MARK: view大小
    override public func intrinsicContentSize() -> CGSize {
        var size: CGSize  = emptyImage.size
        size = CGSize(width: size.width / UIScreen.mainScreen().scale, height: size.height / UIScreen.mainScreen().scale)
        return CGSize(width: CGFloat(self.starCount) * size.width, height: size.height)
    }
}
