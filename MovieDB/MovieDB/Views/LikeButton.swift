//
//  LikeButton.swift
//  MovieDB
//
//  Created by Christos Home on 11/12/2018.
//  Copyright © 2018 Christos Bimpas. All rights reserved.
//

import UIKit
import Lottie

class LikeButton: UIButton, Likeable {
    
    // MARK : - Protocol stubs
    
    var likeAnimationView = LOTAnimationView.likeAnimationView
    var centerXOffset = CGFloat(15)
    var centerYOffset = CGFloat(-15)
    var widthHeightMultiplier = CGFloat(4)
    
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
