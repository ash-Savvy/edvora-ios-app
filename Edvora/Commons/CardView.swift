//
//  CardView.swift
//  Edvora
//
//  Created by TeCh_SavVy on 18/04/22.
//

import SwiftUI

struct CardView <Content : View> : View {
    var strokeColor: Color
    var paddingVal: CGFloat = 20
    var cornerRadius: CGFloat = 8
    var backgroundColor: Color = .white
    var content : Content
    
    
    init(strokeColor: Color, paddingVal: CGFloat = 20, backgroundColor: Color = .white, cornerRadius: CGFloat = 8, @ViewBuilder content: () -> Content) {
        self.strokeColor = strokeColor
        self.paddingVal = paddingVal
        self.cornerRadius = cornerRadius
        self.backgroundColor = backgroundColor
        self.content = content()
       
    }
    
    var body: some View {
        content
            .padding(.all,paddingVal)
            .overlay(
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(strokeColor, lineWidth: 1))
    }
}


/// ShadowView
struct ShadowView<Content: View> : View {
    
    // MARK: - Properties
    var fillColor: Color
    var shadowFill: Color
    var spread: CGFloat
    var isCircle: Bool
    var x: CGFloat
    var y: CGFloat
    var blurRadius: CGFloat
    let content: () -> Content
    
    var body: some View {
        
        self.content()
            .background(GeometryReader { geometry in
                Rectangle()
                    .fill(fillColor)
                    .frame(width: geometry.size.width + spread,
                           height: geometry.size.height + spread)
                    .padding([.top, .leading], -spread / 2)
                    .padding(.leading, x)
                    .padding(.top, y)
                    .shadow(color: shadowFill, radius: blurRadius, x: x, y: y)
            })
    }
}
