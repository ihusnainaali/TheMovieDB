//
//  TwitterLikeButton.swift
//  MovieDB
//
//  Created by Christos Home on 12/12/2018.
//  Copyright © 2018 Christos Bimpas. All rights reserved.
//

import UIKit
import Lottie

class TwitterLikeButton: UIButton, Likeable {
    
    // MARK : - Protocol stubs
    
    var likeAnimationView = LOTAnimationView.twitterLikeAnimationView
    var centerXOffset = CGFloat(8)
    var centerYOffset = CGFloat(0)
    var widthHeightMultiplier = CGFloat(2.7)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureLikeable()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var isSelected: Bool {
        didSet {
            select(isSelected, isAnimated: true)
        }
    }
    
    func selectWithoutAnimation(_ isSelected: Bool) {
        super.isSelected = isSelected
        select(isSelected, isAnimated: false)
    }
}
