import SwiftUI
import Firebase
import FirebaseAuth

struct SignUpView: View {
    @StateObject var authManager = AuthManager()
    @State private var email = ""
    @State private var password = ""
    @State private var confirmPassword = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var navigateToLogin = false
    @State private var showSuccessAlert = false

    var body: some View {
        NavigationStack {
            ZStack {
                LinearGradient(colors: [.mor, .yesil],
                               startPoint: .topTrailing,
                               endPoint: .bottomLeading)
                VStack(spacing: 15) {
                    Text("Welcome To Our App")
                        .foregroundStyle(.white)
                        .font(.system(size: 30, weight: .bold, design: .rounded))
                        .offset(x: -40, y: -150)
                    
                    TextField("", text: $email)
                        .foregroundColor(.white)
                        .textFieldStyle(.plain)
                        .placeholder(when: email.isEmpty) {
                            Text("E-mail")
                                .foregroundStyle(.white)
                                .bold()
                        }
                    Rectangle()
                        .frame(width: 350, height: 1)
                        .foregroundColor(.white)
                    
                    SecureField("", text: $password)
                        .foregroundColor(.white)
                        .textFieldStyle(.plain)
                        .placeholder(when: password.isEmpty) {
                            Text("Password")
                                .foregroundStyle(.white)
                                .bold()
                        }
                    Rectangle()
                        .frame(width: 350, height: 1)
                        .foregroundColor(.white)
                    
                    SecureField("", text: $confirmPassword)
                        .foregroundColor(.white)
                        .textFieldStyle(.plain)
                        .placeholder(when: confirmPassword.isEmpty) {
                            Text("Confirm Password")
                                .foregroundStyle(.white)
                                .bold()
                        }
                    Rectangle()
                        .frame(width: 350, height: 1)
                        .foregroundColor(.white)
                    
                    Button {
                        register()
                    } label: {
                        Text("Sign Up")
                            .bold()
                            .frame(width: 200, height: 40)
                            .background(
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(.linearGradient(colors: [.mor, .yesil], startPoint: .topTrailing, endPoint: .bottomTrailing))
                            )
                            .foregroundColor(.white)
                    }
                    .padding(.top)
                    .offset(y: 70)

                    Button {
                        navigateToLogin = true // Trigger navigation to LoginView
                    } label: {
                        Text("Already have an account? Login")
                            .foregroundStyle(.white)
                            .bold()
                    }
                    .padding(.top)
                    .offset(y: 100)
                }
                .frame(width: 350)
            }
            .ignoresSafeArea()
            .alert("Success", isPresented: $showSuccessAlert) {
                Button("OK") {
                    navigateToLogin = true  // Navigate after clicking OK
                }
            } message: {
                Text("Registration successful!")
            }
            .alert("Error", isPresented: $showAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(alertMessage)
            }
            .navigationDestination(isPresented: $navigateToLogin) {
                LoginView()
            }
        }
        .onAppear {
            // Reset the navigation state when the view appears
            navigateToLogin = false
        }
    }
    
    func register() {
        if email.isEmpty || password.isEmpty || confirmPassword.isEmpty {
            alertMessage = "Please fill in all fields."
            showAlert = true
            return
        }
        
        if password != confirmPassword {
            alertMessage = "Passwords do not match."
            showAlert = true
            return
        }
        
        if password.count < 6 {
            alertMessage = "Password must be at least 6 characters long."
            showAlert = true
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                alertMessage = error.localizedDescription
                showAlert = true
            } else {
                // Show success alert instead of navigating directly
                alertMessage = "Registration successful! Please log in."
                showSuccessAlert = true
            }
        }
    }
}

#Preview {
    SignUpView()
        .environmentObject(AuthManager())
}

extension View {
    func placeholder<Content: View>(
        when shouldShow: Bool,
        alignment: Alignment = .leading,
        @ViewBuilder placeholder: () -> Content) -> some View {
        ZStack(alignment: alignment) {
            placeholder().opacity(shouldShow ? 1 : 0)
            self
        }
    }
}
