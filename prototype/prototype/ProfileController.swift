//
//  ProfileController.swift
//  prototype
//
//  Created by Nicole Milmine on 2025-03-18.
//
import SwiftUI

struct ProfileView: View {
    
    @State private var user: User? 
    @State private var isEditing = false
    var userId: Int
    var databaseHelper = DatabaseHelper()
    
    var body: some View {
        VStack {
            if let user = user {
                VStack(spacing: 16) {
                    // Display user profile information
                    Text(user.name)
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    // Profile Image 
                    Image(systemName: "person.crop.circle.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 120, height: 120)
                        .padding()

                    // Height
                    Text("Height: \(user.heightFt)' \(user.heightIn)\"")
                    
                    // Weight
                    Text("Weight: \(user.weightAsString) lbs")
                    
                    // Activity Level
                    Text("Activity Level: \(user.activityLvl)")
                    
                    // Year Joined
                    Text("Joined: \(user.yearJoined)")

                    // Edit button to go to the EditProfileView
                    Button(action: {
                        isEditing.toggle()
                    }) {
                        Text("Edit Profile")
                            .font(.headline)
                            .foregroundColor(.blue)
                    }
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
        .sheet(isPresented: $isEditing) {
            EditProfileView(userId: userId)
        }
    }
    
    func loadUserData() {
        guard let fetchedUser = databaseHelper.getUserById(userId: userId) else {
            print("User not found!")
            return
        }
        self.user = fetchedUser
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView(userId: 1)
    }
}
