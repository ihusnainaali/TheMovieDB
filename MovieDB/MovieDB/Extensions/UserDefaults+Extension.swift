//
//  UserDefaults+Extension.swift
//  MovieDB
//
//  Created by Christos Home on 11/12/2018.
//  Copyright © 2018 Christos Bimpas. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    static func addMovieId(_ id: Int) {
        let moviesIdsArray = UserDefaults.likedMovieIds() + [id]
        UserDefaults.standard.set(moviesIdsArray, forKey: "likedMovies")
        UserDefaults.standard.synchronize()
    }
    
    static func removeMovieId(_ id: Int) {
        let moviesIdsArray = UserDefaults.likedMovieIds()
        UserDefaults.standard.set(moviesIdsArray.filter { $0 != id }, forKey: "likedMovies")
        UserDefaults.standard.synchronize()
    }
    
    static func likedMovieIds() -> [Int] {
        guard let movieIds = UserDefaults.standard.array(forKey: "likedMovies") as? [Int] else {
            return []
        }
        return movieIds
    }
    
    static func containsMovieId(_ id: Int) -> Bool {
        return likedMovieIds().contains(id)
    }
}
