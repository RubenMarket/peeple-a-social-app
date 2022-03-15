//
//  topgroups.swift
//  People
//
//  Created by Ruben Mercado on 3/11/19.
//  Copyright © 2019 Sirius Awe. All rights reserved.
//

import Foundation
import Firebase
import FirebaseStorage
import FirebaseDatabase
import FirebaseAuth
class topgroups {
    
    var groupname: String = ""
    var groupkey: String = ""
    
    
    let ref: DatabaseReference!
    
    init(groupname: String,groupkey: String ){
        self.groupname = groupname
        self.groupkey = groupkey
        
        ref = Database.database().reference().child("TopGroups")
    }
    
    init(snapshot: DataSnapshot)
    {
        ref = snapshot.ref
        if let value = snapshot.value as? [String : Any] {
            
            groupname = value["Group Name"] as! String
           groupkey = value["Group Key"] as! String
            
            
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
            "Group Key" : groupkey
            
        ]
    }
    
    
    
    
}

