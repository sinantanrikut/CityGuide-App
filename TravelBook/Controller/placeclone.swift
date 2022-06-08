//
//  PlacesVC.swift
//  TravelBook
//
//  Created by Sinan Tanrıkut on 3.06.2022.
//

import UIKit

class PlacesVC: UIViewController,UITableViewDataSource, UITableViewDelegate {
    
    var categoryTitle:String!
    @IBOutlet weak var tableview: UITableView!
   // @IBOutlet weak var categoryName: UILabel!
    
    private(set) public var places = [Places]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.delegate = self
        tableview.dataSource = self
        //bannerImage.image = UIImage(named: categoryImage)
       // categoryName.text = self.categoryTitle
        // Do any additional setup after loading the view.
    }
    
    func initPlace(category:Category){
        places = DataService.instance.getPlaces(forCategoryTitle: category.title)
        print(category)
       //print(places)
      //  categoryTitle = category.title
        //categoryImage = category.imageName

    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return places.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: PLACES_TO_CELL_ID, for: indexPath) as? PlacesCell{
            let place = places[indexPath.row]
            cell.updateViews(places: place)
            return cell
        } else{
        return PlacesCell()
        }
        
    }
    
}
