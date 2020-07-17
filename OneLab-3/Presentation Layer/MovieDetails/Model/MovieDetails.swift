//
//  MovieDetails.swift
//  OneLab-3
//
//  Created by Farukh Iskalinov on 17.07.20.
//  Copyright © 2020 Farukh Iskalinov. All rights reserved.
//

import Foundation

struct MovieDetails: Decodable {
    let backDropPath: String
    let posterPath: String
    let overview: String
    let title: String
    let tagline: String
    
    private enum CodingKeys: String, CodingKey {
        case backDropPath = "backdrop_path", posterPath = "poster_path", overview, title, tagline
    }
}
