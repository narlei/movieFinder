//
//  AppDelegate.swift
//  movieFinder
//
//  Created by Narlei A Moreira on 03/07/18.
//  Copyright © 2018 Narlei A Moreira. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        setupWindowAndMain()
        addShortcuts()
        return true
    }
    
    func setupWindowAndMain(){
        let viewController = MovieListRouter.assembleModule()
        window = UIWindow(frame: UIScreen.main.bounds)
        window!.rootViewController = viewController
        window!.makeKeyAndVisible()
    }
    
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        if shortcutItem.type == "com.nam.movieFinder.search" {
            var delay = 0.0
            if window == nil {
                setupWindowAndMain()
                delay = 2.0 // Delay to animations
            }
            self.perform(#selector(self.openSearch), with: nil, afterDelay: delay)
        }
    }
    
    @objc private func openSearch() {
        guard let activeWindow = window else{
            return
        }
        let viewController = activeWindow.rootViewController
        if viewController is UINavigationController {
            let navigation = viewController as! UINavigationController
            navigation.dismiss(animated: true, completion: nil)
            if let vcMovieList = navigation.viewControllers.first as? MovieListViewController {
                vcMovieList.actionButtonSearch(UIButton())
            }
        }
    }
    
    
    private func addShortcuts() {
        let icon = UIApplicationShortcutIcon(type: .search)
        let item = UIApplicationShortcutItem(type: "com.nam.movieFinder.search", localizedTitle: R.string.localizable.search(), localizedSubtitle: nil, icon: icon, userInfo: nil)
        UIApplication.shared.shortcutItems = [item]
    }
    
    func applicationWillResignActive(_ application: UIApplication) { }
    
    func applicationDidEnterBackground(_ application: UIApplication) { }
    
    func applicationWillEnterForeground(_ application: UIApplication) { }
    
    func applicationDidBecomeActive(_ application: UIApplication) { }
    
    func applicationWillTerminate(_ application: UIApplication) { }
    
    
}

