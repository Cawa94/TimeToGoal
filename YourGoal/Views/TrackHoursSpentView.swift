//
//  TrackHoursSpentView.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 03/10/2020.
//

import SwiftUI

struct TrackHoursSpentView: View {

    @Binding var isPresented: Bool
    @Binding var currentGoal: Goal?

    @State private var trackMode = 0

    @ViewBuilder
    var body: some View {
        ZStack {
            Color.black.opacity(0.75)
                .ignoresSafeArea()
                .onTapGesture {
                    isPresented.toggle()
                }
            ZStack {
                RoundedRectangle(cornerRadius: .defaultRadius)
                    .fill(Color.white)
                    .cornerRadius(50)
                VStack {
                    Spacer()
                        .frame(height: 30)
                    Text("track_popup_title".localized())
                        .font(.title)
                        .bold()
                        .multilineTextAlignment(.center)
                        .foregroundColor(.goalColor)
                    /*Spacer()
                        .frame(height: 20)
                    Picker(selection: $trackMode, label: Text("")) {
                        Text("Manuale").tag(0)
                        Text("Timer").tag(1)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding([.leading, .trailing])*/
                    Spacer()
                    //if trackMode == 0 {
                        TrackManualTimeView(isPresented: $isPresented, currentGoal: $currentGoal)
                    /*} else {
                        
                    }*/
                }
            }
            .frame(height: 400, alignment: .center)
            .padding([.leading, .trailing], 15)
        }
    }
}

struct TrackHoursSpentView_Previews: PreviewProvider {
    static var previews: some View {
        TrackHoursSpentView(isPresented: .constant(true), currentGoal: .constant(Goal()))
    }
}
