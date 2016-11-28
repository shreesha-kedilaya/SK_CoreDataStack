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
            let predicate = NSPredicate(format: "name == %@", Preference.userName() ?? "")

            let user: User! = context.executeFetchRequest(builder: { (fetchRequest) in
                fetchRequest.predicate = predicate
            })?.first
            if let user = user {
                let supplier = user.supplierCompany
                self.products = supplier?.products?.allObjects as? [Product]
            }
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
}
