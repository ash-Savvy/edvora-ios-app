//
//  FilterView.swift
//  Edvora
//
//  Created by TeCh_SavVy on 19/04/22.
//

import SwiftUI

struct FilterView: View {
    @EnvironmentObject var viewModel: RidesViewModel
    @State var showCities = false
    var body: some View {
        ZStack(alignment: .topTrailing) {
            CardView(strokeColor: .primaryGray, paddingVal: 16, backgroundColor: .white, cornerRadius: 15) {
                VStack(alignment: .leading, spacing: 16) {
                    Text("Filters").Inter(.interRegular)
                        .foregroundColor(.primaryBlack)
                    
                    MenuPicker(selected: $viewModel.selectedStateIndex, array: viewModel.arrayOfStates) { item in
                        FilterOptionView(title: .constant(item))
                    } callback: { index in
                        viewModel.selectedState = viewModel.arrayOfStates[index]
                        withAnimation(.spring(response: 0.4, dampingFraction: 0.4, blendDuration: 0.8)) {
                            self.showCities = true
                        }
                    }
                    if showCities {
                        MenuPicker(selected: $viewModel.selectedCityIndex, array: viewModel.arrayOfCities) { item in
                            FilterOptionView(title: .constant(item))
                        } callback: {_ in
                            viewModel.showFilter = false
                        }
                    }
                }
            }.background(Color.white)
                .cornerRadius(10)
                .frame(width: screenWidth / 1.5)
                .padding(.trailing, 20)
                .padding(.top, -20)
            Spacer()
        }
       
    }
}

struct FilterOptionView: View {
    @Binding var title: String
    var body: some View {
        CardView(strokeColor: .clear, paddingVal: 12, backgroundColor: .secondaryBackgrond, cornerRadius: 5) {
            HStack {
                Text(title).foregroundColor(.primaryGray)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Image(systemName: "chevron.down")
//                    .frame(width: 12, height: 12, alignment: .center)
            }
        }.background(Color.secondaryBackgrond)
            .cornerRadius(5)
            
    }
}
