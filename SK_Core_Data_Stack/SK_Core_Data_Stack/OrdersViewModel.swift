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
            request.predicate = NSPredicate(format: "customer.userID == %lf", Preference.userID() ?? 0)
        })
        
        self.orders = orders
        completion(nil)
    }

    func totalPrice(orderAtIndex index: Int) -> Float {

        var returnAmount: Float = 0.0

        if let orders = orders {
            let order = orders[index]
            if let allObjects = order.orderDetails?.allObjects as? [OrderDetails] {
                for detail in allObjects {
                    returnAmount += detail.unitPrice
                }
            }
        }
        return returnAmount
    }
}
