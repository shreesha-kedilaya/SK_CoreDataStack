//
//  HomeViewController.swift
//  SK_Core_Data_Stack
//
//  Created by Shreesha on 26/11/16.
//  Copyright © 2016 YML. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var recentOrdersButton: UIButton!
    var viewModel = HomeViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Home"

        let rightBardButtonItem = UIBarButtonItem(title: "Sign Out", style: .plain, target: self, action: #selector(HomeViewController.handleRightBarItem(_:)))
        navigationItem.rightBarButtonItem = rightBardButtonItem

        // Do any additional setup after loading the view.
    }

    func handleRightBarItem(_ sender: UIBarButtonItem) {
        let viewController = storyboard?.instantiateViewController(withIdentifier: "LoginViewController") as! LoginViewController
        navigationController?.setViewControllers([viewController], animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func productsTapped(_ sender: AnyObject) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ProductListViewController") as! ProductListViewController
        navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func editInfoTapped(_ sender: AnyObject) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "EditInfoViewController") as! EditInfoViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func recentOrdersTapped(_ sender: AnyObject) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "OrdersViewController") as! OrdersViewController
        navigationController?.pushViewController(vc, animated: true)
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
