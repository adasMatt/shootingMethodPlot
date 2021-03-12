//
//  calculatePsi.swift
//  shootingMethodPlot
//
//  Created by Matthew Adas on 3/12/21.
//  addidng class waveFunction but more that class to another file after it is built

import Foundation
import SwiftUI
import CorePlot

class potentialClass: ObservableObject {
    
    // the default is infinite square well
    
    var V = 0.0
    var xMin = 0.0
    var xMax = 10.0        // 0 to pi so sin(xMin) = 0 sin(xMax) = 0 to start
    
    let hbar = 6.582119569e-16  // in eV*s
    let mElectronInEVOverCSquared = 0.510998950e6 / (299792458 * 299792458)
    let hbarSquaredOverElectronMass = 7.61996423107385308868    // ev * ang^2
    
}   //end of potential class


class infiniteSquareWell: potentialClass {
    
}   //end of infinite square well class, nothing is changed since it is the default of potentialClass anyway


// should this be a subclass of potentialClass or not?
class recursionClass: infiniteSquareWell {
    
    @ObservedObject var waveFuncArrays = waveFunctionArrayClass()
        
    //func shootingMethod(xSteps: Double, guessEnergy: Double) -> [plotDataType] {
        
    func shootingMethod(xSteps: Double, guessEnergy: Double) -> Double {

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
        
        for xValue in stride(from: xMin, through: xMax, by: xSteps) {
            
            // need to append deltaX to set of x points for Core Plot

            // slope at each point
            psiPrime.append(psiPrime[i] + psiDoublePrime[i]*deltaX)
            
            // psi depending on initial psiPrime[0] guess
            
            psi.append(psi[i] + psiPrime[i]*deltaX)

            // recursiveness in psiDoublePrime dependent on psi
            psiDoublePrime.append(-(2/hbarSquaredOverElectronMass) * psi[i+1] * energy)
            /* plots psi
            let x = xValue
            let y = psi[i]
            // from coreplot stuff
            let dataPoint: plotDataType = [.X: x, .Y: y] // create single point?
            plotData.append(contentsOf: [dataPoint]) // append single point to an array?
            */
            // what is calculated text?
            //plotDataModel!.calculatedText += "\(x)\t\(y)\n"
            
            i += 1
            
        }
        
        // need to append psi prime and psi to their own sets of y points
        waveFuncArrays.psiArray.append(psi)
        waveFuncArrays.psiPrimeArray.append(psiPrime)
        
        //return plotData for now
        return psi[psi.count-1]
        
    }   // end of functional function
    
}   //end of recursion class


