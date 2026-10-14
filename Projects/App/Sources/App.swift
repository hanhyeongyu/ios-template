import SwiftUI

@main
struct TemplateApp: App {

    @UIApplicationDelegateAdaptor(AppDelegate.self)
    private var appDelegate

    var body: some Scene {
        WindowGroup {
            RootView()
        }
    }
}
