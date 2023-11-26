//
//  NeedNameSheet.swift
//  DWBingo
//
//  Created by Japhet Tegtmeyer on 11/19/23.
//

import SwiftUI

struct NeedNameSheet: View {
    
    // MARK: - App Storage Properties
    
    @AppStorage("first_name") var firstName: String = ""
    @AppStorage("last_name") var lastName: String = ""
    @AppStorage("Edit") var isEditing: Bool = false
    
    // MARK: - Environment Properties
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            
            // MARK: - Vertical Stack
            
            VStack(spacing: 15) {
                
                // MARK: - Introduction Text
                
                Text("We'll need this info for the app to run properly")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .padding(.top, 50)
                    .accessibilityLabel("We need your first and last name for the app to run properly.")
                
                // MARK: - First Name Text Field
                
                TextField("First Name",
                          text: $firstName)
                .padding(.horizontal)
                .padding(.vertical, 10)
                .background(Color(.systemGray5))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .padding(.horizontal)
                .accessibilityLabel("Form for first name")
                
                
                // MARK: - Last Name Text Field
                
                TextField("Last Name",
                          text: $lastName)
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                    .background(Color(.systemGray5))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.horizontal)
                    .accessibilityLabel("Form for last name")
                
                
                Text("*Your last name will be used for registering child cards")
                    .font(.caption2)
                    .foregroundStyle(.secondary)
                    .padding(.top, -8)
                
                // MARK: - Done Button
                
                HStack {
                    Spacer()
                    
                    Button {
                        isEditing = false
                        dismiss()
                        
                        let generator = UINotificationFeedbackGenerator()
                        generator.notificationOccurred(.success)
                    } label: {
                        Label("Done",
                              systemImage: "checkmark.circle")
                            .foregroundStyle(.white)
                            .padding(10)
                            .padding(.horizontal, 50)
                            .background(lastName.isEmpty ? .gray : firstName.isEmpty ? .gray : .purple)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .accessibilityLabel("Dismiss the register card form")
                    }
                    .disabled(firstName.isEmpty ? true : lastName.isEmpty ? true : false)
                    
                    Spacer()
                }
                .padding(.vertical)
                
                Spacer()
            }
            
            // MARK: - Navigation Bar
            
            .navigationTitle(isEditing ? "Edit Name" : "Looks like we missed ya")
            .navigationBarTitleDisplayMode(.inline)
            
            // MARK: - On Appear
            
            .onAppear {
                UIImpactFeedbackGenerator(style: .rigid).impactOccurred()
            }
        }
    }
}

#Preview {
    NeedNameSheet()
}
