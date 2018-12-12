//
//  PageTests.swift
//  MovieDBTests
//
//  Created by Christos Home on 05/12/2018.
//  Copyright © 2018 Christos Bimpas. All rights reserved.
//

import XCTest
@testable import MovieDB

class PageTests: XCTestCase {

    let id = Int(456)
    let title = "Venom"
    let releaseDate = "2017-10-10"
    let overview = "Movie overview"
    let voteAverage = Double(74)
    let posterPath = "/venom.jpg"
    
    var movie: Movie {
        return Movie(id: id,
                     title: title,
                     releaseDate: releaseDate,
                     overview: overview,
                     voteAverage: voteAverage,
                     posterPath: posterPath)
    }
    
    let pageNumber = Int(2)
    let totalPages = Int(922)
    
    var results: [Movie] = []
    
    var page: Page {
        return Page(pageNumber: pageNumber, totalPages: totalPages, results: results)
    }
    
    override func setUp() {
        results = [movie, movie, movie]
    }
    
    func testPageInit() {
        XCTAssert(pageNumber == page.pageNumber, "Page page number not set correctly")
        XCTAssert(totalPages == page.totalPages, "Page total pages set correctly")
        XCTAssert(results == page.results, "Page results not set correctly")
    }
    
    func testPageCodable() {
        let jsonEncoder = JSONEncoder()
        let jsonEncodedData = try? jsonEncoder.encode(page)
        
        guard let jsonData = jsonEncodedData else {
            XCTFail("Encoded Page to JSON is nil")
            return
        }
        
        let jsonDecoder = JSONDecoder()
        let decodedModel = try? jsonDecoder.decode(Page.self, from: jsonData)
        
        guard let decodedPage = decodedModel else {
            XCTFail("Decoded Page is nil")
            return
        }
        
        XCTAssert(decodedPage == page, "Decoded Page is not equal to initial Page")
    }
}
