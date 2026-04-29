//
//  LibraryEntry.swift
//  
//
//  Created by Kody McNamara on 4/29/26.
//

import SwiftUI

struct ReadingProgress: Codable {
    var chapterIndex: Int = 0
    var scrollOffset: Double = 0 //will be like, fraction through the chapter
    var percentComplete: Double = 0 //progress through entire book
    var lastReadAt: Date = .now
}

struct LibraryEntry: Codable, Identifiable {
    let book: Book //book snapshot
    var savedAt: Date
    var cachedText: String? //the gutenberg plain text
    var progress: ReadingProgress
    
    var id: Int { book.id }
    
    init(book: Book) {
        self.book = book
        self.savedAt = .now
        self.progress = ReadingProgress()
    }
}
