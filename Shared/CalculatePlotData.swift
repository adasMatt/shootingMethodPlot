//
//  CalculatePlotData.swift
//  SwiftUICorePlot
//
//  Created by Matthew Adas on 3/5/21.
// search for "add potential"

import Foundation
import SwiftUI
import CorePlot

class CalculatePlotData: ObservableObject {
    
    @ObservedObject var recursion = recursionClass()
    
    var plotDataModel: PlotDataClass? = nil

    // not used in this program but keeping around for reference
    /*
    func shootingMethodPlot(eMin: Double, eMax: Double, energyStep: Double, selection: Int)
    {
        // forget plotting functional or psi, plot functional for different potentials
        // need to add if-else or switch statements for selection to choose between plotting functional or psi
        
        
        //set the Plot Parameters
        plotDataModel!.changingPlotParameters.yMax = 10.0
        plotDataModel!.changingPlotParameters.yMin = -5.0
        plotDataModel!.changingPlotParameters.xMax = 20.0
        plotDataModel!.changingPlotParameters.xMin = -5.0
        plotDataModel!.changingPlotParameters.xLabel = "x"
        plotDataModel!.changingPlotParameters.yLabel = "y"
        plotDataModel!.changingPlotParameters.lineColor = .red()
        plotDataModel!.changingPlotParameters.title = " y = x"
        plotDataModel!.zeroData()
        
        
        var plotData :[plotDataType] =  []
        //var eMin = 0.0
        //var eMax = 20.0
        //let energyStep = 0.0050
         // what is calculated text?
        //  plotDataModel!.calculatedText += "\(x)\t\(y)\n"
        
        // i think... if selection == 0 {
        for energy in stride(from: eMin, through: eMax, by: energyStep) {
            
            let functionalValue = recursion.shootingMethod(xSteps: 0.005, guessEnergy: energy)
            
            let dataPoint: plotDataType = [.X: energy, .Y: functionalValue] // create single point?
            plotData.append(contentsOf: [dataPoint]) // append single point to an array?
            
        }
        
        //but else if selection == 1 {
        
        // what about for length waveFuncArrays.psiArray: plotData.append(deltaX, psi)
        // arguments here should be user input
        
        // first true energy example
        //plotData = recursion.functional(steps: 0.005, guessFirstE: 0.3760301625557498, nodes: 1)
        
        
        // plotData is an array of points
        plotDataModel!.appendData(dataPoint: plotData)
        
        
    }*/
    
    func rk4Plot(eMin: Double, eMax: Double, energyStep: Double, selection: Int) { // add potential?
        // forget plotting functional or psi, plot functional for different potentials
        // need to add if-else or switch statements for selection to choose between plotting functional or psi
        
        
        //set the Plot Parameters
        plotDataModel!.changingPlotParameters.yMax = 10.0
        plotDataModel!.changingPlotParameters.yMin = -5.0
        plotDataModel!.changingPlotParameters.xMax = 20.0
        plotDataModel!.changingPlotParameters.xMin = -5.0
        plotDataModel!.changingPlotParameters.xLabel = "x"
        plotDataModel!.changingPlotParameters.yLabel = "y"
        plotDataModel!.changingPlotParameters.lineColor = .red()
        plotDataModel!.changingPlotParameters.title = " y = x"
        plotDataModel!.zeroData()
        
        
        var plotData :[plotDataType] =  []
        //var eMin = 0.0
        //var eMax = 20.0
        //let energyStep = 0.0050
         // what is calculated text?
        //  plotDataModel!.calculatedText += "\(x)\t\(y)\n"
        
        // i think... if selection == 0 {
        for energy in stride(from: eMin, through: eMax, by: energyStep) {
            
            let functionalValue = recursion.rk4(xSteps: energyStep, guessEnergy: energy) // add potential?
            
            let dataPoint: plotDataType = [.X: energy, .Y: functionalValue] // create single point?
            plotData.append(contentsOf: [dataPoint]) // append single point to an array?
            
        }
        
        //but else if selection == 1 {
        
        // what about for length waveFuncArrays.psiArray: plotData.append(deltaX, psi)
        // arguments here should be user input
        
        // first true energy example
        //plotData = recursion.functional(steps: 0.005, guessFirstE: 0.3760301625557498, nodes: 1)
        
        
        // plotData is an array of points
        plotDataModel!.appendData(dataPoint: plotData)
        
        
    }
    
}



