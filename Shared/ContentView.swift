//
//  ContentView.swift
//  Shared
//
//  Created by Matthew Adas on 3/5/21.
//

import SwiftUI
import CorePlot

typealias plotDataType = [CPTScatterPlotField : Double]

struct ContentView: View {
    @EnvironmentObject var plotDataModel :PlotDataClass
    @ObservedObject private var calculator = CalculatePlotData()
    @State var isChecked:Bool = false
    @State var energyMinInput = "0.0"
    @State var energyMaxInput = "20.0"
    @State var stepWidthInput = "0.005"
    @State var selectionInput = "0"
    
    
    var body: some View {
        
        VStack{
      
            CorePlot(dataForPlot: $plotDataModel.plotData, changingPlotParameters: $plotDataModel.changingPlotParameters)
                .setPlotPadding(left: 10)
                .setPlotPadding(right: 10)
                .setPlotPadding(top: 10)
                .setPlotPadding(bottom: 10)
                .padding()
            
            Divider()
            
            HStack{
                
                //HStack(alignment: .leading) {
                VStack(alignment: .leading) {
                    Text("Energy Min")
                    TextField("Energy Min", text: $energyMinInput)
                    Text("EnergyMax")
                    TextField("Energy Max", text: $energyMaxInput)
                    Text("Step Width")
                    TextField("Step Width", text: $stepWidthInput)

                }
                
                VStack {
                    Picker(selection: $selectionInput, label:
                                    Text("Picker Name")
                                    , content: {
                                        Text("Infinite Sq Well").tag(0)
                                        Text("Something Else").tag(1)
                                        
                                })
                }
                //}.padding()
                
                //Toggle(isOn: $isChecked) {
                //            Text("Display Error")
                //        }
                //.padding()
                
                
            }
            
            
            HStack{
                Button("text", action: {self.calculate()} )
                .padding()
                
            }
            
        }
        
    }
    
    
    
    
    /// calculate
    /// Function accepts the command to start the calculation from the GUI
    func calculate(){
        
        //var temp = 0.0
        let eMin = Double(energyMinInput)!
        let eMax = Double(energyMaxInput)!
        let eStep = Double(stepWidthInput)!
        let selection = Int(selectionInput)!
        //pass the plotDataModel to the cosCalculator
        calculator.plotDataModel = self.plotDataModel
        
        //Calculate the new plotting data and place in the plotDataModel
        calculator.rk4Plot(eMin: eMin, eMax: eMax, energyStep: eStep, selection: selection) // add potential?
        
    }
    

   
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
