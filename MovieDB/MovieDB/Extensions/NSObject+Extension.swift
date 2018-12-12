//
//  NSObject+Extension.swift
//  MovieDB
//
//  Created by Christos Home on 04/12/2018.
//  Copyright © 2018 Christos Bimpas. All rights reserved.
//

import Foundation

extension NSObject {
    static var identifier: String {
        return String(describing: self)
    }
}
