//
//  ViewController.swift
//  SK_CoreDataStack
//
//  Created by Shreesha on 22/11/16.
//  Copyright © 2016 Shreesha. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print("\n============================================================================\n")
        print("Textfield text: \(textField.text)")
        print("string: \(string)")
        print("Range length: \(range.length)")
        print("Range location: \(range.location)")
        print("\n============================================================================\n")
        return true
    }
}

