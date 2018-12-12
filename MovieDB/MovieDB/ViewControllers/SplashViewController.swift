//
//  SplashViewController.swift
//  MovieDB
//
//  Created by Christos Home on 11/12/2018.
//  Copyright © 2018 Christos Bimpas. All rights reserved.
//

import UIKit
import Lottie
import SnapKit

class SplashViewController: UIViewController, NavigationTitleProtocol {
    
    // MARK: - Protocol stubs
    
    var titleLabel: UILabel = UILabel()
    
    // MARK : - UI
    
    let videoCamAnimationView = LOTAnimationView.videoCamAnimationView
    
    // MARK : - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configureNavigationTitleLabel(title: "Movie DB")
        setupViews()
        playAnimation()
    }
    
    // MARK : - Private methods
    
    private func setupViews() {
        guard let videoCamAnimationView = videoCamAnimationView else { return }
        view.addSubview(videoCamAnimationView)
        videoCamAnimationView.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
        }
    }
    
    private func playAnimation() {
        guard let videoCamAnimationView = videoCamAnimationView else {
            finish()
            return
        }
        videoCamAnimationView.play(fromProgress: 0, toProgress: 1) { [weak self] _ in
            self?.finish()
        }
    }
    
    private func finish() {
        let networkClient = NetworkClient()
        let viewModel = MovieDBViewModel(networkClient: networkClient)
        let viewController = MovieDBViewController(viewModel: viewModel)
        navigationController?.viewControllers = [viewController]
    }
    
}
