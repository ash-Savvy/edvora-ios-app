//
//  TextBox.swift
//  Edvora
//
//  Created by TeCh_SavVy on 18/04/22.
//

import SwiftUI

struct PrimaryButton: View {
    
    enum Icon{
        case none
        case leading
        case trailing
    }
    
    enum Size{
        case large
        case medium
    }
    
    enum State{
        case filled
        case outlined
        case disabled
    }
    
    
    
    var title:String
    
    var size : Size
    var state : State
    var isInfinity = false
    var iconType = Icon.none
    var image:Image? = nil
    
    var onTap:(()->())?
    var body: some View {
        
        HStack {
            Button(action: {
                if state != .disabled{
                    onTap?()
                }
                
            }, label: {
                HStack{
                    if iconType == .leading{
                        AnyView(image)
                    }
                    
                    Text(title)
                        .Inter(gibsonStyle())
                    if iconType == .trailing{
                        AnyView(image)
                    }
                } .frame(maxWidth: isInfinity ? .infinity : nil)
            })
        }.foregroundColor(foreground())
        //.padding(.vertical,verticalPadding())
        .padding(.horizontal,16)
        .frame(height:height())
        .background(background())
        
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke( state  == .outlined ? Color.primaryBlue : Color.clear, lineWidth: 1)
        )
        .cornerRadius(8)
        
        
    }
    
    func verticalPadding() -> CGFloat{
        switch size {
        case .large:
            return 14
        case .medium:
            return 9
        }
    }
    func height() -> CGFloat {
        switch size {
        case .large:
            return 48
        case .medium:
            return 26
            
            
        }
    }
    func gibsonStyle() -> Inter.TextStyle{
        switch size {
        case .large:
            return .interRegular
        case .medium:
            return .interBold12
        }
    }
    
    func foreground() -> Color {
        switch state {
        case .filled:
            return .white
        case .outlined:
            return .white
        case .disabled:
            return .white
        }
    }
    
    func background() -> Color {
        switch state {
        case .filled:
            return .primaryBlue
        case .outlined:
            return .clear
        case .disabled:
            return .primaryGray
        }
    }
}

struct PrimaryButton_Previews: PreviewProvider {
    static var previews: some View {
        PrimaryButton(title: "Btn large", size:  .large, state: .filled)
    }
}
