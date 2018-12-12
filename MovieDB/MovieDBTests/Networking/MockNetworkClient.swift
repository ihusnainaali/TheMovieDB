//
//  MockNetworkClient.swift
//  MovieDBTests
//
//  Created by Christos Home on 05/12/2018.
//  Copyright © 2018 Christos Bimpas. All rights reserved.
//

import Foundation
@testable import MovieDB

class MockNetworkingClient: Networking {
    
    // MARK: - Properties
    
    var baseUrlString: String = ""
    var shouldSucceed = false
    
    var error: NSError {
        let userInfo = [NSLocalizedDescriptionKey: "Request failed"]
        let error = NSError(domain: "Fail", code: 0, userInfo: userInfo)
        return error
    }
    
    var lastPage: Page?
    
    // MARK: - Methods
    
    func getRequest(path: String, query: String?, completion: @escaping (Data?, Error?) -> Void) {
        guard shouldSucceed else {
            completion(nil, error)
            return
        }
        let movie1 = Movie(id: 1, title: "Venom",
                           releaseDate: "2010-08-08",
                           overview: "overview",
                           voteAverage: 86,
                           posterPath: "posterPath")
        let movie2 = Movie(id: 1, title: "Venom2",
                           releaseDate: "2012-08-08",
                           overview: "overview2",
                           voteAverage: 43,
                           posterPath: "posterPath2")
        let page = lastPage ?? Page(pageNumber: 11, totalPages: 555, results: [movie1, movie2])
        
        let jsonEncodedData = try? JSONEncoder().encode(page)
        
        guard let jsonData = jsonEncodedData else {
            completion(nil, error)
            return
        }
        completion(jsonData, nil)
    }
}
