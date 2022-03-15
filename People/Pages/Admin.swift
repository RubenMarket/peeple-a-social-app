//
//  AdminPage.swift
//  People
//
//  Created by Ruben Mercado on 9/12/20.
//  Copyright © 2020 A Sirius Company. All rights reserved.
//

import UIKit
 

class AdminPage: UIViewController {
//let storiesRef = databaseRef.child("Posts")
//    let blockedRef = databaseRef.child("BlockedUsers").child("BlockedBy")
    private var postkeys : [String] = []
    private var keepers:[String] = []
    private var blockees:[String] = []
    
    @IBAction func removeoldposts(_ sender: UIButton) {
//        if let count = messages?.count {
//            if count >= 100 {
//                let range = count / 2
//                if let delete = self.messages?[range...] {
//                try! realm.write({
//                    realm.delete(delete)
//                })
//                }
//            }
//        }
            }
    @IBAction func showmostblocked(_ sender: UIButton) {
           
                 
               }
    
    @IBAction func entermodmode(_ sender: UIButton) {
//        peeple.modmode = true
          
        }
            
    @IBAction func out(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
//        databaseRef = Database.database().reference()
//
//        storiesRef.observeSingleEvent(of: .value, with: { (snapshot) in
//                        for child in snapshot.children {
//                            let childSnapshot = child as! DataSnapshot
//                         self.postkeys.append(childSnapshot.key)
//                        }
//
//            self.keepers = self.postkeys.reversed()
//            print(self.keepers)
//            if self.keepers.count > 42 {
//                self.keepers.removeSubrange(0...41)
//
//                        }
//                    })
//
//        blockedRef.observeSingleEvent(of: .value, with: { (snapshot) in
//            for child in snapshot.children {
//
//                if let childSnapshot = child as? DataSnapshot {
//                print(childSnapshot)
//                }
//            }
//
//        })
//
//    }
//
    }
}
