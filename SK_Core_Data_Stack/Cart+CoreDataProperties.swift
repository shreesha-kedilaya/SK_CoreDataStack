//
//  Cart+CoreDataProperties.swift
//  SK_Core_Data_Stack
//
//  Created by Shreesha on 25/11/16.
//  Copyright © 2016 YML. All rights reserved.
//

import Foundation
import CoreData

extension Cart {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Cart> {
        return NSFetchRequest<Cart>(entityName: "Cart");
    }

    @NSManaged public var cartID: Double
    @NSManaged public var totalPrice: NSDecimalNumber?
    @NSManaged public var customer: User?
    @NSManaged public var products: NSSet?

}

extension Cart {
    class func nextId() -> Double {
        let context = SK_CoredataStack.sharedInstance.backgroundContext()
        let predicate = NSPredicate(format: "cartID == max(cartID)")

        let cart: Cart! = context.executeFetchRequest (false, builder: { (fetchRequest) in
            fetchRequest.predicate = predicate
        }) { (error) in
            }?.first

        if let cart = cart {
                    return cart.cartID + Double(1)
        } else {
            return Double(100)
        }


    }
}

// MARK: Generated accessors for products
extension Cart {

    @objc(addProductsObject:)
    @NSManaged public func addToProducts(_ value: Product)

    @objc(removeProductsObject:)
    @NSManaged public func removeFromProducts(_ value: Product)

    @objc(addProducts:)
    @NSManaged public func addToProducts(_ values: NSSet)

    @objc(removeProducts:)
    @NSManaged public func removeFromProducts(_ values: NSSet)

}
