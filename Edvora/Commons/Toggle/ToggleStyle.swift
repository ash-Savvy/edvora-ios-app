//
//  CheckToggleView.swift
//  Edvora
//
//  Created by TeCh_SavVy on 18/04/22.
//


import SwiftUI



struct CheckToggleView: View {
//    @EnvironmentObject var productListViewModel: ProductListViewModel
    @State var toggle = false
    var body: some View {
        VStack {
            
            Picker("What is your favorite color?", selection: $toggle) {
                
                Image("Grid-icon").tag(0)
                Image("GroupList").tag(1)
                
            }
            .pickerStyle(.segmented)
            .frame(width: 90, height: 20, alignment: .center)
        }
    }
}

struct CheckToggleView_Previews: PreviewProvider {
    static var previews: some View {
        CheckToggleView()
        
    }
}
