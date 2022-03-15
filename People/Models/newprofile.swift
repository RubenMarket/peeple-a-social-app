//
//  newprofile.swift
//  People
//
//  Created by Ruben Mercado on 8/12/19.
//  Copyright © 2019 Sirius Awe. All rights reserved.
//

import Foundation
import Firebase
import FirebaseStorage
import FirebaseDatabase
import FirebaseAuth
class newprofile {
    
    var pic:String = ""
    var name: String = ""
    var bio:String = ""
    var beta = "ya"
    var one = 0
    var two = 0
    var three = 0
    var biz:String = ""
    let ref: DatabaseReference!
    
//    var id = ""
    init(pic:String , name:String, biz:String = "", bio:String, beta: String = "ya",one : Int, two: Int, three: Int) {
         self.pic = pic
        self.name = name
        self.biz = biz
        self.one = one
        self.two = two
        self.three = three
        self.bio = bio
        self.beta = beta
        ref = Database.database().reference().child("ProfileInfo").child(Auth.auth().currentUser!.uid)
        
    }
    
    
    
    init(snapshot: DataSnapshot)
    {
        ref = snapshot.ref
        if let value = snapshot.value as? [String : Any] {
            
           name = value["name"] as! String
           pic = value["pic"] as! String
            biz = value["biz"] as! String
           
            if value["bio"] as? String != "" {
                bio = value["bio"] as! String
            }
            if value["peepone"] as? Int != 0 {
                
                one = value["peepone"] as! Int
            }
         
if value["peeptwo"] as? Int != 0 {
               
               two = value["peeptwo"] as! Int
           }
            if value["peepthree"] as? Int != 0 {
                           
                           one = value["peepthree"] as! Int
                       }
//
            if value["beta"] as? String != "" {
                
                
                beta = value["beta"] as! String
            }
            
            
            
            
            
            
            
            
        }else{
            print("no group")
        }
    }
    
    func save(completion: @escaping (Bool)-> Void) {
        ref.setValue(toDictionary()) { (error, ref) in
            
            completion(true)
            
        }
        
    }
    
    func toDictionary() -> [String : Any]
    {
        return [
            "name" : name,
            "pic" : pic,
            "biz" : biz as Any,
            "bio" : bio,
            "beta" : beta as Any,
            "peepone" : one,
            "peeptwo" : two,
            "peepthree" : three
        ]
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
