//
//  SubArticleCell.swift
//  HelpCenterZul
//
//  Created by Hayna Cardoso on 28/07/24.
//

import Foundation
import UIKit

class SubArticleCell: UITableViewCell {
  
  let titleLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.textColor = .black
    return label
  }()
  
  let arrowImageView: UIImageView = {
    let imageView = UIImageView(image: UIImage(systemName: "chevron.right"))
    imageView.tintColor = .blue
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupUI() {
    contentView.addSubview(titleLabel)
    contentView.addSubview(arrowImageView)
    
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    arrowImageView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      arrowImageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
      arrowImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
      arrowImageView.widthAnchor.constraint(equalToConstant: 20),
      arrowImageView.heightAnchor.constraint(equalToConstant: 20),
      
      titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
      titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
      titleLabel.trailingAnchor.constraint(equalTo: arrowImageView.leadingAnchor, constant: -8),
      titleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
    ])
  }
  
  func configure(with subArticle: SubArticle) {
    titleLabel.text = subArticle.title
  }
}
