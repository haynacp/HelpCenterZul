//
//  CategoryCell.swift
//  HelpCenterZul
//
//  Created by Hayna Cardoso on 27/07/24.
//

import UIKit

class CategoryCell: UICollectionViewCell {
  static let identifier = "CategoryCell"
  
  let titleLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 16)
    label.numberOfLines = 2
    return label
  }()
  
  let subtitleLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.systemFont(ofSize: 14)
    label.textColor = .gray
    return label
  }()
  
  let chevronImageView: UIImageView = {
    let imageView = UIImageView()
    imageView.image = UIImage(systemName: "chevron.right")
    imageView.tintColor = .blue
    return imageView
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    contentView.backgroundColor = .white
    contentView.layer.cornerRadius = 12
    contentView.layer.borderColor = UIColor(hex: "#F3F4F6")?.cgColor
    contentView.layer.borderWidth = 2
    
    contentView.addSubview(titleLabel)
    contentView.addSubview(subtitleLabel)
    contentView.addSubview(chevronImageView)
    
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
    chevronImageView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
      titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      titleLabel.trailingAnchor.constraint(lessThanOrEqualTo: chevronImageView.leadingAnchor, constant: -8),
      
      subtitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      subtitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16),
      
      chevronImageView.centerYAnchor.constraint(equalTo: subtitleLabel.centerYAnchor),
      chevronImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      
      chevronImageView.widthAnchor.constraint(equalToConstant: 12),
      chevronImageView.heightAnchor.constraint(equalToConstant: 16)
    ])
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func configure(with category: Category) {
    titleLabel.text = category.title
    subtitleLabel.text = "\(category.totalArticles) artigos"
  }
}
