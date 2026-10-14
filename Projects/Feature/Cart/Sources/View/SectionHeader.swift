import SwiftUI
import DesignSystem

struct SectionHeader: View {

    private let title: String

    init(title: String) {
        self.title = title
    }

    var body: some View {
        Text(title)
            .font(.caption1B)
            .foregroundStyle(Color.textSecondary)
    }
}
