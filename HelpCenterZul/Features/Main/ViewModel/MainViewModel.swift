//
//  MainViewModel.swift
//  HelpCenterZul
//
//  Created by Hayna Cardoso on 27/07/24.
//

import Foundation

class MainViewModel {
  var categories: [Category] = []
  var header: Header?
  var isLoading: ((Bool) -> Void)?
  var didUpdate: (() -> Void)?
  var didFail: ((Error) -> Void)?
  
  func fetchCategories() {
    isLoading?(true)
    NetworkService.shared.fetchCategories { [weak self] result in
      DispatchQueue.main.async {
        self?.isLoading?(false)
        switch result {
        case .success(let categoriesResponse):
          self?.categories = categoriesResponse.items
          self?.header = categoriesResponse.header
          self?.didUpdate?()
        case .failure(let error):
          self?.didFail?(error)
        }
      }
    }
  }
}
