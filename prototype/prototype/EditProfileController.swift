import SwiftUI

struct EditProfileView: View {
    @State private var name: String = "John Doe"
    @State private var heightFt: String = "5"
    @State private var heightIn: String = "10"
    @State private var weight: String = "180"
    @State private var activityLvl: String = "Moderate"
    @State private var yearJoined: String = "2020"
    
    private let activityLevels = ["Sedentary", "Light", "Moderate", "Active", "Very Active"]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                
                // Profile Pic (Static Image for now)
                Image(systemName: "person.crop.circle.fill")
                    .resizable()
                    .frame(width: 100, height: 100)
                    .foregroundColor(.gray)
                    .clipShape(Circle())
                    .shadow(radius: 5)
                
                // Name
                TextField("Name", text: $name)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                // Year Joined
                Text("Member since \(yearJoined)")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                
                Divider()
                
                // Height
                HStack {
                    TextField("Feet", text: $heightFt)
                        .keyboardType(.numberPad)
                        .frame(width: 80)
                        .padding()
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    
                    TextField("Inches", text: $heightIn)
                        .keyboardType(.numberPad)
                        .frame(width: 80)
                        .padding()
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                }
                
                // Weight
                TextField("Weight (lbs)", text: $weight)
                    .keyboardType(.numberPad)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
                // Activity Level
                Picker("Activity Level", selection: $activityLvl) {
                    ForEach(activityLevels, id: \.self) { level in
                        Text(level)
                    }
                }
                .pickerStyle(MenuPickerStyle())
                .padding()
                
                // Save Button
                Button(action: saveProfile) {
                    Text("Save")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.green)
                        .cornerRadius(10)
                }
                .padding(.top)
                
            }
            .padding()
            .navigationTitle("Edit Profile")
        }
    }
    
    private func saveProfile() {
        // Simulate saving the profile data
        print("Profile saved with name: \(name), height: \(heightFt)ft \(heightIn)in, weight: \(weight) lbs, activity level: \(activityLvl), member since: \(yearJoined)")
        
        // In a real app, you would save these values to the database and navigate back to the Profile View
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView()
    }
}
