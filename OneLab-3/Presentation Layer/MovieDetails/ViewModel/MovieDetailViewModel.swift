//
//  MovieDetailViewModel.swift
//  OneLab-3
//
//  Created by Farukh Iskalinov on 15.07.20.
//  Copyright © 2020 Farukh Iskalinov. All rights reserved.
//

import Foundation
import UIKit

class MovieDetailViewModel {
    
    let movie: Movie
    let movieService: MovieService
    
    var posterImage: UIImage?
    var backDropImage: UIImage?
    var title: String?
    var tagline: String?
    var overview: String?

    var didLoadDetails: (() -> Void)?
    var updatePosterImage: (() -> Void)?
    var updateBackdropImage: (() -> Void)?
    
    init(movie: Movie, service: MovieService) {
        self.movie = movie
        self.movieService = service
    }
    
    func fetchMovieDetails() {                    
        movieService.getMovieDetails(movieId: movie.id, success: { [weak self] (movieDetail) in
            self?.title = movieDetail.title
            self?.tagline = movieDetail.tagline
            self?.overview = movieDetail.overview
            self?.didLoadDetails?()
            }, failure: { (error) in
                print("Error while requestion a movie detail with message \(error)")
        })
    }
    
    func fetchPosterImage() {
        if let path = movie.posterPath {
            movieService.getMovieImage(path: path, success: { [weak self] (image) in
                self?.posterImage = image
                self?.updatePosterImage?()
                }, failure: { (error) in
                    print("Error while requestion a movie poster image with message \(error)")
            })
        } else {
            posterImage = UIImage(named: "placeholder")
            updatePosterImage?()
        }
        
    }
    
    func fetchBackDropImage() {
        if let path = movie.backdropPath {
            movieService.getMovieImage(path: path, success: { [weak self] (image) in
                self?.backDropImage = image
                self?.updateBackdropImage?()
                }, failure: { (error) in
                    print("Error while requestion a movie backdrop image with message \(error)")
            })
        } else {
            if let path = movie.posterPath {
                movieService.getMovieImage(path: path, success: { [weak self] (image) in
                    self?.backDropImage = image
                    self?.updateBackdropImage?()
                    }, failure: { (error) in
                        print("Error while requestion a movie backdrop image with message \(error)")
                })
            } else {
                backDropImage = UIImage(named: "placeholder")
                updatePosterImage?()
            }
            
        }

    }
}
