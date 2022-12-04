//
//  Coin.swift
//  DesignCodeiOS15
//
//  Created by HardiBSalih on 1.12.2022.
//

import SwiftUI

struct Coin: Identifiable, Decodable {
    var id : Int
    var coin_name : String
    var acronym : String
    var logo : String
    
}

class CoinModel: ObservableObject {
    @Published var coins: [Coin] = []
    
    @MainActor
    func featchCoin() async {
        do{
            let url = URL(string: "https://random-data-api.com/api/crypto_coin/random_crypto_coin?size=10")!
            let (date, _) = try await URLSession.shared.data(from: url)
            coins = try JSONDecoder().decode([Coin].self, from: date)
        }catch {
            print("Error")
        }
    }
    
}



