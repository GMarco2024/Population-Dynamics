//
//  PlotDataStruct.swift
//  Population Dynamics
//
//  Created by Jeff_Terry on 1/15/24.
//  Modified by Marco Gonzalez 2/11/24
//

import Foundation
import Charts

// This defines a structure for storing individual data points for plotting.
struct PlotDataStruct: Identifiable {
    // Provides a unique identifier for each data point, using the x-value as its unique ID.
    var id: Double { xVal }
    
    // The x-coordinate of the data point, representing a specific dimension or parameter.
    let xVal: Double
    
    // The y-coordinate of the data point, typically representing the value or outcome at the corresponding x-value.
    let yVal: Double
}

