//
//  MovieDBViewModelTests.swift
//  MovieDBTests
//
//  Created by Christos Home on 05/12/2018.
//  Copyright © 2018 Christos Bimpas. All rights reserved.
//

import XCTest
@testable import MovieDB

class MovieDBViewModelTests: XCTestCase {

    let mockNetworkClient = MockNetworkingClient()
    var viewModel: MovieDBViewModel!
    
    override func setUp() {
        viewModel = MovieDBViewModel(networkClient: mockNetworkClient)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testApiKeySet() {
        XCTAssert(viewModel.apiKey != nil, "ApiKey in MovieDBViewModel is not set")
    }

    func testViewModelFetchDataSuccess() {
        viewModel.apiKey = "123456789"
        mockNetworkClient.shouldSucceed = true
        
        let expectation = self.expectation(description: "Fetch Page successfully")
        var hasSuccess: Bool = false
        var hasError = true
        
        viewModel.observeFetchCompletion { (success, error) in
            hasSuccess = success
            hasError = error != nil
            expectation.fulfill()
        }
        
        viewModel.fetchData()
    
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssert(hasSuccess, "Page fetched success")
        XCTAssert(!hasError, "Error fetching Page")
    }
    
    func testViewModelFetchedAllPages() {
        viewModel.apiKey = "123456789"
        mockNetworkClient.shouldSucceed = true
        viewModel.page = Page(pageNumber: 45, totalPages: 45, results: [])
        mockNetworkClient.lastPage = viewModel.page
        
        let expectation = self.expectation(description: "Fetch Last Page successfully")
        var fetchedAllPagedsIsObserved  = false
        
        viewModel.observeFetchedAllPagesCompletion {
            fetchedAllPagedsIsObserved = true
            expectation.fulfill()
        }
        
        viewModel.fetchData()
        
        waitForExpectations(timeout: 5, handler: nil)
        
        XCTAssert(fetchedAllPagedsIsObserved, "Observe Fetched All Pages Failed")
    }
}
