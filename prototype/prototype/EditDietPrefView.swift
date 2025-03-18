import SwiftUI

struct EditDietPreferencesView: View {
    
    var userId: Int
    @State private var dietPreferences: [String] = []
    @State private var newPreference: String = ""
    var databaseHelper = DatabaseHelper()

    var body: some View {
        VStack {
            Text("Edit Dietary Preferences")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            // List dietary preferences
            List {
                ForEach(dietPreferences, id: \.self) { preference in
                    HStack {
                        Text(preference)
                        Spacer()
                        Button(action: {
                            removeDietPreference(preference)
                        }) {
                            Image(systemName: "trash")
                                .foregroundColor(.red)
                        }
                    }
                }
                .onDelete(perform: deleteDietPreference)
            }
            
            // Add new dietary preference input
            HStack {
                TextField("Enter new dietary preference", text: $newPreference)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button(action: addDietPreference) {
                    Text("Add Preference")
                        .font(.headline)
                        .foregroundColor(.blue)
                }
                .padding()
            }
        }
        .onAppear {
            loadDietPreferences()
        }
    }
    
    func loadDietPreferences() {
        guard let userPreferences = databaseHelper.getDietPrefByUserId(userId: userId) else {
            print("No dietary preferences found!")
            return
        }
        dietPreferences = userPreferences.map { $0 }
    }

    func addDietPreference() {
        if !newPreference.isEmpty {
            databaseHelper.addDietPreference(userId: userId, preference: newPreference)
            dietPreferences.append(newPreference)
            newPreference = ""
        }
    }

    func removeDietPreference(_ preference: String) {
        guard let preferenceIndex = dietPreferences.firstIndex(of: preference) else { return }
        dietPreferences.remove(at: preferenceIndex)
        databaseHelper.deleteDietPreference(dietPrefId: preferenceIndex)  // You might need a way to get the diet preference ID
    }
    
    func deleteDietPreference(at offsets: IndexSet) {
        offsets.forEach { index in
            let preference = dietPreferences[index]
            removeDietPreference(preference)
        }
    }
}

struct EditDietPreferencesView_Previews: PreviewProvider {
    static var previews: some View {
        EditDietPreferencesView(userId: 1)
    }
}
