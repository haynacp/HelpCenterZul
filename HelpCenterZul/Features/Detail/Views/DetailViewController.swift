//
//  DetailViewController.swift
//  HelpCenterZul
//
//  Created by Hayna Cardoso on 28/07/24.
//

import Foundation
import UIKit

class DetailViewController: UIViewController {
  
  var viewModel = DetailViewModel()
  var filteredSubArticles: [(Article, [SubArticle])] = []
  var isSearching = false
  var expandedSections: Set<Int> = []
  
  var category: Category? {
    didSet {
      if let categoryId = category?.id {
        viewModel.fetchArticles(for: categoryId)
      }
    }
  }
  
  let frequentQuestionsLabel: UILabel = {
    let label = UILabel()
    label.translatesAutoresizingMaskIntoConstraints = false
    label.text = "Perguntas frequentes"
    label.font = UIFont.boldSystemFont(ofSize: 18)
    return label
  }()
  
  let searchBar: UISearchBar = {
    let sb = UISearchBar()
    sb.placeholder = "Pesquisar"
    return sb
  }()
  
  let tableView: UITableView = {
    let tv = UITableView()
    tv.tableFooterView = UIView()
    return tv
  }()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    setupUI()
    setupNavigationBar()
    bindViewModel()
    
    tableView.delegate = self
    tableView.dataSource = self
    searchBar.delegate = self
  }
  
  func setupUI() {
    view.backgroundColor = UIColor.white
    view.addSubview(frequentQuestionsLabel)
    view.addSubview(searchBar)
    view.addSubview(tableView)
    
    searchBar.translatesAutoresizingMaskIntoConstraints = false
    searchBar.backgroundImage = UIImage()
    tableView.translatesAutoresizingMaskIntoConstraints = false
    
    UISearchBar.appearance().setSearchFieldBackgroundImage(UIImage(), for: .normal)
    searchBar.backgroundColor = UIColor(hex: "#F3F4F6")
    searchBar.layer.cornerRadius = 12.0
    if let searchTextField = searchBar.value(forKey: "searchField") as? UITextField {
      searchTextField.translatesAutoresizingMaskIntoConstraints = false
      
      let iconView = searchTextField.leftView as? UIImageView
      iconView?.image = iconView?.image?.withRenderingMode(.alwaysTemplate)
      iconView?.tintColor = UIColor(hex: "#003FE1")
      
      NSLayoutConstraint.activate([
        searchTextField.heightAnchor.constraint(equalToConstant: 50),
        searchTextField.leadingAnchor.constraint(equalTo: searchBar.leadingAnchor, constant: 4),
        searchTextField.trailingAnchor.constraint(equalTo: searchBar.trailingAnchor, constant: -4),
        searchTextField.centerYAnchor.constraint(equalTo: searchBar.centerYAnchor, constant: 0)
      ])
      searchTextField.clipsToBounds = true
    }
    
    NSLayoutConstraint.activate([
      frequentQuestionsLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
      frequentQuestionsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
      frequentQuestionsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
      
      searchBar.topAnchor.constraint(equalTo: frequentQuestionsLabel.bottomAnchor, constant: 16),
      searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
      searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
      
      tableView.topAnchor.constraint(equalTo: searchBar.bottomAnchor),
      tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
      tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
    
    tableView.register(SubArticleCell.self, forCellReuseIdentifier: "SubArticleCell")
    tableView.register(ArticleView.self, forHeaderFooterViewReuseIdentifier: "ArticleView")
    tableView.sectionHeaderHeight = UITableView.automaticDimension
    tableView.separatorStyle = .none
  }
  
  private func setupNavigationBar() {
    let backButton = UIBarButtonItem(image: UIImage(systemName: "arrow.backward"), style: .plain, target: self, action: #selector(backButtonTapped))
    backButton.tintColor = .white
    navigationItem.leftBarButtonItem = backButton
    title = category?.title
  }
  
  @objc private func backButtonTapped() {
    navigationController?.popViewController(animated: true)
  }
  
  private func bindViewModel() {
    viewModel.isLoading = { [weak self] isLoading in
    }
    
    viewModel.didUpdate = { [weak self] in
      self?.tableView.reloadData()
    }
    
    viewModel.didFail = { error in
      print("Error fetching articles: \(error)")
    }
  }
  
  func filterContentForSearchText(_ searchText: String) {
    filteredSubArticles = viewModel.articles.map { article in
      let matchingSubArticles = article.items?.filter { $0.title.lowercased().contains(searchText.lowercased()) } ?? []
      return (article, matchingSubArticles)
    }.filter { !$0.1.isEmpty }
    tableView.reloadData()
  }
}

extension DetailViewController: UISearchBarDelegate {
  func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    isSearching = !searchText.isEmpty
    filterContentForSearchText(searchText)
  }
  
  func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
    isSearching = false
    searchBar.text = ""
    tableView.reloadData()
  }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
  func numberOfSections(in tableView: UITableView) -> Int {
    return isSearching ? filteredSubArticles.count : viewModel.articles.count
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if isSearching {
      return filteredSubArticles[section].1.count
    } else {
      let article = viewModel.articles[section]
      return expandedSections.contains(section) ? (article.items?.count ?? 0) : 0
    }
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "SubArticleCell", for: indexPath) as! SubArticleCell
    let subArticle: SubArticle
    if isSearching {
      subArticle = filteredSubArticles[indexPath.section].1[indexPath.row]
    } else {
      subArticle = viewModel.articles[indexPath.section].items![indexPath.row]
    }
    cell.configure(with: subArticle)
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let subArticle: SubArticle
    if isSearching {
      subArticle = filteredSubArticles[indexPath.section].1[indexPath.row]
    } else {
      subArticle = viewModel.articles[indexPath.section].items![indexPath.row]
    }
    let alert = UIAlertController(title: subArticle.title, message: subArticle.descriptionText ?? "No description available", preferredStyle: .alert)
    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
    present(alert, animated: true, completion: nil)
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "ArticleView") as! ArticleView
    let article: Article
    if isSearching {
      article = filteredSubArticles[section].0
    } else {
      article = viewModel.articles[section]
    }
    header.titleLabel.text = article.title
    header.section = section
    header.isExpanded = expandedSections.contains(section)
    let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleExpandClose))
    header.addGestureRecognizer(tapGesture)
    return header
  }
  
  @objc func handleExpandClose(gesture: UITapGestureRecognizer) {
    guard let header = gesture.view as? ArticleView else { return }
    let section = header.section
    
    if expandedSections.contains(section) {
      expandedSections.remove(section)
    } else {
      expandedSections.insert(section)
    }
    tableView.reloadSections([section], with: .automatic)
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return UITableView.automaticDimension
  }
}
