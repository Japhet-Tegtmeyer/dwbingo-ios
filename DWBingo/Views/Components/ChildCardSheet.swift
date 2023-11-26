//
//  ChildCardSheet.swift
//  DWBingo
//
//  Created by Japhet Tegtmeyer on 11/15/23.
//

import SwiftUI

struct ChildCardSheet: View {
    
    // MARK: - App Storage Properties
    @AppStorage("name_prefix") var namePrefix: String = ""
    @AppStorage("first_name") var firstName: String = ""
    @AppStorage("last_name") var lastName: String = ""
    @AppStorage("name_suffix") var nameSuffix: String = ""
    @AppStorage("ChildName") var childName: String = ""
    @AppStorage("user_id") var userId: String = ""
    
    // MARK: - Environment Property
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        NavigationStack {
            VStack(alignment: .leading) {
                
                // MARK: - Text Field for Child Name
                
                TextField("First Name", text: $childName)
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                    .background(Color(.systemGray5))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.horizontal)
                    .padding(.top, 30)
                    .accessibilityLabel("Enter the first name of the child or person you're registering this card for")
                
                // MARK: - Information Text
                
                Text("*First name of child or person you're registering this card for")
                    .font(.caption2)
                    .padding(.horizontal)
                    .foregroundStyle(.gray)
                
                // MARK: - Button Section
                
                HStack {
                    Spacer()
                    
                    // MARK: - Done Button
                    
                    Button {
                        dismiss()
                        
                        let generator = UINotificationFeedbackGenerator()
                        generator.notificationOccurred(.success)
                    } label: {
                        Label("Done", systemImage: "checkmark.circle")
                            .foregroundStyle(.white)
                            .padding(10)
                            .padding(.horizontal, 50)
                            .background(childName.isEmpty ? .gray : .purple)
                            .clipShape(RoundedRectangle(cornerRadius: 15))
                            .accessibilityLabel("Dismiss the register card form")
                    }
                    .disabled(childName.isEmpty ? true : false)
                    
                    Spacer()
                }
                .padding(.vertical)
            
                Spacer()
            }
            .navigationTitle("Register Card")
            .navigationBarTitleDisplayMode(.inline)
            .onAppear {
                UIImpactFeedbackGenerator(style: .rigid).impactOccurred()
            }
        }
    }
}

#Preview {
    ChildCardSheet()
}
