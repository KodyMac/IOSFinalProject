//
//  Bookmark.swift
//  
//
//  Created by Kody McNamara on 4/29/26.
//

struct Bookmark: Codable, Identifiable {
    let id: UUID
    let bookID: Int
    let bookTitle: String
    let chapterIndex: Int
    let chapterTitle: String
    let passage: String
    var note: String? //user annotations
    let createdAt: Date
    
    init(bookID: Int, bookTitle:String, chapterIndex:Int,chapterTitle:String,
         passage:String, note:String?=nil) {
        self.id = UUID()
        self.bookID = bookID
        self.bookTitle = bookTitle
        self.chapterIndex = chapterIndex
        self.chapterTitle = chapterTitle
        self.passage = passage
        self.note = note
        self.createdAt = .now
    }
}
