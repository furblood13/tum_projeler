import SwiftUI

struct AIView: View {
    @State var prompt = ""
    @StateObject private var viewModel = AIViewModel()
    @StateObject private var apikey = APIKey()
    
    var body: some View {
        ZStack {
            // Arkaplan gradyanı
            LinearGradient(
                gradient: Gradient(colors: [.mor, .yesil]),
                startPoint: .topTrailing,
                endPoint: .bottomLeading
            )
            .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // ScrollView ekranın yarısını kaplar
                ScrollView {
                    VStack {
                        Text(viewModel.fetchedText.isEmpty ? "Fetched text will appear here." : viewModel.fetchedText)
                            .foregroundColor(.black)
                            .padding()
                            .multilineTextAlignment(.center)
                    }
                    .frame(maxWidth: .infinity)
                    
                }
                
                .frame(height: UIScreen.main.bounds.height * 0.5) // Ekranın yarısı
                Divider()
                        .background(Color.black) // Çizginin rengini belirleyebilirsiniz.
                        .frame(height: 10)
                // Alt kısım
                VStack(alignment: .leading, spacing: 20) {
                    Text("Please Give Some Details About Your Dream Holiday:")
                        .foregroundColor(.white)
                        .bold()
                        .font(.title2)
                        .padding(.horizontal, 20)
                    
                    VStack(alignment: .leading, spacing: 10) {
                        Text("- What kind of holiday?")
                        Text("- For how long?")
                        Text("- How much you can spend?")
                    }
                    .foregroundColor(.white)
                    .font(.body)
                    .padding(.horizontal, 25)
                    
                    TextField("Your answer here...", text: $prompt)
                        .padding()
                        .background(Color.white)
                        .cornerRadius(10)
                        .padding(.horizontal, 20)
                    
                    Button(action: {
                        Task {
                            let newprompt = "I am planning to go Turkey for a holiday and this is my details about my holiday: \(prompt) give me a few place name based on this details"
                            await viewModel.fetchData(prompt: newprompt)
                        }
                    }) {
                        Text("SEND")
                            .bold()
                            .frame(width: 180, height: 55)
                            
                            .background(
                                RoundedRectangle(cornerRadius: 10, style: .continuous)
                                    .fill(.linearGradient(colors: [.mor, .mor],
                                                          startPoint: .top,
                                                          endPoint: .bottom))
                            )
                            .foregroundColor(.white)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    .padding(.bottom, 10)
                }
                .frame(maxWidth: .infinity)
            }
        }
    }
}

#Preview {
    AIView()
}
