//
//  UIView+Extension.swift
//  MovieDB
//
//  Created by Christos Home on 12/12/2018.
//  Copyright © 2018 Christos Bimpas. All rights reserved.
//

import UIKit

extension UIView {
    func displaySubViewsWithAnimationDuration(_ duration: Double) {
        subviews.forEach { subview in
            UIView.animate(withDuration: duration, animations: {
                subview.alpha = 1.0
            })
        }
    }
    
    func hideSubViewsWithAnimationDuration(_ duration: Double) {
        subviews.forEach { subview in
            UIView.animate(withDuration: duration, animations: {
                subview.alpha = 0.0
            })
        }
    }
}
