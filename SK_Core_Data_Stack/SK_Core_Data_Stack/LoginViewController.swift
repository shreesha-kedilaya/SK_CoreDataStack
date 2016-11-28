//
//  ViewController.swift
//  SK_Core_Data_Stack
//
//  Created by Shreesha on 25/11/16.
//  Copyright © 2016 YML. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var usernameTextfield: UITextField!

    @IBOutlet weak var passwordTextfield: UITextField!
    
    private var viewModel = LoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Login"

        usernameTextfield.text = "Ashish"
        passwordTextfield.text = "ashish123"
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func loginDidTap(_ sender: AnyObject) {
        if let username = usernameTextfield.text, let password = passwordTextfield.text {
            viewModel.username = username
            viewModel.password = password
            viewModel.siginInDidTap(success: { (error, admin) in
                if let _ = error {
                    self.showAlert(title: "Error", message: "Username OR Password is incorrect")
                } else {
                    let viewController = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
                    Preference.setUserName(self.viewModel.username)
                    Preference.setAdmin(self.viewModel.user?.admin ?? false)
                    Preference.setUserID(self.viewModel.user?.userID ?? 0)
                    self.navigationController?.setViewControllers([viewController], animated: true)
                }
            })
        }
    }

    @IBAction func signUpDidTap(_ sender: AnyObject) {
        let viewController = self.storyboard?.instantiateViewController(withIdentifier: "SignupViewController") as! SignupViewController
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

