//
//  MovieViewController.swift
//  MovieDB
//
//  Created by Christos Home on 05/12/2018.
//  Copyright © 2018 Christos Bimpas. All rights reserved.
//

import UIKit
import SnapKit

class MovieViewController: UIViewController, NavigationTitleProtocol {
    
    // MARK: - Protocol stubs
    
    var titleLabel = UILabel()
    
    // MARK: - Constants
    
    private let xOffset = CGFloat(20)
    private let yOffset = CGFloat(100)
    private let customViewFrame = CGRect(x: 0, y: 0, width: 60, height: 44)
    private let likeButtonHeight = CGFloat(44)
    
    // MARK: - Properties
    
    var viewModel: MovieViewModel
    
    // MARK: - UI Elements
    
    lazy private var posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.borderColor = UIColor.white.cgColor
        imageView.layer.borderWidth = 5
        imageView.backgroundColor = .white
        return imageView
    }()
    
    lazy var likeButton: TwitterLikeButton = {
        let button = TwitterLikeButton(frame: customViewFrame)
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(didTapOnButton(_:)), for: .touchUpInside)
        button.selectWithoutAnimation(viewModel.isLiked)
        return button
    }()
    
    // MARK: - Init
    
    init(viewModel: MovieViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK : - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .charcoal
        configureNavigationTitleLabel(title: viewModel.title)
        setupViews()
        setPosterImage()
    }
    
    // MARK : - Private methods
    
    private func setupViews() {
        view.addSubview(posterImageView)
        
        let customView = UIView(frame: customViewFrame)
        customView.addSubview(likeButton)
        likeButton.snp.makeConstraints { (make) in
            make.edges.equalToSuperview()
            make.width.height.equalTo(likeButtonHeight)
        }
        
        let rightBarButton = UIBarButtonItem(customView: customView)
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    private func setPosterImage() {
        guard let url = viewModel.posterURL else { return }
        posterImageView.sd_setImage(with: url) { [weak self] (image, _, _, _) in
            self?.remakeConstraintsForImage(image: image)
        }
    }
    
    private func remakeConstraintsForImage(image: UIImage?) {
        guard let image = image else { return }
        
        let maxWidth = view.frame.width - xOffset * 2
        let maxHeight = view.frame.height - yOffset * 2
        
        let size = image.imageSize(maxWidth: maxWidth, maxHeight: maxHeight)
        let width = size.width
        let height = size.height
        
        posterImageView.snp.remakeConstraints { (make) in
            make.center.equalTo(view.safeAreaLayoutGuide)
            make.width.equalTo(width)
            make.height.equalTo(height)
        }
    }
    
    @objc private func didTapOnButton(_ button: UIButton) {
        button.isSelected.toggle()
        if button.isSelected {
            viewModel.like()
        } else {
            viewModel.unlike()
        }
    }
}
