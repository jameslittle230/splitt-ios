//
//  CreateView.swift
//  Splitt iOS
//
//  Created by James Little on 11/6/19.
//  Copyright © 2019 Splitt. All rights reserved.
//

import SwiftUI

struct SplitCreateViewModel {
    enum SplitType {
        case split
        case reimbursement
    }
    
    var amount: Int? {
        if let parsed = Double(amountString) {
            return Int(parsed * 100)
        } else {
            return nil
        }
    }
    
    var amountString = "0.00"
    var memo = ""
    var description = ""
    var date = Date()
    var type: SplitType = .split
    
    mutating func reset() {
        self = SplitCreateViewModel()
    }
}

struct CreateView: View {
    @Binding var active: Bool {
        didSet {
            if !active {
                endEditing()
            }
        }
    }
    @State var datePickerActive = false
    @State var viewModel = SplitCreateViewModel()

    let formatter = DateFormatter()

    var formattedDate: String {
        formatter.dateStyle = .long
        formatter.timeStyle = .none
        return formatter.string(from: viewModel.date)
    }

    func resetData() {
        viewModel.reset()
    }

    var body: some View {
        ZStack() {
            VStack(alignment: .leading) {
                if active {
                    Group {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.gray)
                            .animation(.default)
                            .onTapGesture {
                                self.active = false
                            }
                    }.font(.headline)
                }

                VStack(alignment: .leading) {
                    HStack(spacing: 2) {
                        Text("$")
                        TextField("0.00", text: $viewModel.amountString, onEditingChanged: { focused in
                            self.active = true
                            
                            let nf = NumberFormatter()
                            nf.numberStyle = NumberFormatter.Style.decimal
                            nf.minimumFractionDigits = 2
                            nf.maximumFractionDigits = 2
                            self.viewModel.amountString = nf.string(from: NSNumber(value: Double(self.viewModel.amountString) ?? 0.0 / 100.0)) ?? "0.00"
                        }, onCommit: {
                        })
                    }.font(.largeTitle)
                    
                    TextField("Memo", text: $viewModel.memo).textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("Description (optional)", text: $viewModel.description)
                        .lineLimit(nil)

                    Divider()

                    HStack {
                        Text("Created:").padding(.trailing, 3)
                        Button(action: {
                            endEditing()
                            self.datePickerActive.toggle()
                        }) {
                            Text(formattedDate)
                        }
                    }

                    Divider()

                    Picker(selection: $viewModel.type, label: Text("Transaction Type")) {
                        Text("Split").tag(SplitCreateViewModel.SplitType.split)
                        Text("Reimbursement").tag(SplitCreateViewModel.SplitType.reimbursement)
                    }.pickerStyle(SegmentedPickerStyle())
                }

                VStack {
                    HStack {
                        Text("Member")
                        Spacer()
                        Text("Percentage")
                        Spacer()
                        Text("Amt. Owed")
                    }.font(Font.bold(.body)())
                    
                    Spacer().frame(height: 8)

                    HStack {
                        Text("Maddie")
                        Spacer()
                        Text("50%")
                        Spacer()
                        Text("$255.0")
                    }
                }.padding([.top, .bottom])
                
                Spacer()

                VStack(spacing: 18.0) {
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
                    }.padding(.bottom, 8)
                }
            }.padding()
                .background(BlurView(style: .systemMaterial)).cornerRadius(4)
                .shadow(radius: 8)

            if(datePickerActive) {
                VStack {
                    Spacer()
                    CreateViewDatePicker(date: $viewModel.date, datePickerActive: $datePickerActive).animation(.default)
                }
            }
        }
        .animation(.default)
        .padding()
        .onTapGesture {
            self.active = true
        }
    }
}

struct CreateView_Previews: PreviewProvider {
    static var previews: some View {
        return CreateView(
            active: Binding<Bool>(get: { return true }, set: { _ in })
        )
    }
}
