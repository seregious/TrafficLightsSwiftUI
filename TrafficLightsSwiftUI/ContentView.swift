//
//  ContentView.swift
//  TrafficLightsSwiftUI
//
//  Created by Сергей Иванчихин on 21.04.2022.
//

import SwiftUI

struct ContentView: View {
    
    @State var count = 0
    let width = UIScreen.main.bounds.width/1.5
    let height = UIScreen.main.bounds.height/1.5
    
    @State var redLight = CircleView(color: "red")
    @State var yellowLight = CircleView(color: "yellow")
    @State var greenLight = CircleView(color: "green")
    
    @State var firstStart = true
    
    let bodyColors = [Color.black, Color.init(uiColor: .darkGray), Color.black]
    var gradient: LinearGradient {
        LinearGradient(colors: bodyColors, startPoint: .topLeading, endPoint: .bottomTrailing)
    }
    
    var body: some View {
        VStack{
            ZStack {
                RoundedRectangle(cornerRadius: 25)
                    .fill(gradient)
                    .frame(width: width, height: height)
                    .shadow(color: .black.opacity(0.5), radius: 10, x: 10, y: -10)
                    .overlay {
                        VStack{
                            redLight
                            yellowLight
                            greenLight
                        }
                        .padding(20)
                    }
            }
            
            button
        }
    }
    
    var button: some View {
        Button {
            
            count += 1
            
            switch count {
            case 4:
                count = 1
                fallthrough
            case 1:
                DispatchQueue.main.asyncAfter(deadline: firstStart ? .now() : .now() + 3.5) {
                    withAnimation(.easeInOut) {
                        redLight.getsOn()
                    }
                }
                
                withAnimation(.linear(duration: 0.5).repeatCount(7, autoreverses: true)) {
                    greenLight.getsOff()
                }
            case 2:
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                    withAnimation(.easeInOut) {
                        yellowLight.getsOn()
                    }
                }
                
                withAnimation(.linear(duration: 0.5).repeatCount(7, autoreverses: true)) {
                    redLight.getsOff()
                }
            default:
                DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
                    withAnimation(.easeInOut) {
                        greenLight.getsOn()
                    }
                }
                
                withAnimation(.linear(duration: 0.5).repeatCount(7, autoreverses: true)) {
                    yellowLight.getsOff()
                }
            }
            
            firstStart = false

        } label: {
            Text(count == 0 ? "Start" : "Next")
                .font(.largeTitle)
                .foregroundColor(.white)
                .padding()
                .padding(.horizontal, 30)
                .background(gradient)
                .cornerRadius(25)
                .shadow(color: .black.opacity(0.5), radius: 10, x: 10, y: -10)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

extension ContentView {
    func changeLight(from lightOff: (), to lightOn: ()) {
        
        withAnimation(.linear(duration: 0.5).repeatCount(7, autoreverses: true)) {
            lightOff
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.5) {
            withAnimation(.easeInOut) {
                lightOn
            }
        }
        
        
    }
}


