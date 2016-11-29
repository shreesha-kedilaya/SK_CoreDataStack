//
//  CartViewController.swift
//  SK_Core_Data_Stack
//
//  Created by Shreesha on 26/11/16.
//  Copyright © 2016 YML. All rights reserved.
//

import UIKit

class CartViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    fileprivate var viewModel = CartViewModel.shared

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Cart"
        let leftBardButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(CartViewController.handleLeftBarItem(_:)))
        navigationItem.leftBarButtonItem = leftBardButtonItem

        tableView.delegate = self
        tableView.dataSource = self

        viewModel.fetchAll { (error) in
            self.tableView.reloadData()
            navigationItem.rightBarButtonItem?.isEnabled = (viewModel.products?.count ?? 0) > 0
        }

        let rightBardButtonItem = UIBarButtonItem(title: "Checkout", style: .plain, target: self, action: #selector(CartViewController.handleRightBarItem(_:)))
        navigationItem.rightBarButtonItem = rightBardButtonItem
        navigationItem.rightBarButtonItem?.isEnabled = (viewModel.products?.count ?? 0) > 0

        // Do any additional setup after loading the view.
    }

    func handleRightBarItem(_ sender: UIBarButtonItem) {
        let vc = storyboard?.instantiateViewController(withIdentifier:"BillingViewController") as! BillingViewController

        navigationController?.pushViewController(vc, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func handleLeftBarItem(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
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

extension CartViewController: UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CartTableViewCell", for: indexPath) as! CartTableViewCell
        if let price = viewModel.products?[indexPath.row].pricePerUnit {
            cell.priceLabel.text = String(price)
        }

        if let name = viewModel.products?[indexPath.row].category?.categoryName {
            cell.pruductNameLabel.text = name
        }


        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }


    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {

        let deleteAction = UITableViewRowAction(style: .default, title: "Remove", handler: { (action, indexPath) in
            self.viewModel.removeAt(index: indexPath.row, completion: { (error) in
                tableView.reloadData()
            })
        })
        deleteAction.backgroundColor = UIColor.red

        return [deleteAction]
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.products?.count ?? 0
    }
}
