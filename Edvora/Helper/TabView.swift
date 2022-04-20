//
//  TabView.swift
//  Edvora
//
//  Created by TeCh_SavVy on 19/04/22.
//

import SwiftUI

struct TopTab {
    var icon: Image?
    var title: String
}

struct TopTabsView: View {
    var fixed = false
    var tabs: [TopTab]
    var geoWidth: CGFloat
    @Binding var selectedTab: Int
    @Namespace private var animation
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            ScrollViewReader { proxy in
                VStack(spacing: 0) {
                    HStack(spacing: 0) {
                        ForEach(0 ..< tabs.count, id: \.self) { row in
                            Button(action: {
                                withAnimation(.easeInOut) {
                                    selectedTab = row
                                }
                            }, label: {
                                VStack(spacing: 0) {
                                    HStack {
                                        // Image
                                        AnyView(tabs[row].icon)

                                        // Text
                                        Text(tabs[row].title)
                                            .Inter(selectedTab == row ? .interBold : .interRegular)
                                            .foregroundColor(selectedTab == row ? .primaryBlack : .primaryGray)
                                    }
                                    .padding(EdgeInsets(top: 10, leading: 20, bottom: 10, trailing: 20))
                                    .frame(width: fixed ? (geoWidth / CGFloat(tabs.count)) : .none, height: 52)
                                    // Bar Indicator
                                    if selectedTab == row {
                                        RoundedRectangle(cornerRadius: 2)
                                            .fill(Color.primaryBlue)
                                            .frame(height: 3)
                                            .matchedGeometryEffect(id: "line", in: animation)
                                    }

                                }.fixedSize()
                            })
                                .accentColor(Color.white)
                                .buttonStyle(PlainButtonStyle())
                        }
                    }
                    .onChange(of: selectedTab) { target in
                        withAnimation {
                            proxy.scrollTo(target)
                        }
                    }
                }
            }
        }
        .frame(height: 55)
        .onAppear(perform: {
//            UIScrollView.appearance().bounces = fixed ? false : true
        })
        .onDisappear(perform: {
            UIScrollView.appearance().bounces = true
        })
    }
}

struct TopTabs_Previews: PreviewProvider {
    static var previews: some View {
        TopTabsView(fixed: false,
                    tabs: [.init(icon: Image(systemName: "star.fill"), title: "Tab 1"),
                           .init(icon: Image(systemName: "star.fill"), title: "Tab 2"),
                           .init(icon: nil, title: "Tab 3")],
                    geoWidth: 375,
                    selectedTab: .constant(0))
    }
}
