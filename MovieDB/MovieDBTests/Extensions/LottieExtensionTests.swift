//
//  LottieExtensionTests.swift
//  MovieDBTests
//
//  Created by Christos Home on 12/12/2018.
//  Copyright © 2018 Christos Bimpas. All rights reserved.
//

import XCTest
@testable import MovieDB
@testable import Lottie

class LottieExtensionTests: XCTestCase {

    func testLottieTwitterLikeAnimationViewNotNil() {
        XCTAssert(LOTAnimationView.twitterLikeAnimationView != nil, "twitterLikeAnimationView is nil")
    }

    func testLottieVideoCamAnimationViewViewNotNil() {
        XCTAssert(LOTAnimationView.videoCamAnimationView != nil, "videoCamAnimationView is nil")
    }
    
    func testLottieLikeAnimationViewNotNil() {
        XCTAssert(LOTAnimationView.likeAnimationView != nil, "likeAnimationView is nil")
    }
    
    func testLottieInfiniteLoaderAnimationViewNotNil() {
        XCTAssert(LOTAnimationView.infiniteLoaderAnimationView != nil, "infiniteLoaderAnimationView is nil")
    }

}
