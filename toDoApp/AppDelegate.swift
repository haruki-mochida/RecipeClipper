//
//  AppDelegate.swift
//  toDoApp
//
//  Created by 持田晴生 on 2023/11/28.
//

import UIKit
import SwiftUI
// ↓ここと
import Firebase
// ↓Firebaseとは関係ないですがこちらも記述しておいてください
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        // ↓ここに追記
        FirebaseApp.configure()
        // ↓Firebaseとは関係ないですがこちらも記述しておいてください
        IQKeyboardManager.shared.enable = true
        return true
    }

    // 省略
}
