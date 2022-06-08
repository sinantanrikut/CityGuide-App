//
//  ViewController.swift
//  TravelBook
//
//  Created by Sinan Tanrıkut on 27.05.2022.
//

import UIKit
import Firebase

class LandingpageVC: UIViewController {

    
    
  
    @IBOutlet weak var registerBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
     
                                            
        registerBtn.layer.cornerRadius = 20.0;
        // Do any additional setup after loading the view.
    }

    
    @IBAction func registerClicked(_ sender: Any) {
        performSegue(withIdentifier: LANDING_TO_REGISTER, sender: self)

    }
    
    @IBAction func loginClicked(_ sender: Any) {
        performSegue(withIdentifier: LANDING_TO_LOGIN, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == LANDING_TO_REGISTER {
            guard segue.destination is RegisterVC else {return}
        

        }
        
        if segue.identifier == LANDING_TO_LOGIN {
            guard segue.destination is LoginVC else {return}
        

        }
    }

}

