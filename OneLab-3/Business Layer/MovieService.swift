//
//  MovieService.swift
//  OneLab-3
//
//  Created by Farukh Iskalinov on 9.07.20.
//  Copyright © 2020 Farukh Iskalinov. All rights reserved.
//

import Alamofire
import AlamofireImage
import UIKit

protocol MovieService {
    
    func getPopularMovies(page: Int, success: @escaping(Movie, UIImage) -> Void, failure: @escaping(Error) -> Void)
    func getMovieDetails(movieId: Int, success: @escaping(MovieDetails) -> Void, failure: @escaping(Error) -> Void)
    func getMovieImage(path: String, success: @escaping(UIImage) -> Void, failure: @escaping(Error) -> Void)
}

class MovieServiceImplementation: MovieService {
    
    func getMovieImage(path: String, success: @escaping(UIImage) -> Void, failure: @escaping(Error) -> Void) {
        let urlString = String(format: "%@%@", Api.imageBaseUrl, path)
        guard let url = URL(string: urlString) else { return }
        AF.request(url, method: .get).responseImage { (response) in
            switch response.result {
                case .success(let image):
                    success(image)
                case .failure(let error):
                    failure(error)
            }
        }
    }
    
    func getMovieDetails(movieId: Int, success: @escaping (MovieDetails) -> Void, failure: @escaping (Error) -> Void) {
        
        let urlString = String(format: "%@/movie/%@", Api.baseUrl, "\(movieId)")
        guard let url = URL(string: urlString) else { return }
        let query: Parameters = [
            "api_key": Api.key,
            "language": Api.language,
        ]
        AF.request(url, method: .get, parameters: query).responseDecodable { (dataResponse: DataResponse<MovieDetails, AFError>) in
            switch dataResponse.result {
             case .success(let detail):
                success(detail)
             case .failure(let error):
                failure(error)
            }
        }
    }
    
    
    func getPopularMovies(page: Int, success: @escaping(Movie, UIImage) -> Void, failure: @escaping(Error) -> Void) {
        
        let urlString = String(format: "%@/movie/popular", Api.baseUrl)
        guard let url = URL(string: urlString) else { return }
        let query: Parameters = [
            "api_key": Api.key,
            "language": Api.language,
            "page": page
        ]
        AF.request(url, method: .get, parameters: query).responseDecodable { (dataResponse: DataResponse<MovieData, AFError>) in
            switch dataResponse.result {
             case .success(let wrapper):
                let movies = wrapper.results
                Api.totalPages = wrapper.totalPages
                movies.forEach {
                    if let urlImage = URL(string: String(format: "%@%@", Api.imageBaseUrl, $0.posterPath)) {
                        if let newData = try? Data(contentsOf: urlImage), let image = UIImage(data: newData) {
                            success($0, image)
                        }
                    }
                }
            case .failure(let error): failure(error)
            }
        }
    }
    
    private func parseMovieData(_ data: Data) -> MovieData? {
        
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(MovieData.self, from: data)
            let page = decodedData.page
            let totalResults = decodedData.totalResults
            let totalPages = decodedData.totalPages
            let results = decodedData.results
            let movieData = MovieData(page: page, totalResults: totalResults, totalPages: totalPages, results: results)
            return movieData
        } catch {
            print("Error while parsing a Movie data with message \(error)")
            return nil
        }
    }
    
    private func parseMovieDetails(_ data: Data) -> MovieDetails? {
        
        let decoder = JSONDecoder()
       
        do {
            let decodedData = try decoder.decode(MovieDetails.self, from: data)
            let backDropPath = decodedData.backDropPath
            let posterPath = decodedData.posterPath
            let overview = decodedData.overview
            let title = decodedData.title
            let tagline = decodedData.tagline
            let movieData = MovieDetails(backDropPath: backDropPath, posterPath: posterPath, overview: overview, title: title, tagline: tagline)
            return movieData
        } catch {
            print("Error while parsing a Movie details with message \(error)")
            return nil
        }
    }
}
