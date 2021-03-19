//
//  rk4.swift
//  rk4Plot
//
//  Created by Matthew Adas on 3/19/21.
// search "add potential"

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
    
    
    func rk4(xSteps: Double, guessEnergy: Double) -> Double { // add potential?
        
        // need to make potential selectable
        let xMin = potential.xMin
        let xMax = potential.xMax
        
        var psi: [Double] = []
        var psiPrime: [Double] = []
        var psiDoublePrime: [Double] = []
        var k1: [Double] = [] // first slope, same as shooting method
        var y1: [Double] = []
        var k2: [Double] = []
        var y2: [Double] = []
        var k3: [Double] = []
        var y3: [Double] = []
        var k4: [Double] = []
        var y4: [Double] = []
        
        let energy = guessEnergy
        
        var i = 0
        
        // start with a guess for the slope at zero, and 2nd derivative of psi equal to zero
        psiPrime.append(5.0)
        psiDoublePrime.append(0.0)
        psi.append(0.0)
        
        let deltaX = xSteps
        
        for xValue in stride(from: xMin, through: xMax, by: xSteps) {
            
            // shooting method to find k1
            psiPrime.append(psiPrime[i] + psiDoublePrime[i]*deltaX)
            psi.append(psi[i] + psiPrime[i]*deltaX)
            psiDoublePrime.append(-(2/hbarSquaredOverElectronMass) * psi[i+1] * energy) // add potential?
            
            //k1 = f(y*, t), shooting method, beginning of step
            k1.append(psiPrime[i] + psiDoublePrime[i]*deltaX)
            // estimate y1 at xSteps/2 with slope k1
            y1.append(k1[i] * xSteps / 2.0 + psiPrime[i])
            
            //k2 = f(t+h/2, y+hk1/2)
            k2.append(psiPrime[i] *  psiDoublePrime[i]*deltaX)
            y2.append(k2[i] * xSteps / 2.0 + psiPrime[i])
            
            //k3 = f(t+h/2, y+hk2/2)
            k3.append(psiPrime[i] * y2[i] * xSteps / 2.0)
            y3.append(psiPrime[i] + k3[i] * deltaX)
            
            //k4 = f(t+h/2, y+hk3)
            k4.append(psiPrime[i] * y3[i] * xSteps)
            
            //y(h) = y + 1/6 (k1+2k2+2k3+k4) * h
            y4.append(psi[i] + (k1[i]/6.0 + k2[i]/3.0 + k3[i]/3.0 + k4[i]/6.0) * xSteps)
            
            i += 1
            
        }
        
        // need to append psi prime and psi to their own sets of y points
        waveFuncArrays.psiArray.append(psi)
        waveFuncArrays.psiPrimeArray.append(y4)
        
        //return plotData for now
        return y4[y4.count-1]
        
    }
    
    /*
    // start with shooting method, not used in this program but keeping it for reference
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
        
    }   // end of shooting method function, aka first order approximation of RK method
    

    */
    
    // else if psi, this one
    //func shootingMethod(xSteps: Double, guessEnergy: Double) -> [plotDataType] {

    
}   //end of recursion class
