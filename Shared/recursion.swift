//
//  recursion.swift
//  shootingMethodPlot
//
//  Created by Matthew Adas on 3/19/21.
//

import Foundation
import SwiftUI
import CorePlot



// should this be a subclass of potentialClass or not?
class recursionClass: ObservableObject {
    
    @ObservedObject var waveFuncArrays = waveFunctionArrayClass()
    // potential will be selectable somehow
    @ObservedObject var potential = potentialClass()
    
    //let hbar = 6.582119569e-16  // in eV*s
    //let mElectronInEVOverCSquared = 0.510998950e6 / (299792458 * 299792458)
    let hbarSquaredOverElectronMass = 7.61996423107385308868    // ev * ang^2
    
    
    // if functional, this one
    func shootingMethod(xSteps: Double, guessEnergy: Double) -> Double {
        let xMin = potential.xMin
        let xMax = potential.xMax
        
        var plotData: [plotDataType] =  []

        var psi: [Double] = []
        var psiPrime: [Double] = []
        var psiDoublePrime: [Double] = []
        
        let energy = guessEnergy
        
        // for test function
        //let n = Double(nodes)
        //let exactEnergy = hbarSquaredOverElectronMass/2 * Double.pi * Double.pi * Double(n) * Double(n) / (xMax * xMax)
        
        var i = 0
        
        // start with a guess for the slope at zero, and 2nd derivative of psi equal to zero
        psiPrime.append(5.0)
        psiDoublePrime.append(0.0)
        psi.append(0.0)
        
        let deltaX = xSteps
        
        // xValues was previously used to plot psi instead of the functional
        for xValue in stride(from: xMin, through: xMax, by: xSteps) {
            
            // need to append deltaX to set of x points for Core Plot

            // slope at each point
            psiPrime.append(psiPrime[i] + psiDoublePrime[i]*deltaX)
            
            // psi depending on initial psiPrime[0] guess
            
            psi.append(psi[i] + psiPrime[i]*deltaX)

            // recursiveness in psiDoublePrime dependent on psi
            psiDoublePrime.append(-(2/hbarSquaredOverElectronMass) * psi[i+1] * energy)
           
            /* ///////         plots psi       /////////
             if selection == 1
            let x = xValue
            let y = psi[i]
            // from coreplot stuff
            let dataPoint: plotDataType = [.X: x, .Y: y] // create single point?
            plotData.append(contentsOf: [dataPoint]) // append single point to an array?
            */
            // what is calculated text?
            //plotDataModel!.calculatedText += "\(x)\t\(y)\n"
            
            //else {
            i += 1
            
        }
        
        // need to append psi prime and psi to their own sets of y points
        waveFuncArrays.psiArray.append(psi)
        waveFuncArrays.psiPrimeArray.append(psiPrime)
        
        //return plotData for now
        return psi[psi.count-1]
        
    }   // end of functional function
    
    
    // else if psi, this one
    //func shootingMethod(xSteps: Double, guessEnergy: Double) -> [plotDataType] {

    
}   //end of recursion class
