//
//  ContentView.swift
//  DesignCodeiOS15
//
//  Created by HardiBSalih on 28.11.2022.
//

import SwiftUI

struct ContentView: View {
    @AppStorage("selectedTab") var selectedTab : Tab = .home
    @AppStorage("showModal") var showModal = false

    @EnvironmentObject var model : Model
    var body: some View {
        ZStack (alignment: .bottom){
            switch selectedTab {
            case .home:
                HomeView()
            case .explore:
                ExplorerView()
            case .notifications:
                NotificationView()
            case .library:
                LibraryView()
            }
            
            TabBar()
                .offset(y: model.showDetail ? 200 : 0)
            
            if showModal {
                ModalView()
                    .zIndex(1)
                    .accessibilityAddTraits(.isModal)
            }
            
        }.safeAreaInset(edge: .bottom, spacing: 0) {
            Color.clear.frame(height: 88)
        }
        .dynamicTypeSize(.large ... .xxxLarge)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
            ContentView()
                .preferredColorScheme(.dark)
        }
        .environmentObject(Model())
        
    }
}
