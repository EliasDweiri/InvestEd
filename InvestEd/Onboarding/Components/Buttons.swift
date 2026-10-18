import SwiftUI

struct PrimaryButton: View {
    let title: String
    var isLoading: Bool = false
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            ZStack {
                if isLoading {
                    ProgressView().tint(.white)
                } else {
                    Text(title)
                        .font(AppTheme.bodyFont.bold())
                }
            }
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(AppTheme.primaryGreen)
            .foregroundColor(.white)
            .clipShape(RoundedRectangle(cornerRadius: AppTheme.cornerRadius))
        }
        .buttonStyle(SpringPressStyle())
        .disabled(isLoading)
    }
}

struct SecondaryButton: View {
    let title: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(AppTheme.bodyFont.bold())
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(AppTheme.cardBackground)
                .foregroundColor(AppTheme.primaryGreen)
                .overlay(
                    RoundedRectangle(cornerRadius: AppTheme.cornerRadius)
                        .stroke(AppTheme.primaryGreen, lineWidth: 2)
                )
                .clipShape(RoundedRectangle(cornerRadius: AppTheme.cornerRadius))
        }
        .buttonStyle(SpringPressStyle())
    }
}

/// Used for both lesson questions and placement test questions. Colors
/// itself based on whether it's the correct answer, the (wrong) one that
/// was picked, or just a normal unselected option.
struct AnswerOptionButton: View {
    enum OptionState {
        case normal, correct, incorrect, disabled
    }

    let text: String
    let state: OptionState
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Text(text)
                    .font(AppTheme.bodyFont)
                    .multilineTextAlignment(.leading)
                Spacer()
                if state == .correct {
                    Image(systemName: "checkmark.circle.fill")
                } else if state == .incorrect {
                    Image(systemName: "xmark.circle.fill")
                }
            }
            .padding(16)
            .background(backgroundColor)
            .foregroundColor(foregroundColor)
            .clipShape(RoundedRectangle(cornerRadius: AppTheme.cornerRadius, style: .continuous))
            .overlay(
                RoundedRectangle(cornerRadius: AppTheme.cornerRadius, style: .continuous)
                    .stroke(borderColor, lineWidth: state == .normal || state == .disabled ? 1 : 2)
            )
        }
    }

    private var backgroundColor: Color {
        switch state {
        case .normal, .disabled: return AppTheme.cardBackground
        case .correct: return AppTheme.primaryGreen.opacity(0.15)
        case .incorrect: return AppTheme.dangerRed.opacity(0.15)
        }
    }

    private var foregroundColor: Color {
        switch state {
        case .normal, .disabled: return AppTheme.textPrimary
        case .correct: return AppTheme.primaryGreen
        case .incorrect: return AppTheme.dangerRed
        }
    }

    private var borderColor: Color {
        switch state {
        case .normal, .disabled: return AppTheme.hairline
        case .correct: return AppTheme.primaryGreen
        case .incorrect: return AppTheme.dangerRed
        }
    }
}
