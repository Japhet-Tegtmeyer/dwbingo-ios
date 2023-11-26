//
//  LegalView.swift
//  DWBingo
//
//  Created by Japhet Tegtmeyer on 11/26/23.
//

import SwiftUI

struct LegalView: View {
    var body: some View {
        NavigationStack {
            List {
                Section(header: Text("Legal")) {
                    Link("Apple Weather Kit", destination: URL(string: "https://weatherkit.apple.com/legal-attribution.html")!)
                }
            }
            .navigationTitle("Legal")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    LegalView()
}
