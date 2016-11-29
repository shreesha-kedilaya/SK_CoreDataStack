//
//  ProductListViewModel.swift
//  SK_Core_Data_Stack
//
//  Created by Shreesha on 26/11/16.
//  Copyright © 2016 YML. All rights reserved.
//

import Foundation
class ProductListViewModel {

    var products: [Product]?
    func fetchAllProducts(completion: () -> ()) {
        let context = SK_CoredataStack.sharedInstance.viewContext()
        if Preference.isAdmin() {

            let predicate = NSPredicate(format: "userID == %lf", Preference.userID() ?? 0)
            let user: User! = context.executeFetchRequest(builder: { (fetchRequest) in
                fetchRequest.predicate = predicate
            })?.first
            let product: [Product]! = context.executeFetchRequest(builder: { (request) in
                request.predicate = NSPredicate(format: "supplier.supplierID == %lf", user.supplierCompany?.supplierID ?? 0)
            })
            self.products = product

            completion()
        } else {
            products = context.executeFetchRequest()
            completion()
        }
    }

    func remove(atIndex: Int, completion: @escaping ViewModelCompletion) {
        let selfproduct = products?[atIndex]
        let context = selfproduct?.managedObjectContext
        context?.removeObject(object: selfproduct)
        context?.saveAllToStore(false, completion: { (error) in
            completion(error)
        })

        self.products?.remove(at: atIndex)
    }

    func addProductToCart(atIndex: Int, completion: @escaping ViewModelCompletion) {
        let context = SK_CoredataStack.sharedInstance.backgroundContext()
        let user: User? = context.executeFetchRequest(builder: { (request) in
            request.predicate = NSPredicate(format: "userID == %lf", Preference.userID() ?? 0)
            })?.first
        if let user = user {

            let productAt = self.products?[atIndex]
            guard let productAtIndex = productAt else {
                completion(NSError(domain: "No products", code: 3024, userInfo: nil))
                return
            }
            guard let cart = user.cart else {
                let cart: Cart? = context.newObject()
                cart?.addToProducts(productAtIndex)
                user.cart = cart
                cart?.customer = user
                context.saveAllToStore(false, completion: { (error) in
                    completion(error)
                })
                return
            }

            cart.addToProducts(productAtIndex)
            context.saveAllToStore(false, completion: { (error) in
                completion(error)
            })

        } else {
            let error = NSError(domain: "User not found", code: 90000, userInfo: nil)
            completion(error)
        }
    }
}
