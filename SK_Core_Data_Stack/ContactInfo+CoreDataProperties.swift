//
//  ContactInfo+CoreDataProperties.swift
//  SK_Core_Data_Stack
//
//  Created by Shreesha on 25/11/16.
//  Copyright © 2016 YML. All rights reserved.
//

import Foundation
import CoreData

extension ContactInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ContactInfo> {
        return NSFetchRequest<ContactInfo>(entityName: "ContactInfo");
    }

    @NSManaged public var address: String?
    @NSManaged public var contactID: Double
    @NSManaged public var email: String?
    @NSManaged public var pinCode: Int64
    @NSManaged public var userID: Double
    @NSManaged public var supplierID: Double

}

extension ContactInfo {
    class func nextId() -> Double {
        let context = SK_CoredataStack.sharedInstance.backgroundContext()
        let predicate = NSPredicate(format: "contactID == max(contactID)")

        let contactInfo: ContactInfo! = context.executeFetchRequest(false, builder: { (fetchRequest) in
            fetchRequest.predicate = predicate
        }) { (error) in
            }?.first

        if let contactInfo = contactInfo {
            return contactInfo.contactID + Double(1)
        } else {
            return Double(100)
        }

    }

}
