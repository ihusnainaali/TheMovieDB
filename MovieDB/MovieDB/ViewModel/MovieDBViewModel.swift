//
//  MovieDBViewModel.swift
//  MovieDB
//
//  Created by Christos Home on 04/12/2018.
//  Copyright © 2018 Christos Bimpas. All rights reserved.
//

import UIKit

class MovieDBViewModel: NSObject {
    
    typealias CompletionBlock = (Bool, Error?) -> Void
    typealias VoidCompletionBlock = () -> Void
    
    // MARK: - API KEY
    
    //You can get your api key here https://developers.themoviedb.org/3/getting-started/introduction
    
    var apiKey: String? = "a958639c02dfa3b7b4dedd5b32f98226"
    
    // MARK: - Constants
    
    let collectionViewPadding = CGFloat(10)
    let title = "Popular Movies"
    
    private let collectionViewFooterHeight = CGFloat(80)
    private let path = "movie/popular"
    private let initialPage = Int(1)
    
    // MARK: - Properties
    
    var networkClient: Networking
    private var completionBlock: CompletionBlock?
    private var fetchedAllPagesCompletionBlock: VoidCompletionBlock?
    private var noApiKeyCompletionBlock: VoidCompletionBlock?
    private var didFetchAllPages = false
    
    var page: Page? {
        didSet {
            guard let pageResults = page?.results else { return }
            movies.append(contentsOf: pageResults)
        }
    }
    
    var movies = [Movie]()
    
    var numberOfItems: Int {
        return movies.count
    }
    
    var shouldFetchData: Bool {
        return numberOfItems > 0 && !didFetchAllPages
    }
    
    private var nextPageNumber: Int? {
        var pageNumber = initialPage
        
        guard let page = page,
            let currentPageNumber = page.pageNumber,
            let currentTotalPages = page.totalPages else {
                return pageNumber
        }
        
        pageNumber = currentPageNumber + 1
        
        guard pageNumber <= currentTotalPages else {
            return nil
        }
        
        return pageNumber
    }
    
    private var shouldHideFooter: Bool {
        return didFetchAllPages || apiKey == nil
    }
    
    // MARK: - Init
    
    init(networkClient: Networking) {
        self.networkClient = networkClient
        super.init()
    }
    
    // MARK: - Public methods
    
    // MARK: - Data
    
    func fetchData() {
        guard let pageNumber = nextPageNumber else {
            didFetchAllPages = true
            fetchedAllPagesCompletionBlock?()
            return
        }
        
        guard let apiKey = apiKey else {
            noApiKeyCompletionBlock?()
            return
        }
        
        let query = "api_key=\(apiKey)&page=\(pageNumber)"
        
        networkClient.getRequest(path: path, query: query) { [weak self] data, error in
            guard let data = data else {
                print(error ?? "network data couldn't be fetched")
                self?.completionBlock?(false, error)
                return
            }
            
            do {
                let jsonDecoder = JSONDecoder()
                self?.page = try jsonDecoder.decode(Page.self, from: data)
                self?.completionBlock?(self?.page != nil, nil)
            }
            catch {
                print(error)
                self?.completionBlock?(false, error)
            }
        }
    }
    
    func movieModelAtIndex(index: Int) -> MovieViewModel? {
        guard let movie = movies[safe: index] else { return nil }
        return MovieViewModel(movie: movie)
    }
    
    // MARK: Sizes
    
    func itemSizeInView(frame: CGRect) -> CGSize {
        return CGSize(width: frame.width - collectionViewPadding * 2, height: frame.width * 2.0 / 3.0)
    }
    
    func headerSizeInView(frame: CGRect) -> CGSize {
        return CGSize(width: frame.width, height: collectionViewPadding)
    }
    
    func footerSizeInView(frame: CGRect) -> CGSize {
        return CGSize(width: frame.width, height: shouldHideFooter ? 0 : collectionViewFooterHeight)
    }
    
    // MARK: Observers
    
    func observeFetchCompletion(_ block: @escaping CompletionBlock) {
        completionBlock = block
    }
    
    func observeFetchedAllPagesCompletion(_ block: @escaping VoidCompletionBlock) {
        fetchedAllPagesCompletionBlock = block
    }
    
    func observeNoApiKeyCompletion(_ block: @escaping VoidCompletionBlock) {
        noApiKeyCompletionBlock = block
    }
}
