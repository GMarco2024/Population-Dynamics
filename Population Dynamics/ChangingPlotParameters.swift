//
//  ChangingPlotParameters.swift
//  Population Dynamics
//
//  Created by Jeff_Terry on 1/15/24.
//  Modified by Marco Gonzalez 2/11/24
//

import SwiftUI
import Observation
@Observable class ChangingPlotParameters {
    
    //These plot parameters are adjustable
    // Label for the x-axis of the plot, can be set to describe the data represented.
    var xLabel: String = ""
    
    // Label for the y-axis of the plot, can be set to describe the data represented.
    var yLabel: String = ""
    
    // Maximum value for the x-axis, used to set the horizontal bounds of the plot.
    var xMax : Double = 2.0
    
    // Maximum value for the y-axis, used to set the vertical bounds of the plot.
    var yMax : Double = 2.0
    
    // Minimum value for the y-axis, used to set the lower vertical bounds of the plot.
    var yMin : Double = -1.0
    
    // Minimum value for the x-axis, used to set the lower horizontal bounds of the plot.
    var xMin : Double = -1.0
    
    // Default color used for the line in the plot. Initially set to blue.
    var lineColor: Color = Color.blue
    
    // Boolean flag to decide if points on the plot should be connected with lines.
    var shouldIPlotPointLines = false
    
    // Title of the plot, which can be displayed above the plot in the UI.
    var title: String = "Population Dynamics"
    
}
    



