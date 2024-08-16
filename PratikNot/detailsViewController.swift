//
//  detailsViewController.swift
//  PratikNot
//
//  Created by Mürşide Gökçe on 16.08.2024.
//

import UIKit

class detailsViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate{

    @IBOutlet weak var bedentextfield: UITextField!
    @IBOutlet weak var isimtextfield: UITextField!
    @IBOutlet weak var fiyattextfield: UITextField!
    @IBOutlet weak var image: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(klavyeyiKapat))
        view.addGestureRecognizer(gestureRecognizer)
        image.isUserInteractionEnabled=true
        
        
        let imageGesture=UITapGestureRecognizer(target: self, action: #selector(gorselSec))
        image.addGestureRecognizer(imageGesture)

    }
    
    @objc func gorselSec( ){
        let imagepicker = UIImagePickerController()
        imagepicker.delegate = self
        imagepicker.sourceType = .photoLibrary
        imagepicker.allowsEditing=true
        present(imagepicker, animated: true, completion: nil)
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        image.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    @objc func klavyeyiKapat( ){
        view.endEditing(true)
        
    }
    

    @IBAction func kaydetButon(_ sender: Any) {
    }

   

}
