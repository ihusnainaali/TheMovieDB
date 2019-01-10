//
//  UserdefaultsTests.swift
//  MovieDBTests
//
//  Created by Christos Home on 18/12/2018.
//  Copyright © 2018 Christos Bimpas. All rights reserved.
//

import XCTest
@testable import MovieDB

class UserdefaultsTests: XCTestCase {
    
    func testAddMovieToUserDefaults() {
        let movieId = Int(444)
        UserDefaults.addMovieId(movieId)
        XCTAssert(UserDefaults.containsMovieId(movieId), "Movie id not added to likedMovies in UserDefaults")
    }
    
    func testRemoveMovieFromUserDefaults() {
        let movieId = Int(444)
        UserDefaults.addMovieId(movieId)
        XCTAssert(UserDefaults.containsMovieId(movieId))
        UserDefaults.removeMovieId(movieId)
        XCTAssertFalse(UserDefaults.containsMovieId(movieId), "Movie id not removed from likedMovies in UserDefaults")
    }
}
