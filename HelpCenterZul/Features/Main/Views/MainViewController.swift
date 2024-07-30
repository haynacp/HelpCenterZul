//
//  MainViewController.swift
//  HelpCenterZul
//
//  Created by Hayna Cardoso on 27/07/24.
//

import UIKit
import SDWebImage

class MainViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
  
  var viewModel = MainViewModel()
  let loadingIndicator = UIActivityIndicatorView(style: .large)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "Central de ajuda"
    
    if #available(iOS 13.0, *) {
      let appearance = UINavigationBarAppearance()
      appearance.configureWithDefaultBackground()
      appearance.backgroundColor = .blue
      appearance.titleTextAttributes = [
        .foregroundColor: UIColor.white
      ]
      
      navigationController?.navigationBar.standardAppearance = appearance
      navigationController?.navigationBar.scrollEdgeAppearance = appearance
    } else {
      navigationController?.navigationBar.barTintColor = .blue
    }
    
    setupView()
    setupNavigationBar()
    setupLoadingIndicator()
    bindViewModel()
    viewModel.fetchCategories()
  }
  
  private func setupNavigationBar() {
    navigationController?.navigationBar.prefersLargeTitles = false
    navigationController?.navigationBar.titleTextAttributes = [
      .foregroundColor: UIColor.white
    ]
  }
  
  private func setupView() {
    view.backgroundColor = .white
    view.addSubview(headerView)
    view.addSubview(collectionView)
    
    headerHeightConstraint = headerView.heightAnchor.constraint(equalToConstant: 200)
    
    NSLayoutConstraint.activate([
      headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      headerHeightConstraint!,
      
      collectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
      collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
      collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
      collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
    ])
  }
  
  private func setupLoadingIndicator() {
    loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
    view.addSubview(loadingIndicator)
    NSLayoutConstraint.activate([
      loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
    ])
  }
  
  private func bindViewModel() {
    viewModel.isLoading = { [weak self] isLoading in
      if isLoading {
        self?.loadingIndicator.startAnimating()
      } else {
        self?.loadingIndicator.stopAnimating()
      }
    }
    
    viewModel.didUpdate = { [weak self] in
      if let header = self?.viewModel.header {
        self?.headerView.configure(with: header)
      }
      self?.collectionView.reloadData()
    }
    
    viewModel.didFail = { error in
      print("Error fetching categories: \(error)")
    }
  }
  
  // MARK: UICollectionViewDataSource
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return viewModel.categories.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoryCell.identifier, for: indexPath) as! CategoryCell
    let category = viewModel.categories[indexPath.item]
    cell.configure(with: category)
    return cell
  }
  
  // MARK: UICollectionViewDelegateFlowLayout
  
  func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    let width = (collectionView.frame.width - 48) / 2
    return CGSize(width: width, height: 120)
  }
  
  func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    let category = viewModel.categories[indexPath.item]
    let detailVC = DetailViewController()
    detailVC.category = category
    navigationController?.pushViewController(detailVC, animated: true)
  }
  
  func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let offsetY = scrollView.contentOffset.y
    let threshold: CGFloat = 50.0
    
    let newHeight = max(100, 200 - offsetY)
    headerHeightConstraint?.constant = newHeight
    
    if offsetY > threshold {
      headerView.backgroundColor = UIColor.blue
      headerView.backgroundImage.alpha = 0
    } else {
      headerView.backgroundColor = UIColor.clear
      headerView.backgroundImage.alpha = 1
    }
  }
  
  lazy var collectionView: UICollectionView = {
    let layout = UICollectionViewFlowLayout()
    layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
    layout.minimumInteritemSpacing = 16
    layout.minimumLineSpacing = 16
    let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
    collectionView.dataSource = self
    collectionView.delegate = self
    collectionView.register(CategoryCell.self, forCellWithReuseIdentifier: CategoryCell.identifier)
    collectionView.translatesAutoresizingMaskIntoConstraints = false
    return collectionView
  }()
  
  let headerView: HeaderView = {
    let header = HeaderView()
    header.translatesAutoresizingMaskIntoConstraints = false
    return header
  }()
  
  var headerHeightConstraint: NSLayoutConstraint?
}
