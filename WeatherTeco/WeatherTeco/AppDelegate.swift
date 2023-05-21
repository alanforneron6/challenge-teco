//
//  AppDelegate.swift
//  WeatherTeco
//
//  Created by Alan Forneron on 18/05/2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let viewController = CurrentViewController()
        let navigationController = UINavigationController(rootViewController: viewController)
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = .systemBackground
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
        return true
    }
    
}
