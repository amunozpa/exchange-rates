//
//  Exchange.swift
//  Exchange
//
//  Created by DAMII on 7/12/20.
//  Copyright © 2020 Cibertec. All rights reserved.
//

import CoreData

class Moneda: NSManagedObject, Identifiable {
    @NSManaged var base: String?
    @NSManaged var quote: String?
    @NSManaged var rate: Double
    @NSManaged var time: Date?
    
    
    static func getAllContactRequest() -> NSFetchRequest<Moneda> {
        let request = Moneda.fetchRequest() as! NSFetchRequest<Moneda>
        request.sortDescriptors = [NSSortDescriptor(key: "quote", ascending: false)]
        return request
    }
}

