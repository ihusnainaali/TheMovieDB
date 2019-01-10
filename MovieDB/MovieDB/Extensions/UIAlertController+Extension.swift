//
//  UIAlertController+Extension.swift
//  MovieDB
//
//  Created by Christos Home on 18/12/2018.
//  Copyright © 2018 Christos Bimpas. All rights reserved.
//

import UIKit

extension UIAlertController {
    final class var noApiKeyAlert: UIAlertController {
        let alertController = UIAlertController(title: "No api key",
                                                message: "Please set the apiKey constant in MovieDBViewModel",
                                                preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(action)
        return alertController
    }
}
