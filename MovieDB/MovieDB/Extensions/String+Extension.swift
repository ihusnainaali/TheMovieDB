//
//  String+Extension.swift
//  MovieDB
//
//  Created by Christos Home on 18/12/2018.
//  Copyright © 2018 Christos Bimpas. All rights reserved.
//

import Foundation

extension String {
    func isValidResourceFile() -> Bool {
        guard Bundle.main.url(forResource: self, withExtension: "json") != nil else {
            return false
        }
        return true
    }
}
