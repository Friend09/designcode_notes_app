import SwiftUI

struct Note: Identifiable {
    let id = UUID()
    var title: String
    var content: String
    var location: String
    var date: Date
}

class NotesViewModel: ObservableObject {
    @Published var notes: [Note] = []

    func addNote(title: String, content: String, location: String) {
        let note = Note(title: title, content: content, location: location, date: Date())
        notes.append(note)
    }

    func deleteNote(at offsets: IndexSet) {
        notes.remove(atOffsets: offsets)
    }
}

struct ContentView: View {
    @StateObject private var viewModel = NotesViewModel()
    @State private var showingNewNoteSheet = false
    @State private var newNoteTitle = ""
    @State private var newNoteContent = ""
    @State private var newNoteLocation = ""

    // Custom colors
    private let accentColor = Color(red: 0.2, green: 0.5, blue: 0.9)
    private let backgroundColor = Color(red: 0.98, green: 0.98, blue: 0.98)
    private let cardBackgroundColor = Color.white
    private let textColor = Color(red: 0.2, green: 0.2, blue: 0.2)
    private let secondaryTextColor = Color(red: 0.6, green: 0.6, blue: 0.6)

    var body: some View {
        NavigationView {
            Group {
                if viewModel.notes.isEmpty {
                    VStack(spacing: 20) {
                        Image(systemName: "note.text")
                            .font(.system(size: 60))
                            .foregroundColor(accentColor)
                        Text("No Notes Yet")
                            .font(.title2)
                            .fontWeight(.medium)
                            .foregroundColor(textColor)
                        Text("Tap the + button to create your first note")
                            .font(.body)
                            .foregroundColor(secondaryTextColor)
                            .multilineTextAlignment(.center)
                    }
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(backgroundColor)
                } else {
                    List {
                        ForEach(viewModel.notes) { note in
                            VStack(alignment: .leading, spacing: 8) {
                                Text(note.title)
                                    .font(.headline)
                                    .foregroundColor(textColor)
                                Text(note.content)
                                    .font(.body)
                                    .foregroundColor(secondaryTextColor)
                                    .lineLimit(2)
                                HStack {
                                    Image(systemName: "location.fill")
                                        .foregroundColor(accentColor)
                                    Text(note.location)
                                        .font(.caption)
                                        .foregroundColor(accentColor)
                                }
                                Text(note.date, style: .date)
                                    .font(.caption)
                                    .foregroundColor(accentColor)
                            }
                            .padding(.vertical, 8)
                            .listRowBackground(cardBackgroundColor)
                        }
                        .onDelete(perform: viewModel.deleteNote)
                    }
                    .listStyle(PlainListStyle())
                    .background(backgroundColor)
                }
            }
            .navigationTitle("Notes")
            .toolbar {
                Button(action: {
                    showingNewNoteSheet = true
                }) {
                    Image(systemName: "plus")
                        .foregroundColor(accentColor)
                }
            }
            .sheet(isPresented: $showingNewNoteSheet) {
                NavigationView {
                    Form {
                        TextField("Title", text: $newNoteTitle)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .foregroundColor(textColor)
                        TextField("Location", text: $newNoteLocation)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .foregroundColor(textColor)
                        TextEditor(text: $newNoteContent)
                            .frame(height: 200)
                            .foregroundColor(textColor)
                    }
                    .navigationTitle("New Note")
                    .navigationBarItems(
                        leading: Button("Cancel") {
                            showingNewNoteSheet = false
                            newNoteTitle = ""
                            newNoteContent = ""
                            newNoteLocation = ""
                        }
                        .foregroundColor(accentColor),
                        trailing: Button("Save") {
                            if !newNoteTitle.isEmpty {
                                viewModel.addNote(title: newNoteTitle, content: newNoteContent, location: newNoteLocation)
                                showingNewNoteSheet = false
                                newNoteTitle = ""
                                newNoteContent = ""
                                newNoteLocation = ""
                            }
                        }
                        .disabled(newNoteTitle.isEmpty)
                        .foregroundColor(newNoteTitle.isEmpty ? secondaryTextColor : accentColor)
                    )
                }
            }
        }
        .accentColor(accentColor)
    }
}

#Preview {
    ContentView()
}
