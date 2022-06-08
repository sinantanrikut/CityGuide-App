//
//  FavoritePlaceCell.swift
//  TravelBook
//
//  Created by Sinan Tanrıkut on 7.06.2022.
//

import UIKit
import Cosmos
import TinyConstraints


class FavoriteCell: UITableViewCell {

    @IBOutlet weak var placeImg: UIImageView!
    
    @IBOutlet weak var placeLbl: UILabel!
    
    @IBOutlet weak var ratinf: CosmosView!
    
    func updateViews(favorite :FavoritePlace){
        
        placeImg.image = UIImage(named: favorite.imageName)
        placeLbl.text = favorite.PlaceName
        ratinf.rating = favorite.rating
        
        
    }
   
    
}
