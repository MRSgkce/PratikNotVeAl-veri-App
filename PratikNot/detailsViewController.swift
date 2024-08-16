//
//  detailsViewController.swift
//  PratikNot
//
//  Created by Mürşide Gökçe on 16.08.2024.
//

import UIKit

class detailsViewController: UIViewController {

    @IBOutlet weak var bedentextfield: UITextField!
    @IBOutlet weak var isimtextfield: UITextField!
    @IBOutlet weak var fiyattextfield: UITextField!
    @IBOutlet weak var image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(klavyeyiKapat))
        view.addGestureRecognizer(gestureRecognizer)
    }
    @objc func klavyeyiKapat( ){
        view.endEditing(true)
        
    }
    

    @IBAction func kaydetButon(_ sender: Any) {
    }

   

}
