//
//  Badge.swift
//  DWBingo
//
//  Created by Japhet Tegtmeyer on 11/22/23.
//

import SwiftUI

// Define a protocol for objects that can provide and set application icon badge numbers
protocol BadgeNumberProvidable: AnyObject {
    var applicationIconBadgeNumber: Int { get set }
}

// Extend UIApplication to conform to the BadgeNumberProvidable protocol
extension UIApplication: BadgeNumberProvidable {}

// Define an actor for managing application alert badges
actor AppAlertBadgeManager {
    
    // A property to store an object that conforms to the BadgeNumberProvidable protocol
    let application: BadgeNumberProvidable
    
    // Initialize the manager with an object that conforms to BadgeNumberProvidable
    init(application: BadgeNumberProvidable) {
        self.application = application
    }
    
    // Set the alert badge number on the application icon
    @MainActor
    func setAlertBadge(number: Int) {
        application.applicationIconBadgeNumber = number
    }
    
    // Reset the alert badge number to zero on the application icon
    @MainActor
    func resetAlertBadge() {
        application.applicationIconBadgeNumber = 0
    }
}

