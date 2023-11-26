//
//  EditNameTip.swift
//  DWBingo
//
//  Created by Japhet Tegtmeyer on 11/21/23.
//

import Foundation
import TipKit
import SwiftUI

struct EditNameTip: Tip {
    var title: Text {
        Text("Edit your name")
    }

    var message: Text? {
        Text("Long press on your name to edit it.")
    }

    var image: Image? {
        Image(systemName: "star")
    }
}
