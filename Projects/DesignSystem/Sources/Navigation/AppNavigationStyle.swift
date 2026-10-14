import SwiftUI

public struct AppNavigationStyle: Equatable {
    public var foreground: UIColor
    public var background: UIColor?
    public var isTransparent: Bool

    public init(
        foreground: UIColor,
        background: UIColor? = nil,
        isTransparent: Bool = true
    ) {
        self.foreground = foreground
        self.background = background
        self.isTransparent = isTransparent
    }

    public static var dark: AppNavigationStyle {
        .init(
            foreground: .white,
            background: UIColor.black.withAlphaComponent(0.85),
            isTransparent: false
        )
    }

    public static var light: AppNavigationStyle {
        .init(
            foreground: DesignSystemAsset.gray900.color,
            background: nil,
            isTransparent: false
        )
    }
}

extension View {
    public func navigationStyle(scheme: AppNavigationStyle) -> some View {
        modifier(NavBarStyleModifier(style: scheme))
    }
}

private struct NavBarStyleModifier: ViewModifier {
    let style: AppNavigationStyle

    func body(content: Content) -> some View {
        content
            .background(NavConfigurator(style: style).frame(width: 0, height: 0))
    }
}

// MARK: - Legacy implementation (kept for reference)
//
// private struct NavConfigurator: UIViewControllerRepresentable {
//     let style: AppNavigationStyle
//
//     func makeUIViewController(context: Context) -> CarrierVC {
//         CarrierVC(style: style)
//     }
//
//     func updateUIViewController(_ uiViewController: CarrierVC, context: Context) {
//         uiViewController.style = style
//         uiViewController.apply()
//     }
//
//     /// Invisible VC that sits in the SwiftUI hierarchy and configures the nearest UINavigationController.
//     final class CarrierVC: UIViewController {
//         var style: AppNavigationStyle
//         private weak var nav: UINavigationController?
//         private var originalStandard: UINavigationBarAppearance?
//         private var originalScroll: UINavigationBarAppearance?
//         private var originalCompact: UINavigationBarAppearance?
//
//         init(style: AppNavigationStyle) {
//             self.style = style
//             super.init(nibName: nil, bundle: nil)
//             view.isHidden = true
//             view.isUserInteractionEnabled = false
//         }
//
//         required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
//
//         override func viewWillAppear(_ animated: Bool) {
//             super.viewWillAppear(animated)
//             apply()
//         }
//
//         override func viewWillDisappear(_ animated: Bool) {
//             super.viewWillDisappear(animated)
//             restore()
//         }
//
//         func apply() {
//             guard let nav = navController() else { return }
//             if self.nav !== nav { captureOriginal(from: nav) }
//             self.nav = nav
//
//             let appearance = UINavigationBarAppearance()
//
//             if style.isTransparent {
//                 appearance.configureWithTransparentBackground()
//             } else {
//                 appearance.configureWithDefaultBackground()
//             }
//
//             if let bg = style.background {
//                 appearance.backgroundColor = bg
//             }
//
//             appearance.titleTextAttributes = [
//                 .foregroundColor: style.foreground,
//                 .font: DesignSystemFontFamily.PretendardVariable.semiBold.font(size: 20.0)
//             ]
//             appearance.largeTitleTextAttributes = [
//                 .foregroundColor: style.foreground,
//                 .font: DesignSystemFontFamily.PretendardVariable.semiBold.font(size: 34.0)
//             ]
//
//             nav.navigationBar.standardAppearance = appearance
//             nav.navigationBar.compactAppearance = appearance
//
//             let barButton = UIBarButtonItem.appearance()
//             barButton.tintColor = style.foreground
//         }
//
//         func restore() {
//             guard let nc = nav else { return }
//             if let v = originalStandard { nc.navigationBar.standardAppearance = v }
//             if let v = originalScroll { nc.navigationBar.scrollEdgeAppearance = v }
//             if let v = originalCompact { nc.navigationBar.compactAppearance = v }
//
//             let barButton = UIBarButtonItem.appearance()
//             barButton.tintColor = UIColor.black
//         }
//
//         private func captureOriginal(from nc: UINavigationController) {
//             originalStandard = nc.navigationBar.standardAppearance
//             originalScroll = nc.navigationBar.scrollEdgeAppearance
//             originalCompact = nc.navigationBar.compactAppearance
//         }
//
//         private func navController() -> UINavigationController? {
//             sequence(first: self.parent) { $0?.parent }
//                 .compactMap { $0 as? UINavigationController }
//                 .first
//         }
//     }
// }

// MARK: - New implementation
//
// Per-navigationItem appearance. UIKit interpolates between adjacent items' appearances during
// push/pop and the interactive swipe-back gesture, so styles cleanly transition and snap back
// when the gesture is cancelled — fixing both the missing back button after push and the
// "stuck" tint after a cancelled swipe.

private struct NavConfigurator: UIViewControllerRepresentable {
    let style: AppNavigationStyle

    func makeUIViewController(context: Context) -> CarrierVC {
        CarrierVC(style: style)
    }

    func updateUIViewController(_ uiViewController: CarrierVC, context: Context) {
        uiViewController.style = style
        uiViewController.apply()
    }

    final class CarrierVC: UIViewController {
        var style: AppNavigationStyle {
            didSet { if style != oldValue { apply() } }
        }

        init(style: AppNavigationStyle) {
            self.style = style
            super.init(nibName: nil, bundle: nil)
            view.isHidden = true
            view.isUserInteractionEnabled = false
        }

        required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }

        override func didMove(toParent parent: UIViewController?) {
            super.didMove(toParent: parent)
            apply()
        }

        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            apply()
        }

        func apply() {
            guard let host = hostingViewController() else { return }
            host.navigationItem.standardAppearance = makeAppearance(transparent: style.isTransparent)
            host.navigationItem.compactAppearance = makeAppearance(transparent: style.isTransparent)
            host.navigationItem.scrollEdgeAppearance = makeAppearance(transparent: true)
            host.navigationController?.navigationBar.tintColor = style.foreground
        }

        private func makeAppearance(transparent: Bool) -> UINavigationBarAppearance {
            let appearance = UINavigationBarAppearance()

            if transparent {
                appearance.configureWithTransparentBackground()
            } else {
                appearance.configureWithDefaultBackground()
                if let bg = style.background {
                    appearance.backgroundColor = bg
                }
            }

            appearance.titleTextAttributes = [
                .foregroundColor: style.foreground,
                .font: DesignSystemFontFamily.PretendardVariable.semiBold.font(size: 20.0)
            ]
            appearance.largeTitleTextAttributes = [
                .foregroundColor: style.foreground,
                .font: DesignSystemFontFamily.PretendardVariable.semiBold.font(size: 34.0)
            ]

            let backImage = UIImage(systemName: "chevron.backward")?
                .withTintColor(style.foreground, renderingMode: .alwaysOriginal)
            appearance.setBackIndicatorImage(backImage, transitionMaskImage: backImage)

            let buttonAppearance = UIBarButtonItemAppearance()
            buttonAppearance.normal.titleTextAttributes = [.foregroundColor: style.foreground]
            appearance.backButtonAppearance = buttonAppearance
            appearance.buttonAppearance = buttonAppearance
            appearance.doneButtonAppearance = buttonAppearance

            return appearance
        }

        /// Walks up the parent chain to find the view controller that sits directly inside the
        /// UINavigationController (typically the SwiftUI UIHostingController).
        private func hostingViewController() -> UIViewController? {
            var current: UIViewController? = self
            while let candidate = current {
                if candidate.parent is UINavigationController {
                    return candidate
                }
                current = candidate.parent
            }
            return nil
        }
    }
}
