import SwiftUI

struct PlacementTestFlowView: View {
    @StateObject private var viewModel = OnboardingViewModel()

    var body: some View {
        ZStack {
            AppTheme.background.ignoresSafeArea()
            switch viewModel.stage {
            case .intro:
                PlacementIntroView(onStart: viewModel.startPlacementTest)
            case .test:
                PlacementQuestionView(viewModel: viewModel)
            case .result:
                PlacementResultView(viewModel: viewModel)
            }
        }
    }
}

private struct PlacementIntroView: View {
    var onStart: () -> Void

    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            Image(Mascots.owl.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 96, height: 96)
                .padding(12)
                .background(MainTab.learn.color.opacity(0.12), in: Circle())

            Text("Let's find your starting point")
                .font(AppTheme.titleFont)
                .multilineTextAlignment(.center)
                .foregroundColor(AppTheme.textPrimary)
                .padding(.horizontal, 20)

            Text("Answer a few quick questions about money and investing. Don't know an answer? No problem — just tap \"I'm not sure\" and move on. There's no failing this.")
                .font(AppTheme.bodyFont)
                .foregroundColor(AppTheme.textSecondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 30)

            Spacer()
            PrimaryButton(title: "Start", action: onStart)
                .padding(.horizontal, 32)
                .padding(.bottom, 50)
        }
    }
}

private struct PlacementQuestionView: View {
    @ObservedObject var viewModel: OnboardingViewModel

    var body: some View {
        VStack(spacing: 24) {
            ProgressBarView(progress: Double(viewModel.questionsAnswered) / 10.0)
                .padding(.top, 20)
                .padding(.horizontal, 20)

            if let question = viewModel.currentQuestion {
                ScrollView {
                    VStack(alignment: .leading, spacing: 24) {
                        Text(question.prompt)
                            .font(AppTheme.headingFont)
                            .foregroundColor(AppTheme.textPrimary)
                            .padding(.horizontal, 24)
                            .padding(.top, 12)

                        VStack(spacing: 12) {
                            ForEach(question.choices) { choice in
                                AnswerOptionButton(text: choice.text, state: .normal) {
                                    viewModel.answer(choiceID: choice.id)
                                }
                            }
                        }
                        .padding(.horizontal, 24)
                    }
                }
                // Forces SwiftUI to treat each question as a fresh view,
                // so old answer button states never bleed into the next one.
                .id(question.id)
            }

            Spacer()

            Button("I'm not sure — skip") {
                viewModel.answer(choiceID: nil)
            }
            .font(AppTheme.captionFont)
            .foregroundColor(AppTheme.textSecondary)
            .padding(.bottom, 30)
        }
    }
}

private struct PlacementResultView: View {
    @ObservedObject var viewModel: OnboardingViewModel

    var body: some View {
        VStack(spacing: 20) {
            Spacer()
            Image(systemName: "checkmark.seal.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 90, height: 90)
                .foregroundColor(AppTheme.primaryGreen)

            Text("You're all set!")
                .font(AppTheme.titleFont)
                .foregroundColor(AppTheme.textPrimary)

            Text("Based on your answers, we've matched you with the perfect starting point on your path: \(LessonContentData.units[viewModel.placementResultUnitIndex].title).")
                .font(AppTheme.bodyFont)
                .foregroundColor(AppTheme.textSecondary)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 30)

            Spacer()
            PrimaryButton(title: "Start Learning") {
                viewModel.finalizePlacement()
            }
            .padding(.horizontal, 32)
            .padding(.bottom, 50)
        }
    }
}
