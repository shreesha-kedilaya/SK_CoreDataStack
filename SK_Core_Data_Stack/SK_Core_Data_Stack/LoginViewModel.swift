//
//  LoginViewModel.swift
//  SK_Core_Data_Stack
//
//  Created by Shreesha on 25/11/16.
//  Copyright © 2016 YML. All rights reserved.
//

import Foundation

typealias ViewModelCompletion = (Error?) -> ()
let defaultError = NSError(domain: "Some Error occurred", code: 1000, userInfo: nil)

class LoginViewModel {
    var username = ""
    var password = ""
    var supplier: Supplier?
    var personalInfo: ContactInfo?
    
    func siginInDidTap(success: @escaping (_ error:Error?, _ admin: Bool) -> ()) {
        let context = SK_CoredataStack.sharedInstance.viewContext()
        let user: User? = context.executeFetchRequest(false, builder: { (fetchRequest) in
            let predicate = NSPredicate(format: "name = %@", self.username)
            fetchRequest.predicate = predicate
            }) { (error) in
        }?.first
        
        guard let password = user?.password else {
            return
        }
        if self.password == password, let admin = user?.admin {
            success(nil, admin)
        } else {
            success(defaultError, false)
        }
    }
}
