//
//  BillingViewModel.swift
//  SK_Core_Data_Stack
//
//  Created by Shreesha on 26/11/16.
//  Copyright © 2016 YML. All rights reserved.
//

import Foundation
class BillingViewModel {

    func placeOrder(address: String, creditCardNumber: Double, creditCardPin: Int, completion: ViewModelCompletion) {
        let context = SK_CoredataStack.sharedInstance.backgroundContext()
        let user: User? = context.executeFetchRequest(builder: { (request) in
            request.predicate = NSPredicate(format: "userID = %lf", Preference.userID() ?? 0)
        })?.first
        if let user = user {
            let order: Order? = context.newObject()
            let billing: Billing? = context.newObject()
let orderDetails: ? = context.newObject()
            billing?.billDate = NSDate()
            billing?.billingAddress = address
            billing?.creditCardNo = creditCardNumber
            billing?.creditCardPin = Int16(creditCardPin)
            billing?.user = user

            order?.customer = user
            order?.expectedDate = NSDate.addingTimeInterval(NSDate(timeIntervalSinceNow: 60*60*24*2))
            order?.billing = billing
            billing?.order = order
            user.addToOrders(order)
        }
    }
}
