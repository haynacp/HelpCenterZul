//
//  AppDelegate.swift
//  HelpCenterZul
//
//  Created by Hayna Cardoso on 27/07/24.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
  
  var window: UIWindow?
  
  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
    window = UIWindow(frame: UIScreen.main.bounds)
    let mainViewController = MainViewController()
    let navigationController = UINavigationController(rootViewController: mainViewController)
    window?.rootViewController = navigationController
    window?.makeKeyAndVisible()
    
    return true
  }
}
