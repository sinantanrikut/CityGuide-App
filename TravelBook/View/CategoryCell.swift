//
//  CategoryCell.swift
//  TravelBook
//
//  Created by Sinan Tanrıkut on 3.06.2022.
//

import UIKit

class CategoryCell: UITableViewCell {

    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var categoryTitle: UILabel!
    
    
    func updateViews(category:Category){
        categoryImage.image = UIImage(named: category.imageName)
        categoryTitle.text = category.title
    }

}
