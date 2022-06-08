//
//  FavoritePlaceCV.swift
//  TravelBook
//
//  Created by Sinan Tanrıkut on 7.06.2022.
//

import UIKit
import Firebase
import FirebaseDatabase

class FavoritePlaceCV: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var buttomtab: UITabBarItem!
    private var placeData = [FavoritePlace]()
    var ref: DatabaseReference!
 
    

    @IBOutlet weak var placeTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
   
        
        
        placeTable.dataSource = self
        placeTable.delegate = self
        fetchObject()
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return placeData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: FAVORITE_PLACE_ID, for: indexPath) as? FavoriteCell{
            let place = placeData[indexPath.row]
            cell.updateViews(favorite: place)
            return cell
        } else{
        return FavoriteCell()
        }
    }
    
    
    func fetchObject(){
      
        let refDB = Database.database().reference(withPath: "Rating")
        guard let uid = Auth.auth().currentUser?.uid else {return}
        
        refDB.child(uid).queryOrdered(byChild: "Rating").observeSingleEvent(of: .value) { snapshot in
            self.placeData.removeAll()
            for child in snapshot.children.allObjects as! [DataSnapshot] {
                if let Obj = child.value as? [String:Any], let category = Obj["categoryTitle"] as? String, let rating = Obj["Rating"] as? Double, let userid = Obj["uid"] as? String, let placeTitle = Obj["placeTitle"] as? String, let ImageName = Obj["ImageName"] as? String{
                    if rating >= 4.0{
                        
                        
                        
                    let ratings = FavoritePlace(PlaceName: placeTitle, CategoryName: category, uid: userid, rating: rating, imageName: ImageName)
                    self.placeData.append(ratings)
                        print(self.placeData)}
                  
                }
                self.placeTable.reloadData()
            }
        }
        
        
        
        
    }
    
    
    


}
