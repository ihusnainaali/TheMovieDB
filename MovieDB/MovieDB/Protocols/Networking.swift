//
//  Networking.swift
//  MovieDB
//
//  Created by Christos Home on 04/12/2018.
//  Copyright © 2018 Christos Bimpas. All rights reserved.
//

import Foundation

protocol Networking {
    func getRequest(path: String,query: String?, completion: @escaping (Data?, Error?) -> Void)
}
