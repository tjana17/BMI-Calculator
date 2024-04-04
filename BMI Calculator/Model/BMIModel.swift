//
//  BMIModel.swift
//  BMI Calculator
//
//  Created by DB-MBP-023 on 04/04/24.
//

import Foundation
import UIKit

struct BMIModel {
    let classification: WeightClass
    let value: Float
    let advice: String
    let color: UIColor
}

enum WeightClass {
    case underweight
    case healthy
    case overweight
    case obese
    case extremelyObese
    case unknown
}
