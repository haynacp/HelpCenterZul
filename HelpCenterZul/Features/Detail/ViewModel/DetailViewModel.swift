//
//  DetailViewModel.swift
//  HelpCenterZul
//
//  Created by Hayna Cardoso on 28/07/24.
//

import Foundation

class DetailViewModel {
  var articles: [Article] = []
  var isLoading: ((Bool) -> Void)?
  var didUpdate: (() -> Void)?
  var didFail: ((Error) -> Void)?
  
  func fetchArticles(for categoryId: String) {
    isLoading?(true)
    NetworkService.shared.fetchArticles(for: categoryId) { [weak self] result in
      DispatchQueue.main.async {
        self?.isLoading?(false)
        switch result {
        case .success(let categoryDetailResponse):
          self?.articles = categoryDetailResponse.items
          self?.didUpdate?()
        case .failure(let error):
          self?.didFail?(error)
        }
      }
    }
  }
}
