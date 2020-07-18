//
//  VistaAlternativaView.swift
//  Exchange
//
//  Created by DAMII on 7/12/20.
//  Copyright © 2020 Cibertec. All rights reserved.
//

import SwiftUI



struct ConsultaBTCResponse: Decodable {
    let rates: [CoinBTC]
}

struct CoinBTC: Identifiable, Decodable {
    let id = UUID()
    let asset_id_quote: String
    let rate: Float
    let time: String
}

class ConsultaBTCViewModel: ObservableObject {
    var base = "USD"
 
    
    @Published var coinbtcs = [CoinBTC]()
    

    func getCoinBTCs() {
        
   
        let stringUrl = "https://rest.coinapi.io/v1/exchangerate/\(base)?invert=false&apikey=62ADF072-9054-4214-BCB9-4BBDDFEEEBA3"

        let url = URL(string: stringUrl)!

         let session = URLSession.shared
        session.dataTask(with: url){
            (data, response, error) in
            DispatchQueue.main.async {
                self.coinbtcs = try! JSONDecoder().decode(ConsultaBTCResponse.self, from: data!).rates
               // self.base += 20
            }
        }.resume()
    }
}

struct CoinBTCRowView: View {
    let coinbtc: CoinBTC
    var body: some View {
        VStack(alignment: .leading){
            HStack(){
                Text(coinbtc.asset_id_quote.capitalized)
                Text(String(coinbtc.rate))
            }
            Text(coinbtc.time)
        }
    }
}

struct VistaView: View {
    
    @ObservedObject var ConsultaBTCVM = ConsultaBTCViewModel()
    
    var body: some View {
        NavigationView{
            List{
                ForEach(ConsultaBTCVM.coinbtcs) { coinbtc in
                    CoinBTCRowView(coinbtc: coinbtc)
                }
            }.navigationBarTitle(Text("ConsultaBTC"))
            
        }.onAppear{
            self.ConsultaBTCVM.getCoinBTCs()
        }
    }
}

struct VistaView_Previews: PreviewProvider {
    static var previews: some View {
        VistaView()
    }
}
