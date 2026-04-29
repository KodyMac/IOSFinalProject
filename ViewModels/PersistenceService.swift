//
//  PersistenceService.swift
//  
//
//  Created by Kody McNamara on 4/29/26.
//

import SwiftUI

struct PersistenceService {
    
    private static let encoder = JSONEncoder()
    private static let decoder = JSONDecoder()
    
    //save encodable valuesunder a defaults key (i got this from online)
    static func save<T: Encodable>(_ value: T, key: String) {
        if let data = try? encoder.encode(value) {
            UserDefaults.standard.set(data,forKey:key)
        }
    }
    
    //load decodable values; return nil if missing key or failur (online too)
    static func load<T: Decodable>{_ type: T.Type, key: String) -> T? {
        guard let data = UserDefaults.standard.data(forKey: key) else { return nil }
        return try? decoder.decode(T.self, from: data)
    }
        //keys
        enum Key {
            static let library = "library"
            static let bookmarks = "bookmarks"
            static let readerSettings =  "readerSettings"
            static let searchHistory = "searchHistory"
        }
    }

