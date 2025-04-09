import SwiftUI

struct ContentView: View {
    @State private var inputText: String = ""
    @State private var isLoading: Bool = false

    var body: some View {
        VStack (spacing: 20) {
            Text("Generate Notes")
                .font(.title)
                .fontWeight(.bold)
            Text("Transform your thoughts into well-structured notes using artificial intelligence.")
            

            TextEditor(text: $inputText)
                .frame(height: 200)
                .padding()
                .background(RoundedRectangle(cornerRadius: 10)
                    .fill(Color(.systemGray6)))
                .padding(.horizontal)

            Button(action: {}) {
                HStack {
                    if isLoading {
                        ProgressView()
                            .tint(.white)
                    } else {
                        Image(systemName: "sparkles")
                    }
                    Text(isLoading ? "Generating..." : "Generate Notes")
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
            }
            .disabled(isLoading || inputText.isEmpty)
            .padding(.horizontal)

            Spacer()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
    }
}

#Preview {
    ContentView()
}
