//
//  DetailViewController.swift
//  OneLab-3
//
//  Created by Farukh Iskalinov on 15.07.20.
//  Copyright © 2020 Farukh Iskalinov. All rights reserved.
//

import UIKit
import UICircularProgressRing

class MovieDetailsViewController: UIViewController {
    
    private let viewModel: MovieDetailViewModel
    
    init(viewModel: MovieDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let backDropImageView: UIImageView = {
        let image = UIImageView()
        image.alpha = 0.3
        return image
    }()
    
    private let posterImageView: UIImageView = {
        let image = UIImageView()
        image.layer.masksToBounds = true
        image.clipsToBounds = true
        image.layer.cornerRadius = 10
        return image
    }()
    
    private let movieTitleLabel: UILabel =  {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 1
        return label
    }()
    
    private let movieTaglineLabel: UILabel =  {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = .italicSystemFont(ofSize: 17)
        label.textAlignment = .left
        label.numberOfLines = 2
        return label
    }()
    
    private let movieOverviewLabel: UITextView  =  {
        let label = UITextView()
        label.textColor = .white
        label.backgroundColor = #colorLiteral(red: 0.01287723985, green: 0.1454687715, blue: 0.255453229, alpha: 1)
        label.font = .systemFont(ofSize: 16)
        label.textAlignment = .left
        label.setContentHuggingPriority(.defaultHigh, for: .vertical)
        label.isEditable = false
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [movieTitleLabel, movieTaglineLabel, movieOverviewLabel])
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 8
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        layoutUI()
        
        fetchImages()
        
        fetchMovieDetails()
        
        bindViewModel()

    }
    
    private func fetchImages() {
        viewModel.fetchBackDropImage()
        viewModel.fetchPosterImage()
    }
    
    private func fetchMovieDetails() {
        viewModel.fetchMovieDetails()
    }
    
    private func bindViewModel() {
        viewModel.updatePosterImage = { [weak self] in
            self?.posterImageView.image = self?.viewModel.posterImage
        }
        
        viewModel.updateBackdropImage = { [weak self] in
            self?.backDropImageView.image = self?.viewModel.backDropImage
        }
        
        viewModel.didLoadDetails = { [weak self] in
            self?.movieTitleLabel.text = self?.viewModel.title
            self?.movieTaglineLabel.text = self?.viewModel.tagline
            self?.movieOverviewLabel.text = self?.viewModel.overview
        }
    }
    
    private func layoutUI() {
        
        view.backgroundColor = #colorLiteral(red: 0.01287723985, green: 0.1454687715, blue: 0.255453229, alpha: 1)
        view.addSubview(backDropImageView)
        backDropImageView.snp.makeConstraints { (make) in
            make.leading.top.trailing.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.height.equalTo(UIScreen.main.bounds.height / 2)
        }
        
        view.addSubview(stackView)
        stackView.snp.makeConstraints { (make) in
            make.top.equalTo(backDropImageView.snp.bottom).offset(8)
            make.leading.trailing.bottom.equalTo(view.safeAreaLayoutGuide).inset(10)
            
        }
        view.addSubview(posterImageView)
        posterImageView.snp.makeConstraints { (make) in
            make.leading.equalTo(backDropImageView.snp.leading).inset(10)
            make.bottom.equalTo(backDropImageView.snp.bottom).inset(10)
            make.height.equalTo(backDropImageView.snp.height).multipliedBy(0.6)
            make.width.equalTo(backDropImageView.snp.width).multipliedBy(0.5)
            
        }
    }
}
