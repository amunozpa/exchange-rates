//
//  ContentView.swift
//  Exchange
//
//  Created by DAMII on 7/12/20.
//  Copyright © 2020 Cibertec. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var colors = ["Red", "Green", "Blue", "Tartan"]
    @State private var selectedColor = 0
    var base = "BTC"
    @State var textQuote = ""
    @ObservedObject var monedaVM = MonedaViewModel()
    
    var body: some View {
        NavigationView{
        List{
            Section(header: Text("Moneda Base")){
                HStack{
                    Text(self.base)
                    Spacer()
                    /*Button(action: {
                        if !self.textQuote.isEmpty {
                            self.monedaVM.addMoneda(quote: self.textQuote)
                            self.textQuote = ""
                        }
                    }){
                        Image(systemName: "plus")
                    }*/
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
