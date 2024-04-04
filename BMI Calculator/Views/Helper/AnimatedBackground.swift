//
//  AnimatedBackground.swift
//  BMI Calculator
//
//  Created by DB-MBP-023 on 04/04/24.
//

import Foundation
import SwiftUI

//MARK: - Custom BackgroundView
struct AnimatedBackground: View {
    
    @State var start    = UnitPoint(x: 0, y: -2)
    @State var end      = UnitPoint(x: 4, y: 0)
    
    let timer = Timer.publish(every: 1, 
                              on: .main,
                              in: .default).autoconnect()
    
    let colors = [
        Color(.black),
        Color("purpleDark"), 
        Color("purpleLight"),
        Color("purpleHighlight")
    ]
    
    var body: some View {
        LinearGradient(gradient: Gradient(colors: colors), 
                       startPoint: start,
                       endPoint: end)
            .animation(.easeInOut(duration: 10).repeatForever(), value: 0)
            .onReceive(timer, perform: { _ in
                self.start = UnitPoint(x: 4, y: 0)
                self.end = UnitPoint(x: 0, y: 2)
                self.start = UnitPoint(x: -4, y: 20)
                self.start = UnitPoint(x: 4, y: 0)
            })
    }
    
}
