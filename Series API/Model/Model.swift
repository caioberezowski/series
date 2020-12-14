//
//  Model.swift
//  Series API
//
//  Created by Caio Berezowski on 12/12/20.
//

import Foundation

struct SeriesData: Decodable {
    let series: [Serie]
    
    private enum CodingKeys: String, CodingKey{
        case series = "results"
    }
}

struct Serie: Decodable {
    let title: String?
    let overview: String?
    let rate: Double?
    let posterImage: String?
    let count: Int
    
    private enum CodingKeys: String, CodingKey {
        case overview
        case title = "name"
        case rate = "vote_average"
        case posterImage = "poster_path"
        case count = "vote_count"
    }
    
}
