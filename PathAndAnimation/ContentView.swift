//
//  ContentView.swift
//  PathAndAnimation
//
//  Created by Aleksandr Mamlygo on 27.07.23.
//

import SwiftUI

struct ContentView: View {
    @State private var figureIsShowing = true
    let numberOfPetals = 12
    
    var body: some View {
        VStack {
            Button(action: { buttonAction() }) {
                Text(figureIsShowing ? "Hide figure" : "Show figure")
            }
            Spacer()
            
            if figureIsShowing {
                ZStack {
                    ForEach(0..<12) { iteration in
                        Petal()
                            .rotationEffect(.degrees(Double(iteration * 360 / numberOfPetals)))
                            .offset(x: 175 * cos(CGFloat(iteration) * 2 * .pi / CGFloat(numberOfPetals) - .pi/2),
                                    y: 175 * sin(CGFloat(iteration) * 2 * .pi / CGFloat(numberOfPetals) - .pi/2))
                            .scaleEffect(0.4)
                    }
                }
                .frame(width: 400, height: 400)
                .rotationEffect(.degrees(figureIsShowing ? -180 : 0))
                .transition(AnyTransition.scale)
            }

            

            Spacer()
        }
    }
    
    private func buttonAction() {
        withAnimation {
            figureIsShowing.toggle()
        }
    }
}

struct Petal: View {
    var body: some View {
        GeometryReader { geometry in
            let width = geometry.size.width
            let height = geometry.size.height
            let middleX = width / 2
            let middleY = height / 2
            let farPointX = width * 0.75
            let nearPointX = width * 0.25
            
            Path { path in
                path.move(to: CGPoint(x: nearPointX , y: middleY))
                path.addQuadCurve(to: CGPoint(x: middleX, y: 0), control: CGPoint(x: 0, y: 0))
                
                path.addQuadCurve(to: CGPoint(x: farPointX, y: middleY), control: CGPoint(x: farPointX, y: 0))
                
                path.move(to: CGPoint(x: farPointX, y: middleY))
                
                path.addQuadCurve(to: CGPoint(x: middleX, y: width), control: CGPoint(x: farPointX, y: height))
                
                path.addQuadCurve(to: CGPoint(x: nearPointX, y: middleY), control: CGPoint(x: nearPointX, y: middleY))
            }
            .fill(LinearGradient(colors: [.red, .yellow] , startPoint: .bottomLeading, endPoint: .topTrailing))
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .frame(width: 400, height: 400)
    }
}
