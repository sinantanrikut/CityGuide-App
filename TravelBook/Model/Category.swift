//
//  Category.swift
//  TravelBook
//
//  Created by Sinan Tanrıkut on 3.06.2022.
//

import Foundation

// Category entity
struct Category{
    private(set) public var title:String // Private set public get değişken 
    private(set) public var imageName:String
    
    init(title:String,imageName:String){
        self.title = title
        self.imageName = imageName
    }

}
