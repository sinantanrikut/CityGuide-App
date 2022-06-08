//
//  LoginVC.swift
//  TravelBook
//
//  Created by Sinan Tanrıkut on 27.05.2022.
//

import UIKit
import Firebase

class LoginVC: UIViewController {

    @IBOutlet weak var hata: UILabel!
    @IBOutlet weak var userpass: UITextField!
    @IBOutlet weak var usermail: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        userpass.isSecureTextEntry = true
        // Do any additional setup after loading the view.
    }
    


    @IBAction func girisyapClicked(_ sender: Any) {
        
     
        Auth.auth().signIn(withEmail: usermail.text!, password: userpass.text!, completion:
                   
                   {
                   
                   user,error in
                       
                       
                    if error != nil {

              
                        
                       }
                       
                    else {
                        self.performSegue(withIdentifier: LOGIN_TO_HOME, sender: self)
                       
                        

                       }
                       
               })
      
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == LOGIN_TO_HOME{
            let homeVC = segue.destination
            homeVC.modalPresentationStyle = .fullScreen
        }}
    
    }
   

