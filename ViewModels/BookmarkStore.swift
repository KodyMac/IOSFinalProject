//
//  BookmarkStore.swift
//  
//
//  Created by Kody McNamara on 4/29/26.
//

import SwiftUI

class BookmarkStore: ObservableObject {
    @Published var bookmarks: [Bookmark] = []
    
    init() { load()}
    
    //add a new bookmark //use in bookmarksview
    func add(_ bookmark: Bookmark) {
        bookmarks.insert(bookmark, at: 0) //newest first
        save()
    }
    
    //remove by id
    func remove(id: UUID) {
        bookmarks.removeAll { $0.id == id}
        save()
    }
    
    //update annotations (edit in bookmarks view)
    func updateNote(_ note: String, for id: UUID) {
        guard let i=bookmarks.firstIndex(where: { $0.id ==id}) else { return }
        bookmarks[i].note=note
        save()
    }
    
    //all bookmarks for a specific book //note to self, use in readerview
    func bookmarks(for bookID: Int) -> [Bookmark] {
        bookmarks.filter { $0.bookID == bookID }
    }
    
    //MARK: - Private
    private func save() {
        PersistenceService.save(bookmarks, key: PersistenceService.Key.bookmarks)
    }
    
    private func load() {
        bookmarks = PersistenceService.load([Bookmark].self, key: PersistenceService.Key.bookmarks) ?? []
    }
}
