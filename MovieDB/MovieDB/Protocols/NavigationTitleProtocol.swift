//
//  NavigationTitleProtocol.swift
//  MovieDB
//
//  Created by Christos Home on 11/12/2018.
//  Copyright © 2018 Christos Bimpas. All rights reserved.
//

import UIKit

protocol NavigationTitleProtocol {
    var titleLabel: UILabel { get set }
}

extension NavigationTitleProtocol where Self: UIViewController {
    
    func configureNavigationTitleLabel(title: String?) {
        titleLabel.text = title
        titleLabel.textColor = .white
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        titleLabel.alpha = 0.0
        titleLabel.textAlignment = .center
        navigationItem.titleView = titleLabel
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.titleLabel.alpha = 1.0
        }
    }
}
