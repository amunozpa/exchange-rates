//
//  ContentView.swift
//  Exchange
//
//  Created by DAMII on 7/12/20.
//  Copyright © 2020 Cibertec. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var textQuote = ""
    @ObservedObject var monedaVM = MonedaViewModel()
    
    var body: some View {
        
        List{
            Section(header: Text("Nueva moneda")){
                HStack{
                    TextField("Ingrese moneda a guardar", text: $textQuote )
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
