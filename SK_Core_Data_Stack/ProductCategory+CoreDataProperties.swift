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
