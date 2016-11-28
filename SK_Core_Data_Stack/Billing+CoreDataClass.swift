//
//  Billing+CoreDataClass.swift
//  SK_Core_Data_Stack
//
//  Created by Shreesha on 25/11/16.
//  Copyright © 2016 YML. All rights reserved.
//

import Foundation
import CoreData


public class Billing: NSManagedObject {

}


extension Billing {
    class func nextId() -> Double {
        let context = SK_CoredataStack.sharedInstance.backgroundContext()
        let predicate = NSPredicate(format: "billingID == max(billingID)")

        let billing: Billing! = context.executeFetchRequest(false, builder: { (fetchRequest) in
            fetchRequest.predicate = predicate
        }) { (error) in
            }?.first

        if let billing = billing {
            return billing.billingID + Double(1)
        } else {
            return Double(100)
        }

    }
}
