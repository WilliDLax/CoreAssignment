//
//  PaintingDetailsController.swift
//  CoreAssignment
//
//  Created by Wema Bank on 20/12/2021.
//

import UIKit

class PaintingDetailsController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageNameLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    
    var imageName = ""
    var artist = ""
    var year = ""
    var image = UIImage(named: "addimage")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Picture Details"

        imageNameLabel.text = imageName
        artistLabel.text = artist
        yearLabel.text = year
        imageView.image = image
    }

}
