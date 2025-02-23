//
//  SceneDelegate.swift
//  HelpCenterZul
//
//  Created by Hayna Cardoso on 27/07/24.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
  
  var window: UIWindow?
  
  func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
    guard let windowScene = (scene as? UIWindowScene) else { return }
    
    let mainVC = MainViewController()
    let navigationController = UINavigationController(rootViewController: mainVC)
    
    window = UIWindow(windowScene: windowScene)
    window?.rootViewController = navigationController
    window?.makeKeyAndVisible()
  }
  
  func sceneDidDisconnect(_ scene: UIScene) {}
  func sceneDidBecomeActive(_ scene: UIScene) {}
  func sceneWillResignActive(_ scene: UIScene) {}
  func sceneWillEnterForeground(_ scene: UIScene) {}
  func sceneDidEnterBackground(_ scene: UIScene) {}
}
