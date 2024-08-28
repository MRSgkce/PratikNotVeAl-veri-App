//
//  detailsViewController.swift
//  PratikNot
//
//  Created by Mürşide Gökçe on 16.08.2024.
//

import UIKit
import CoreData

class detailsViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate{

    @IBOutlet weak var bedentextfield: UITextField!
    @IBOutlet weak var isimtextfield: UITextField!
    @IBOutlet weak var fiyattextfield: UITextField!
    @IBOutlet weak var image: UIImageView!
    
    var secilenUrunIsmi = ""
    var secilenUrunId : UUID?
   
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if secilenUrunIsmi != "" {
            
            if let uuidString = secilenUrunId?.uuidString{
                
                    print("UUID: \(uuidString)")
                    // Fetch işlemi burada
                

                let appdelegate=UIApplication.shared.delegate as! AppDelegate
                let context = appdelegate.persistentContainer.viewContext
                
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Alisveris")
                fetchRequest.predicate = NSPredicate(format: "id = %@", uuidString)
                fetchRequest.returnsObjectsAsFaults = false

                
                do{
                    let sonuclar = try context.fetch(fetchRequest)
                    
                    if sonuclar.count > 0{
                        for sonuc in sonuclar as! [NSManagedObject]{
                            if let isim = sonuc.value(forKey: "isim") as? String{
                                isimtextfield.text = isim
                                print(isim)
                            }
                            if let fiyat = sonuc.value(forKey: "fiyat") as? Int{
                                fiyattextfield.text = String(fiyat)
                            }
                            
                            if let beden = sonuc.value(forKey: "beden") as? String{
                                bedentextfield.text = beden
                            }
                            
                            if let gorseldata = sonuc.value(forKey: "gorsel") as? Data{
                                let imagem = UIImage(data:gorseldata)
                                image.image=imagem
                            }
                            
                        }
                    }
                }catch{
                    print("hata var")
                }


            }
            
        }else{
            isimtextfield.text = ""
            fiyattextfield.text=""
            bedentextfield.text=""
        }
        
        
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
        
        let appDelegate=UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let not = NSEntityDescription.insertNewObject(forEntityName: "Alisveris", into: context)
        
        not.setValue(isimtextfield.text!, forKey: "isim")
        
        not.setValue(bedentextfield.text, forKey: "beden")
        
        if let fiyat = Int(fiyattextfield.text!){
            not.setValue(fiyat, forKey: "fiyat")
        }
        
        not.setValue(UUID(), forKey: "id")
        
        let data = image.image!.jpegData(compressionQuality: 0.5)
        
        not.setValue(data, forKey: "gorsel")
        
        do{
            try context.save()
            print("kayıt edildi")
        }catch{
            print("hata var")
        }
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "veriGirildi"), object: nil)
        self.navigationController?.popViewController(animated: true)
        
        
        
        
    }

   

}
