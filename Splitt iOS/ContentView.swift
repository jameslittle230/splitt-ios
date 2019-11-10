//
//  ContentView.swift
//  Splitt iOS
//
//  Created by James Little on 9/7/19.
//  Copyright © 2019 Splitt. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var historyElements: [HistoryElement]
    
    @State private var active = false
    
    @State var createViewRect: CGRect = .zero
    func makeCreateViewWithOffset() -> some View {
        let offset = createViewRect.height + ((UIScreen.main.bounds.height - createViewRect.height) / 2) - createViewPeekAmount
        return CreateView(active: $active)
            .background(
                GeometryReader { geometry -> AnyView in
                    let rect = geometry.frame(in: .global)
                    // This avoids an infinite layout loop
                    if rect.integral != self.createViewRect.integral {
                        DispatchQueue.main.async {
                            self.createViewRect = rect
                        }
                    }
                    return AnyView(EmptyView())
                }
            )
            .offset(x: 0, y: active ? 0 : offset)
    }
    
    var createViewPeekAmount: CGFloat = 96.0

    var body: some View {
        return ZStack(alignment: .bottom) {
            ScrollView {
                Spacer().frame(height: 108)
                ForEach(historyElements) { element in
                    HistoryView(element: element)
                        .padding(.horizontal)
                }
                Spacer(minLength: createViewPeekAmount)
            }
            .edgesIgnoringSafeArea([.top])

            VStack{
                NavigationHeader()
                Spacer()
            }
            .edgesIgnoringSafeArea([.top])

            if active {
                Button(action: { withAnimation {
                    self.active = false
                    }
                }) {
                    BlurView(style: .regular).edgesIgnoringSafeArea(.all)
                }
            }

            self.makeCreateViewWithOffset()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let history = [
            HistoryElement(),
            HistoryElement(),
            HistoryElement(),
            HistoryElement(),
            HistoryElement(),
            HistoryElement(),
            HistoryElement(),
            HistoryElement(),
            HistoryElement(),
            HistoryElement()
        ]

        return ContentView(historyElements: history)
    }
}
