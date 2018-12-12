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
        let button = TwitterLikeButton()
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
        posterImageView.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.left.lessThanOrEqualToSuperview().offset(xOffset)
            make.right.lessThanOrEqualToSuperview().offset(-xOffset)
            make.top.lessThanOrEqualTo(view.safeAreaLayoutGuide).offset(yOffset)
            make.bottom.lessThanOrEqualToSuperview().offset(-yOffset)
        }
        
        let customView = UIView(frame: customViewFrame)
        customView.addSubview(likeButton)
        likeButton.snp.makeConstraints { (make) in
            make.center.equalToSuperview()
            make.width.height.equalTo(likeButtonHeight)
        }
        
        let rightBarButton = UIBarButtonItem(customView: likeButton)
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
        
        let size = posterSizeForImage(image: image)
        let width = size.width
        let height = size.height
        
        posterImageView.snp.remakeConstraints { (make) in
            make.center.equalTo(view.safeAreaLayoutGuide)
            make.width.equalTo(width)
            make.height.equalTo(height)
        }
    }
    
    private func posterSizeForImage(image: UIImage) -> CGSize {
        var width = CGFloat(0)
        var height = CGFloat(0)
        let maxWidth = view.frame.width - xOffset * 2
        let maxHeight = view.frame.height - yOffset * 2
        
        if image.size.height > width {
            height = maxHeight
            width = height * image.size.width / image.size.height
        } else {
            width = maxWidth
            height = width * image.size.height / image.size.width
        }
        
        if width > maxWidth {
            width = maxWidth
            height = width * image.size.height / image.size.width
        } else if height > maxHeight {
            height = maxHeight
            width = height * image.size.width / image.size.height
        }
        
        return CGSize(width: width, height: height)
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
