//
//  CalculatePlotData.swift
//  Population Dynamics
//
//  Created by Jeff_Terry on 1/15/24.
//  Modified by Marco Gonzalez 2/11/24
//
//  The following is based off the "Bugs.java: Bifurcation diagram for logistic map" code from page 294.
//

import Foundation
import SwiftUI

@Observable class CalculatePlotData {
    
    var plotDataModel: PlotDataClass? = nil
    var theText = ""
    
    /// Set the Plot Parameters
    /// - Parameters:
    ///   - color: Color of the Plotted Data
    ///   - xLabel: x Axis Label
    ///   - yLabel: y Axis Label
    ///   - title: Title of the Plot
    ///   - xMin: Minimum value of x Axis
    ///   - xMax: Maximum value of x Axis
    ///   - yMin: Minimum value of y Axis
    ///   - yMax: Maximum value of y Axis
    
    @MainActor func setThePlotParameters(color: String, xLabel: String, yLabel: String, title: String, xMin: Double, xMax: Double, yMin: Double, yMax: Double) {
        //set the Plot Parameters
        plotDataModel!.changingPlotParameters.yMax = yMax
        plotDataModel!.changingPlotParameters.yMin = yMin
        plotDataModel!.changingPlotParameters.xMax = xMax
        plotDataModel!.changingPlotParameters.xMin = xMin
        plotDataModel!.changingPlotParameters.xLabel = xLabel
        plotDataModel!.changingPlotParameters.yLabel = yLabel
        
        if color == "Red" {
            plotDataModel!.changingPlotParameters.lineColor = Color.red
        } else {
            plotDataModel!.changingPlotParameters.lineColor = Color.blue
        }
        plotDataModel!.changingPlotParameters.title = title
        
        plotDataModel!.zeroData()
    }
    
    /// This appends data to be plotted to the plot array
    /// - Parameter plotData: Array of (x, y) points to be added to the plot
    @MainActor func appendDataToPlot(plotData: [(x: Double, y: Double)]) {
        plotDataModel!.appendData(dataPoint: plotData)
    }
    
    /// Generates data using the logistic map
    /// - Parameters:
    ///   - mu: The growth rate parameter of the logistic map
    ///   - initialX: The initial population normalized to carrying capacity
    ///   - numberOfGenerations: Number of generations to simulate
    ///
    /// Logistic Map Equation
    ///
    ///   x       =   mu x  (1  -  x )
    ///    n + 1           n         n
    ///
    func generateLogisticMapData(mu: Double, initialX: Double, numberOfGenerations: Int) async {
        await MainActor.run {
            plotDataModel?.zeroData()
        }

        var x = initialX
        var dataPoints: [(x: Double, y: Double)] = []

        for generation in 0..<numberOfGenerations {
            x = mu * x * (1 - x)
            dataPoints.append((x: Double(generation), y: x))
        }

        await updateCalculatedTextOnMainThread(theText: "µ: \(mu), Initial Population: \(initialX), Generations: \(numberOfGenerations)")
        await appendDataToPlot(plotData: dataPoints)

    }

    /// Resets the Calculated Text to ""
    @MainActor func resetCalculatedTextOnMainThread() {
        plotDataModel!.calculatedText = ""
    }

    /// Adds the passed text to the display in the main window
    /// - Parameter theText: Text Passed To Add To Display
    @MainActor func updateCalculatedTextOnMainThread(theText: String) {
        plotDataModel!.calculatedText += theText
    }
}

extension Array where Element: Hashable {
    func unique() -> [Element] {
        var seen: Set<Element> = []
        return filter { seen.insert($0).inserted }
    }
}
