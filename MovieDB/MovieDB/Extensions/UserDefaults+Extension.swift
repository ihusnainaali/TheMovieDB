//
//  UserDefaults+Extension.swift
//  MovieDB
//
//  Created by Christos Home on 11/12/2018.
//  Copyright © 2018 Christos Bimpas. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    static private let likedMoviesKey = "likedMovies"
    
    final class func addMovieId(_ id: Int) {
        let moviesIdsArray = UserDefaults.movieIds + [id]
        UserDefaults.standard.set(moviesIdsArray, forKey: likedMoviesKey)
        UserDefaults.standard.synchronize()
    }
    
    final class func removeMovieId(_ id: Int) {
        let moviesIdsArray = UserDefaults.movieIds
        UserDefaults.standard.set(moviesIdsArray.filter { $0 != id }, forKey: likedMoviesKey)
        UserDefaults.standard.synchronize()
    }
    
    final class func containsMovieId(_ id: Int) -> Bool {
        return movieIds.contains(id)
    }
    
    final private class var movieIds: [Int] {
        guard let movieIds = UserDefaults.standard.array(forKey: likedMoviesKey) as? [Int] else {
            return []
        }
        return movieIds
    }
}
