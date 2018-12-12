//
//  MovieViewModel.swift
//  MovieDB
//
//  Created by Christos Home on 04/12/2018.
//  Copyright © 2018 Christos Bimpas. All rights reserved.
//

import UIKit

class MovieViewModel: NSObject {
    
    // MARK: - Properties
    
    var movie: Movie
    
    var title: String? {
        return movie.title
    }
    
    var releaseDate: String? {
        let dateFormatterInput = DateFormatter()
        dateFormatterInput.dateFormat = "yyyy-MM-dd"
        
        let dateFormatterOutput = DateFormatter()
        dateFormatterOutput.dateFormat = "MMMM dd, yyyy"
        
        guard let releaseDate = movie.releaseDate,
            let formattedDate = dateFormatterInput.date(from: releaseDate) else {
                return nil
        }
        return dateFormatterOutput.string(from: formattedDate)
    }
    
    var posterURL: URL? {
        guard let posterPath = movie.posterPath else {
            return nil
        }
        let urlString = "http://image.tmdb.org/t/p/w500/\(posterPath)"
        return URL(string: urlString)
    }
    
    var overview: String? {
        return movie.overview
    }
    
    var voteAverage: String? {
        guard let voteAveragePercent = voteAveragePercent else {
            return nil
        }
        
        return String(voteAveragePercent) + "%"
    }
    
    var voteAverageTextColor: UIColor {
        guard let voteAveragePercent = voteAveragePercent else {
            return .clear
        }
        
        if voteAveragePercent >= 70 {
            return .green
        } else if voteAveragePercent < 40 {
            return .red
        } else {
            return .orange
        }
    }
    
    var isLiked: Bool {
        guard let movieId = movie.id else { return false }
        return UserDefaults.containsMovieId(movieId)
    }
    
    private var voteAveragePercent: Int? {
        guard let voteAverage = movie.voteAverage else { return nil }
        return Int(voteAverage * 10.0)
    }
    
    // MARK: - Init
    
    init(movie: Movie) {
        self.movie = movie
        super.init()
    }
    
    // MARK : - Public methods
    
    func like() {
        guard let movieId = movie.id else { return }
        UserDefaults.addMovieId(movieId)
    }
    
    func unlike() {
        guard let movieId = movie.id else { return }
        UserDefaults.removeMovieId(movieId)
    }
}
