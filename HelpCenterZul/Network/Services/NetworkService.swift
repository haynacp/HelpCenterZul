//
//  NetworkService.swift
//  HelpCenterZul
//
//  Created by Hayna Cardoso on 27/07/24.
//

import Foundation

struct NetworkService {
  static let shared = NetworkService()
  
  func fetchCategories(completion: @escaping (Result<CategoriesResponse, Error>) -> Void) {
    let url = URL(string: "https://helpcenter.dev.homolog.me/v1/helpcenter/categories")!
    
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
      if let error = error {
        completion(.failure(error))
        return
      }
      
      guard let data = data else {
        completion(.failure(NSError(domain: "dataNilError", code: -10001, userInfo: nil)))
        return
      }
      
      do {
        let categoriesResponse = try JSONDecoder().decode(CategoriesResponse.self, from: data)
        completion(.success(categoriesResponse))
      } catch {
        completion(.failure(error))
      }
    }
    
    task.resume()
  }
  
  func fetchArticles(for categoryId: String, completion: @escaping (Result<CategoryDetailResponse, Error>) -> Void) {
    let urlString = "https://helpcenter.dev.homolog.me/v1/helpcenter/categories/\(categoryId)"
    guard let url = URL(string: urlString) else {
      completion(.failure(NSError(domain: "invalidURLError", code: -10002, userInfo: nil)))
      return
    }
    
    let task = URLSession.shared.dataTask(with: url) { data, response, error in
      if let error = error {
        completion(.failure(error))
        return
      }
      
      guard let data = data else {
        completion(.failure(NSError(domain: "dataNilError", code: -10001, userInfo: nil)))
        return
      }
      
      do {
        let categoryDetailResponse = try JSONDecoder().decode(CategoryDetailResponse.self, from: data)
        completion(.success(categoryDetailResponse))
      } catch {
        completion(.failure(error))
      }
    }
    
    task.resume()
  }
}
