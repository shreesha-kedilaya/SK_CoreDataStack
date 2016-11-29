//
//  BillingViewController.swift
//  SK_Core_Data_Stack
//
//  Created by Shreesha on 26/11/16.
//  Copyright © 2016 YML. All rights reserved.
//

import UIKit

class BillingViewController: UIViewController {

    @IBOutlet weak var creditCardPin: UITextField!
    @IBOutlet weak var creditCardNumber: UITextField!
    @IBOutlet weak var billingAddress: UITextField!
    
    var viewModel = BillingViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Billing"
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func payDidClick(_ sender: AnyObject) {
        let creditCardNumber = self.creditCardNumber.text ?? ""
        if let pin = creditCardPin.text, let cardNumber = Double(creditCardNumber), let address = billingAddress.text {
            viewModel.placeOrder(address: address, creditCardNumber: cardNumber, creditCardPin: Int(pin)!, completion: { (error) in
                Async.main {
                    if let error = error {
                        self.showAlert(title: "Error", message: error.localizedDescription)
                    } else {
                        
                        self.showAlert(title: "Success", message: "Order placed successfully", completion: {
                            let vc = self.storyboard?.instantiateViewController(withIdentifier: "OrdersViewController") as! OrdersViewController
                            self.navigationController?.pushViewController(vc, animated: true)
                        })
                    }
                }
            })
        } else {
            showAlert(title: "Error", message: "All fields are Mandatory")
        }
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
