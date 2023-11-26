//
//  DWBingoApp.swift
//  DWBingo
//
//  Created by Japhet Tegtmeyer on 11/12/23.
//

import SwiftUI
import Firebase
import UserNotifications

@main
struct DWBingoApp: App {
    // Use the AppDelegate as a delegate adaptor
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @State private var networkMonitor = NetworkMonitor()
    
    // App storage properties
    @AppStorage("email") var email: String = ""
    @AppStorage("name_prefix") var namePrefix: String = ""
    @AppStorage("first_name") var firstName: String = ""
    @AppStorage("last_name") var lastName: String = ""
    @AppStorage("name_suffix") var nameSuffix: String = ""
    
    @AppStorage("user_id") var userId: String = ""
    
    var body: some Scene {
        // Define the main window group
        WindowGroup {
            if !networkMonitor.isConnected { // Check if device is connected to Wi-Fi or Cellular
                NetworkUnavailableView()
            } else {
                // Check if the user is logged in based on userId
                if userId.isEmpty {
                    // Show the WelcomeView if the user is not logged in
                    WelcomeView()
                } else {
                    // Show the ContentView with bingo cards if the user is logged in
                    MainTabView(bingocards: BingoCards().bingoCards,
                                selectedCard: Card(bcard: "Disaney",
                                                   cardId: 001,
                                                   color: .colorD1),
                                childselectedCard: Card(bcard: "D",
                                                        cardId: 01,
                                                        color: .colorD1))
                }
            }
        }
    }
}
