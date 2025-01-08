import SwiftUI
import Firebase
import FirebaseAuth

struct LoginView: View {
    @StateObject var authManager = AuthManager()
    @State private var email = ""
    @State private var password = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        NavigationStack {
            if authManager.isLoggedIn {
                ContentView()
                    .navigationBarBackButtonHidden(true)
            } else {
                ZStack {
                    LinearGradient(colors: [.mor, .yesil],
                                   startPoint: .topTrailing,
                                   endPoint: .bottomLeading)
                    VStack(spacing: 15) {
                        Text("Welcome Back")
                            .foregroundStyle(.white)
                            .font(.system(size: 30, weight: .bold, design: .rounded))
                            .offset(x: -70, y: -150)
                        
                        TextField("E-mail", text: $email)
                            .foregroundColor(.white)
                            .textFieldStyle(.plain)
                        Rectangle()
                            .frame(width: 350, height: 1)
                            .foregroundColor(.white)
                        
                        SecureField("Password", text: $password)
                            .foregroundColor(.white)
                            .textFieldStyle(.plain)
                        Rectangle()
                            .frame(width: 350, height: 1)
                            .foregroundColor(.white)
                        
                        Button {
                            login()
                        } label: {
                            Text("Login")
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
                    }
                    .frame(width: 350)
                }
                .ignoresSafeArea()
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                }
                .navigationTitle("Login")
                .navigationBarTitleDisplayMode(.inline)
            }
        }
    }
    
    func login() {
        if email.isEmpty || password.isEmpty {
            alertMessage = "Please enter both email and password."
            showAlert = true
            return
        }

        authManager.login(email: email, password: password) { success in
            if !success {
                alertMessage = "Invalid credentials. Please try again."
                showAlert = true
            }
        }
    }
}

#Preview {
    LoginView()
        .environmentObject(AuthManager())
}
