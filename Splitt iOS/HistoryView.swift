//
//  HistoryView.swift
//  Splitt iOS
//
//  Created by James Little on 11/6/19.
//  Copyright © 2019 Splitt. All rights reserved.
//

import SwiftUI

struct HistoryView: View {
    let element: HistoryElement
    var body: some View {
        Group {
            HStack {
                VStack(alignment: .leading) {
                    Text(element.time.uppercased())
                        .font(.caption)
                        .fontWeight(.bold)
                        .foregroundColor(.secondary)
//                        .tracking(1.2)
                        .layoutPriority(0)
                    HStack {
                        Text(element.who).bold() + Text(" ") + Text(element.action)
                        Spacer()
                    }.lineLimit(nil)
                }
            }.padding()
                .background(LinearGradient(gradient: Gradient(colors: [element.color, element.color.opacity(0.6)]),
                                           startPoint: .topLeading,
                                           endPoint: .bottomTrailing))
                .cornerRadius(12)
        }
        .padding(3)
        .background(Color.white)
        .cornerRadius(15)
        .shadow(color: element.color.opacity(0.7), radius: 12, x: 0, y: 0)
        .padding(.vertical, 8)
    }
}
