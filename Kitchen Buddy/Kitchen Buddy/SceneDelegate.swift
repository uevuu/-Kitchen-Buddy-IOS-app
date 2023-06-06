import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?
    private var appCoordinator: RootCoordinator?
    private var serviceLocator: ServiceLocator?
    
    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let scene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: scene)
        let serviceLocator = ServiceLocator()
        self.window = window
        self.serviceLocator = serviceLocator
        self.appCoordinator = RootCoordinator(window: window, resolver: serviceLocator.getResolver())
        appCoordinator?.start(animated: true)
    }
}
