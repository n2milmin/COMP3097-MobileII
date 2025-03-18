import SwiftUI

struct EditProfileView: View {
    
    var userId: Int
    @State private var user: User?
    @State private var name: String = ""
    @State private var profilePic: String = ""
    @State private var heightFt: String = ""
    @State private var heightIn: String = ""
    @State private var weight: String = ""
    @State private var activityLvl: String = ""
    @State private var yearJoined: String = ""
    
    var databaseHelper = DatabaseHelper()
    
    var body: some View {
        VStack(spacing: 16) {
            if let user = user {
                // User Editing Form
                TextField("Name", text: $name)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                TextField("Profile Picture URL", text: $profilePic)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                TextField("Height (Ft)", text: $heightFt)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
                    .padding()
                
                TextField("Height (In)", text: $heightIn)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
                    .padding()
                
                TextField("Weight (lbs)", text: $weight)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
                    .padding()
                
                TextField("Activity Level", text: $activityLvl)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                TextField("Year Joined", text: $yearJoined)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
                    .padding()

                // Save button
                Button(action: saveProfile) {
                    Text("Save Changes")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                .padding()
            } else {
                // Loading state
                Text("Loading...")
            }
        }
        .onAppear {
            loadUserData()
        }
    }
    
    func loadUserData() {
        guard let fetchedUser = databaseHelper.getUserById(userId: userId) else {
            print("User not found!")
            return
        }
        self.user = fetchedUser
        self.name = fetchedUser.name
        self.profilePic = fetchedUser.profilePic
        self.heightFt = "\(fetchedUser.heightFt)"
        self.heightIn = "\(fetchedUser.heightIn)"
        self.weight = "\(fetchedUser.weight)"
        self.activityLvl = fetchedUser.activityLvl
        self.yearJoined = "\(fetchedUser.yearJoined)"
    }
    
    func saveProfile() {
        guard let updatedHeightFt = Int(heightFt),
              let updatedHeightIn = Int(heightIn),
              let updatedWeight = Int64(weight) else {
            print("Invalid data!")
            return
        }
        
        let updatedUser = User(id: userId,
                               name: name,
                               profilePic: profilePic,
                               heightFt: updatedHeightFt,
                               heightIn: updatedHeightIn,
                               weight: updatedWeight,
                               activityLvl: activityLvl,
                               activityLvlPosition: 0,
                               yearJoined: Int(yearJoined) ?? 0)
        
        // Update the user in the database
        let rowsAffected = databaseHelper.updateUser(userId: userId,
                                                     name: name,
                                                     profilePic: profilePic,
                                                     heightFt: updatedHeightFt,
                                                     heightIn: updatedHeightIn,
                                                     weight: updatedWeight,
                                                     activityLvl: activityLvl,
                                                     activityLvlPosition: 0,
                                                     yearJoined: Int(yearJoined) ?? 0)
        
        if rowsAffected > 0 {
            print("Profile updated successfully!")
        } else {
            print("Failed to update profile.")
        }
    }
}

struct EditProfileView_Previews: PreviewProvider {
    static var previews: some View {
        EditProfileView(userId: 1)
    }
}
