//
//  ChildTip.swift
//  DWBingo
//
//  Created by Japhet Tegtmeyer on 11/21/23.
//

import Foundation
import SwiftUI
import TipKit

struct ChildTip: Tip {
    var title: Text {
        Text("Register a child")
    }
    
    var message: Text? {
        Text("Tap the child icon to register a bingo card for your child")
    }
    
    var image: Image? {
        Image(systemName: "figure.and.child.holdinghands")
    }
}
