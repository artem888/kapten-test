//
//  SceneDelegate.swift
//  KaptenTest
//
//  Created by Artem Sidorenko on 09/10/2019.
//  Copyright © 2019 Artem Sidorenko. All rights reserved.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        let rootController = UINavigationController()
        let navigator = TripsNavigator(navigationController: rootController)
        let controller = TripsListViewController(navigator: navigator)
        rootController.setViewControllers([controller],
                                          animated: false)
        rootController.styleNavigationBar()
        self.window?.rootViewController = rootController
        self.window?.makeKeyAndVisible()
    }
}
