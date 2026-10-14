import Foundation
import Preference

extension PreferenceKeys {
    public var token : PrefKey<OAuthToken?> { .init(name: "kToken", defaultValue: nil) }
    public var isSignIn: PrefKey<Bool> { .init(name: "kIsSignIn", defaultValue: false) }
    public var isSkipAutoSignIn: PrefKey<Bool> { .init(name: "kIsSkipAutoSignIn", defaultValue: true) }
}
