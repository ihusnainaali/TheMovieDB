//
//  Lottie+Extension.swift
//  MovieDB
//
//  Created by Christos Home on 05/12/2018.
//  Copyright © 2018 Christos Bimpas. All rights reserved.
//

import Lottie

extension LOTAnimationView {
    static var videoCamAnimationView: LOTAnimationView? {
        let filename = "video_cam"
        guard isFilenameValid(filename) else {
            return nil
        }
        
        let view = LOTAnimationView(name: filename, bundle: Bundle.main)
        view.contentMode = .scaleAspectFit
        return view
    }
    
    static var likeAnimationView: LOTAnimationView? {
        let filename = "like_pop_animation"
        guard isFilenameValid(filename) else {
            return nil
        }
        
        let view = LOTAnimationView(name: filename, bundle: Bundle.main)
        view.contentMode = .scaleAspectFit
        return view
    }
    
    static var twitterLikeAnimationView: LOTAnimationView? {
        let filename = "TwitterFavoriteHeart"
        guard isFilenameValid(filename) else {
            return nil
        }
        
        let view = LOTAnimationView(name: filename, bundle: Bundle.main)
        view.contentMode = .scaleAspectFit
        return view
    }
    
    static var infiniteLoaderAnimationView: LOTAnimationView? {
        let filename = "loader_4"
        guard isFilenameValid(filename) else {
            return nil
        }
        let view = LOTAnimationView(name: filename, bundle: Bundle.main)
        view.contentMode = .scaleAspectFit
        view.loopAnimation = true
        return view
    }
    
    static func isFilenameValid(_ filename: String) ->  Bool {
        guard Bundle.main.url(forResource: filename, withExtension: "json") != nil else {
            return false
        }
        return true
    }
}
