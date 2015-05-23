//
//  JLStarRatingView.swift
//  JLStarRating
//
//  Created by Aimy on 5/23/15.
//  Copyright (c) 2015 Aimy. All rights reserved.
//

import UIKit

@IBDesignable
class JLStarRatingView: UIView {

    @IBInspectable var starCount: NSInteger = 5 {
        didSet {
            self.initialSetup()
        }
    }

    @IBInspectable var emptyImage: UIImage = UIImage() {
        didSet {
            self.initialSetup()
        }

    }
    @IBInspectable var fillImage: UIImage = UIImage() {
        didSet {
            self.initialSetup()
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialSetup()
    }

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialSetup()
    }

    override func prepareForInterfaceBuilder() {
        self.initialSetup()
    }

    func initialSetup() {
        for var i = 0; i < starCount; i++ {
            var imageView: UIImageView = UIImageView(image: emptyImage)
            let size: CGSize = imageView.image!.size
            imageView.frame = CGRectMake(CGFloat(i) * size.width, (self.bounds.height - size.height) / 2, size.width, size.height)
            addSubview(imageView);
        }

        self.invalidateIntrinsicContentSize()
    }

    override func intrinsicContentSize() -> CGSize {
        let size: CGSize  = emptyImage.size
        return CGSize(width: CGFloat(self.starCount) * size.width, height: size.height)
    }
}
