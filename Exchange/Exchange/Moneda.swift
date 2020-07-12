//
//  Exchange.swift
//  Exchange
//
//  Created by DAMII on 7/12/20.
//  Copyright © 2020 Cibertec. All rights reserved.
//

import CoreData

class Exchange: NSManagedObject, Identifiable {
    @NSManaged var base: String?
    @NSManaged var quote: String?
    @NSManaged var rate: Double
    @NSManaged var time: Date?
    
    
    /*static func getAllContactRequest() -> NSFetchRequest<Exchange> {
        let request = Exchange.fetchRequest() as! NSFetchRequest<Exchange>
        request.sortDescriptors = [NSSortDescriptor(key: "name", ascending: false)]
        return request
    }*/
}

