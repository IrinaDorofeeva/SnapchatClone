//
//  SelectUserViewController.swift
//  SnapchatClone
//
//  Created by Mac on 6/7/17.
//  Copyright © 2017 Mac. All rights reserved.
//

import UIKit
import FirebaseDatabase

class SelectUserViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var users: [User] = []
    var imageURL = ""
    var descrip = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        Database.database().reference().child("users").observe(DataEventType.childAdded, with: {(snapshot) in
        print(snapshot)
            
            
            let user = User()
            user.email = (snapshot.value as! NSDictionary)["email"] as! String
            
            user.uid = snapshot.key
            
            self.users.append(user)
            self.tableView.reloadData()
        })
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     return users.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = UITableViewCell()
        let user = users[indexPath.row]
        cell.textLabel?.text = user.email
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let user = users[indexPath.row]
        
       // let snap = ["email":user.email]
        let snap = ["from":user.email, "description":descrip,"imageURL":imageURL]
        Database.database().reference().child("users").child(user.uid).child("snaps").childByAutoId().setValue(snap)
    }
 

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
