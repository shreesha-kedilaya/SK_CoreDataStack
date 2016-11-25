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

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signUpDidTap(_ sender: AnyObject) {
        viewModel.addSupplier(name: "Ton Towers", address: "#900, Ton Towers, 5th cross, Vishweshwara Nagar, Bangalore", pincode: 574447, emailId: "tontowers@gmail.com")
    }
    @IBOutlet weak var addAdminTapped: UIButton!

    @IBAction func actionAddAdmin(_ sender: AnyObject) {

        viewModel.addUser(username: "Ashish", password: "ashish123", address: "#786, Maria building, 5th cross, Vasanta Nagar, Bangalore", pincode: 574449, emailId: "ashishKoddar@gmail.com", admin: true, supplier: viewModel.supplier)
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
