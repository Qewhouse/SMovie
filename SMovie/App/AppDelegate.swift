//
//  AppDelegate.swift
//  SMovie
//
//  Created by Alexander Altman on 01.04.2023.
//

import UIKit
import FirebaseCore

// ...
      

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        return true
    }
}

