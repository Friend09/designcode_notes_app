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
                
                .background(MeshGradient(width: 3, height: 3, points: [
                    .init(0, 0), .init(0.5, 0), .init(1, 0),
                    .init(0, 0.5), .init(0.5, 0.5), .init(1, 0.5),
                    .init(0, 1), .init(0.5, 1), .init(1, 1)
                ], colors: [
                    .red, .purple, .indigo,
                    .orange, .white, .blue,
                    .yellow, .green, .mint
                ]).cornerRadius(16))
                .foregroundColor(.black)
                .cornerRadius(10)
                .overlay(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(.white, lineWidth: 3)
                        .blur(radius: 2)
                        .blendMode(.overlay)
                )
                .background(.black)
                .cornerRadius(16)
                .background(
                    RoundedRectangle(cornerRadius: 16)
                        .stroke(.black.opacity(0.5), lineWidth: 1)
                )
                .shadow(color: .black.opacity(0.15), radius: 20, x: 0, y: 20)
                .shadow(color: .black.opacity(0.1), radius: 15, x: 0, y: 15)
                
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
