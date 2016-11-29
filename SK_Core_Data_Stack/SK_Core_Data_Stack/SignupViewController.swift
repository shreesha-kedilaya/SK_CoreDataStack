//
//  SignupViewController.swift
//  SK_Core_Data_Stack
//
//  Created by Shreesha on 25/11/16.
//  Copyright © 2016 YML. All rights reserved.
//

import UIKit

class SignupViewController: UIViewController {

    fileprivate var viewModel = SignupViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Sgin Up"
        // Do any additional setup after loading the view.
    }
    @IBOutlet var allTextfieldInputs: [UITextField]!

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signUpDidTap(_ sender: AnyObject) {
        
        var username: String = ""
        var password: String = ""
        var address: String = ""
        var pincode: Int = 0
        var emailId: String = ""
        
        for textfield in allTextfieldInputs {
            switch textfield.tag {
            case 0:
                username = textfield.text!
            case 1:
                emailId = textfield.text!
            case 2:
                password = textfield.text!
            case 3:
                address = textfield.text!
            case 4:
                pincode = Int(textfield.text!)!
            default: break
            }
        }

        let admin = false
//        viewModel.addSupplier(name: "Ton Supplier", address: "#903, Ton Suppliers, Vishweshwara Nagar", pincode: 575333, emailId: "tonsuppliers@gmail.com", completion: {_ in
            self.viewModel.addUser(username: username, password: password, address: address, pincode: pincode, emailId: emailId, admin: admin, supplier: self.viewModel.supplier) { (error) in
                Async.main {
                    if let _ = error {
                        self.showAlert(title: "Error", message: "Some Error has occurred")
                    } else {
                        Preference.setAdmin(admin)
                        Preference.setUserName(username)
                        Preference.setUserID(self.viewModel.user?.userID ?? 0)
                        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                        self.navigationController?.setViewControllers([viewController], animated: true)
                    }
                }
            }
            
//        })

    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension UIViewController {
    func showAlert(title: String, message: String, completion: (() -> ())? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let okayAction = UIAlertAction(title: "Okay", style: .default, handler: { (action) in
            completion?()
        })
        alertController.addAction(okayAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
