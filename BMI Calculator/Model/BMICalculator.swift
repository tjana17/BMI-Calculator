//
//  BMICalculator.swift
//  BMI Calculator
//
//  Created by DB-MBP-023 on 03/04/24.
//

import Foundation
import SwiftUI

struct BMICalculator {
    var height: Float = 0.0 // default cm
    var weight: Float = 0.0 // default kg
    var age: Int = 18
    
    var bmi: BMIModel?
    mutating func calculateBMI(height: Float, weight: Float) {
        
        let heightInMetres = height / 100
        let bmiValue = weight / (heightInMetres * heightInMetres)
        
        if bmiValue < 18.5 {
            bmi = BMIModel(
                classification: .underweight,
                value: bmiValue,
                advice: "Underweight",
                color: .systemBlue)
        } else if bmiValue < 25 {
            bmi = BMIModel(
                classification: .healthy,
                value: bmiValue,
                advice: "Healthy & Normal",
                color: .systemGreen)
        } else if bmiValue < 30 {
            bmi = BMIModel(
                classification: .overweight,
                value: bmiValue,
                advice: "Overweight",
                color: .systemOrange)
        } else if bmiValue < 40 {
            bmi = BMIModel(
                classification: .obese,
                value: bmiValue,
                advice: "Obese",
                color: .systemRed)
        } else {
            bmi = BMIModel(
                classification: .extremelyObese,
                value: bmiValue,
                advice: "Extremely obese!",
                color: .systemRed)
        }
    }
    
    // Get BMI symbol as String system icon name
    func getClassification() -> WeightClass {
        return bmi?.classification ?? .unknown
    }
    
    // Return BMI as formatted String
    func getBMIValue() -> String {
        let bmiToDecimalPlace = String(format: "%.1f", bmi?.value ?? 0.0)
        return bmiToDecimalPlace
    }
    
    // Get BMI advice as String
    func getAdvice() -> String {
        return bmi?.advice ?? "Please enter your height and weight to get a BMI result."
    }
    
    // Get BMI feature color as UIColor
    func getColor() -> UIColor {
        return bmi?.color ?? UIColor.white
    }
    
    // Determine a weight loss/gain goal based on BMI
    func determineWeightLossGoal() -> (healthyMinimum: Float, healthyMaximum: Float, type: String) {
        var min: Float = 0.0
        var max: Float = 0.0
        var type = ""
        switch bmi?.classification {
        case .underweight:
            min = reverseBMI(targetBMI: 18.5) - weight
            max = reverseBMI(targetBMI: 24.9) - weight
            type = "Gain"
        default:
            min = weight - reverseBMI(targetBMI: 24.9)
            max = weight - reverseBMI(targetBMI: 18.5)
            type = "Lose"
        }
        return (min, max, type)
    }
    
    // Determine a target weight based on a given BMI value
    func reverseBMI(targetBMI: Float) -> Float {
        let heightInMetres = height / 100 // m
        let targetWeight = targetBMI * (heightInMetres * heightInMetres) // BMI * (height^2)
        return targetWeight // kg
    }
    func getBMIValue() -> Float {
        return bmi?.value ?? 0.0
    }
}

