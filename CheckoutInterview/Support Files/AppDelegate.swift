#if UIKIT

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        return true
    }
}

#else

import SwiftUI

@main
struct CheckoutInterviewApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

#endif
