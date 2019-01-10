//
//  MoviewDBViewController.swift
//  MovieDB
//
//  Created by Christos Home on 03/12/2018.
//  Copyright © 2018 Christos Bimpas. All rights reserved.
//

import UIKit
import SnapKit
import Lottie

class MovieDBViewController: UIViewController, NavigationTitleProtocol {
    
    // MARK: - Protocol stubs
    
    var titleLabel = UILabel()
    
    // MARK: - Properties

    var viewModel: MovieDBViewModel
    
    var layout: UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = viewModel.itemSizeInView(frame: view.frame)
        layout.headerReferenceSize = viewModel.headerSizeInView(frame: view.frame)
        layout.footerReferenceSize = viewModel.footerSizeInView(frame: view.frame)
        layout.minimumInteritemSpacing = viewModel.collectionViewPadding
        return layout
    }
    
    // MARK: - UI Elements
    
    lazy private var collectionView: UICollectionView = {
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(MovieCollectionViewCell.self,
                                forCellWithReuseIdentifier: MovieCollectionViewCell.identifier)
        
        collectionView.register(UICollectionReusableView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: UICollectionReusableView.identifier)
        
        collectionView.register(MovieCollectionViewFooterView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter,
                                withReuseIdentifier: MovieCollectionViewFooterView.identifier)
        
        collectionView.backgroundColor = .clear
        collectionView.dataSource = self
        collectionView.delegate = self
        
        return collectionView
    }()
    
    // MARK: - Init
    
    init(viewModel: MovieDBViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .whiteSmoke
        configureNavigationTitleLabel(title: viewModel.title)
        setupViews()
        addObservers()
        viewModel.fetchData()
        view.hideSubViewsWithAnimationDuration(0)
        view.displaySubViewsWithAnimationDuration(0.5)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }

    // MARK: - Private methods
    
    private func setupViews() {
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.edges.equalTo(view)
        }
    }
    
    private func didFetchMovies() {
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
    }
    
    private func invalidateLayout() {
        collectionView.collectionViewLayout.invalidateLayout()
        collectionView.collectionViewLayout = layout
    }
    
    private func addObservers() {
        viewModel.observeFetchCompletion { [weak self] success, _ in
            guard success else { return }
            self?.didFetchMovies()
        }
        
        viewModel.observeFetchedAllPagesCompletion { [weak self] in
            self?.invalidateLayout()
        }
        
        viewModel.observeNoApiKeyCompletion { [weak self] in
            self?.presentNoApiKeyAlert()
        }
    }
    
    private func presentNoApiKeyAlert() {
        let alertController = UIAlertController.noApiKeyAlert
        present(alertController, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDataSource Cells

extension MovieDBViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.identifier, for: indexPath) as? MovieCollectionViewCell,
        let movieViewModel = viewModel.movieModelAtIndex(index: indexPath.row) else {
            return UICollectionViewCell()
        }
        cell.viewModel = movieViewModel
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        switch kind {
        case UICollectionView.elementKindSectionFooter:
            let supplementaryView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: MovieCollectionViewFooterView.identifier, for: indexPath)
            return supplementaryView
        case UICollectionView.elementKindSectionHeader:
            let supplementaryView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: UICollectionReusableView.identifier, for: indexPath)
            return supplementaryView
        default:
            fatalError("Unexpected element kind")
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        guard elementKind == UICollectionView.elementKindSectionFooter else { return }
        guard let footerView = view as? MovieCollectionViewFooterView else { return }
        guard viewModel.shouldFetchData else { return }
        footerView.startAnimating()
        viewModel.fetchData()
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, at indexPath: IndexPath) {
        guard elementKind == UICollectionView.elementKindSectionFooter else { return }
        guard let footerView = view as? MovieCollectionViewFooterView else { return }
        footerView.stopAnimating()
    }
}

// MARK: - UICollectionViewDelegate

extension MovieDBViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let movie = viewModel.movies[safe: indexPath.row] else { return }
        let movieViewModel = MovieViewModel(movie: movie)
        let movieViewController = MovieViewController(viewModel: movieViewModel)
        navigationController?.pushViewController(movieViewController, animated: true)
    }
}
