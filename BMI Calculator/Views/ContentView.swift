//
//  ContentView.swift
//  BMI Calculator
//
//  Created by DB-MBP-023 on 03/04/24.
//

import SwiftUI

struct ContentView: View {
    
    @State var isHeightMetric = true
    @State var isWeightMetric = true
    @State var bmi = BMICalculator(height: 0.0, weight: 0.0)
    @State var isPopoverPresented = false
    
    var body: some View {
            
            ZStack {
                
                Color(.black)
                    .edgesIgnoringSafeArea(.all)
                AnimatedBackground()
                    .edgesIgnoringSafeArea(.all)
                    .blur(radius: 25)
                    .scaleEffect(1.2)
                    .opacity(0.9)
                
                VStack {
                    Spacer()
                    Text("Calculate your BMI")
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                    
                    Text("For better results, please be as accurate as possible")
                        .font(.body)
                        .fontWeight(.medium)
                        .foregroundColor(.white)
                        .multilineTextAlignment(.center)
                        .lineLimit(2)
                        .opacity(0.8)
                        .padding()
                    Spacer()
                    
                    //MARK: - Height CardView
                    ZStack {
                        Color("transparentBG")
                        VStack {
                            Text("HEIGHT")
                                .font(.body)
                                .fontWeight(.medium)
                                .opacity(1)
                                .foregroundColor(.white)
                            
                            HStack(alignment: .lastTextBaseline, spacing: 5) {
                                
                                Text("\(getHeight(cm: bmi.height, isMetric: isHeightMetric, indicator: false))")
                                    .font(.largeTitle)
                                    .fontWeight(.heavy)
                                    .opacity(1)
                                    .foregroundColor(.white)
                                
                                Text("cm")
                                    .foregroundColor(.white)
                                    .font(.body)
                                    .fontWeight(.regular)
                                    .opacity(0.8)
                            }
                            //Slider
                            Slider(value: $bmi.height, in: 120...220)
                                .accentColor(Color("purpleHighlight"))
                                .padding()
                                .onAppear {
                                    if(self.bmi.height < 1) {
                                        self.bmi.height = 170
                                    }
                                }
                                .foregroundColor(.red)
                            
                        }
                        .opacity(1)
                        .padding()
                    }
                    .frame(width: UIScreen.main.bounds.width - 40, height: 200)
                    .cornerRadius(15)
                    
                    Spacer()
                    //MARK: - Weight & Age CardView
                    HStack(alignment: .center, spacing:20) {
                        /// Weight
                        ZStack(alignment: .center){
                            Color("transparentBG")
                            VStack {
                                Text("WEIGHT")
                                    .font(.body)
                                    .fontWeight(.medium)
                                    .opacity(1)
                                    .foregroundColor(.white)
                                
                                HStack(alignment: .lastTextBaseline, spacing: 5) {
                                    Text("\(getWeight(kg: bmi.weight, isMetric: isWeightMetric, indicator: false))")
                                        .font(.largeTitle)
                                        .fontWeight(.heavy)
                                        .opacity(1)
                                        .foregroundColor(.white)
                                        .onAppear {
                                            if(self.bmi.weight < 1) {
                                                self.bmi.weight = 85
                                            }
                                        }
                                    
                                    Text("kg")
                                        .foregroundColor(.white)
                                        .font(.body)
                                        .fontWeight(.regular)
                                        .opacity(0.8)
                                }
                                HStack(alignment: .lastTextBaseline, spacing: 15) {
                                    Button(action: {
                                        self.bmi.weight -= 1
                                    }) {
                                        Text("-")
                                            .frame(width: 50, height: 50)
                                            .font(.largeTitle)
                                        
                                            .foregroundColor(.white)
                                            .background(.purpleLight)
                                            .clipShape(Circle())
                                    }
                                    
                                    Button(action: {
                                        self.bmi.weight += 1
                                    }) {
                                        Text("+")
                                            .frame(width: 50, height: 50)
                                            .font(.largeTitle)
                                            .foregroundColor(.white)
                                            .background(.purpleLight)
                                            .clipShape(Circle())
                                    }
                                }
                            }
                            
                        } .cornerRadius(20)
                        
                        
                        //MARK: - Age
                        ZStack {
                            Color("transparentBG")
                            
                            VStack {
                                Text("AGE")
                                    .font(.body)
                                    .fontWeight(.medium)
                                    .opacity(1)
                                    .foregroundColor(.white)
                                
                                
                                Text("\(self.bmi.age)")
                                    .font(.largeTitle)
                                    .fontWeight(.heavy)
                                    .opacity(1)
                                    .foregroundColor(.white)
                                    .onAppear {
                                        if(self.bmi.age < 1) {
                                            self.bmi.age = 18
                                        }
                                    }
                                
                                
                                HStack(alignment: .lastTextBaseline, spacing: 15) {
                                    Button(action: {
                                        self.bmi.age -= 1
                                    }) {
                                        Text("-")
                                            .frame(width: 50, height: 50)
                                            .font(.largeTitle)
                                        
                                            .foregroundColor(.white)
                                            .background(.purpleLight)
                                            .clipShape(Circle())
                                    }
                                    
                                    
                                    
                                    Button(action: {
                                        self.bmi.age += 1
                                    }) {
                                        Text("+")
                                            .frame(width: 50, height: 50)
                                            .font(.largeTitle)
                                        
                                            .foregroundColor(.white)
                                            .background(.purpleLight)
                                            .clipShape(Circle())
                                    }
                                }
                            }
                        } .cornerRadius(20)
                    }.frame(width: UIScreen.main.bounds.width - 40, 
                            height: 200)
                    Spacer()
                    
                    Button("CALCULATE BMI") {
                        bmi.calculateBMI(height: bmi.height, 
                                         weight: bmi.weight)
                        self.isPopoverPresented.toggle()
                    }
                        .foregroundStyle(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .fontWeight(.bold)
                        .background(.red)
                        .clipShape(Capsule())
                        .padding()
                        .fullScreenCover(isPresented: $isPopoverPresented,  content: {
                            ResultView(bmi: bmi, 
                                       isHeightMetric: isHeightMetric,
                                       isWeightMetric: isWeightMetric)
                        })
                    
                }
            }
        
    }
}




// Get height in centimetres or feet and inches
func getHeight(cm: Float, isMetric: Bool, indicator: Bool) -> String {
    var heightString: String
    if isMetric {
        heightString = "\(String(format: "%.0f", cm))"
        if indicator { heightString = "\(String(format: "%.0f", cm)) cm" }
        return heightString
    } else {
        let feet = cm * 0.0328084
        let feetDisplay = Int(floor(feet))
        let feetRemainder: Float = ((feet * 100).truncatingRemainder(dividingBy: 100) / 100)
        let inches = Int(floor(feetRemainder * 12))
        return "\(feetDisplay)' \(inches)\""
    }
}

// Get weight in kilograms or pounds
func getWeight(kg: Float, isMetric: Bool, indicator: Bool) -> String {
    var weightString: String
    if isMetric {
        weightString = String(format: "%.0f", kg)
        if indicator { weightString += " kg" }
    } else {
        let lbs = kg * 2.205
        weightString = String(format: "%.0f", lbs)
        if indicator { weightString += " lbs" }
    }
    return weightString
}

#Preview {
    ContentView()
}
