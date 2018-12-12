//
//  Page.swift
//  MovieDB
//
//  Created by Christos Home on 04/12/2018.
//  Copyright © 2018 Christos Bimpas. All rights reserved.
//

import UIKit

struct Page: Codable, Equatable {
    var pageNumber: Int?
    var totalPages: Int?
    var results: [Movie]?
    
    enum CodingKeys: String, CodingKey {
        case pageNumber = "page"
        case totalPages = "total_pages"
        case results
    }
    
    static func ==(lhs: Page, rhs: Page) -> Bool {
        return lhs.pageNumber == rhs.pageNumber &&
            lhs.totalPages == rhs.totalPages &&
            lhs.results == rhs.results
    }
}
