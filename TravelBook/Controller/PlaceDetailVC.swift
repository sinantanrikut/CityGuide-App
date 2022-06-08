//
//  PlaceDetailVC.swift
//  TravelBook
//
//  Created by Sinan Tanrıkut on 4.06.2022.
//

import UIKit
import Cosmos
import TinyConstraints
import Firebase
import FirebaseDatabase


class PlaceDetailVC: UIViewController {
    
    
    private var ratingData:RatingStruct!
    var categoryTitle:String!
    private(set) public var places = [Places]()
    var ref: DatabaseReference!
    var ucret:String!
    var calismasaatleri:String!
    var aciklama:String!
    var baslik:String!
    var resim:String!
    var categoryid:Category!
    @IBOutlet weak var ratingView: CosmosView!
    var placeid:Places!
    
    @IBOutlet weak var placePricing: UILabel!
    @IBOutlet weak var placeWorking: UILabel!
    @IBOutlet weak var placeDesc: UILabel!
    @IBOutlet weak var placeTitle: UILabel!
    @IBOutlet weak var placeImage: UIImageView!
    override func viewDidLoad() {
        
      
        fetchObject()
  
        
        
        ratingView.didFinishTouchingCosmos = { rating in
           
           
    
            guard let uid = Auth.auth().currentUser?.uid else {return}
       //     guard let displayName = Auth.auth().currentUser?.displayName else {return}
            self.ref = Database.database().reference(withPath: "Rating")
            self.ref.child(uid).child(self.baslik!).setValue(["uid" : uid, "Rating" : rating, "categoryTitle" : self.categoryTitle!, "placeTitle" : self.baslik!, "ImageName" : self.resim! ])
            
            // Create new Alert
            let dialogMessage = UIAlertController(title: "İşlem Başarılı", message: "Rating başarılı bir şekilde eklendi.", preferredStyle: .alert)
            
            // Create OK button with action handler
            let ok = UIAlertAction(title: "Tamam", style: .default, handler: { (action) -> Void in
               // print("Ok button tapped")
             })
            
            //Add OK button to a dialog message
            dialogMessage.addAction(ok)
            // Present Alert to
            self.present(dialogMessage, animated: true, completion: nil)
           
            
            
            
        }
 
        
        super.viewDidLoad()

        placeTitle.text = baslik
        placeWorking.text = "Çalışma Saatleri: " + calismasaatleri
        placeDesc.text = aciklama
        placePricing.text = "Ücreti: " + ucret
        placeImage.image = UIImage(named: resim)
        // Do any additional setup after loading the view.
    }
    
    func initPlacedetail(place:Places){
     
        ucret = place.price
        calismasaatleri = place.workingHours
        aciklama = place.description
        baslik = place.title
        resim = place.imageName
        placeid = place.self
        
     
        
        
        
    }
    func initPlaceCategory(category:Category){
        self.categoryTitle = category.title
        categoryid = category.self
    }
    
    @IBAction func commentClicked(_ sender: Any) {
        performSegue(withIdentifier: DETAIL_TO_COMMENT, sender: nil)
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let commentVC = segue.destination as? CommentVC{
            commentVC.initPlaceCategory(category: categoryid)
            commentVC.initPlacedetail(place: placeid)
        }
    }
    
    
    func fetchObject(){
      
        let refDB = Database.database().reference(withPath: "Rating")
        guard let uid = Auth.auth().currentUser?.uid else {return}
        

        refDB.child(uid).child(self.categoryTitle!).child(self.baslik!).observeSingleEvent(of: .value) { snapshot in
            
            if let value = snapshot.value as? [String: Any]{
                let uid = value["uid"] as? String ?? ""
                let rating = value["Rating"] as? Double ?? 1.0
                let ratings = RatingStruct(uid: uid, rating: rating)
                self.ratingData =  ratings.self

                self.ratingView.rating = self.ratingData.rating

            }
                
        }
    }
    
    
    
    
   

}
