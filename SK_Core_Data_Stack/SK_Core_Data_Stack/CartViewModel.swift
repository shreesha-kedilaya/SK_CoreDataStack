//
//  CartViewModel.swift
//  SK_Core_Data_Stack
//
//  Created by Shreesha on 26/11/16.
//  Copyright © 2016 YML. All rights reserved.
//

import Foundation
class CartViewModel {
    var products: [Product]?
    var cart: Cart?
    static var shared = CartViewModel()

    func fetchAll(completion: ViewModelCompletion) {
        let context = SK_CoredataStack.sharedInstance.viewContext()
        let user: User? = context.executeFetchRequest(builder: { (request) in
            request.predicate = NSPredicate(format: "userID == %lf", Preference.userID() ?? 0)
        })?.first

        self.cart = user?.cart
        self.products = cart?.products?.allObjects as? [Product]

        completion(nil)
    }

    func removeAt(index: Int, completion: @escaping ViewModelCompletion) {
        let context = cart?.managedObjectContext
        products?.remove(at: index)

        if let products = self.products {
            cart?.products = NSMutableSet(array: products)
        }

        context?.saveAllToStore(false, completion: { (error) in
            completion(error)
        })
    }
}
