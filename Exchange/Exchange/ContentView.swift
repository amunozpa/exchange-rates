//
//  ContentView.swift
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

struct ContentView: View {
    var colors = ["Red", "Green", "Blue", "Tartan"]
    @State private var selectedColor = 0
    var base = "BTC"
    @State var textQuote = ""
    @ObservedObject var monedaVM = MonedaViewModel()
    @ObservedObject var coinVM = ConsultorViewModel()
    
    
    var body: some View {
        NavigationView{
        List{
            Section(header: Text("Moneda Base")){
                HStack{
                    Text(self.base)
                    Spacer()
                }
            }
            Section(header: Text("Moneda Quote")){
                VStack(alignment: .center){
                    Picker("Select a Coin",selection: $selectedColor) {
                       ForEach(0 ..< colors.count) {
                          Text(self.colors[$0])
                       }
                    }.labelsHidden()
                    .frame(height: 45)
                    .clipped()
                    //Text("You selected: \(colors[selectedColor])")
                }
            }
            Section(header: Text("Valor Exchange Rate")){
                HStack{
                    TextField("Valor del Rate", text: $textQuote )
                    Button(action: {
                        if !self.textQuote.isEmpty {
                            self.monedaVM.addMoneda(quote: self.textQuote)
                            self.textQuote = ""
                        }
                    }){
                        Image(systemName: "plus")
                    }
                }
            }
            
            Section(header: Text("Monedas")){
                ForEach(self.monedaVM.monedas){
                    moneda in
                    Text(moneda.quote!)
                }.onDelete{
                    indexSet in
                    self.monedaVM.deleteMoneda(index: indexSet.first!)
                }
            }
        }
        }.onAppear{
            self.monedaVM.getMonedas()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
