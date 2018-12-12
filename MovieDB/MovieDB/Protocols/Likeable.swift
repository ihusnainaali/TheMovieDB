//
//  Likeable.swift
//  MovieDB
//
//  Created by Christos Home on 12/12/2018.
//  Copyright © 2018 Christos Bimpas. All rights reserved.
//

import UIKit
import Lottie

protocol Likeable {
    var likeAnimationView: LOTAnimationView? { get set }
    var centerXOffset: CGFloat { get set }
    var centerYOffset: CGFloat { get set }
    var widthHeightMultiplier: CGFloat { get set }
    func selectWithoutAnimation(_ isSelected: Bool)
}

extension Likeable {
    func select(_ isSelected: Bool, isAnimated: Bool) {
        guard isSelected else {
            likeAnimationView?.animationProgress = 0
            return
        }
        if isAnimated {
            likeAnimationView?.play(toProgress: 0.8, withCompletion: nil)
        } else {
            likeAnimationView?.animationProgress = 0.8
        }
    }
}

extension Likeable where Self: UIView {
    
    func configureLikeable() {
        guard let likeAnimationView = likeAnimationView else { return }
        likeAnimationView.isUserInteractionEnabled = false
        likeAnimationView.animationProgress = 0
        addSubview(likeAnimationView)
        likeAnimationView.snp.makeConstraints { (make) in
            make.centerY.equalToSuperview().offset(centerYOffset)
            make.centerX.equalToSuperview().offset(centerXOffset)
            make.width.height.equalToSuperview().multipliedBy(widthHeightMultiplier)
        }
    }
}



