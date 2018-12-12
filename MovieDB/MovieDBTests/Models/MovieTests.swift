//
//  MovieTests.swift
//  MovieDBTests
//
//  Created by Christos Home on 03/12/2018.
//  Copyright © 2018 Christos Bimpas. All rights reserved.
//

import XCTest
@testable import MovieDB

class MovieTests: XCTestCase {

    let id = Int(3)
    let title = "Venom"
    let releaseDate = "2018-10-10"
    let overview = "Movie overview"
    let voteAverage = Double(54)
    let posterPath = "/venom.jpg"
    
    var movie: Movie {
        return Movie(id: id,
                     title: title,
                     releaseDate: releaseDate,
                     overview: overview,
                     voteAverage: voteAverage,
                     posterPath: posterPath)
    }
    
    func testMovieInit() {
        XCTAssert(id == movie.id, "Movie id not set correctly")
        XCTAssert(title == movie.title, "Movie title not set correctly")
        XCTAssert(releaseDate == movie.releaseDate, "Movie releaseDate not set correctly")
        XCTAssert(overview == movie.overview, "Movie overview not set correctly")
        XCTAssert(voteAverage == movie.voteAverage, "Movie voteAverage not set correctly")
        XCTAssert(posterPath == movie.posterPath, "Movie posterPath not set correctly")
    }
    
    func testMovieCodable() {
        let jsonEncoder = JSONEncoder()
        let jsonEncodedData = try? jsonEncoder.encode(movie)
        
        guard let jsonData = jsonEncodedData else {
            XCTFail("Encoded Movie to JSON is nil")
            return
        }
        
        let jsonDecoder = JSONDecoder()
        let decodedModel = try? jsonDecoder.decode(Movie.self, from: jsonData)
        
        guard let decodedMovie = decodedModel else {
            XCTFail("Decoded Movie is nil")
            return
        }
        
        XCTAssert(decodedMovie == movie, "Decoded Movie is not equal to initial Movie")
    }

    
    

}
