//
//  Billing+CoreDataProperties.swift
//  SK_Core_Data_Stack
//
//  Created by Shreesha on 25/11/16.
//  Copyright © 2016 YML. All rights reserved.
//

import Foundation
import CoreData

extension Billing {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Billing> {
        return NSFetchRequest<Billing>(entityName: "Billing");
    }

    @NSManaged public var billDate: NSDate?
    @NSManaged public var billingAddress: String?
    @NSManaged public var billingID: Double
    @NSManaged public var creditCardNo: Int16
    @NSManaged public var creditCardPin: Int16
    @NSManaged public var order: Order?
    @NSManaged public var user: User?

}
