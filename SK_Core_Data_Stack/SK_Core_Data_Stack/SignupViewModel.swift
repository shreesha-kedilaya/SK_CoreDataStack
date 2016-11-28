//
//  SignupViewModel.swift
//  SK_Core_Data_Stack
//
//  Created by Shreesha on 25/11/16.
//  Copyright © 2016 YML. All rights reserved.
//

import Foundation
class SignupViewModel {

    var supplier: Supplier?
    func addUser(username: String, password: String, address: String, pincode: Int, emailId: String, admin: Bool, supplier: Supplier?, success: @escaping ViewModelCompletion) {

        let context = supplier?.managedObjectContext ?? SK_CoredataStack.sharedInstance.backgroundContext()
        let user: User? = context.newObject()
        user?.admin = admin
        user?.password = password
        user?.name = username
        user?.supplierCompany = supplier
        user?.userID = Constants.CoredataStartingIDs.user.d
        user?.admin = true

        let contactInfo: ContactInfo? = context.newObject()
        contactInfo?.address = address
        contactInfo?.email = emailId
        contactInfo?.pinCode = pincode.i64
        contactInfo?.contactID = Constants.CoredataStartingIDs.user.d
        contactInfo?.supplierID = supplier?.supplierID ?? 0


        context.saveAllToStore(false) { (error) in
            guard let error = error else{
                success(nil)
                print("Added successfully")
                return
            }
            success(defaultError)
            print("Error in saving to core data: \(error)")
        }
    }

    func addSupplier(name: String, address: String, pincode: Int, emailId: String, completion : @escaping ViewModelCompletion) {
        let context = SK_CoredataStack.sharedInstance.backgroundContext()
        let supplier: Supplier? = context.newObject()
        supplier?.companyName = "Ton Suppliers"
        supplier?.supplierID = Constants.CoredataStartingIDs.supplier.d

        let contactInfo: ContactInfo? = context.newObject()
        contactInfo?.address = address
        contactInfo?.email = emailId
        contactInfo?.pinCode = pincode.i64
        contactInfo?.supplierID = Constants.CoredataStartingIDs.supplier.d
        contactInfo?.contactID = 0

        self.supplier = supplier
        context.saveAllToStore(false) { (error) in

            guard let error = error else {
                print("Added successfully")
                completion(nil)
                return
            }
            print("Error in saving to core data: \(error)")
            completion(error)
        }
    }
}

extension Int {
    var d: Double {
        return Double(self)
    }

    var i16: Int16 {
        return Int16(self)
    }

    var i64: Int64{
        return Int64(self)
    }
}
