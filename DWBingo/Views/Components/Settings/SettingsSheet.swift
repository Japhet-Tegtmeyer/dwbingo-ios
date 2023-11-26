//
//  SettingsSheet.swift
//  DWBingo
//
//  Created by Japhet Tegtmeyer on 11/18/23.
//

import SwiftUI

struct SettingsSheet: View {
    
    // MARK: - Environment Properties
    
    @Environment(\.dismiss) var dismiss
    
    // MARK: - App Storage Properties
    
    @AppStorage("user_id") var userId: String = ""
    @AppStorage("Cardresets") var clickCount: Int = 0
    @AppStorage("Cardresetschild") var clickCountC: Int = 0
    @AppStorage("HasReset") var hasReset: Bool = false
    @AppStorage("isButtonD") var isButtonDisabled: Bool = false
    @AppStorage("IsButtonDC") var isButtonDisabledC: Bool = false
    @AppStorage("agreed") var agreed: Bool = false
    
    // MARK: - State Properties
    
    @State private var showingAlert = false
    @State private var showingAlertClicks = false
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 8) {
                
                // MARK: - Logo Image
                
                Image("Icon")
                    .resizable()
                    .frame(width: 150, height: 150)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(.gray, lineWidth: 1)
                    )
                    .padding(.horizontal)
                    .padding(.top, 50)
                
                // MARK: - App Title and Version
                
                Text("DWBingo")
                    .font(.title)
                    .bold()
                    .padding(8)
                
                Text("v1.0.4")
                    .font(.caption)
                    .foregroundStyle(.gray)
                    .padding(.top, -10)
                
                Text("Built on the moon")
                    .font(.subheadline)
                    .foregroundStyle(.gray)
                
                
                List {
                    NavigationLink(destination: UserSettingsView()) {
                        Text("User Settings")
                    }
                    
                    NavigationLink(destination: AccountSettingsView()) {
                        Text("Account Settings")
                    }
                    
                    NavigationLink(destination: LegalView()) {
                        Text("Legal")
                    }
                }
                .navigationTitle("Settings")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            dismiss()
                        } label: {
                            Text("Done")
                        }
                    }
                }
            }
            
            // MARK: - Background Color
            
            .background(Color(.systemGray6))
        }
    }
}

#Preview {
    SettingsSheet()
}
