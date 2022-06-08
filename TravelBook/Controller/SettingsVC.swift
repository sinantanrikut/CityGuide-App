//
//  SettingsVC.swift
//  TravelBook
//
//  Created by Sinan Tanrıkut on 28.05.2022.
//

import UIKit
import Firebase

class SettingsVC: UIViewController {

    @IBOutlet weak var nameLbl: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLbl.text = Auth.auth().currentUser?.displayName
        // Do any additional setup after loading the view.
    }
    
    @IBAction func Logout(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            performSegue(withIdentifier: "logout", sender: self)
            
        }catch {
            print("error")
        }
    }
 
   
    
override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "logout"{
        let LandingpageVC = segue.destination
        LandingpageVC.modalPresentationStyle = .fullScreen
    }}
    
    
    
    @IBAction func updateProfile(_ sender: Any) {
        let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
        changeRequest?.displayName = nameLbl.text
        
        changeRequest?.commitChanges{ error in
            if error != nil{
             
            } else{
            
                // Create new Alert
                let dialogMessage = UIAlertController(title: "Güncelleme", message: "Ad ve Soyadınız Güncellendi", preferredStyle: .alert)
                
                // Create OK button with action handler
                let ok = UIAlertAction(title: "Tamam", style: .default, handler: { (action) -> Void in
                   // print("Ok button tapped")
                 })
                
                //Add OK button to a dialog message
                dialogMessage.addAction(ok)
                // Present Alert to
                self.present(dialogMessage, animated: true, completion: nil)
                
            }
        }
        
        
    }
    
}
