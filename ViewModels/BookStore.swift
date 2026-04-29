//
//  BookStore.swift
//  
//
//  Created by Kody McNamara on 4/29/26.
//

import SwiftUI

class BookStore: ObservableObject {
    
    @Published var results: [Book] = [] //serach results //use in a discover tab?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil
    @Published var searchHistory: [String] =[]
    
    private var nextPageURL: String?=nil //results will be in pages, like catalogs/google
    
    init() {
        searchHistory = PersistenceService.load([String].self, key: PersistenceService.Key.searchHistory) ?? []
        
        Task { await search(query: "") } //put famous books at launch
    }
    
    //MARK: - Search
    
    @MainActor
    func search(query: String) async {
        isLoading= true
        errorMessage=nil
        nextPageURL=nil
        
        var urlString = "https://gutendex.com/books/?languages=en"
        if !query.isEmpty {
            let encoded = query.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)??query
            urlString+= "&search=\(encoded)"
        } else {
            urlString += "&sort=popular" //the default
        }
        
        guard let url = URL(string:urlString) else { isLoading = false; return}
        
        do{
            let(data, _) = try await URLSession.shared.data(from:url)
            let response = try JSONDecoder().decode(GutenbergResponse.self, from: data)
            results=response.results
            nextPageURL= response.next
            if!query.isEmpty { addToHistory(query)}
        } catch {
        errorMessage = "Could not load books. Check your connection and try again."
        }
        isLoading=false
    }
    
    //load next page
    @MainActor
    func loadNextPage() async {
        guard !isLoading, let next=nextPageURL, let url=URL(string:next) else { return}
        isLoading = true
        do {
            let (data, _) = try await URLSession.shared.data(from:url)
            let response = try JSONDecoder().decode(GutenbergResponse.self, from: data)
            results += response.results
            nextPageURL = response.next
        } catch { }
        isLoading= false
    }
    
    //MARK: - Search history
    
    private func addToHistory(_ query: String) {
        searchHistory.removeAll { $0.lowercased() == query.lowercased() }
        searchHistory.insert(query, at:0)
        if searchHistory.count > 10 { searchHistory = Array(searchHistory.prefix(10))}
        PersistenceService.save(searchHistory, key: PersistenceService.Key.searchHistory)
    }
}
