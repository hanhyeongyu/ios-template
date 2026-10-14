import ProjectDescription
import Foundation

public extension TargetScript {
    static let SwiftLint = TargetScript.pre(
        script: """
                ROOT_DIR=\(ProcessInfo.processInfo.environment["TUIST_ROOT_DIR"] ?? "")
                if test -d "/opt/homebrew/bin/"; then
                    PATH="/opt/homebrew/bin/:${PATH}"
                fi

                export PATH

                if which swiftlint > /dev/null; then
                      swiftlint --config ${ROOT_DIR}/.swiftlint.yml
                else
                    echo "warning: SwiftLint not installed, download from https://github.com/realm/SwiftLint"
                fi
                """,
        name: "SwiftLint",
        basedOnDependencyAnalysis: false
    )

    static let FirebaseCrashlytics = TargetScript.post(
        script: """
                ROOT_DIR=\(ProcessInfo.processInfo.environment["TUIST_ROOT_DIR"] ?? "")
                CRASHLYTICS_RUN="${ROOT_DIR}/Tuist/.build/checkouts/firebase-ios-sdk/Crashlytics/run"
                if test ! -f "${CRASHLYTICS_RUN}"; then
                    echo "warning: FirebaseCrashlytics not found, run 'tuist install'"
                elif test ! -f "${ROOT_DIR}/Projects/App/Resources/GoogleService-Info.plist"; then
                    echo "warning: GoogleService-Info.plist missing, skipping Crashlytics upload"
                else
                    "${CRASHLYTICS_RUN}"
                fi
                """,
        name: "Firebase Crashlytics",
        inputPaths: [
            "${DWARF_DSYM_FOLDER_PATH}/${DWARF_DSYM_FILE_NAME}/Contents/Resources/DWARF/${TARGET_NAME}",
            "$(SRCROOT)/$(BUILT_PRODUCTS_DIR)/$(INFOPLIST_PATH)"
        ],
        basedOnDependencyAnalysis: false
    )

    static let GoogleService = TargetScript.post(
        script: """
            PLIST="$SRCROOT/Resources/GoogleService-Info.plist"
            if test -f "${PLIST}"; then
                cp -r "${PLIST}" "${BUILT_PRODUCTS_DIR}/${PRODUCT_NAME}.app/GoogleService-Info.plist"
            else
                echo "warning: GoogleService-Info.plist not found in Projects/App/Resources"
            fi
            """,
        name: "Firebase Info copy by Configuration",
        basedOnDependencyAnalysis: false
    )
}
