//
//  CommentVC.swift
//  TravelBook
//
//  Created by Sinan Tanrıkut on 4.06.2022.
//

import UIKit
import Firebase
import FirebaseDatabase

class CommentVC: UIViewController,UITableViewDataSource, UITableViewDelegate {

    private var commentData = [Commentstruct]()
    var ref: DatabaseReference!
    var categorytitle:String!
    var placetitle:String!
    @IBOutlet weak var commentTable: UITableView!
    @IBOutlet weak var textField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commentTable.dataSource = self
        commentTable.delegate = self
        
        // Do any additional setup after loading the view.
      
      fetchObject()
        
    }
  
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return commentData.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: PLACES_TO_COMMENT_ID, for: indexPath) as? CommentCell{
            let comment = commentData[indexPath.row]
            cell.updateViews(comments: comment)
            return cell
        } else{
        return CommentCell()
        }
    }
    
    func initPlaceCategory(category:Category){
        categorytitle = category.title
    }
    func initPlacedetail(place:Places){
        placetitle = place.title
        
    }
    
    
    @IBAction func yorumYap(_ sender: Any) {
 
        ref = Database.database().reference(withPath: "Yorumlar")
        ref.child(categorytitle!).child(placetitle!).childByAutoId().setValue(["uid" : Auth.auth().currentUser?.displayName, "Comment" : textField.text! ])
        
        // Create new Alert
        let dialogMessage = UIAlertController(title: "İşlem Başarılı", message: "Yorum başarılı bir şekilde eklendi.", preferredStyle: .alert)
        
        // Create OK button with action handler
        let ok = UIAlertAction(title: "Tamam", style: .default, handler: { (action) -> Void in
           // print("Ok button tapped")
         })
        
        //Add OK button to a dialog message
        dialogMessage.addAction(ok)
        // Present Alert to
        self.present(dialogMessage, animated: true, completion: nil)
       
        
    }
    

    func fetchObject(){
      
        let refDB = Database.database().reference(withPath: "Yorumlar")
         
         refDB.child(categorytitle!).child(placetitle!).observe(.value) { snapshot in
             if snapshot.childrenCount > 0 {
                 self.commentData.removeAll()
                 for comments in snapshot.children.allObjects as! [DataSnapshot] {
                     
                     //Verinin geldiğinden emin oluyoruz
                     if let commentObject = comments.value as? [String:Any], let uid = commentObject["uid"] as? String, let comment = commentObject["Comment"] as? String{
                         //Yeni bir yorum objesi oluşturuyoruz
                         let comments = Commentstruct(uid: uid, comment: comment)
                         self.commentData.append(comments)
                       
                     }
                     
                 }
                 self.commentTable.reloadData()
             }
         }
       
        
    }
    
}
