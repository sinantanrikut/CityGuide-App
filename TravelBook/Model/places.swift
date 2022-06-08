//
//  places.swift
//  TravelBook
//
//  Created by Sinan Tanrıkut on 3.06.2022.
//

import Foundation


// Places entity
struct Places{
    private(set) public var title:String
    private(set) public var imageName:String
    private(set) public var description:String
    private(set) public var price:String
    private(set) public var workingHours:String

    
    init(title:String, imageName:String, description:String, price:String, workingHours:String){
        self.title = title
        self.imageName = imageName
        self.description = description
        self.price = price
        self .workingHours = workingHours
    }
}
