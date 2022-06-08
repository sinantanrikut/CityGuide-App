//
//  FavoritePlace.swift
//  TravelBook
//
//  Created by Sinan Tanrıkut on 8.06.2022.
//

import Foundation


// Category entity
struct FavoritePlace{
    private(set) public var PlaceName:String // Private set public get değişken
    private(set) public var CategoryName:String
    private(set) public var uid:String
    private(set) public var rating:Double
    private(set) public var imageName:String
    
    init( PlaceName:String,CategoryName:String,uid:String,rating:Double,imageName:String ){
        self.PlaceName = PlaceName
        self.CategoryName = CategoryName
        self.uid = uid
        self.rating = rating
        self.imageName = imageName
      
    }}
