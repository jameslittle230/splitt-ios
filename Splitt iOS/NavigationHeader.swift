//
//  NavigationHeader.swift
//  Splitt iOS
//
//  Created by James Little on 11/6/19.
//  Copyright © 2019 Splitt. All rights reserved.
//

import SwiftUI

struct NavigationHeader: View {
    var body: some View {
        VStack {
            ZStack {
                BlurView(style: .systemMaterial)
                VStack {
                    Spacer()
                    HStack {
                        Text("History").font(.largeTitle).fontWeight(.heavy)
                        Spacer()
                        VStack(alignment: .trailing) {
                            HStack {
                                Image(systemName: "person.fill")
                                Text("littleguy23@gmail.com")
                            }
                            HStack {
                                Image(systemName: "person.3.fill")
                                Text("echinacea")
                            }
                        }.font(.footnote)
                    }.padding(.horizontal)
                }.padding()
            }
            .frame(height: 100)
        }
    }
}

struct NavigationHeader_Previews: PreviewProvider {
    static var previews: some View {
        return NavigationHeader()
    }
}
