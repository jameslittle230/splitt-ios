//
//  HistoryElement.swift
//  Splitt iOS
//
//  Created by James Little on 11/6/19.
//  Copyright © 2019 Splitt. All rights reserved.
//

import SwiftUI

struct HistoryElement: Identifiable {
    var id: UUID = UUID()
    var time: String = "\(["5", "10", "15", "20", "25"].randomElement()!) minutes ago"
    var who: String = ["James", "Maddie", "Danny"].randomElement()!
    var action: String = [
        "reconciled 30 splits",
        "created transaction \"Dan and Liz Dinner\"",
        "created transaction \"Groceries\"",
        "edited transaction \"Groceries\""
        ].randomElement()!
    var color: Color = [Color.red, Color.green, Color.blue].randomElement()!
}
