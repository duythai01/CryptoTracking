//
//  NewsViewModel.swift
//  CryptoTracking
//
//  Created by DuyThai on 25/11/2023.
//

import Foundation
import SwiftUI
import Combine

class NewsViewModel: ObservableObject {
    @Published var articles: [ResultArticles] = []
    @Published var articlesDisplay: [ResultArticles] = []
    @Published var error: Error?
    @Published var searchText: String = ""
    @Published var isHiddenLoadNews: Bool = false

    private let coreDataController = CoreDataController.shared
    private var cancellables = Set<AnyCancellable>()

    init() {
        addSubscriber()
    }

    private func addSubscriber() {
        $searchText
            .combineLatest($articlesDisplay)
            .map { (text, startingCoins) -> [ResultArticles] in
                if text == ""  {
                    return self.articles
                }
                let lowercasedText = text.lowercased()
                return startingCoins.filter { article -> Bool in
                    return article.title?.lowercased().contains(lowercasedText) ?? false
                }
            }
            .sink { [weak self] resultSearch in
                self?.articlesDisplay = resultSearch
            }
            .store(in: &cancellables)
    }

    func getArticles() {
        self.isHiddenLoadNews = false
        APIService.shared.request(endpoint: "https://6c7ea76e-47ae-430d-bcfe-648ea3f827b7.mock.pstmn.io//news",
                                  parameters: [:],
                                  method: .get) { (result: Result<Article, Error>) in
            //                                    ["apikey" : "pub_33530946da719ceefac5401fee664a13482a8",
            //                                               "country" : "us"],
                switch result {
                case .success(let success):
                    DispatchQueue.main.async { [weak self] in
                        guard let self = self else { return }
                        self.articles = success.results ?? []
                        self.articlesDisplay = success.results ?? []
                        self.isHiddenLoadNews = true
                    }
                case .failure(let failure):
                    DispatchQueue.main.async { [weak self] in
                        guard let self = self else { return }
                        self.error = failure
                    }
                }

            }
            
    }

    func getArticlesByCategory(parameters: [String : Any]) {
        self.isHiddenLoadNews = false
        APIService.shared.request(endpoint: ".",
                                  parameters: ["apikey" : "pub_33530946da719ceefac5401fee664a13482a8",
                                               "country" : "us"],
                                  method: .get) { (result: Result<Article, Error>) in
                switch result {
                case .success(let success):
                    DispatchQueue.main.async { [weak self] in
                        guard let self = self else { return }
                        self.articles = success.results ?? []
                        self.articlesDisplay = success.results ?? []
                        self.isHiddenLoadNews = true
                    }
                case .failure(let failure):
                    DispatchQueue.main.async { [weak self] in
                        guard let self = self else { return }
                        self.error = failure
                    }
                }

            }

    }

}
