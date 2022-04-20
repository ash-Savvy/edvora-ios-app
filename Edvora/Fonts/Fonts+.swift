//
//  TextBox.swift
//  Edvora
//
//  Created by TeCh_SavVy on 18/04/22.
//

import SwiftUI

extension View {
    func Inter(_ textStyle: Inter.TextStyle) -> some View {
        self.modifier(Edvora.Inter(textStyle: textStyle))
    }
}


struct Inter: ViewModifier {
    
    //@Environment(\.sizeCategory) var sizeCategory
    
    public enum TextStyle {
        case interBold
        case interBold12
        case interRegular
        case interMedium
        case interMedium10
        case interMedium16
    }
    
    var textStyle: TextStyle
    
    func body(content: Content) -> some View {
        return content.font(getFont)
    }
    
    private var getFont: Font {
        switch textStyle {
        case .interBold:
            return Font.custom("Inter-Bold", size: 14, relativeTo: .body)
        case .interBold12:
            return Font.custom("Inter-Bold", size: 12, relativeTo: .body)
        case .interRegular:
            return Font.custom("Inter-Regular", size: 14, relativeTo: .body)
        case .interMedium:
            return Font.custom("Inter-Medium", size: 14, relativeTo: .body)
        case .interMedium10:
            return Font.custom("Inter-Medium", size: 10, relativeTo: .body)
        case .interMedium16:
            return Font.custom("Inter-Medium", size: 16, relativeTo: .body)
        }
    }
}

