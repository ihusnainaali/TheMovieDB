//
//  Collection+Extension.swift
//  MovieDB
//
//  Created by Christos Home on 04/12/2018.
//  Copyright © 2018 Christos Bimpas. All rights reserved.
//

import Foundation

extension Collection {
    
    subscript (safe index: Index) -> Element? {
        return indices.contains(index) ? self[index] : nil
    }
}
