//
//  ProductListViewController.swift
//  SK_Core_Data_Stack
//
//  Created by Shreesha on 26/11/16.
//  Copyright © 2016 YML. All rights reserved.
//

import UIKit

class ProductListViewController: UIViewController {

    var viewModel = ProductListViewModel()
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Products"

        var rightTitle = ""

        if Preference.isAdmin() {
            rightTitle = "Add Product"
        } else {
            rightTitle = "Cart"
        }

        tableView.delegate = self
        tableView.dataSource = self

        viewModel.fetchAllProducts(completion: {
            Async.main {
                self.tableView.reloadData()
            }
        })

        let rightBardButtonItem = UIBarButtonItem(title: rightTitle, style: .plain, target: self, action: #selector(ProductListViewController.handleRightBarItem(_:)))
        navigationItem.rightBarButtonItem = rightBardButtonItem
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func handleRightBarItem(_ sender: UIBarButtonItem) {
        var vc: UINavigationController
        if Preference.isAdmin() {
            vc = storyboard?.instantiateViewController(withIdentifier: "AddProductViewControllerNavigation") as! UINavigationController
            (vc.topViewController as! AddProductViewController).delegate = self
        } else {
            vc = storyboard?.instantiateViewController(withIdentifier: "CartViewControllerNavigation") as! UINavigationController
        }
        navigationController?.present(vc, animated: true, completion: nil)
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

extension ProductListViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductsTableViewCell", for: indexPath) as! ProductsTableViewCell
        if let price = viewModel.products?[indexPath.row].pricePerUnit {
            cell.productPriceLabel.text = String(price)
        }

        cell.pruductNameLabel.text = viewModel.products?[indexPath.row].category?.categoryName

        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.products?.count ?? 0
    }

    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return Preference.isAdmin()
    }

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {

        let editAction = UITableViewRowAction(style: .default, title: "Edit", handler: { (action, indexPath) in
            
        })
        editAction.backgroundColor = UIColor.blue

        let deleteAction = UITableViewRowAction(style: .default, title: "Remove", handler: { (action, indexPath) in
            self.viewModel.remove(atIndex: indexPath.row, completion: { (error) in
                tableView.reloadData()
            })
        })
        deleteAction.backgroundColor = UIColor.red
        
        return [editAction, deleteAction]
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if !Preference.isAdmin() {
            let alertController = UIAlertController(title: "Add to Cart", message: "Do you wish to add this item to Cart", preferredStyle: .actionSheet)
            let addAction = UIAlertAction(title: "Add", style: .default, handler: { (action) in
                self.viewModel.addProductToCart(atIndex: indexPath.row, completion: { (error) in
                    if error == nil {
                        self.showAlert(title: "Error", message: error?.localizedDescription ?? "Some error")
                    } else {
                        self.showAlert(title: "Success", message: "The product added to Cart")
                    }
                })
            })

            let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
            alertController.addAction(addAction)
            alertController.addAction(cancelAction)

            self.present(alertController, animated: true, completion: nil)
        }
    }
}

extension ProductListViewController: AddProductViewControllerDelegate {
    func addProductViewControllerDidAddPrduct(vc: AddProductViewController) {
        vc.dismiss(animated: true) {
            Async.after(0.5) {
                self.viewModel.fetchAllProducts(completion: {
                    Async.main {
                        self.tableView.reloadData()
                    }
                })
            }
        }
    }
}
