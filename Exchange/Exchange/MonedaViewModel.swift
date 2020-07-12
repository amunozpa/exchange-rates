//
//  MonedaViewModel.swift
//  Exchange
//
//  Created by DAMII on 7/12/20.
//  Copyright © 2020 Cibertec. All rights reserved.
//

import CoreData
import SwiftUI

class ContactViewModel: ObservableObject {
    @Published var monedas = [Moneda]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func getMonedas(){
        let request = Moneda.getAllContactRequest()
        do {
            monedas = try context.fetch(request)
        } catch (let error){
            print(error)
        }
    }
       
    func addMoneda(quote: String){
        let moneda = Moneda(context: context)
        moneda.quote = quote
        saveContext()
    }
    
    func deleteMoneda(index: Int){
        let moneda = monedas[index]
        context.delete(moneda)
        saveContext()
    }
    
    func saveContext(){
        if context.hasChanges {
            do{
                try context.save()
                getMonedas()
            } catch (let error){
                print(error)
            }
        }
    }
       
}
