//
//  ChangingPlotParameters.swift
//  Bifurcation Diagram
//
//  Created by Jeff_Terry on 1/15/24.
//  Modified by Marco Gonzalez 2/11/24
//

import SwiftUI
import Charts

struct ContentView: View {
    @EnvironmentObject var plotData: PlotClass
    
    @State private var calculator = CalculatePlotData()
    @State private var selector = 0
    @State private var inputμ: String = ""
    @State private var inputInitialPopulation: String = ""
    @State private var inputGenerations: String = ""
    @State private var resultText: String = ""
    @State private var showError: Bool = false
    
    var body: some View {
        VStack {
            Group {
                Text("Bifurcation Diagram")
                    .font(.title)
                    .bold()
                    .underline()
                
                // Rotates the Y-axis label by -90 degrees.
                HStack(alignment: .center, spacing: 0) {
                    Text(plotData.plotArray[selector].changingPlotParameters.yLabel)
                        .rotationEffect(Angle(degrees: -90))
                        .foregroundColor(.red)
             
                // Renders a chart with line marks using the plot data.
                    VStack {
                        Chart(plotData.plotArray[selector].plotData) { data in
                            LineMark(
                                x: .value("Generation", data.xVal),
                                y: .value("Population", data.yVal)
                            )
                            .foregroundStyle(plotData.plotArray[selector].changingPlotParameters.lineColor)
                        }
                        .chartYScale(domain: [plotData.plotArray[selector].changingPlotParameters.yMin, plotData.plotArray[selector].changingPlotParameters.yMax])
                        .chartXScale(domain: [plotData.plotArray[selector].changingPlotParameters.xMin, plotData.plotArray[selector].changingPlotParameters.xMax])
                        .chartYAxis {
                            AxisMarks(position: .leading)
                        }
                // Displays the X-axis label.
                        Text(plotData.plotArray[selector].changingPlotParameters.xLabel)
                            .foregroundColor(.red)
                    }
                }
                .frame(alignment: .center)
            }
            
            //Here we have the textfields in which serve as the input for the Groth Rate, Initial Population, and Number of Generations.
         
            Group {
                HStack {
                    VStack {
                        Text("Growth Rate (μ)")
                        TextField("Enter growth rate (μ) between 0 and 4", text: $inputμ)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(maxWidth: 150)
                    }
                    
                    VStack {
                        Text("Initial Population (Proportion)")
                        TextField("Enter initial population proportion between 0 and 1", text: $inputInitialPopulation)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(maxWidth: 150)
                    }
                    
                    VStack {
                        Text("Number of Generations")
                        TextField("Enter number of generations", text: $inputGenerations)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .frame(maxWidth: 150)
                    }
                }
                //Button to calculate the function from CalculatePlotData, such function being the Logistic Map Equation.
                
                Button("Calculate") {
                    Task {
                        await calculatePopulationDynamics()
                    }
                }
                .frame(maxWidth: .infinity, alignment: .center)
                .padding()

                if showError {
                    Text(resultText)
                        .foregroundColor(.red)
                        .padding()
                }
            }
        }
    }
    
    // Asynchronously calculates population dynamics based on user input.
    
    func calculatePopulationDynamics() async {
        guard let mu = Double(inputμ), let initialPop = Double(inputInitialPopulation), let generations = Int(inputGenerations) else {
            resultText = "Invalid input. Please enter valid numbers."
            showError = true
            return
        }
        showError = false
        calculator.plotDataModel = plotData.plotArray[selector]
        await calculator.generateLogisticMapData(mu: mu, initialX: initialPop, numberOfGenerations: generations)
    }
}

// Preview provider for SwiftUI previews.

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(PlotClass())
    }
}
