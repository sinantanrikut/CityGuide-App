//
//  RegisterVC.swift
//  TravelBook
//
//  Created by Sinan Tanrıkut on 27.05.2022.
//

import UIKit
import Firebase
class RegisterVC: UIViewController {
    @IBOutlet weak var appleloginBtn: UIButton!
    
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var privacylabel: UILabel!
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var facebookloginBtn: UIButton!
    @IBOutlet weak var googleloginBtn: UIButton!
    
    @IBOutlet weak var mailtextField: UITextField!
    
    @IBOutlet weak var passwordtextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
registerBtn.layer.cornerRadius = 20.0;
        // Do any additional setup after loading the view.
    }
    
    

    
   
    @IBAction func kayıtolClicked(_ sender: Any) {
        
        Auth.auth().createUser(withEmail: mailtextField.text! ,password: passwordtextField.text!, completion: { user, error in
                        
                        if error != nil
                        
                        {
                            self.label1.text="basarili"
                        }
                            
                        else
                        {
                            // Create new Alert
                            let dialogMessage = UIAlertController(title: "İşlem Başarılı", message: "Kayıt başarılı bir şekilde oluşturuldu.", preferredStyle: .alert)
                            
                            // Create OK button with action handler
                            let ok = UIAlertAction(title: "Tamam", style: .default, handler: { (action) -> Void in
                               // print("Ok button tapped")
                             })
                            
                            //Add OK button to a dialog message
                            dialogMessage.addAction(ok)
                            // Present Alert to
                            self.present(dialogMessage, animated: true, completion: nil)
                            self.performSegue(withIdentifier: REGISTER_TO_LOGIN, sender: nil)
                           

                        }
        })
        
        
    }
    
}
