//
//  AccountView.swift
//  DesignCodeiOS15
//
//  Created by HardiBSalih on 29.11.2022.
//

import SwiftUI

struct AccountView: View {
    @State var isDeleted = false
    @State var isPinned = false
    @State var address : Address = Address(id: 1, country: "Iraq")
    @Environment (\.dismiss) var dismiss
    @Environment (\.presentationMode) var presentationMode
    @AppStorage("isLogged") var isLogged = false
    @ObservedObject var coinModel = CoinModel()
    @AppStorage("isLiteMode") var isLiteMode = true


    func featchData() async {
        do {
            let url = URL(string: "https://random-data-api.com/api/address/random_address")!
            let (data, _ ) = try await URLSession.shared.data(from: url)
//            print(String(decoding: data, as: UTF8.self))
            address = try JSONDecoder().decode(Address.self, from: data)
        } catch {
            // Show error
            address = Address(id: 1, country: "error Feaching")
        }
            
        
    }
    
    var body: some View {
        NavigationView {
            List {
                profile
                menu
                
                Section {
                    Toggle(isOn: $isLiteMode) {
                        Label("Lite Mode", systemImage: isLiteMode ? "tortoise" : "hare")
                    }
                    .foregroundColor(.primary)
                }
                
                links
                coins
                
                Button {
                    isLogged = false
                    dismiss()
                } label: {
                    Text("Sign Out").bold()
                        .frame(maxWidth: .infinity, alignment: .center)
                }
                .tint(.red)
            }
            .task {
                await featchData()
                await coinModel.featchCoin()
            }
            .refreshable {
                await featchData()
                await coinModel.featchCoin()
            }
            .listStyle(.insetGrouped)
            .navigationTitle("Account")
            .navigationBarItems(trailing : Button { dismiss() } label: {
                Text("Done").bold()
            })
        }
    }
    
    
    var profile: some View {
        VStack (spacing: 8) {
            Image(systemName: "person.crop.circle.fill.badge.checkmark")
                .symbolVariant(.circle.fill)
                .font(.system(size: 32))
                .symbolRenderingMode(.palette)
                .foregroundStyle(.blue, .blue.opacity(0.3))
                .padding()
                .background(Circle().fill(.ultraThinMaterial))
                .background(HexagonView().offset(x: -50, y: -100))
                .background(BlobView().offset(x: 200, y: 0).scaleEffect(0.6))
            Text("Hardib.Salih")
                .font(.title).fontWeight(.semibold)
            HStack {
                Image(systemName: "location")
                    .imageScale(.small)
                Text(address.country)
                    .foregroundColor(.secondary)
            }
            
        }
        .frame(maxWidth: .infinity)
        .padding()
    }
    
    var menu: some View {
        Section {
            NavigationLink(destination: HomeView()) {
                Label("Settinig", systemImage: "gear")
            }
            NavigationLink {
                Text("Billing")
            } label: {
                Label("Billing", systemImage: "creditcard")
            }
            
            NavigationLink { HomeView() } label: {
                Label("Help", systemImage: "questionmark")
            }
                
        }
        .foregroundColor(.primary)
        .listRowSeparator(.hidden)
    }
    
    
    var links: some View {
        Section {
            if !isDeleted {
                Link(destination: URL(string: "https://designcode.io")!) {
                    HStack {
                        Label("Website", systemImage: "house")
                        Spacer()
                        Image(systemName: "link")
                            .foregroundColor(.secondary)
                    }
                }
                .swipeActions(edge: .leading, allowsFullSwipe: true) {
                    Button (action: { isDeleted = true }) {
                        Label("Delete", systemImage: "trash")
                    }.tint(.red)
                    pinButton
                }
            }
            Link(destination: URL(string: "https://youtube.com")!) {
                HStack {
                    Label("YouTube", systemImage: "tv")
                    Spacer()
                    Image(systemName: "link")
                        .foregroundColor(.secondary)
                }
            }.swipeActions(edge: .leading, allowsFullSwipe: true) {
                pinButton
            }
        }
        .foregroundColor(.primary)
        .listRowSeparator(.hidden)
    }
    
    var coins: some View {
        Section(header: Text("Coin")) {
            ForEach(coinModel.coins) { coin in
                HStack(alignment: .center, spacing: 16) {
                    AsyncImage(url: URL(string: coin.logo)) { phase in
                        switch phase {
                        case .success(let image) : image.resizable().aspectRatio(contentMode: .fit)
                        case .empty:
                            ProgressView()
                        case .failure(_):
                            Color.gray
                        @unknown default:
                            EmptyView()
                        }
                    }
                    .frame(width: 26, height: 26)
                    .cornerRadius(10)
                    .padding(8)
                    .background(.ultraThinMaterial, in: RoundedRectangle(cornerRadius: 18, style: .continuous))
                    .strokeStyle(cornerRadius: 18)
                    VStack(alignment: .leading, spacing: 4) {
                        Text(coin.coin_name)
                        Text(coin.acronym).font(.caption)
                            .foregroundColor(.secondary)
                    }
                }
            }
        }
    }
    
    var pinButton : some View {
        Button { isPinned.toggle() } label: {
            if isPinned {
                Label("UnPin", systemImage: "pin.slash")
            } else {
                Label("pin", systemImage: "pin")
            }
            
        }.tint(isPinned ? .gray : .yellow)
    }
}

struct AccountView_Previews: PreviewProvider {
    static var previews: some View {
        AccountView()
    }
}
