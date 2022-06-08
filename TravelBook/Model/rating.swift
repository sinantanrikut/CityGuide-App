//
//  rating.swift
//  TravelBook
//
//  Created by Sinan Tanrıkut on 7.06.2022.
//

import Foundation


struct RatingStruct{
    private(set) public var uid:String
    private(set) public var rating:Double
   
    
    init(uid:String, rating:Double){
        self.uid = uid
        self.rating = rating
   
    }
}
