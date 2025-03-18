//
//  ProfileController.swift
//  prototype
//
//  Created by Nicole Milmine on 2025-03-18.
//

import SwiftUI

struct ProfileView: View {
    @State private var user = User(name: "John Doe", heightFt: 5, heightIn: 10, weight: 180, activityLvl: "Moderate", yearJoined: 2020)
    @State private var dietPrefs: [String] = ["Vegetarian", "Gluten-Free"]
    @State private var allergies: [String] = ["Peanuts", "Shellfish"]
    
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(spacing: 20) {
                    
                    // Profile Card
                    VStack(spacing: 12) {
                        // Profile Picture
                        Image(systemName: "person.crop.circle.fill")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .foregroundColor(.gray)
                            .clipShape(Circle())
                            .shadow(radius: 5)
                        
                        Text(user.name)
                            .font(.headline)
                            .bold()
                        
                        Text("Member since \(user.yearJoined)")
                            .font(.subheadline)
                        
                        Divider()
                        
                        // Profile Details
                        ProfileDetail(title: "Height", value: "\(user.heightFt)\' \(user.heightIn)\"")
                        ProfileDetail(title: "Weight", value: "\(user.weight) lbs")
                        ProfileDetail(title: "Activity Level", value: user.activityLvl)
                        
                        Divider()
                        
                        // Edit Profile Button - Navigate to EditProfileView
                        NavigationLink(destination: EditProfileView()) {
                            Text("Edit Profile")
                                .font(.body)
                                .foregroundColor(.green)
                                .padding()
                                .background(Capsule().strokeBorder(Color.green, lineWidth: 2))
                        }
                    }
                    .padding()
                    .background(RoundedRectangle(cornerRadius: 16).fill(Color.white).shadow(radius: 5))
                    .padding(.horizontal)
                    
                    // Dietary Preferences Card
                    VStack(alignment: .leading) {
                        Text("Dietary Preferences")
                            .font(.title2)
                            .bold()
                            .padding(.horizontal)
                        
                        LazyHStack(spacing: 10) {
                            ForEach(dietPrefs, id: \.self) { pref in
                                Text(pref)
                                    .padding()
                                    .background(RoundedRectangle(cornerRadius: 8).strokeBorder(Color.green, lineWidth: 2))
                                    .frame(height: 40)
                            }
                        }
                        .padding(.horizontal)
                        
                        // Edit Preferences Button - Navigate to EditPreferencesView
                        NavigationLink(destination: EditDietPrefView()) {
                            Text("Edit")
                                .foregroundColor(.green)
                        }
                        .padding(.horizontal)
                    }
                    .padding(.top, 20)
                    .background(RoundedRectangle(cornerRadius: 16).fill(Color.white).shadow(radius: 5))
                    .padding(.horizontal)
                    
                    // Allergies & Restrictions Card
                    VStack(alignment: .leading) {
                        Text("Allergies & Restrictions")
                            .font(.title2)
                            .bold()
                            .padding(.horizontal)
                        
                        LazyHStack(spacing: 10) {
                            ForEach(allergies, id: \.self) { allergy in
                                Text(allergy)
                                    .padding()
                                    .background(RoundedRectangle(cornerRadius: 8).strokeBorder(Color.red, lineWidth: 2))
                                    .frame(height: 40)
                            }
                        }
                        .padding(.horizontal)
                        
                        // Edit Allergies Button - Navigate to EditAllergiesView
                        NavigationLink(destination: EditAllergiesView()) {
                            Text("Edit")
                                .foregroundColor(.red)
                        }
                        .padding(.horizontal)
                    }
                    .padding(.top, 20)
                    .background(RoundedRectangle(cornerRadius: 16).fill(Color.white).shadow(radius: 5))
                    .padding(.horizontal)
                }
                .padding(.top)
            }
            .background(Color.green.opacity(0.1))
        }
    }
}

// Helper view for profile details (Height, Weight, etc.)
struct ProfileDetail: View {
    var title: String
    var value: String
    
    var body: some View {
        HStack {
            Text(title)
                .font(.subheadline)
                .foregroundColor(.gray)
            Spacer()
            Text(value)
                .font(.subheadline)
                .fontWeight(.bold)
        }
        .padding(.horizontal)
    }
}

struct EditProfileView: View {
    var body: some View {
        Text("Edit Profile Screen")
            .font(.largeTitle)
    }
}

struct EditDietPrefView: View {
    var body: some View {
        Text("Edit Dietary Preferences Screen")
            .font(.largeTitle)
    }
}

struct EditAllergiesView: View {
    var body: some View {
        Text("Edit Allergies Screen")
            .font(.largeTitle)
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}

