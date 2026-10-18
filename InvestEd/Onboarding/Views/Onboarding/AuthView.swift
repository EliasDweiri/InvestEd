import SwiftUI
import AuthenticationServices
import CryptoKit

struct AuthView: View {
    /// Flip on once the "Sign in with Apple" capability is added in Xcode and
    /// configured in the Firebase console (needs the Apple Developer account).
    /// The full flow below is wired and ready — this just hides the button
    /// until that's set up. (Email/password already satisfies Apple's rules.)
    static let appleSignInEnabled = false

    @StateObject private var viewModel = AuthViewModel()
    @State private var isSignUp = true
    @State private var email = ""
    @State private var password = ""
    @State private var username = ""
    @State private var currentNonce: String?

    var body: some View {
        ZStack {
            AppTheme.background.ignoresSafeArea()
            ScrollView {
                VStack(spacing: 20) {
                    VStack(alignment: .leading, spacing: 6) {
                        Text("INVESTED")
                            .font(AppTheme.kickerFont)
                            .tracking(1.4)
                            .foregroundColor(AppTheme.onInk.opacity(0.75))
                        Text(isSignUp ? "Create your account" : "Welcome back")
                            .font(.system(size: 30, weight: .bold, design: .serif))
                            .foregroundColor(AppTheme.onInk)
                        Text(isSignUp ? "Free, and it takes about 30 seconds." : "Pick up your streak where you left off.")
                            .font(.subheadline)
                            .foregroundColor(AppTheme.onInk.opacity(0.85))
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(20)
                    .background(InkHeaderBackground(color: MainTab.learn.color))
                    .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
                    .padding(.top, 24)

                    if isSignUp {
                        InvestEdTextField(title: "Username", text: $username)
                    }
                    InvestEdTextField(title: "Email", text: $email, keyboard: .emailAddress)
                    InvestEdSecureField(title: "Password", text: $password)

                    if let error = viewModel.errorMessage {
                        Text(error)
                            .font(AppTheme.captionFont)
                            .foregroundColor(AppTheme.dangerRed)
                    }

                    PrimaryButton(title: isSignUp ? "Sign Up" : "Log In", isLoading: viewModel.isLoading) {
                        Task {
                            if isSignUp {
                                await viewModel.signUp(email: email, password: password, username: username)
                            } else {
                                await viewModel.signIn(email: email, password: password)
                            }
                        }
                    }

                    Button {
                        isSignUp.toggle()
                    } label: {
                        Text(isSignUp ? "Already have an account? Log in" : "New here? Create an account")
                            .font(AppTheme.captionFont)
                            .foregroundColor(AppTheme.secondaryBlue)
                    }

                    if Self.appleSignInEnabled {
                        HStack {
                            Rectangle().fill(AppTheme.textSecondary.opacity(0.3)).frame(height: 1)
                            Text("or").font(AppTheme.captionFont).foregroundColor(AppTheme.textSecondary)
                            Rectangle().fill(AppTheme.textSecondary.opacity(0.3)).frame(height: 1)
                        }
                        SignInWithAppleButton(.continue) { request in
                            let nonce = Self.randomNonceString()
                            currentNonce = nonce
                            request.requestedScopes = [.fullName, .email]
                            request.nonce = Self.sha256(nonce)
                        } onCompletion: { result in
                            handleAppleResult(result)
                        }
                        .signInWithAppleButtonStyle(.black)
                        .frame(height: 50)
                        .clipShape(RoundedRectangle(cornerRadius: 14))
                    }
                }
                .padding(.horizontal, 28)
                .padding(.bottom, 40)
            }
        }
    }

    // MARK: - Sign in with Apple

    private func handleAppleResult(_ result: Result<ASAuthorization, Error>) {
        switch result {
        case .success(let auth):
            guard let credential = auth.credential as? ASAuthorizationAppleIDCredential,
                  let tokenData = credential.identityToken,
                  let idToken = String(data: tokenData, encoding: .utf8),
                  let nonce = currentNonce else {
                viewModel.errorMessage = "Apple sign-in failed. Please try again."
                return
            }
            Task {
                await viewModel.signInWithAppleCredential(
                    idToken: idToken, nonce: nonce,
                    email: credential.email, fullName: credential.fullName)
            }
        case .failure(let error):
            viewModel.errorMessage = error.localizedDescription
        }
    }

    private static func randomNonceString(length: Int = 32) -> String {
        let charset: [Character] = Array("0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz-._")
        var result = ""
        var remaining = length
        while remaining > 0 {
            var random: UInt8 = 0
            _ = SecRandomCopyBytes(kSecRandomDefault, 1, &random)
            if random < UInt8(charset.count) {
                result.append(charset[Int(random)])
                remaining -= 1
            }
        }
        return result
    }

    private static func sha256(_ input: String) -> String {
        SHA256.hash(data: Data(input.utf8)).map { String(format: "%02x", $0) }.joined()
    }
}

private struct InvestEdTextField: View {
    let title: String
    @Binding var text: String
    var keyboard: UIKeyboardType = .default

    var body: some View {
        TextField(title, text: $text)
            .keyboardType(keyboard)
            .textInputAutocapitalization(.never)
            .autocorrectionDisabled()
            .padding()
            .cardSurface(radius: 14)
    }
}

private struct InvestEdSecureField: View {
    let title: String
    @Binding var text: String

    var body: some View {
        SecureField(title, text: $text)
            .padding()
            .cardSurface(radius: 14)
    }
}
