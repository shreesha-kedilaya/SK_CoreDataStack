//
//  OrdersViewModel.swift
//  SK_Core_Data_Stack
//
//  Created by Shreesha on 26/11/16.
//  Copyright © 2016 YML. All rights reserved.
//

import Foundation

class OrdersViewModel {
    var orders: [Order]?
    
    func fetchAll(completion: ViewModelCompletion){
        let context = SK_CoredataStack.sharedInstance.viewContext()
        let orders: [Order]? = context.executeFetchRequest(builder: { (request) in
            request.predicate = NSPredicate(format: "user.userID == %lf", Preference.userID() ?? 0)
        })
        
        self.orders = orders
        completion(nil)
    }

//    func totalPrice(orderAtIndex index: Int) -> Float {
//        if let order = orders[index] {
//            for details in order.
//        }
//    }
}
