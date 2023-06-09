// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let movieResponseModel = try? JSONDecoder().decode(MovieResponseModel.self, from: jsonData)

import Foundation

// MARK: - MovieResponseModel
struct MovieResponseModel: Codable {  //general model for all
    let page: Int
    let results: [Movie]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct Movie: Codable {
    let backdrop_path: String?
    let id: Int?
    let title, original_language, original_title, overview: String?
    let poster_path: String?
    let media_type: String?
    let genre_ids: [Int?]
    let popularity: Double?
    let release_date: String?
    let video: Bool?
    let vote_averagee: Double?
    let vote_count: Int?
}

