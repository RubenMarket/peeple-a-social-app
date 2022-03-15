//
//  search.swift
//  People
//
//  Created by Ruben Mercado on 12/19/18.
//  Copyright © 2018 Sirius Awe. All rights reserved.
//

import Foundation
import Firebase
import FirebaseStorage
import FirebaseDatabase
import FirebaseAuth
class Search
{
    var fullname : String = ""
    var bio : String = ""
    var uid : String = ""
    var oniminiapp : Int = 0
    var twominiapp : Int = 0
    var threeminiapp : Int = 0
    var photo: String = ""
    var bizz : String = ""
    
    
    let ref: DatabaseReference!
    
    init(name: String, bio: String, onemini: Int, twomini : Int, threemini: Int, photo: String,uid:String,bizz: String) {
        self.bio = bio
        self.fullname = name
       self.oniminiapp = onemini
        self.twominiapp = twomini
        self.threeminiapp = threemini
        self.photo = photo
        self.uid = uid
        self.bizz = bizz
        ref = Database.database().reference().child("ProfileInfo")
        
    }
    deinit {
      print("Deallocating Search Feed for \(fullname)")
    }
    
    init(snapshot: DataSnapshot)
    {
        ref = snapshot.ref
        if let value = snapshot.value as? [String : Any] {
            
           
            if value["Full Name"] as? String != nil {
                fullname = value["Full Name"] as! String
                
                
            }
            
            
            uid = snapshot.key
            
            if value["FirstPeep"] as? Int != nil {
                
                oniminiapp = value["FirstPeep"] as! Int
              
                
                
            }
            if value["Bussiness?"] as? String != nil {
                          
                          bizz = value["Bussiness?"] as! String
                        
                          
                          
                      }
            if value["SecondPeep"] as? Int != nil {
                
                
                twominiapp = value["SecondPeep"] as! Int
               
                
                
            }
            if value["ThirdPeep"] as? String != nil {
                
              
                threeminiapp = value["ThirdPeep"] as! Int
                
                
            }
            
            
            
            if value["Bio"] as? String != nil {
                
                bio = value["Bio"] as! String
                
            }
                
                
                
            if value["ProfilePic"] as? String != nil {
                
                
                photo = value["ProfilePic"] as! String
                
                
                
                
                
                
                
            }
                
            
            
                
            
                
            
            
            
            
        }else{
            print("no name and bio")
        }
//        if let userid = snapshot.key as? String {
//            
//            uid = userid 
//            
//            
//            
//            
//            
//        }


    }
    
    
    
    
}
