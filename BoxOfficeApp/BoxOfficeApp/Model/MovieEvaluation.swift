//
//  MovieEvaluation.swift
//  BoxOfficeApp
//
//  Created by oingbong on 08/12/2018.
//  Copyright © 2018 oingbong. All rights reserved.
//

import Foundation

struct MovieEvaluation: Decodable {
    var movieId: String // 영화 고유ID
    var rating: Double // 평점
    var timestamp: Double // 작성일시 UNIX Timestamp 값
    var writer: String // 작성자
    var contents: String // 한줄평 내용
    
    enum CodingKeys: String, CodingKey {
        case movieId = "movie_id"
        case rating = "rating"
        case timestamp = "timestamp"
        case writer = "writer"
        case contents = "contents"
    }
}
