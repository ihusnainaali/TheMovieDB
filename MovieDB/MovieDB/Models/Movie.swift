//
//  Movie.swift
//  MovieDB
//
//  Created by Christos Home on 03/12/2018.
//  Copyright © 2018 Christos Bimpas. All rights reserved.
//

import Foundation

struct Movie: Codable, Equatable {
    var id: Int?
    var title: String?
    var releaseDate: String?
    var overview: String?
    var voteAverage: Double?
    var posterPath: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case releaseDate = "release_date"
        case overview
        case voteAverage = "vote_average"
        case posterPath = "poster_path"
    }
    
    static func ==(lhs: Movie, rhs: Movie) -> Bool {
        return lhs.id == rhs.id 
    }
}
