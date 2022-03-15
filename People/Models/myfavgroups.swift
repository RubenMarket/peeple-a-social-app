//
//  myfavgroups.swift
//  People
//
//  Created by Ruben Mercado on 3/21/19.
//  Copyright © 2019 Sirius Awe. All rights reserved.
//

import Foundation
import Firebase
import FirebaseStorage
import FirebaseDatabase
import FirebaseAuth

class favgroups {
    var groupname: String = ""
    var groupdes: String = ""
    var groupim: String = ""
    var key: String = ""
    var groupkey : String = ""
    let ref: DatabaseReference!
    
    init(groupname: String, groupim: String, groupdes: String,groupkey : String) {
        self.groupname = groupname
        self.groupim = groupim
        self.groupdes = groupdes
        self.groupkey = groupkey
        ref = Database.database().reference().child("peoplesgroups").child(Auth.auth().currentUser!.uid).childByAutoId()
        self.key = ref.key!
    }
    
    init(snapshot: DataSnapshot)
    {
        ref = snapshot.ref
        key = ref.key!
        if let value = snapshot.value as? [String : Any] {
            
           
            groupname = value["Group Name"] as! String
            if value["Group Image"] as? String != nil {
                groupim = value["Group Image"] as! String
            }
            
            if value["Group Description"] as? String != nil {
                groupdes = value["Group Description"] as! String
            }
            if value["Group Key"] as? String != nil {
                groupkey = value["Group Key"] as! String
            }
            
            
        }else{
            print("no group")
        }
        
        
        
    }

    
    func save() {
        ref.setValue(toDictionary())
        
    }
    
    func toDictionary() -> [String : Any]
    {
        return [
            "Group Name" : groupname,
            "Group Image" : groupim,
            "Group Description" : groupdes,
            "Key" : key,
            "Group Key" : groupkey
            
        ]
    }
    
    
    
    
}
    

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

