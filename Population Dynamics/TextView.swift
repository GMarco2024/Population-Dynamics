//
//  TextView.swift
//  Bifurcation Diagram
//
//  Created by Jeff_Terry on 1/15/24.
//  Modified by Marco Gonzalez on [your modification date]
//

import SwiftUI

struct TextView: View {
    
    @EnvironmentObject var plotData: PlotClass
    
    // Dimensions for the text editors
    @State private var width: CGFloat = 300
    @State private var height: CGFloat = 500
    
    var body: some View {
        VStack {
            Text("Plot Points")
                .font(.headline)
                .foregroundColor(.gray)
            ScrollView {
                TextEditor(text: Binding(
                    get: { plotData.plotArray[0].calculatedText },
                    set: { _ in }
                ))
                .frame(width: width, height: height)
                .border(Color.gray, width: 1)
                .padding()
            }
        }
    }
}

struct TextView_Previews: PreviewProvider {
    static var previews: some View {
        TextView().environmentObject(PlotClass())
    }
}
