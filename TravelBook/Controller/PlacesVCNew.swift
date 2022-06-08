//
//  PlacesVCNew.swift
//  TravelBook
//
//  Created by Sinan Tanrıkut on 4.06.2022.
//

import UIKit

class PlacesVCNew: UIViewController, UITabBarDelegate, UITableViewDataSource, UITableViewDelegate{
  
    var categoryid:Category!
    var bannerText:String!
    var bannerImg:String!
    @IBOutlet weak var placetable: UITableView!
    @IBOutlet weak var banimg: UIImageView!
    @IBOutlet weak var bannerLbl: UILabel!
    @IBOutlet weak var bannerimage: UILabel!
    private(set) public var places = [Places]()
    override func viewDidLoad() {
        super.viewDidLoad()
        bannerLbl.text = bannerText
        placetable.delegate = self
        placetable.dataSource = self
        banimg.image = UIImage(named: bannerImg)
        // Do any additional setup after loading the view.
    }
    

    
    func initPlace(category:Category){
        places = DataService.instance.getPlaces(forCategoryTitle: category.title)
    
        bannerText = category.title
        bannerImg = category.imageName
        categoryid = category.self
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
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let place = places[indexPath.row]
        performSegue(withIdentifier: PLACES_TO_DETAIL, sender: place)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let placeDetailVC = segue.destination as? PlaceDetailVC{
            placeDetailVC.initPlacedetail(place: sender as! Places)
            placeDetailVC.initPlaceCategory(category: categoryid!)
        }
    }
    
    
}
