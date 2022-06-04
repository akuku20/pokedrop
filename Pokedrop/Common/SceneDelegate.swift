//  SceneDelegate.swift
//  Pokedrop
import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
        
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene)
            
            window.overrideUserInterfaceStyle = .light
            
            // Collection
            let collectionVM = CollectionViewModel()
            let colletionVC = CollectionViewController(viewModel: collectionVM)
            let collectionNavController = UINavigationController(rootViewController: colletionVC)
            let collectionImg = UIImage(named: "collectionIcon")?.withRenderingMode(.alwaysOriginal).withTintColor(.gray)
            let collectionSelectedImg = UIImage(named: "collectionIcon")?.withRenderingMode(.alwaysOriginal).withTintColor(.black)
            let tabBarItem1 = UITabBarItem(title: nil, image: collectionImg, selectedImage: collectionSelectedImg)
            tabBarItem1.setOnlyImageAppearance()
            collectionNavController.tabBarItem = tabBarItem1
            
            //Open Pokeball
            let ballVM = PokeballsViewModel()
            let ballVC = PokeballsViewController(viewModel: ballVM)
            let ballNavController = UINavigationController(rootViewController: ballVC)
            let ballImg = UIImage(named: "ballIcon")?.withRenderingMode(.alwaysOriginal).withTintColor(.gray)
            let ballSelectedImg = UIImage(named: "ballIcon")?.withRenderingMode(.alwaysOriginal).withTintColor(.black)
            let tabBarItem2 = UITabBarItem(title: nil, image: ballImg, selectedImage: ballSelectedImg)
            tabBarItem2.setOnlyImageAppearance()
            ballNavController.tabBarItem = tabBarItem2
            
            // Tab bar
            let tabBarController = UITabBarController()
            tabBarController.tabBar.layer.borderWidth = 1
            tabBarController.tabBar.layer.borderColor = UIColor.black.cgColor
            tabBarController.tabBar.clipsToBounds = true
            tabBarController.viewControllers = [collectionNavController, ballNavController]
            
            window.rootViewController = tabBarController
            self.window = window
            window.makeKeyAndVisible()
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

extension UITabBarItem {
    func setOnlyImageAppearance() {
        self.imageInsets = UIEdgeInsets(top: 10, left: 0, bottom: -10, right: 0)
        self.title = nil
        self.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: 1000.0)
    }
}
