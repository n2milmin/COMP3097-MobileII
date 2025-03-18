import SwiftUI

struct EditAllergiesView: View {
    
    var userId: Int
    @State private var allergies: [String] = []
    @State private var newAllergy: String = ""
    var databaseHelper = DatabaseHelper()

    var body: some View {
        VStack {
            Text("Edit Allergies")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding()
            
            // List allergies
            List {
                ForEach(allergies, id: \.self) { allergy in
                    HStack {
                        Text(allergy)
                        Spacer()
                        Button(action: {
                            removeAllergy(allergy)
                        }) {
                            Image(systemName: "trash")
                                .foregroundColor(.red)
                        }
                    }
                }
                .onDelete(perform: deleteAllergy)
            }
            
            // Add new allergy input
            HStack {
                TextField("Enter new allergy", text: $newAllergy)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                Button(action: addAllergy) {
                    Text("Add Allergy")
                        .font(.headline)
                        .foregroundColor(.blue)
                }
                .padding()
            }
        }
        .onAppear {
            loadAllergies()
        }
    }
    
    func loadAllergies() {
        guard let userAllergies = databaseHelper.getAllergiesByUserId(userId: userId) else {
            print("No allergies found!")
            return
        }
        allergies = userAllergies.map { $0 }
    }

    func addAllergy() {
        if !newAllergy.isEmpty {
            databaseHelper.addAllergy(userId: userId, allergy: newAllergy)
            allergies.append(newAllergy)
            newAllergy = ""
        }
    }

    func removeAllergy(_ allergy: String) {
        guard let allergyIndex = allergies.firstIndex(of: allergy) else { return }
        allergies.remove(at: allergyIndex)
        databaseHelper.deleteAllergy(allergyId: allergyIndex)  // You might need a way to get the allergy ID
    }
    
    func deleteAllergy(at offsets: IndexSet) {
        offsets.forEach { index in
            let allergy = allergies[index]
            removeAllergy(allergy)
        }
    }
}

struct EditAllergiesView_Previews: PreviewProvider {
    static var previews: some View {
        EditAllergiesView(userId: 1)
    }
}
