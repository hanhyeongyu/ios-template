import UIKit.UIApplication

public final class URLSchemeManager {

    public static let shared = URLSchemeManager()

    private init() {}

    // Replace with this app's Apple ID (App Store Connect -> App Information). KakaoTalk is a sample.
    private static let APPSTORE_APPID = "362057947"

    public func openLink(url: String) {
        if let url = URL(string: url) {
            UIApplication.shared.open(url)
        }
    }

    public func openSettingApp() {
        if let url = URL(string: UIApplication.openSettingsURLString) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }

    public func openCallApp(phoneNumber : String) {
        if let url = URL(string: "tel:\(phoneNumber)") {
            UIApplication.shared.open(url)
        }
    }

    public func openMessageApp(phoneNumber : String) {
        if let url = URL(string: "sms:\(phoneNumber)") {
            UIApplication.shared.open(url)
        }
    }

    public func openMailApp(email: String) {
        if let url = URL(string: "mailto:\(email)") {
            UIApplication.shared.open(url)
        }
    }

    public func openAppStore() {
        let url = URL(string: "itms-apps://itunes.apple.com/app/id" + URLSchemeManager.APPSTORE_APPID)!
        UIApplication.shared.open(url)
    }

    public func openAppStore(_ appId: String) {
        if let url = URL(string: "itms-apps://itunes.apple.com/app/id" + appId) {
            UIApplication.shared.open(url)
        }
    }
}
