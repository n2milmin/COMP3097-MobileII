import SwiftUI

struct EditAllergiesView: View {
    @State private var allergies: [String] = ["Peanuts", "Shellfish", "Gluten", "Dairy", "Soy"] // Example allergies
    @State private var selectedAllergies: [String] = ["Peanuts", "Soy"] // Example user allergies (could be fetched from database)
    
    // Simulated Database Interaction for saving allergies
    func saveAllergies() {
        // Here you can update the database with the selected allergies
        print("Selected allergies: \(selectedAllergies)")
        // Call your actual database saving logic here
        // e.g., dbHelper.updateAllergies(userId: userId, allergies: selectedAllergies)
    }

    var body: some View {
        VStack {
            Text("Allergies & Restrictions")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 20)
            
            // List of allergies with checkboxes
            List(allergies, id: \.self) { allergy in
                HStack {
                    Text(allergy)
                        .font(.title3)
                    Spacer()
                    CheckBoxView(isChecked: self.selectedAllergies.contains(allergy)) {
                        if self.selectedAllergies.contains(allergy) {
                            self.selectedAllergies.removeAll { $0 == allergy }
                        } else {
                            self.selectedAllergies.append(allergy)
                        }
                    }
                }
                .padding(.vertical, 5)
            }
            
            // Save button
            Button(action: {
                saveAllergies()
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

struct EditAllergiesView_Previews: PreviewProvider {
    static var previews: some View {
        EditAllergiesView()
    }
}
