//
//  OrdersViewController.swift
//  SK_Core_Data_Stack
//
//  Created by Shreesha on 26/11/16.
//  Copyright © 2016 YML. All rights reserved.
//

import UIKit

class OrdersViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    fileprivate var viewModel = OrdersViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Orders"
        
        let leftItem = UIBarButtonItem(title: "Home", style: .plain, target: self, action: #selector(OrdersViewController.handleLeftButton(_:)))
        navigationItem.leftBarButtonItem = leftItem
        tableView.delegate = self
        tableView.dataSource = self
        viewModel.fetchAll { (error) in
            self.tableView.reloadData()
        }
        // Do any additional setup after loading the view.
    }
    
    func handleLeftButton(_ sender: UIBarButtonItem) {
        ((UIApplication.shared.delegate) as! AppDelegate).window?.rootViewController?.dismiss(animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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

extension OrdersViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.orders?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrdersTableViewCell", for: indexPath) as! OrdersTableViewCell
//        if let order = viewModel.orders[indexPath.row] {
//            cell.priceLabel = order.
//        }
        return cell
    }
}

