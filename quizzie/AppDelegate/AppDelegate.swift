//
//  AppDelegate.swift
//  quizzie
//
//  Created by Ensar Baba on 30.04.2020.
//  Copyright © 2020 Ensar Baba. All rights reserved.
//

import UIKit
import Bagel

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        Bagel.start()

        let view = HomeViewController()
        let presenter = HomePresenter(view: view)
        view.presenter = presenter
        
        let navigationController = UINavigationController(rootViewController: view)
        navigationController.navigationBar.isTranslucent = false
        window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
        
        return true
    }

}
