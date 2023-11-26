//
//  NetworkUnavailableView.swift
//  DWBingo
//
//  Created by Japhet Tegtmeyer on 11/21/23.
//

import SwiftUI

// Define a SwiftUI view for representing a network unavailable state
struct NetworkUnavailableView: View {
    var body: some View {
        // Display a ContentUnavailableView with specific content for network unavailability
        ContentUnavailableView(
            "No Internet Connection",                      // Title
            systemImage: "wifi.exclamationmark",          // System image
            description: Text("Please check your connection and try again.")  // Description
        )
    }
}

// Define a preview for the NetworkUnavailableView
struct NetworkUnavailableView_Previews: PreviewProvider {
    static var previews: some View {
        // Preview the NetworkUnavailableView
        NetworkUnavailableView()
    }
}

