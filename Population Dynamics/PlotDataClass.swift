//
//  PlotDataClass.swift
//  Bifurcation Diagram
//
//  Created by Jeff_Terry on 1/15/24.
//  Modified by Marco Gonzalez on 05/2/2024
//

import Foundation
import SwiftUI
import Observation

// Observable class that manages the data and settings for plotting diagrams.
@Observable class PlotDataClass {
    
    // Holds the actual plot data points as an array of PlotDataStruct.
    @MainActor var plotData = [PlotDataStruct]()
    // Manages settings for plot appearance such as axis labels, limits, and colors.
    @MainActor var changingPlotParameters: ChangingPlotParameters = ChangingPlotParameters()
    // This holds text that used for calculation
    @MainActor var calculatedText = ""
    // This tracks the number of points plotted.
    @MainActor var pointNumber = 1.0
    
    // Initializes the class with an option to start with a blank plot.
    init(fromLine line: Bool) {
        Task {
            await self.plotBlank()
        }
    }

    /// Initializes a blank chart with predefined parameters, effectively resetting the plot.
    @MainActor func plotBlank() {
        zeroData()  // Clears any existing data.

    // Set the Plot Parameters with initial values for a blank plot.
        changingPlotParameters.yMax = 1.0
        changingPlotParameters.yMin = 0.0
        changingPlotParameters.xMax = 30.0
        changingPlotParameters.xMin = 0.0
        changingPlotParameters.xLabel = "Growth Rate (µ)"
        changingPlotParameters.yLabel = "Attractor Populations (X^*)"
        changingPlotParameters.lineColor = Color.blue
        changingPlotParameters.shouldIPlotPointLines = false
        changingPlotParameters.title = "Initial Plot"
    }

    /// Clears all data points and resets the point counter and calculated text.
    @MainActor func zeroData() {
        plotData = []  // Empty the data array.
        pointNumber = 1.0  // Reset the point counter.
        calculatedText = ""  // Clear any text associated with calculations.
    }

    /// Adds an array of data points to the plot and updates the plot count and display text.
    /// - Parameter dataPoint: Array of (x, y) data for plotting.
    @MainActor func appendData(dataPoint: [(x: Double, y: Double)]) {
        for item in dataPoint {
            let dataValue: [PlotDataStruct] = [.init(xVal: item.x, yVal: item.y)]
            plotData.append(contentsOf: dataValue)
            pointNumber += 1.0

    // This updates the calculatedText to include new point details for display.
            calculatedText += "\(item.x), \(item.y)\n"
        }
    }
}
