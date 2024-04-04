//
//  GaugeView.swift
//  BMI Calculator
//
//  Created by DB-MBP-023 on 03/04/24.
//

import Foundation
import SwiftUI


// MARK: - Content View
struct ResultView: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State var bmi: BMICalculator
    @State var isHeightMetric = true
    @State var isWeightMetric = true
    @State var showModal = false
    
    @State var value = 25.0
    var maxValue = 40
    
    var body: some View {
        
            ZStack {
                AnimatedBackground()
                    .edgesIgnoringSafeArea(.all)
                    .blur(radius: 25)
                    .scaleEffect(1.2)
                    .opacity(0.9)
                Spacer()
                VStack {
                    GaugeView(coveredRadius: 225,
                              maxValue: maxValue,
                              stepperSplit: 4,
                              value: $value,
                              bmi: bmi)
                    ZStack {
                        Color("transparentBG")
                        VStack {
                            Spacer()
                            Text("Your Weight Status is")
                                .foregroundColor(.white)
                                .opacity(0.9)
                            Text("\(bmi.getAdvice())")
                                .font(Font.system(size: 35, design: .rounded).weight(.bold))
                                .foregroundColor(Color(bmi.getColor()))
                            // Weight goal
                            if bmi.getClassification() != .healthy {
                                let goal = bmi.determineWeightLossGoal()
                                Group {
                                    Text("\(goal.type) at least ") +
                                    Text("\(getWeight(kg: goal.healthyMinimum, isMetric: isWeightMetric, indicator: true))").bold() +
                                    Text(".")
                                }.font(.title2)
                                    .foregroundColor(.white)
                                    .multilineTextAlignment(.leading)
                            }
                            
                            Divider()
                                .background(.white)
                            Spacer()
                            HStack(alignment: .center, spacing: 10){
                                Text("Age - \(bmi.age)")
                                    .foregroundColor(.white)
                                    .opacity(0.9)
                                    .font(Font.system(size: 13, weight: .regular))
                                Divider()
                                    .background(.white)
                                Text("Weight - \(String(format: "%.0f", bmi.weight)) kg")
                                    .foregroundColor(.white)
                                    .opacity(0.9)
                                    .font(Font.system(size: 13, weight: .regular))
                                Divider()
                                    .background(.white)
                                Text("Height - \(String(format: "%.0f", bmi.height)) cm")
                                    .foregroundColor(.white)
                                    .opacity(0.9)
                                    .font(Font.system(size: 13, weight: .regular))
                            }
                            Divider()
                                .background(.white)
                            Spacer()
                            Spacer()
                            Text("Your BMI Score")
                                .foregroundColor(.white)
                                .opacity(0.9)
                            Text("\(bmi.getBMIValue())")
                                .font(Font.system(size: 45, design: .rounded).weight(.bold))
                                .foregroundColor(Color(bmi.getColor()))
                            Spacer()
                        }
                        .padding()
                        
                    } .frame(width: UIScreen.main.bounds.width - 40, height: 300)
                        .cornerRadius(20)
                    Button("Return") {
                        presentationMode.wrappedValue.dismiss()
                    }
                        .foregroundStyle(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .fontWeight(.bold)
                        .background(.red)
                        .clipShape(Capsule())
                        .padding()
                }
            }
        
    }
    
}

struct GuageView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView(bmi: BMICalculator(height: 120.0, weight: 150.0))
    }
}
