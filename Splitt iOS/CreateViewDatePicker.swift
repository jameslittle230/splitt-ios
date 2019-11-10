//
//  CreateViewDatePicker.swift
//  Splitt iOS
//
//  Created by James Little on 11/6/19.
//  Copyright © 2019 Splitt. All rights reserved.
//

import SwiftUI

struct CreateViewDatePicker: View {
    @Binding var date: Date
    @Binding var datePickerActive: Bool

    var body: some View {
        VStack {
            HStack {
                Button("Done") {
                    withAnimation {
                        self.datePickerActive.toggle()
                    }
                }
                Spacer()
                Button("Reset to Today") {
                    self.date = Date()
                }.disabled(Calendar.current.isDateInToday(date))
            }.padding(.horizontal)
            DatePicker(selection: $date, displayedComponents: .date) {
                Text("")
            }

        }.padding(.top).background(BlurView(style: .regular)).shadow(radius: 8).padding()
    }
}

struct CreateViewDatePicker_Previews: PreviewProvider {
    static var previews: some View {
        var date = Date() {
            didSet {
                print("aaaa")
            }
        }
        return CreateViewDatePicker(
            date: Binding<Date>(get: {return date}, set: {d in date = d; print(d)}),
            datePickerActive: Binding<Bool>(get: { return true }, set: {_ in})
        )
    }
}
