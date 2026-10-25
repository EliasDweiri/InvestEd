import SwiftUI

/// The Settings screen (opened from the Profile tab). Home for account
/// management — including the App Store-required in-app account deletion —
/// notifications, purchases, and the legal links every published app needs.
struct SettingsView: View {
    @EnvironmentObject var appState: AppState
    @StateObject private var viewModel = SettingsViewModel()
    @Environment(\.dismiss) private var dismiss

    @AppStorage("streakReminderOn") private var streakReminderOn = true
    @State private var showDisclaimer = false
    @State private var showDeleteConfirm = false
    @State private var showPasswordPrompt = false
    @State private var deletePassword = ""

    var body: some View {
        NavigationStack {
            Form {
                accountSection
                notificationsSection
                if ShopView.purchasesEnabled { purchasesSection }
                legalSection
                dangerSection

                Section {
                    Text("InvestEd \(Constants.appVersion)")
                        .font(AppTheme.captionFont)
                        .foregroundColor(AppTheme.textSecondary)
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                .listRowBackground(Color.clear)
            }
            .navigationTitle("Settings")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Done") { dismiss() }
                }
            }
            .onAppear { viewModel.loadDraft() }
            .sheet(isPresented: $showDisclaimer) { DisclaimerView() }
            .alert("Delete account?", isPresented: $showDeleteConfirm) {
                Button("Cancel", role: .cancel) {}
                Button("Delete", role: .destructive) {
                    if viewModel.needsPasswordToDelete {
                        showPasswordPrompt = true
                    } else {
                        Task { await viewModel.deleteAccount(password: "") }
                    }
                }
            } message: {
                Text("This permanently erases your profile, progress, and simulated portfolio. This can't be undone.")
            }
            .alert("Confirm your password", isPresented: $showPasswordPrompt) {
                SecureField("Password", text: $deletePassword)
                Button("Cancel", role: .cancel) { deletePassword = "" }
                Button("Delete", role: .destructive) {
                    let pw = deletePassword
                    deletePassword = ""
                    Task { await viewModel.deleteAccount(password: pw) }
                }
            } message: {
                Text("For your security, re-enter your password to delete your account.")
            }
        }
    }

    // MARK: - Sections

    private var accountSection: some View {
        Section("Account") {
            HStack {
                TextField("Username", text: $viewModel.usernameDraft)
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled()
                Button("Save") { Task { await viewModel.saveUsername() } }
                    .font(AppTheme.captionFont.bold())
                    .disabled(viewModel.isWorking)
            }
            HStack {
                Text("Email").foregroundColor(AppTheme.textSecondary)
                Spacer()
                Text(viewModel.email).foregroundColor(AppTheme.textSecondary)
            }
            if let message = viewModel.message {
                Text(message)
                    .font(AppTheme.captionFont)
                    .foregroundColor(AppTheme.secondaryBlue)
            }
            // Re-runs the adaptive placement test. Nothing is saved until the
            // test is finished, and a retake never moves you backward.
            Button("Retake placement test") {
                guard var user = appState.currentUser else { return }
                user.hasCompletedPlacement = false
                dismiss()
                appState.currentUser = user
            }
        }
    }

    private var notificationsSection: some View {
        Section("Notifications") {
            Toggle("Daily streak reminder", isOn: $streakReminderOn)
                .onChange(of: streakReminderOn) { _, on in
                    if on { NotificationService.shared.scheduleDailyStreakReminder() }
                    else { NotificationService.shared.cancelDailyStreakReminder() }
                }
            Text("A gentle nudge at 6:30pm so your streak never slips.")
                .font(AppTheme.captionFont)
                .foregroundColor(AppTheme.textSecondary)
        }
    }

    private var purchasesSection: some View {
        Section("Purchases") {
            Button("Restore Purchases") { Task { await IAPManager.shared.restore() } }
        }
    }

    private var legalSection: some View {
        Section("About") {
            if let url = URL(string: Constants.privacyPolicyURL) {
                Link("Privacy Policy", destination: url)
            }
            if let url = URL(string: Constants.termsOfServiceURL) {
                Link("Terms of Service", destination: url)
            }
            Button("Educational Disclaimer") { showDisclaimer = true }
            Link("Contact Support", destination: URL(string: "mailto:\(Constants.supportEmail)")!)
        }
    }

    private var dangerSection: some View {
        Section {
            Button("Sign Out") { viewModel.signOut() }
            Button(role: .destructive) {
                showDeleteConfirm = true
            } label: {
                if viewModel.isWorking {
                    ProgressView()
                } else {
                    Text("Delete Account")
                }
            }
            .disabled(viewModel.isWorking)
        } footer: {
            Text("Deleting your account removes all your data from InvestEd.")
        }
    }
}
