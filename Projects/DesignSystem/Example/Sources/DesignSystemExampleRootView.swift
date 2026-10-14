import SwiftUI
import DesignSystem

struct DesignSystemExampleRootView: View {

    var body: some View {
        NavigationStack {
            List {
                Section("Button") {
                    Button("Filled") {}.appButtonStyle(.filled)
                    Button("Filled Disabled") {}.appButtonStyle(.filledDisabled)
                    Button("Outlined") {}.appButtonStyle(.outlined)
                    Button("Text") {}.appButtonStyle(.text)
                }
            }
            .navigationTitle("DesignSystem")
        }
    }

}
