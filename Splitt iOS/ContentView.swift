//
//  ContentView.swift
//  Splitt iOS
//
//  Created by James Little on 9/7/19.
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

struct ContentView: View {

    var historyElements: [HistoryElement]
    @State var amount: String = "$0.00"
    @State var active: Bool = true {
        didSet {
            if !active {
                endEditing()
            }
        }
    }
    var createViewPeekAmount: CGFloat = 128.0

    var body: some View {
        ZStack(alignment: .bottom) {
            ScrollView {
                Spacer().frame(height: 108)
                ForEach(historyElements) { element in
                    HistoryView(element: element)
                        .padding(.horizontal)
                }
                Spacer(minLength: createViewPeekAmount)
            }
            .edgesIgnoringSafeArea([.top])

            NavigationHeader()

            if active {
                Button(action: { withAnimation {
                    self.active = false
                    }
                }) {
                    BlurView(style: .systemThickMaterialDark)
                        .edgesIgnoringSafeArea([.horizontal, .vertical])
                }.animation(.default)
            }

            CreateView(active: $active)
                .offset(x: 0, y: active ? 0 : UIScreen.main.bounds.height - createViewPeekAmount)
                .onTapGesture {
                    withAnimation {
                        self.active = true
                    }
            }
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

struct BlurView: UIViewRepresentable {

    let style: UIBlurEffect.Style

    func makeUIView(context: UIViewRepresentableContext<BlurView>) -> UIView {
        let view = UIView(frame: .zero)
        view.backgroundColor = .clear
        let blurEffect = UIBlurEffect(style: style)
        let blurView = UIVisualEffectView(effect: blurEffect)
        blurView.translatesAutoresizingMaskIntoConstraints = false
        view.insertSubview(blurView, at: 0)
        NSLayoutConstraint.activate([
            blurView.heightAnchor.constraint(equalTo: view.heightAnchor),
            blurView.widthAnchor.constraint(equalTo: view.widthAnchor),
        ])
        return view
    }

    func updateUIView(_ uiView: UIView,
                      context: UIViewRepresentableContext<BlurView>) {

    }

}

struct CreateView: View {
    @Binding var active: Bool {
        didSet {
            if !active {
                resetData()
            } else {
                print(date)
            }
        }
    }
    @State var datePickerActive = false

    @State var amount: String = ""
    @State var memo: String = ""
    @State var description: String = ""
    @State var date = Date()
    @State var type = 0

    let formatter = DateFormatter()

    var formattedDate: String {
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter.string(from: date)
    }

    func resetData() {
        datePickerActive = false
        amount = ""
        memo = ""
        description = ""
        date = Date()
        type = 0
    }

    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(alignment: .leading) {
                if active {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                        .animation(.default)
                        .onTapGesture { withAnimation {
                            self.active = false
                            }
                    }
                }

                HStack(spacing: 2) {
                    Text("$")
                    TextField("0.00", text: $amount)
                        .keyboardType(.decimalPad)
                }.font(.largeTitle)
                TextField("Memo", text: $memo).textFieldStyle(RoundedBorderTextFieldStyle())
                TextField("Description (optional)", text: $description)
                    .lineLimit(nil)
                HStack {
                    Text("Created:").padding(.trailing, 3)
                    Button(action: {
                        endEditing()
                        self.datePickerActive.toggle()
                    }) {
                        Text(formattedDate)
                    }
                }

                Picker(selection: $type, label: Text("Transaction Type")) {
                    Text("Split").tag(0)
                    Text("Reimbursement").tag(1)
                }.pickerStyle(SegmentedPickerStyle())

                Divider()

                VStack {
                    HStack {
                        Text("Member")
                        Text("Percentage")
                        Text("Amt. Owed")
                    }
                }

                Spacer()
                VStack(spacing: 11.0) {
                    Button(action: {
                        print("230")
                    }) {
                        HStack {
                            Spacer()
                            Text("Create Split")
                                .fontWeight(.bold)
                                .padding()
                                .foregroundColor(Color.white)
                            Spacer()
                        }.background(Color.blue)
                        .cornerRadius(8)
                    }

                    Button(action: {
                        print("asdf")
                    }) {
                        HStack {
                            Spacer()
                            Text("Create and add another")
                            Spacer()
                        }
                    }
                }
            }.padding()
                .background(BlurView(style: .systemMaterial)).cornerRadius(3)
                .shadow(radius: 8)

            if(datePickerActive) {
                CreateViewDatePicker(date: $date, datePickerActive: $datePickerActive)
            }
        }
        .animation(.default)
        .padding(.horizontal, active ? nil : 28)
    }
}

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
            }.frame(height: 100)
            Spacer()
        }.edgesIgnoringSafeArea(.vertical)
    }
}

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
