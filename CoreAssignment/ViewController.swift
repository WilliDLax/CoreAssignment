//
//  ViewController.swift
//  CoreAssignment
//
//  Created by Wema Bank on 20/12/2021.
//

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var myTableView: UITableView!
    
    var pictures:[NSManagedObject] = []
    
    var imageName = ""
    var artist = ""
    var year = ""
    var image = UIImage(named: "addimage")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Pretty Pictures"
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Picture")
        
        do {
            pictures = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Error \(error), \(error.userInfo)")
        }
        
        myTableView.reloadData()
    
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pictures.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let picture = pictures[indexPath.row]
        let cell = UITableViewCell()
        cell.textLabel?.text = picture.value(forKey: "name") as? String
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if(segue.identifier == "showImageDetails"){
            let detailsController = segue.destination as! PaintingDetailsController
            
            detailsController.imageName = imageName
            detailsController.artist = artist
            detailsController.year = year
            detailsController.image = image
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let picture = pictures[indexPath.row]
        imageName = picture.value(forKey: "name") as! String
        artist = picture.value(forKey: "artist") as! String
        let yearInt = picture.value(forKey: "year") as! Int32
        year = String(yearInt)
        let imageData = picture.value(forKey: "image") as! Data
        image = UIImage(data: imageData)
        performSegue(withIdentifier: "showImageDetails", sender: nil)
    }

    @IBAction func addButton(_ sender: Any) {
        performSegue(withIdentifier: "addNewImage", sender: nil)
    }
    
}

