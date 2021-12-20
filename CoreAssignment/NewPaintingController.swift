//
//  NewPaintingController.swift
//  CoreAssignment
//
//  Created by Wema Bank on 20/12/2021.
//

import UIKit
import CoreData

class NewPaintingController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var uploadImageView: UIImageView!
    @IBOutlet weak var imageNameTextField: UITextField!
    @IBOutlet weak var artistTextField: UITextField!
    @IBOutlet weak var yearTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Upload new Picture"
        
        let imageTap = UITapGestureRecognizer(target: self, action: #selector(uploadImage))
        uploadImageView.addGestureRecognizer(imageTap)
        
    }
    
    @objc func uploadImage(){
        
        let imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        
        self.present(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        uploadImageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
        
    }

    @IBAction func saveNewButton(_ sender: Any) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let picture = NSEntityDescription.insertNewObject(forEntityName: "Picture", into: managedContext)
        
        picture.setValue(imageNameTextField.text, forKey: "name")
        picture.setValue(artistTextField.text, forKey: "artist")
        
        guard let year = Int(yearTextField.text!) else{
            return
        }
        picture.setValue(year, forKey: "year")
        
        let id = UUID()
        picture.setValue(id, forKey: "id")
        
        let imageData = uploadImageView.image?.jpegData(compressionQuality: 0.5)
        picture.setValue(imageData, forKey: "image")
        
        do {
            try managedContext.save()
            print("Success")
        } catch {
            print("Error")
        }
        
        self.navigationController?.popViewController(animated: true)
    }
}
