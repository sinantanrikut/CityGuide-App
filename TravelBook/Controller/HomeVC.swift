//
//  HomeVC.swift
//  TravelBook
//
//  Created by Sinan Tanrıkut on 27.05.2022.
//

import UIKit
import Firebase

class HomeVC: UIViewController,UITableViewDelegate,UITableViewDataSource {
    @IBOutlet weak var favoriteImg: UIImageView!
    
    
    @IBOutlet weak var welcomeLbl: UILabel!
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return DataService.instance.getCategories().count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: CATEGORY_TO_CELL_ID) as? CategoryCell{
            let category = DataService.instance.getCategories()[indexPath.row]
            cell.updateViews(category: category)
            return cell
        } else {   return CategoryCell()
            
        }
        
        
     
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let category = DataService.instance.getCategories()[indexPath.row]
      performSegue(withIdentifier: CATEGORY_TO_PLACES, sender: category)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let placesVC = segue.destination as? PlacesVCNew{
            let barBtn = UIBarButtonItem()
            
            barBtn.title = ""
            navigationItem.backBarButtonItem = barBtn
            
            placesVC.initPlace(category: sender as! Category)
     
          //  print(sender as? Category != nil)
        }
    }

    

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {

        
 
        
       
        
        let currentUser = Auth.auth().currentUser
        if currentUser?.displayName != nil{
            
        } else{
            let changeRequest = currentUser?.createProfileChangeRequest()
            changeRequest?.displayName = "Name Undefined"
            
            changeRequest?.commitChanges(completion: { Error in
            })

        }
        super.viewDidLoad()
        favoriteImg.isUserInteractionEnabled = true
        
        let gR = UITapGestureRecognizer(target: self, action: #selector(gotofavorite))
        favoriteImg.addGestureRecognizer(gR)
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
      
        
        
        guard let user = Auth.auth().currentUser?.displayName
        else{return}
        welcomeLbl.text = "Hoşgeldin, " +  user
        
        
    }
   
    @objc func gotofavorite(){
        performSegue(withIdentifier: HOME_TO_FAVORITE, sender: nil)
        //dprint("deneme")
    }
   
    
}
