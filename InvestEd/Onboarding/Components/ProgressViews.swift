import SwiftUI

struct ProgressBarView: View {
    let progress: Double

    var body: some View {
        GeometryReader { geo in
            ZStack(alignment: .leading) {
                Capsule().fill(AppTheme.textSecondary.opacity(0.2))
                Capsule()
                    .fill(AppTheme.primaryGreen)
                    .frame(width: geo.size.width * min(max(progress, 0), 1))
                    .animation(.easeInOut, value: progress)
            }
        }
        .frame(height: 12)
    }
}
