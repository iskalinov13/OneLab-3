//
//  MovieListViewModel.swift
//  OneLab-3
//
//  Created by Farukh Iskalinov on 9.07.20.
//  Copyright © 2020 Farukh Iskalinov. All rights reserved.
//

import Foundation
import UIKit

class MovieListViewModel {
    
    var movies: [CellConfigurator] = []
    let movieService: MovieService
    var currentPage = 1
    var isRequestPerforming = false
    var didLoadTableItems: (() -> Void)?
    var didStopAnimating: (() -> Void)?
    
    init(movieService: MovieService) {
        self.movieService = movieService
    }
    
    func fetchPopularMovies() {
        
        isRequestPerforming = true
        
        movieService.getPopularMovies(page: currentPage, success: { [weak self] (movie, image) in
            if let image = image {
                self?.movies.append(ImageCellConfigurator(item: image))
            } else {
                self?.movies.append(ImageCellConfigurator(item: UIImage(named: "placeholder")!))
            }
            self?.movies.append(InfoCellConfigurator(item: movie))
            
            DispatchQueue.main.async {
                self?.didLoadTableItems?()
                self?.didStopAnimating?()
            }
        }, failure: { (error) in
            print("Error while requesting a popular movies, with message \(error)")
        })
        isRequestPerforming = false
        currentPage += 1
    }
}
