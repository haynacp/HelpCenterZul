//
//  ArticleView.swift
//  HelpCenterZul
//
//  Created by Hayna Cardoso on 28/07/24.
//

import Foundation
import UIKit

class ArticleView: UITableViewHeaderFooterView {
  
  var section: Int = 0
  var isExpanded: Bool = false {
    didSet {
      arrowImageView.transform = isExpanded ? CGAffineTransform(rotationAngle: .pi) : .identity
    }
  }
  
  let titleLabel: UILabel = {
    let label = UILabel()
    label.font = UIFont.boldSystemFont(ofSize: 18.0)
    label.numberOfLines = 0
    label.textColor = UIColor(hex: "#003FE1")
    return label
  }()
  
  let arrowImageView: UIImageView = {
    let imageView = UIImageView(image: UIImage(systemName: "chevron.down"))
    imageView.tintColor = .blue
    imageView.contentMode = .scaleAspectFit
    return imageView
  }()
  
  let borderView: UIView = {
    let view = UIView()
    view.layer.borderWidth = 2
    view.layer.cornerRadius = 12
    view.layer.borderColor = UIColor(hex: "#F3F4F6")?.cgColor
    return view
  }()
  
  override init(reuseIdentifier: String?) {
    super.init(reuseIdentifier: reuseIdentifier)
    setupUI()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupUI() {
    contentView.addSubview(borderView)
    contentView.addSubview(titleLabel)
    contentView.addSubview(arrowImageView)
    
    borderView.translatesAutoresizingMaskIntoConstraints = false
    titleLabel.translatesAutoresizingMaskIntoConstraints = false
    arrowImageView.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      borderView.topAnchor.constraint(equalTo: contentView.topAnchor),
      borderView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      borderView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      borderView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
      
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
}
