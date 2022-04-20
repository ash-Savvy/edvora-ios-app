//
//  MainScreenView.swift
//  Edvora
//
//  Created by TeCh_SavVy on 18/04/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct MainScreenView: View {
    @StateObject var viewModel = RidesViewModel()
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                NavigationHeader(imageUrl: viewModel.userModel?.url ?? "").padding()
                HStack {
                    TopTabsView(fixed: false, tabs: viewModel.tabs, geoWidth: geo.size.width, selectedTab: $viewModel.selectedTab)
                    Button(action: {
                        withAnimation(.easeInOut, { viewModel.showFilter = true})
                    }, label: {
                        ImageLabel(title: "Filters", image: "sort")
                    }).padding(.trailing, 20)
                    
                }
                ZStack(alignment: .topTrailing) {
                    TabView(selection: $viewModel.selectedTab, content: {
                        NearestRide(arrayOfRides: viewModel.nearestRide).tag(0).environmentObject(viewModel)
                        NearestRide(arrayOfRides: viewModel.upCommingRides).tag(1)
                            .environmentObject(viewModel)
                        NearestRide(arrayOfRides: viewModel.pastRides).tag(2).environmentObject(viewModel)
                    }).tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    if viewModel.showFilter {
                        FilterView().environmentObject(viewModel)
                    }
                } 
            }.task {
                await viewModel.getUser()
                await viewModel.getRides()
            }
        }.ignoresSafeArea(.all, edges: .bottom)
           
        .sheetWithDetents(
            isPresented: $viewModel.showDetails,
            detents: [.medium(),.large()]
        ) {
            print("The sheet has been dismissed")
        } content: {
            MapDetailView().environmentObject(viewModel)
                .background(.ultraThinMaterial)
        }
        
        
    }
}

struct NearestRide: View {
    @EnvironmentObject var viewModel: RidesViewModel
    var arrayOfRides: [RideModel]?
    var body: some View {
        ScrollView(showsIndicators: false) {
            VStack(spacing: 30) {
                if let array = arrayOfRides {
                    ForEach(array, id: \.self) { row in
                        Button(action: {
                            viewModel.selectedRide = row
                            viewModel.showDetails = true
                        }, label: {
                            MapCardView(model: row, distance: viewModel.getDistance(model: row))
                        }).buttonStyle(CardButtonStyle())
                            .disabled(viewModel.showFilter)
                    }
                }
            }
        }
    }
}
#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainScreenView()
    }
}
#endif

struct NavigationHeader: View {
    var imageUrl: String
    var body: some View {
        HStack {
            Text("Edvora").frame(maxWidth: .infinity, alignment: .leading)
                .font(.largeTitle.bold())
            Button(action: { }, label: {
                WebImage(url: URL(string: imageUrl)).resizable()
                    .frame(width: 40, height: 40, alignment: .center)
            })
        }
    }
}



struct BackgroundClearView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        let view = UIView()
        DispatchQueue.main.async {
            view.superview?.superview?.backgroundColor = .clear
        }
        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}
