//
//  SceneDelegate.swift
//  TheFlightTrackerApp
//
//  Created by Ilhan Sari on 7.11.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowsScene = (scene as? UIWindowScene) else { return }
        let rootViewController = TabbarController()
        window = UIWindow(windowScene: windowsScene)
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
    }
}
