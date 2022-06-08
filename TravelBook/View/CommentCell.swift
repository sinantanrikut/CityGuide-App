//
//  CommentCell.swift
//  TravelBook
//
//  Created by Sinan Tanrıkut on 5.06.2022.
//

import UIKit

class CommentCell: UITableViewCell {

    @IBOutlet weak var commentLbl: UILabel!
    
    @IBOutlet weak var userLbl: UILabel!
    
    func updateViews(comments :Commentstruct){
        commentLbl.text = comments.comment
        userLbl.text = comments.uid
    }
   
    
}
