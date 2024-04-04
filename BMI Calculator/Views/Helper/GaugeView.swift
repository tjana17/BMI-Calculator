//
//  GaugeView.swift
//  BMI Calculator
//
//  Created by DB-MBP-023 on 04/04/24.
//

import Foundation
import SwiftUI

// MARK: - Gauge View
struct GaugeView: View {
    
    let coveredRadius: Double // 0 - 360
    var maxValue: Int
    let stepperSplit: Int
    
    private var tickCount: Int {
        maxValue/stepperSplit
    }
    
    @Binding var value: Double
    @State var bmi: BMICalculator
    @State var degreesRotating = 0.0
    
    var body: some View {
        
        ZStack{
            
            Text("\(bmi.getBMIValue())")
                .font(.system(size: 40, weight: .bold))
                .foregroundColor(.white)
                .offset(x:0, y: 40)
            Needle()
                .fill(Color.red)
                .frame(width: 140, height: 6)
                .offset(x: -70, y: 0)
                .rotationEffect(.init(degrees: getAngle(value: degreesRotating)), anchor: .center)
                .onAppear {
                    withAnimation(.linear(duration: 1)
                        .speed(0.5)) {
                            degreesRotating = Double(bmi.getBMIValue())
                        }
                }
            
            
            Circle()
                .frame(width: 20, height: 20)
                .foregroundColor(.red)
            ForEach(0..<tickCount*2 + 1) { tick in
                self.tick(at: tick, 
                          totalTicks: self.tickCount*2)
            }
            ForEach(0..<tickCount + 1) { tick in
                self.tickText(at: tick, 
                              text: "\(self.stepperSplit*tick)")
            }
        }.frame(width: 300, 
                height: 300,
                alignment: .center)
        
    }
    
    func getAngle(value: Double) -> Double {
        return (value/Double(maxValue))*coveredRadius - coveredRadius/2 + 90
    }
    
    func colorMix(percent: Int) -> Color {
        let p = Double(percent)
        let tempG = (100.0-p)/100
        let g: Double = tempG < 0 ? 0 : tempG
        let tempR = 1+(p-100.0)/100.0
        let r: Double = tempR < 0 ? 0 : tempR
        return Color.init(red: r, green: g, blue: 0)
    }
    
    func tick(at tick: Int, totalTicks: Int) -> some View {
        let percent = (tick * 100)/totalTicks
        let startAngle = coveredRadius/2 * -1
        let stepper = coveredRadius/Double(totalTicks)
        let rotation = Angle.degrees(startAngle + stepper * Double(tick))
        return VStack {
            Rectangle()
                .fill(colorMix(percent: percent))
                .frame(width: tick % 2 == 0 ? 5 : 3, height: tick % 2 == 0 ? 20 : 10)
            Spacer()
        }.rotationEffect(rotation)
    }
    
    func tickText(at tick: Int, text: String) -> some View {
        let percent = (tick * 100) / tickCount
        let startAngle = coveredRadius/2 * -1 + 90
        let stepper = coveredRadius/Double(tickCount)
        let rotation = startAngle + stepper * Double(tick)
        return Text(text)
            .foregroundColor(colorMix(percent: percent))
            .rotationEffect(.init(degrees: -1 * rotation), anchor: .center)
            .offset(x: -115, y: 0)
            .rotationEffect(Angle.degrees(rotation))
    }
}


// MARK: - Needle View
struct Needle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: 0, y: rect.height/2))
        path.addLine(to: CGPoint(x: rect.width, y: 0))
        path.addLine(to: CGPoint(x: rect.width, y: rect.height))
        return path
    }
}
