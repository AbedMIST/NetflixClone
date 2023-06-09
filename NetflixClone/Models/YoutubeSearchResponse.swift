//
//  YoutubeSearchResponse.swift
//  NetflixClone
//
//  Created by BS1095 on 6/6/23.
//

import Foundation

struct YoutubeSearchResponse: Codable {
    let items: [videoElements]
}

struct videoElements: Codable{
    let id: idVideoElements
}

struct idVideoElements: Codable{
    let kind: String
    let videoId: String
}
