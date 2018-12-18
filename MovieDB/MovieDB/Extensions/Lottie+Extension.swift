//
//  Lottie+Extension.swift
//  MovieDB
//
//  Created by Christos Home on 05/12/2018.
//  Copyright © 2018 Christos Bimpas. All rights reserved.
//

import Lottie

extension LOTAnimationView {
    final class var videoCamAnimationView: LOTAnimationView? {
        let filename = "video_cam"
        guard filename.isValidResourceFile() else {
            return nil
        }
        
        let view = LOTAnimationView(name: filename, bundle: Bundle.main)
        view.contentMode = .scaleAspectFit
        return view
    }
    
    final class var likeAnimationView: LOTAnimationView? {
        let filename = "like_pop_animation"
        guard filename.isValidResourceFile() else {
            return nil
        }
        
        let view = LOTAnimationView(name: filename, bundle: Bundle.main)
        view.contentMode = .scaleAspectFit
        return view
    }
    
    final class var twitterLikeAnimationView: LOTAnimationView? {
        let filename = "TwitterFavoriteHeart"
        guard filename.isValidResourceFile() else {
            return nil
        }
        
        let view = LOTAnimationView(name: filename, bundle: Bundle.main)
        view.contentMode = .scaleAspectFit
        return view
    }
    
    final class var infiniteLoaderAnimationView: LOTAnimationView? {
        let filename = "loader_4"
        guard filename.isValidResourceFile() else {
            return nil
        }
        let view = LOTAnimationView(name: filename, bundle: Bundle.main)
        view.contentMode = .scaleAspectFit
        view.loopAnimation = true
        return view
    }
}

