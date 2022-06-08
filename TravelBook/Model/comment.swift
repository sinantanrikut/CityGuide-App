//
//  comment.swift
//  TravelBook
//
//  Created by Sinan Tanrıkut on 5.06.2022.
//

import Foundation

struct Commentstruct{
    private(set) public var uid:String
    private(set) public var comment:String
   
    
    init(uid:String, comment:String){
        self.uid = uid
        self.comment = comment
   
    }
}
