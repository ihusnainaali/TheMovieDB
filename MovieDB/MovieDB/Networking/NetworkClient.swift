//
//  NetworkingClient.swift
//  MovieDB
//
//  Created by Christos Home on 04/12/2018.
//  Copyright © 2018 Christos Bimpas. All rights reserved.
//

import Foundation

class NetworkClient: Networking {
    
    // MARK: - Properties
    
    private var baseUrlString = "https://api.themoviedb.org/3/"
    private let defaultSession = URLSession(configuration: .default)
    private var dataTask: URLSessionDataTask?
    
    // MARK: - Methods
    
    func getRequest(path: String, query: String?, completion: @escaping (Data?, Error?) -> Void) {
        var urlComponents = URLComponents(string: baseUrlString + path)
        urlComponents?.query = query
        
        guard let url = urlComponents?.url else {
            completion(nil, nil)
            return
        }
        
        dataTask?.cancel()
        
        dataTask = defaultSession.dataTask(with: url) { data, response, error in
            completion(data, error)
        }
        
        dataTask?.resume()
    }
}
