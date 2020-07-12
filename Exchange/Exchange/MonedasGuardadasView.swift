//
//  MonedasGuardadasView.swift
//  Exchange
//
//  Created by DAMII on 7/12/20.
//  Copyright © 2020 Cibertec. All rights reserved.
//

import SwiftUI



struct ConsultorResponse: Decodable {
    let rates: [Coin]
}

struct Coin: Identifiable, Decodable {
    let id = UUID()
    let asset_id_quote: String
    let rate: Float
    let time: String
}

class ConsultorViewModel: ObservableObject {
    var base = "USD"
 
    
    @Published var monedas = [Coin]()
    

    func getCoins() {
        
   
        let stringUrl = "https://rest.coinapi.io/v1/exchangerate/\(base)?invert=false&apikey=62ADF072-9054-4214-BCB9-4BBDDFEEEBA3"

        let url = URL(string: stringUrl)!

         let session = URLSession.shared
        session.dataTask(with: url){
            (data, response, error) in
            DispatchQueue.main.async {
                self.monedas = try! JSONDecoder().decode(ConsultorResponse.self, from: data!).rates
               // self.base += 20
            }
        }.resume()
    }
}

struct CoinRowView: View {
    let moneda: Coin
    var body: some View {
        VStack(alignment: .leading){
            HStack(){
                Text(moneda.asset_id_quote.capitalized)
                Text(String(moneda.rate))
            }
            Text(moneda.time)
        }
    }
}

struct CoinsGuardadasView: View {
    
    @ObservedObject var monedaVM = ConsultorViewModel()
    
    var body: some View {
        NavigationView{
            List{
                ForEach(monedaVM.monedas) { moneda in
                    CoinRowView(moneda: moneda)
                }
            }.navigationBarTitle(Text("Consultor"))
            
        }.onAppear{
            self.monedaVM.getCoins()
        }
    }
}

struct CoinsGuardadasView_Previews: PreviewProvider {
    static var previews: some View {
        CoinsGuardadasView()
    }
}
