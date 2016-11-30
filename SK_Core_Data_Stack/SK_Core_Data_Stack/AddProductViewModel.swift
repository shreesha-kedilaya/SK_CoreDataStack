//
//  AddProductViewModel.swift
//  SK_Core_Data_Stack
//
//  Created by Shreesha on 26/11/16.
//  Copyright © 2016 YML. All rights reserved.
//

import Foundation
class AddProductViewModel {

    var product: Product!

    func addProduct(name: String, description: String, quantityPerUnit: Int, inStock: Double, weight: Float, unitsOrdered: Int, categoryDescription: String, price: Float, edit: Bool = false, completion: @escaping ViewModelCompletion) {

        let context = edit ? self.product.managedObjectContext : SK_CoredataStack.sharedInstance.backgroundContext()
        let product: Product! = edit ? self.product : context?.newObject()
        let user: User? = context?.executeFetchRequest(builder: { (fetchRequest) in
            fetchRequest.predicate = NSPredicate(format: "name == %@", Preference.userName() ?? "")
        })?.first

        let supplier = user?.supplierCompany

        if let product = product {
            product.productDescription = description
            product.quantityPerUnitPackage = Int16(quantityPerUnit)
            product.unitsInStock = Float(inStock)
            product.unitWeight = weight
            product.unitsOrdered = Float(unitsOrdered)
            product.pricePerUnit = price
            product.productID = Product.nextId()
            product.supplier = supplier

            context?.saveAllToStore(false, completion: { (error) in
                let category: ProductCategory! = context?.newObject()
                if let category = category {
                    category.categoryDescription = categoryDescription
                    category.categoryName = name
                    category.product = product
                    category.categoryID = ProductCategory.nextId()
                }

                context?.saveAllToStore(false, completion: { (error) in
                    completion(error)
                })
            })

        } else {
            completion(defaultError)
        }
    }
}
