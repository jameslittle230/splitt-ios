//
//  TestView.swift
//  Splitt iOS
//
//  Created by James Little on 11/7/19.
//  Copyright © 2019 Splitt. All rights reserved.
//

import SwiftUI

struct TestView: View {
    @State var active = false
    
    var createViewPeekAmount: CGFloat = 64.0
    
    @State var blueViewRect: CGRect = .zero
    func makeBlueView() -> some View {
        let offset = blueViewRect.height + ((UIScreen.main.bounds.height - blueViewRect.height) / 2) - createViewPeekAmount
        return BlueView(active: $active)
            .background(
                GeometryReader { geometry -> AnyView in
                    let rect = geometry.frame(in: .global)
                    // This avoids an infinite layout loop
                    if rect.integral != self.blueViewRect.integral {
                        DispatchQueue.main.async {
                            self.blueViewRect = rect
                        }
                    }
                    return AnyView(EmptyView())
                }
            )
            .offset(x: 0, y: active ? 0 : offset)
    }

    var body: some View {
        return ZStack() {
            
            Text(active ? "Hello World" : "How are you")
            
            makeBlueView().onTapGesture { withAnimation {
                    self.active.toggle()
                }
            }
        }
    }
}

struct BlueView: View {
    @Binding var active: Bool
    var body: some View {
        Color(active ? .blue : .green).frame(width: 100, height: 300)
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        return TestView()
    }
}
