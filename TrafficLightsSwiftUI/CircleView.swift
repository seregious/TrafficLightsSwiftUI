//
//  CircleView.swift
//  TrafficLightsSwiftUI
//
//  Created by Сергей Иванчихин on 21.04.2022.
//

import SwiftUI

struct CircleView: View {
    
    let circleWidth = UIScreen.main.bounds.width/2
    
    let color: String
    
    var colors: [Color] {
        switch color {
        case "red":
            return [Color.init(red: 0.3, green: 0, blue: 0),
                    Color.init(red: 1, green: 0, blue: 0)]
        case "yellow":
            return [Color.init(red: 0.3, green: 0.3, blue: 0),
                    Color.init(red: 1, green: 1, blue: 0)]
        default:
            return [Color.init(red: 0, green: 0.3, blue: 0),
                    Color.init(red: 0, green: 1, blue: 0)]
        }
    }
    var isOn = false
    var opacity = 0.5
    
    var gradient: RadialGradient {
        RadialGradient(colors: colors, center: .center, startRadius: circleWidth, endRadius: isOn ? 50 : 1)
    }
    
    var body: some View {
        
            Circle()
                .fill(gradient)
                .opacity(opacity)
                .overlay {
                    Circle()
                        .strokeBorder(.gray, lineWidth: 7)
                        .modifier(LightShadow(colorOn: colors[1], isOn: isOn))
                }

    }
    
    mutating func getsOn() {
            isOn = true
            opacity = 1        
    }
    
    mutating func getsOff() {
            isOn = false
            opacity = 0.5
    }
    
}

struct CircleView_Previews: PreviewProvider {
    
    static var previews: some View {
        CircleView(color: "red")
    }
}

struct LightShadow: ViewModifier {
    let colorOn: Color
    let isOn: Bool
    func body(content: Content) -> some View {
        if isOn {
        content
            .shadow(color: colorOn, radius: 30)
            .shadow(color: colorOn, radius: 40)
            .shadow(color: colorOn, radius: 50)
            .shadow(color: colorOn, radius: 60)
        } else {
            content
        }
    }
}
