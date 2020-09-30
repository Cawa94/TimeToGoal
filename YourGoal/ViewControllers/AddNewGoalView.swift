//
//  AddNewGoalView.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 30/09/2020.
//

import SwiftUI

struct AddNewGoalView: View {
    @State var nameFieldValue: String = ""
    @State var timeRequiredFieldValue: String = ""
    @State var pickerVisible = false

    let days = ["L", "M", "M", "G", "V", "S", "D"]

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Nome dell'obiettivo")) {
                    TextField("", text: $nameFieldValue)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.gray)
                }

                Section(header: Text("Tempo richiesto")) {
                    TextField("", text: $timeRequiredFieldValue)
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.gray)
                        .onTapGesture(count: 1, perform: {
                            pickerVisible.toggle()
                        })

                    if pickerVisible {
                        Picker(selection: $timeRequiredFieldValue,
                               label: Text("Tempo richiesto")) {
                            ForEach(0 ..< 24) {
                                Text("\($0)")
                            }
                        }.onTapGesture(count: 1, perform: {
                            pickerVisible.toggle()
                        }).pickerStyle(WheelPickerStyle())
                    }
                }

                Section(header: Text("Giorni in cui ci lavoro")) {
                    HStack {
                        ForEach(0 ..< days.count) { index in
                            VStack {
                                Text(days[index])
                                TextField("", text: $timeRequiredFieldValue)
                                    .padding()
                                    .foregroundColor(.white)
                                    .background(Color.gray)
                                    .onTapGesture(count: 1, perform: {
                                        pickerVisible.toggle()
                                    })
                            }
                        }
                    }.background(Color.clear)
                }

                Section(header: Text("Raggiungendo il mio obiettivo il")) {
                    Text("20-10-2021")
                }

                Button(action: {
                    
                }) {
                    HStack {
                        Spacer()
                        HStack {
                            Image(systemName: "plus.rectangle.fill").foregroundColor(.green)
                            Text("Aggiungi")
                        }
                        .padding(15.0)
                        .overlay(
                            RoundedRectangle(cornerRadius: 15.0)
                                .stroke(lineWidth: 2.0)
                        )
                    }
                }.accentColor(.green)
            }
        }
    }
}

struct AddNewGoalView_Previews: PreviewProvider {
    static var previews: some View {
        AddNewGoalView()
    }
}
