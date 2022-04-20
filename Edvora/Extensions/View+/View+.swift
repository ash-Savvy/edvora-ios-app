//
//  TextBox.swift
//  Edvora
//
//  Created by TeCh_SavVy on 18/04/22.
//

import SwiftUI

struct DropShadow<Content>: View where Content: View {
    
    var views: Content
    var x: Int = 0
    var y: Int = 6
    var radius: Int = 4
    init(x: Int = 0, y: Int = 6, radius: Int = 4, @ViewBuilder content: () -> Content) {
        self.views = content()
        self.x = x
        self.y = y
        self.radius = radius
    }
    var body: some View {
        views
            .padding(8)
            .background(RoundedRectangle(cornerRadius: 0).fill(.white)
                            .shadow(color: .black.opacity(0.3), radius: 4, x: 0, y: 6))
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}

struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}

