//
//  clearstories.swift
//  People
//
//  Created by Ruben Mercado on 2/14/20.
//  Copyright © 2020 Sirius Awe. All rights reserved.
//

import Foundation
import Firebase
class clearStory
{
    var text: String = ""
    var name: String = ""
    var timestamp: String = ""
    var imgeurl: String = ""
    var onemini: Int = 0
    var twomini: Int = 0
    var threemini: Int = 0
    var profpic: String = ""
    var user: String = ""
    var bussiness: String = ""
    var event: Int = 0
    var peep: Int = 0
    var lotag: String = ""
    
//    var ID:String?
    
    let ref: DatabaseReference!
    
    init(text: String, name: String, timestamp: String, imgeurl: String, onemini:Int, twomini:Int, threeemini:Int, profpic:String, user:String , bussiness: String, event: Int, peep: Int, lotag: String) {
        self.text = text
       self.name = name
        self.timestamp = timestamp
        self.imgeurl = imgeurl
       self.onemini = onemini
        self.twomini = twomini
        self.threemini = threeemini
        self.profpic = profpic
        self.user = user
        self.bussiness = bussiness
        self.event = event
        self.peep = peep
        self.lotag = lotag
        
        ref = Database.database().reference().child("Posts").childByAutoId()
        
    }
    
    deinit {
      print("Deallocating Story Feed at \(timestamp)")
    }
   
    
    init(snapshot: DataSnapshot)
    {
        
       
        
       ref = snapshot.ref
        
        
        if let value = snapshot.value as? [String : Any] {
            
            name = value["Name"] as! String
            text = value["Post"] as! String
            timestamp = value["Time"] as! String
            imgeurl = value["Image"] as! String
                
            if value["firstminiapp"] as? Int != nil {
            onemini = value["firstminiapp"] as! Int
            }
               if value["Secondminiapp"] as? Int != nil {
            twomini = value["Secondminiapp"] as! Int
            }
            if value["Thirdminiapp"] as? Int != nil {
            threemini = value["Thirdminiapp"] as! Int
            }
            
            
            user = value["user"] as! String
            
                 profpic = value["Profile picture"] as! String
            
            if value["Bussiness?"] as? String != nil {
            
            bussiness = value["Bussiness?"] as! String
                
            
            }
                
            if value["Event"] as? Int != nil {
                
                
                event = value["Event"] as! Int
                
            }
//
            if value["Peep"] as? Int != nil {
                
                
                peep = value["Peep"] as! Int
                
                
                
            }
            if value["lotag"] as? String != nil {
                
                lotag = value["lotag"] as! String
                
                
                
            }
            
            
            
          
        }else{
            print("no stories here")
        }
    }
    
        func save() {
       ref.setValue(toDictionary())
            
    }
    
    func toDictionary() -> [String : Any]
    {
        return [
            "Post" : text,
            "Name" : name,
            "Time" : timestamp,
            "Image" : imgeurl,
            "firstminiapp" : onemini,
            "Secondminiapp" : twomini,
            "Thirdminiapp" : threemini,
            "Profile picture" : profpic,
            "user" : user,
            "Bussiness?" : bussiness,
            "Event" : event,
            "Peep" : peep,
            "lotag" : lotag

        ]
    }
}
