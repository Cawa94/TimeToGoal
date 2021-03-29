//
//  RectangleProgressViewStyle.swift
//  YourGoal
//
//  Created by Yuri Cavallin on 27/3/21.
//

import SwiftUI

struct LoadingView: View {

    var body: some View {
        Rectangle()
            .background(Color.black)
            .opacity(0.05)
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity)

        RoundedRectangle(cornerRadius: .defaultRadius)
            .fill(Color.white)
            .frame(width: 80, height: 80)
        
        ProgressView()
            .progressViewStyle(CircularProgressViewStyle(tint: Color.orangeGoal))
            .scaleEffect(2, anchor: .center)
    }

}
/*
struct RectangleProgressViewStyle_Previews: PreviewProvider {
    static var previews: some View {
        RectangleProgressViewStyle()
    }
}
*/
