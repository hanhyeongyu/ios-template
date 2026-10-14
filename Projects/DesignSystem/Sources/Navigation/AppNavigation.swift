import SwiftUI
import UIKit

extension UINavigationController {
    open override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        navigationBar.topItem?.backButtonDisplayMode = .minimal
    }
}

public class AppNavigation {
    
    public static let tintColor: Color = Color.gray900
    
    public static func configuration() {
        let style = AppNavigationStyle.light
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithDefaultBackground()
        appearance.titleTextAttributes = [
            .foregroundColor: style.foreground,
            .font: DesignSystemFontFamily.PretendardVariable.semiBold.font(size: 20.0)
        ]
        appearance.largeTitleTextAttributes = [
            .foregroundColor: style.foreground,
            .font: DesignSystemFontFamily.PretendardVariable.semiBold.font(size: 34.0)
        ]
                        
        let navBar = UINavigationBar.appearance()
        navBar.standardAppearance = appearance
        navBar.compactAppearance = appearance
        
        let barButton = UIBarButtonItem.appearance()
        barButton.tintColor = DesignSystemAsset.gray900.color
    }
}
