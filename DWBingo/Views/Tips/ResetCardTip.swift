//
//  ResetCardTip.swift
//  DWBingo
//
//  Created by Japhet Tegtmeyer on 11/21/23.
//

import Foundation
import SwiftUI
import TipKit

struct ResetCardTip: Tip {
    var title: Text {
        Text("Get a new card")
    }
    
    var message: Text? {
        Text("You can get a new card up to 5 times before 11:59PM Feb 17")
    }
    
    var image: Image? {
        Image(systemName: "arrow.clockwise")
    }
}
