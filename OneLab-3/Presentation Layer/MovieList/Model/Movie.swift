//
//  Movie.swift
//  OneLab-3
//
//  Created by Farukh Iskalinov on 8.07.20.
//  Copyright © 2020 Farukh Iskalinov. All rights reserved.
//

import Foundation

struct MovieData: Decodable {
    let page: Int
    let totalResults: Int
    let totalPages: Int
    let results: [Movie]
    
    private enum CodingKeys : String, CodingKey {
        case page, totalResults = "total_results", totalPages = "total_pages", results
    }
}

struct Movie: Decodable {
    let popularity: Double
    let voteCount: Int
    let video: Bool
    let posterPath: String
    let id: Int
    let adult: Bool
    let backdropPath: String
    let originalLanguage: String
    let originalTitle: String
    let genreIds: [Int]
    let title: String
    let voteAverage: Float
    let overview: String
    let releaseDate: String
    
    private enum CodingKeys : String, CodingKey {
        case popularity, voteCount = "vote_count", video, posterPath = "poster_path", id, adult, backdropPath = "backdrop_path", originalLanguage = "original_language", originalTitle = "original_title", genreIds = "genre_ids", title, voteAverage = "vote_average", overview, releaseDate = "release_date"
    }
}





