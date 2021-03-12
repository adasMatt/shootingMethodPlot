//
//  CalculatePlotData.swift
//  SwiftUICorePlotExample
//
//  Created by Jeff Terry on 12/22/20.
//

import Foundation
import SwiftUI
import CorePlot

class CalculatePlotData: ObservableObject {
    
    @ObservedObject var recursion = recursionClass()
    
    var plotDataModel: PlotDataClass? = nil

    func shootingMethodPlot()
    {
        
        //set the Plot Parameters
        plotDataModel!.changingPlotParameters.yMax = 10.0
        plotDataModel!.changingPlotParameters.yMin = -5.0
        plotDataModel!.changingPlotParameters.xMax = 10.0
        plotDataModel!.changingPlotParameters.xMin = -5.0
        plotDataModel!.changingPlotParameters.xLabel = "x"
        plotDataModel!.changingPlotParameters.yLabel = "y"
        plotDataModel!.changingPlotParameters.lineColor = .red()
        plotDataModel!.changingPlotParameters.title = " y = x"
        plotDataModel!.zeroData()
        
        
        var plotData :[plotDataType] =  []
        
        // maybe change to  for loop dependent on length of psiArray
        /*
        for i in 0 ..< 120 {

            //create x values here

            let x = -2.0 + Double(i) * 0.2

            //create y values here from psi prime

            let y = x

            let dataPoint: plotDataType = [.X: x, .Y: y] // create single point?
            plotData.append(contentsOf: [dataPoint]) // append single point to an array?
            
         // what is calculated text?
            plotDataModel!.calculatedText += "\(x)\t\(y)\n"
        
        }*/
        
        
        // what about for length waveFuncArrays.psiArray: plotData.append(deltaX, psi)
        plotData = recursion.functional(steps: 1.0, guessFirstE: 5.0, nodes: 1)
        
        // plotData is an array of points
        plotDataModel!.appendData(dataPoint: plotData)
        
        
    }
    
    /*
    func ploteToTheMinusX()
    {
        
        //set the Plot Parameters
        plotDataModel!.changingPlotParameters.yMax = 10
        plotDataModel!.changingPlotParameters.yMin = -3.0
        plotDataModel!.changingPlotParameters.xMax = 10.0
        plotDataModel!.changingPlotParameters.xMin = -3.0
        plotDataModel!.changingPlotParameters.xLabel = "x"
        plotDataModel!.changingPlotParameters.yLabel = "y = exp(-x)"
        plotDataModel!.changingPlotParameters.lineColor = .blue()
        plotDataModel!.changingPlotParameters.title = "exp(-x)"

        plotDataModel!.zeroData()
        var plotData :[plotDataType] =  []
        for i in 0 ..< 60 {

            //create x values here

            let x = -2.0 + Double(i) * 0.2

        //create y values here

        let y = exp(-x)
            
            let dataPoint: plotDataType = [.X: x, .Y: y]
            plotData.append(contentsOf: [dataPoint])
            
            plotDataModel!.calculatedText += "\(x)\t\(y)\n"
            
        }
        
        plotDataModel!.appendData(dataPoint: plotData)
        
        return
    }*/
    
}



