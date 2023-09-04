//
//  Post.swift
//  DiaryApp
//
//  Created by t2023-m0056 on 2023/09/01.
//

import Foundation

struct Post: Codable {
    var date: Date?
    var content: String?
    var goal: String?
    var image: String?
    var tag: Array<String>
    var temperature: String
    var weather: String
    var weatherIcon: String

    enum CodingKeys: String, CodingKey {
        case date
        case content
        case goal
        case image
        case tag
        case temperature
        case weather
        case weatherIcon
    }
}
