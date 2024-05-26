//
//  Structs.swift
//  WilsonWang-Lab4
//
//  Created by Wilson Wang on 10/30/23.
//

import Foundation

struct APIResults:Decodable {
    let page: Int
    let total_results: Int
    let total_pages: Int
    let results: [Movie]
}

struct Movie: Decodable {
    let id: Int!
    let poster_path: String?
    let title: String
    let release_date: String?
    let vote_average: Double?
    let overview: String?
    let vote_count:Int!
}
