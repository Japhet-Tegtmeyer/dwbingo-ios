//
//  UserSettingsView.swift
//  DWBingo
//
//  Created by Japhet Tegtmeyer on 11/24/23.
//

import SwiftUI

struct UserSettingsView: View {
    
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
            VStack {
                List {
                    Section(header: Text("User")) {
                        Button {
                            showingAlertClicks = true
                        } label: {
                            HStack {
                                if hasReset == true {
                                    Text("0")
                                        .opacity(0)
                                        .background(.red)
                                        .clipShape(Circle())
                                }
                                Text("Refresh Card Resets")
                                    .foregroundStyle(.primary)
                            }
                        }
                        .disabled(hasReset)
                        .alert("This will reset the number of allowed card resets.",
                               isPresented: $showingAlertClicks) {
                            
                            Button("Reset", role: .destructive) {
                                clickCount = 0
                                clickCountC = 0
                                hasReset = true
                                isButtonDisabled = false
                                isButtonDisabledC = false
                            }
                            Button("Cancel", role: .cancel) { }
                        }
                        .onTapGesture {
                            if hasReset {
                                let generator = UINotificationFeedbackGenerator()
                                generator.notificationOccurred(.error)
                            }
                        }
                    }
                }
            }
            .navigationTitle("User Settings")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    UserSettingsView()
}
