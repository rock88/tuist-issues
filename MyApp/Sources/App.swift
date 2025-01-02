import UIKit
import MyModule

@main
final class AppDelegate: NSObject, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        window = UIWindow()
        window?.rootViewController = UIViewController()
        window?.makeKeyAndVisible()

        let module = MyModule()
        module.test()

        return true
    }
}
