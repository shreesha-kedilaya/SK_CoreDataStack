//
//  Preference.swift
//  SK_Core_Data_Stack
//
//  Created by Shreesha on 28/11/16.
//  Copyright © 2016 YML. All rights reserved.
//

import Foundation
let userNameKey = "UserName"
let userIDKey = "UserID"
let adminKey = "IsAdmin"

class Preference {
    
    class func userName() -> String? {
        return UserDefaults.standard.object(forKey: userNameKey) as? String
    }

    class func setUserName(_ value: String?) {
        UserDefaults.standard.set(value, forKey: userNameKey)
        UserDefaults.standard.synchronize()
    }

    class func userID() -> Double? {
        return UserDefaults.standard.object(forKey: userIDKey) as? Double
    }

    class func setUserID(_ value: Double?) {
        UserDefaults.standard.set(value, forKey: userIDKey)
        UserDefaults.standard.synchronize()
    }

    class func isAdmin() -> Bool {
        return UserDefaults.standard.bool(forKey: adminKey)
    }

    class func setAdmin(_ value: Bool) {
        UserDefaults.standard.set(value, forKey: adminKey)
        UserDefaults.standard.synchronize()
    }
}
