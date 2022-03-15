//
//  messagestome.swift
//  People
//
//  Created by Ruben Mercado on 5/13/19.
//  Copyright © 2019 Sirius Awe. All rights reserved.
//

import Foundation
import Firebase
import FirebaseStorage
import FirebaseDatabase
import FirebaseAuth
class messagestome {
    
    var name : String = ""
    var message : String = ""
    var photo : String = ""
    var timestamp : String = ""
    var userid : String = ""
    let ref: DatabaseReference!
    
    init(name: String,message: String,photo: String,timestamp : String ,userid: String) {
        
        self.name = name
        self.message = message
        self.photo = photo
        self.timestamp = timestamp
        self.userid = userid
        ref = Database.database().reference().child("DirectMessages").child(Auth.auth().currentUser!.uid).childByAutoId()
        
    }
    
    init(snapshot: DataSnapshot)
    {
        ref = snapshot.ref
        if let value = snapshot.value as? [String : Any] {
            
            name = value["Name"] as! String
            message = value["Message"] as! String
            
            
            if value["photo"] as? String != nil {
                
                
                
                photo = value["photo"] as! String
                
                
            }
            timestamp = value["timestamp"] as! String
            
            userid = value["userid"] as! String
            
        }else{
            print("no message")
        }
    }
    
    func save() {
        ref.setValue(toDictionary())
        
    }
    
    func toDictionary() -> [String : Any]
    {
        return [
            "Name" : name,
            "Message" : message,
            "photo" : photo,
            "timestamp" : timestamp,
            "userid" : userid
        ]
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
