//
//  NameView.swift
//  DWBingo
//
//  Created by Japhet Tegtmeyer on 11/22/23.
//

import SwiftUI

struct NameView: View {
    @AppStorage("first_name") var firstName: String = ""
    @AppStorage("last_name") var lastName: String = ""
    @AppStorage("user_id") var userId: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("First Name", text: $firstName)
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                    .background(Color(.systemGray5))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.horizontal)
                    .accessibilityLabel("Form for first name")
                
                TextField("Last Name", 
                          text: $lastName)
                    .padding(.horizontal)
                    .padding(.vertical, 10)
                    .background(Color(.systemGray5))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.horizontal)
                    .accessibilityLabel("Form for last name")
                
                Button {
                    userId = "qwerty"
                } label: {
                    Label("Continue",
                          systemImage: "checkmark.circle")
                        .foregroundStyle(.white)
                        .padding(10)
                        .padding(.horizontal, 50)
                        .background(lastName.isEmpty ? .gray : firstName.isEmpty ? .gray : .purple)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .padding(.top)
                        .accessibilityLabel("Dismiss the name form")
                }
                .disabled(lastName.isEmpty ? true : firstName.isEmpty ? true : false)
            }
            .navigationTitle("Info")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    NameView()
}
