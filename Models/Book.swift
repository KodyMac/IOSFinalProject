//
//  Book.swift
//  
//
//  Created by Kody McNamara on 4/29/26.
//

import Foundation

struct Author: Codable, Hashable {
    let name: String
    let birthYear: Int?
    let deathYear: Int?
    
    enum CodingKeys: String, CodingKey { //i prefer camelCase :)
        case name
        case birthYear = "birth_year"
        case deathYear = "death_year"
    }
}

struct Book: Codable, Identifiable, Hashable {
    let id: Int
    let title: String
    let authors: [Author]
    let subjects: [String]
    let downloadCount: Int
    let formats: [String: String] //MIME to URL
    
    //helpers-------------
    var coverURL: URL? {
        formats["image/jpeg"].flatMap { URL(string: $0) }
    }
    var textURL: URL? {
        let pref = ["text/plain; charset=utf-8", "text/plain"] //use utf8 plain but default to plain
        return preferred.compactMap { formats[$0] }
            .compactMap { URL(string: $0) }
            .first
    }
    var authorNames: String {
        authors.map(\.name).joined(separator: ", ")
    }
    
    enum CodingKeys: String, CodingKey {
        case id, title, authors, subjects, formats
        case downloadCount = "download_count"
    }
}

//api response wrapper
struct GutenbergResponse: Codable {
    let count: Int
    let next: String? //url to next page
    let results: [Book]
}
