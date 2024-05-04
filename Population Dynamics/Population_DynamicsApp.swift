//
//  Population_DynamicsApp.swift
//  Population Dynamics
//
//  Created by Jeff_Terry on 1/15/24.
//  Created by Marco Gonzalez on 4/9/24.
//

import SwiftUI
import Observation

@main
struct Population_DynamicsApp: App {
    
    // Declare an instance of PlotClass to manage and pass data throughout the views as an environment object.
    var plotData = PlotClass()

    // Defines the body of the app which provides the content view.
    var body: some Scene {
        WindowGroup {
            TabView {
                //First tab properties.
                //Here we have the labeling for the tabs created in the GUI.
                ContentView()
                    .environmentObject(plotData)
                    .tabItem {
                        Label("Logistic Population", systemImage: "chart.xyaxis.line")
                    }
                //Here we have the labeling for the tabs created in the GUI.
                TextView()
                    .environmentObject(plotData)
                    .tabItem {
                        Label("Plot Points", systemImage: "text.alignleft")
                }
            }
        }
    }
}
