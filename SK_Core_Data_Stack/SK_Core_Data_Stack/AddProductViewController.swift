//
//  AddProductViewController.swift
//  SK_Core_Data_Stack
//
//  Created by Shreesha on 26/11/16.
//  Copyright © 2016 YML. All rights reserved.
//

import UIKit
protocol AddProductViewControllerDelegate: class {
    func addProductViewControllerDidAddPrduct(vc: AddProductViewController)
}

class AddProductViewController: UIViewController {

    private var viewModel = AddProductViewModel()
    weak var delegate: AddProductViewControllerDelegate?
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Add Product"
        let leftBardButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(AddProductViewController.handleLeftBarItem(_:)))
        navigationItem.leftBarButtonItem = leftBardButtonItem
        // Do any additional setup after loading the view.
    }
    @IBOutlet var addProductTextFields: [UITextField]!

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func handleLeftBarItem(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func addClicked(_ sender: AnyObject) {
        var product: (name: String, description: String, quantityPerUnit: Int, inStock: Double, weight: Float, unitsOrdered: Int, categoryDescription: String, price: Float) = (name: "", description: "", quantityPerUnit: 0, inStock: 0.0, weight: 0.0, unitsOrdered: 0, categoryDescription: "" , price: 0.0)

        for textfield in addProductTextFields {

            if let text = textfield.text, !text.isEmpty {
                switch textfield.tag {
                case 0:
                    product.name = text
                case 1:
                    product.description = text
                case 2:
                    product.quantityPerUnit = Int(text)!
                case 3:
                    product.inStock = Double(text)!
                case 4:
                    product.weight = Float(text)!
                case 5:
                    product.unitsOrdered = Int(text)!
                case 6:
                    product.categoryDescription = text
                case 7:
                    product.price = Float(text)!
                default: break
                }
            } else {
                return
            }
        }

        viewModel.addProduct(name: product.name, description: product.description, quantityPerUnit: product.quantityPerUnit, inStock: product.inStock, weight: product.weight, unitsOrdered: product.unitsOrdered, categoryDescription: product.categoryDescription, price: product.price) { (error) in
            DispatchQueue.main.sync {
                if let _ = error {
                    self.showAlert(title: "Success", message: "Some Error Occurred" ,completion: {
                        self.delegate?.addProductViewControllerDidAddPrduct(vc: self)
                    })
                } else {
                    self.showAlert(title: "Success", message: "Successfully Added", completion: {
                        self.delegate?.addProductViewControllerDidAddPrduct(vc: self)
                    })
                }
            }
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
