//
//  BillingViewModel.swift
//  SK_Core_Data_Stack
//
//  Created by Shreesha on 26/11/16.
//  Copyright © 2016 YML. All rights reserved.
//

import Foundation
let shipperID = 100
class BillingViewModel {

    func placeOrder(address: String, creditCardNumber: Double, creditCardPin: Int, completion: ViewModelCompletion) {
        let context = SK_CoredataStack.sharedInstance.backgroundContext()
        let user: User? = context.executeFetchRequest(builder: { (request) in
            request.predicate = NSPredicate(format: "userID = %lf", Preference.userID() ?? 0)
        })?.first
        if let user = user {
            let order: Order? = context.newObject()
            let billing: Billing? = context.newObject()
            
            billing?.billDate = NSDate()
            billing?.billingAddress = address
            billing?.creditCardNo = creditCardNumber
            billing?.creditCardPin = Int16(creditCardPin)
            billing?.user = user

            order?.customer = user
            order?.expectedDate = Date().addingTimeInterval(60*60*24*2) as NSDate
            order?.billing = billing
            order?.orderID = Order.nextId()
            billing?.order = order
            billing?.billingID = Billing.nextId()
            
            let cartViewModel = CartViewModel.shared
            
            if let products = cartViewModel.products {
                for product in products.enumerated() {
                    let orderDetails: OrderDetails? = context.newObject()
                    orderDetails?.productID = product.element.productID
                    orderDetails?.orderNumber = Float(product.offset)
                    orderDetails?.orderDetailsID = OrderDetails.nextId()
                    orderDetails?.order = order
                    orderDetails?.quantity = 1
                    orderDetails?.unitPrice = product.element.pricePerUnit
                }
            }
            
            if let order = order {
                var shipper: Shipper? = context.executeFetchRequest(builder: { (request) in
                    request.predicate = NSPredicate(format: "shipperID == %i", shipperID)
                })?.first
                
                if let shipper = shipper {
                    shipper.addToOrders(order)
                } else {
                    shipper = context.newObject()
                    shipper?.shipperID = Double(shipperID)
                    shipper?.companyName = "Emirates Fly"
                    shipper?.phoneNumber = 9984834947
                    shipper?.addToOrders(order)
                }
                
                user.addToOrders(order)
                completion(nil)
            } else {
                let error = NSError(domain: "Cannot create an order", code: 100, userInfo: nil)
                completion(error)
            }
        } else {
            let error = NSError(domain: "User doesnt exist", code: 100, userInfo: nil)
            completion(error)
        }
    }
}
