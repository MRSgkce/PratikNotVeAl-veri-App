//
//  ViewController.swift
//  PratikNot
//
//  Created by Mürşide Gökçe on 16.08.2024.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //ekleme butonu ekleme
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.add, target: self, action: #selector(eklemeButonuTiklandi) )
        
    }
    @objc func eklemeButonuTiklandi(){
        performSegue(withIdentifier: "todetails", sender: nil)
    }


}

