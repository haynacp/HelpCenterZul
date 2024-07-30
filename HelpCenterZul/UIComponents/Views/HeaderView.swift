//
//  HeaderView.swift
//  HelpCenterZul
//
//  Created by Hayna Cardoso on 27/07/24.
//

import UIKit
import SDWebImage

class HeaderView: UIView {
  
  let backgroundImage: UIImageView = {
    let imageView = UIImageView()
    imageView.contentMode = .scaleAspectFill
    imageView.translatesAutoresizingMaskIntoConstraints = false
    return imageView
  }()
  
  private let greetingLabel: UILabel = {
    let label = UILabel()
    label.textColor = UIColor(red: 176/255, green: 197/255, blue: 251/255, alpha: 1)
    label.numberOfLines = 0
    label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  private let questionLabel: UILabel = {
    let label = UILabel()
    label.textColor = .white
    label.numberOfLines = 0
    label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
    label.translatesAutoresizingMaskIntoConstraints = false
    return label
  }()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    setupView()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  private func setupView() {
    addSubview(backgroundImage)
    addSubview(greetingLabel)
    addSubview(questionLabel)
    
    NSLayoutConstraint.activate([
      backgroundImage.topAnchor.constraint(equalTo: topAnchor),
      backgroundImage.leadingAnchor.constraint(equalTo: leadingAnchor),
      backgroundImage.trailingAnchor.constraint(equalTo: trailingAnchor),
      backgroundImage.bottomAnchor.constraint(equalTo: bottomAnchor),
      
      greetingLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
      greetingLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
      greetingLabel.bottomAnchor.constraint(equalTo: questionLabel.topAnchor),
      
      questionLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
      questionLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
      questionLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16)
    ])
    
    bringSubviewToFront(greetingLabel)
    bringSubviewToFront(questionLabel)
  }
  
  func configure(with header: Header) {
    if let url = URL(string: header.image.oneX) {
      backgroundImage.sd_setImage(with: url, completed: nil)
    }
    
    let firstName = generateRandomFirstName()
    greetingLabel.text = header.line1.replacingOccurrences(of: "%firstName%", with: firstName)
    questionLabel.text = header.line2
  }
  
  func generateRandomFirstName() -> String {
    let names = [
      "Aprígio", "Cristiano"
    ]
    return names.randomElement()!
  }
  
}
