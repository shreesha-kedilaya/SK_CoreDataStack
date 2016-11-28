//
//  ProductCategory+CoreDataProperties.swift
//  SK_Core_Data_Stack
//
//  Created by Shreesha on 25/11/16.
//  Copyright © 2016 YML. All rights reserved.
//

import Foundation
import CoreData

extension ProductCategory {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ProductCategory> {
        return NSFetchRequest<ProductCategory>(entityName: "ProductCategory");
    }

    @NSManaged public var categoryDescription: String?
    @NSManaged public var categoryID: Double
    @NSManaged public var categoryName: String?
    @NSManaged public var product: Product?

}

extension ProductCategory {
    class func nextId() -> Double {
        let context = SK_CoredataStack.sharedInstance.backgroundContext()
        let predicate = NSPredicate(format: "categoryID == max(categoryID)")

        let category: ProductCategory! = context.executeFetchRequest (false, builder: { (fetchRequest) in
            fetchRequest.predicate = predicate
        }) { (error) in
            }?.first

        if let category = category {
            return category.categoryID + Double(1)
        } else {
            return Double(100)
        }

    }
}
