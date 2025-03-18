import SwiftUI

struct EditDietPrefView: View {
    @State private var selectedPreferences: [String] = []
    @State private var dietPreferences: [String] = ["Vegetarian", "Vegan", "Gluten-Free", "Keto", "Paleo"] // Example preferences
    @State private var userDietPreferences: [String] = ["Vegetarian", "Keto"] // Example user preferences, fetched from the database
    
    // Replace this with your actual database helper method for saving data
    func savePreferences() {
        // Here you can update the database with the selected preferences
        print("Selected preferences: \(selectedPreferences)")
        // You can call your database save method here
        // e.g., dbHelper.updateDietPreferences(userId: userId, preferences: selectedPreferences)
    }
    
    var body: some View {
        VStack {
            Text("Dietary Preferences")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 20)

            // List of dietary preferences with checkboxes
            List(dietPreferences, id: \.self) { preference in
                HStack {
                    Text(preference)
                        .font(.title3)
                    Spacer()
                    CheckBoxView(isChecked: self.selectedPreferences.contains(preference)) {
                        if self.selectedPreferences.contains(preference) {
                            self.selectedPreferences.removeAll { $0 == preference }
                        } else {
                            self.selectedPreferences.append(preference)
                        }
                    }
                }
                .padding(.vertical, 5)
            }
            
            // Save button
            Button(action: {
                savePreferences()
            }) {
                Text("Save")
                    .font(.title)
                    .frame(maxWidth: .infinity, minHeight: 50)
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding(.top, 20)
            }
            .padding(.horizontal, 20)
        }
        .padding()
        .onAppear {
            // Initialize the selected preferences with the user's existing preferences
            self.selectedPreferences = self.userDietPreferences
        }
    }
}

struct CheckBoxView: View {
    var isChecked: Bool
    var action: () -> Void

    var body: some View {
        Button(action: action) {
            Image(systemName: isChecked ? "checkmark.square" : "square")
                .font(.title)
                .foregroundColor(.green)
        }
    }
}

struct EditDietPrefView_Previews: PreviewProvider {
    static var previews: some View {
        EditDietPrefView()
    }
}
