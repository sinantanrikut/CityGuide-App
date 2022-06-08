//
//  PlacesCell.swift
//  TravelBook
//
//  Created by Sinan Tanrıkut on 3.06.2022.
//

import UIKit

class PlacesCell: UITableViewCell {


    @IBOutlet weak var labelTitle: UILabel!
    
    @IBOutlet weak var labelWorkingHours: UILabel!
    @IBOutlet weak var placeimage: UIImageView!
    
    func updateViews(places:Places){
     placeimage.image = UIImage(named: places.imageName)
        labelTitle.text = places.title
 
        labelWorkingHours.text = places.workingHours
    }

}
