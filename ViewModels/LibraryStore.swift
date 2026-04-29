//
//  LibraryStore.swift
//  
//
//  Created by Kody McNamara on 4/29/26.
//

import SwiftUI

class LibraryStore: ObservableObject {
    //all saved books
    @Published var entries: [LibraryEntry] = []
    
    //reader settings here
    @Published var settings: ReaderSettings = ReaderSettings()
    
    init() { load() }
    
    //MARK: - Library
    
    func add(_ book: Book) {
        guard !contains(book) else { return }
        entries.append(LibraryEntry(book:book))
        save()
    }
    
    func remove(_ book: Book) {
        entries.removeAll { $0.id == book.id }
        save()
    }
    
    func contains(_ book: Book) -> Bool {
        entries.contains {$0.id==book.id}
    }
    
    //download text into cache to not have to keep refetching
    func cacheText(_ text: String, for bookID: Int) {
        guard let i = entries.firstIndex(where: {$0.id==bookID }) else {return}
        entries[i].cachedText = text
        save()
    }
    
    //call from readerview as user scrolls
    func updateProgress(_ progress: ReadingProgress, for bookID: Int) {
        
    }
}
