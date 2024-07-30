//
//  HelpCenterModels.swift
//  HelpCenterZul
//
//  Created by Hayna Cardoso on 27/07/24.
//

import Foundation

struct CategoriesResponse: Codable {
  let header: Header
  let items: [Category]
}

struct Category: Codable {
  let id: String
  let title: String
  let category: String?
  let totalArticles: Int
}

struct CategoryDetailResponse: Codable {
  let id: String
  let title: String
  let type: String
  let category: String?
  let header: Header
  let items: [Article]
}

struct Article: Codable {
  let id: String
  let title: String
  let type: String
  let items: [SubArticle]?
}

struct SubArticle: Codable {
  let id: String
  let title: String
  let type: String
  let descriptionText: String?
}

struct Header: Codable {
  let image: Image
  let line1: String
  let line2: String
}

struct Image: Codable {
  let oneX: String
  let twoX: String
  let threeX: String
  
  enum CodingKeys: String, CodingKey {
    case oneX = "@1x"
    case twoX = "@2x"
    case threeX = "@3x"
  }
}

