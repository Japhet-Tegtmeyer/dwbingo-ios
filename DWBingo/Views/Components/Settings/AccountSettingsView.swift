//
//  AccountSettingsView.swift
//  DWBingo
//
//  Created by Japhet Tegtmeyer on 11/24/23.
//

import SwiftUI

struct AccountSettingsView: View {
    
    // MARK: - App Storage Properties
    
    @AppStorage("user_id") var userId: String = ""
    @AppStorage("Cardresets") var clickCount: Int = 0
    @AppStorage("Cardresetschild") var clickCountC: Int = 0
    @AppStorage("HasReset") var hasReset: Bool = false
    @AppStorage("isButtonD") var isButtonDisabled: Bool = false
    @AppStorage("IsButtonDC") var isButtonDisabledC: Bool = false
    @AppStorage("agreed") var agreed: Bool = false
    @AppStorage("name_prefix") var namePrefix: String = "" // Name prefix mr/mrs
    @AppStorage("first_name") var firstName: String = "" // First/Given name
    @AppStorage("last_name") var lastName: String = "" // Last/Family name
    @AppStorage("name_suffix") var nameSuffix: String = "" // Name suffix (jr)
    
    // MARK: - State Properties
    
    @State private var showingAlert = false
    @State private var showingAlertClicks = false
    @State private var isDeleteAlert = false
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    Section(header: Text("Account")) {
                        Button {
                            showingAlert = true
                        } label: {
                            Text("Log Out")
                        }
                        .alert("Are you sure you want to log out? This will delete all data.",
                               isPresented: $showingAlert) {
                            Button("Log Out", role: .destructive) {
                                userId = ""
                                agreed = false
                                clickCount = 0
                                clickCountC = 0
                                hasReset = false
                                namePrefix = ""
                                firstName = ""
                                lastName = ""
                                nameSuffix = ""
                            }
                            Button("Cancel",
                                   role: .cancel) { }
                        }
                        
                        Button {
                            isDeleteAlert = true
                        } label: {
                            Text("Delete Account")
                                .foregroundStyle(.red)
                        }
                        .alert("This will delete all data.",
                               isPresented: $isDeleteAlert) {
                            Button("Delete", role: .destructive) {
                                userId = ""
                                agreed = false
                                clickCount = 0
                                clickCountC = 0
                                hasReset = false
                                namePrefix = ""
                                firstName = ""
                                lastName = ""
                                nameSuffix = ""
                            }
                            Button("Cancel",
                                   role: .cancel) { }
                        }
                    }
                }
            }
            .navigationTitle("Account Settings")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    AccountSettingsView()
}
