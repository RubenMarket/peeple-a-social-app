//
//  group.swift
//  People
//
//  Created by Ruben Mercado on 1/1/19.
//  Copyright © 2019 Sirius Awe. All rights reserved.
//

import Foundation
import RealmSwift

class allGroups:Object {
    @Persisted var name: String = ""
    @Persisted var image: String = ""
    @Persisted var des: String = ""
    @Persisted var userId: String = ""
    @Persisted var color: Int = 0
    @Persisted var priv : Bool = false
    // location in storage after the users ID and groupimages
    @Persisted var dateMade : String = ""
    @Persisted(primaryKey: true) var _id:String = UUID().uuidString
    
    convenience init(name: String,image:String, des: String, userId: String,color:Int,priv:Bool,dateMade:String) {
        self.init()
        self.name = name
        self.image = image
        self.des = des
        self.userId = userId
        self.priv = priv
        self.dateMade = dateMade
        self.color = color
         }
    
}

class myGroups:EmbeddedObject {
    @Persisted var name: String = ""
    @Persisted var des: String = ""
    @Persisted var image: String = ""
    @Persisted var color: Int = 4
    @Persisted var userId:String =  ""
    @Persisted var key:String = ""
    
    convenience init(name: String,image:String,color:Int, des: String,userId:String,key:String) {
        self.init()
        self.name = name
        self.image = image
        self.des = des
        self.userId = userId
        self.key = key
        self.color = color
        
    }
    
}
//class topGroups:Object {
//    @Persisted var name: String = ""
//    @Persisted var image: String = ""
//    @Persisted var des: String = ""
//    @Persisted var userId: String = ""
//    @Persisted var color: Int = 0
//    @Persisted var isAd : Bool = false
//    @Persisted var dateMade : String = ""
//    @Persisted var numGroup : String = ""
//    @Persisted(primaryKey: true) var _id:String = ""
//    
//    convenience init(name: String,image:String, des: String, userId: String,color:Int,isAd:Bool,dateMade:String,numGroup:String,_id:String) {
//    self.init()
//        self.name = name
//        self.image = image
//        self.des = des
//        self.userId = userId
//        self.isAd = isAd
//        self.numGroup = numGroup
//        self._id = _id
//        self.dateMade = dateMade
//        self.color = color
//        
//    }
//    
//    
//}

class groupMessages:Object {
    @Persisted var username: String = ""
    @Persisted var image: String = ""
    @Persisted var color: Int = 0
    @Persisted var peepOne: Int = 0
    @Persisted var peepTwo: Int = 0
    @Persisted var peepThree: Int = 0
    @Persisted var lat: Double = 0
    @Persisted var long: Double = 0
    @Persisted var chatmessage: String = ""
    @Persisted var timeStamp : String = ""
    @Persisted var timeCode : TimeInterval = 0.0
    @Persisted var profPic : String = ""
    @Persisted var isBiz: Bool = false
    @Persisted var userId : String = ""
    @Persisted(primaryKey: true) var _id : String
    
    convenience init(username: String,image:String,color:Int,peepOne:Int,peepTwo:Int,peepThree:Int,lat:Double,long:Double, chatmessage: String, timeStamp : String, userId: String,profPic:String,isBiz:Bool,_id:String,timeCode:TimeInterval) {
    self.init()
        self.username = username
        self.image = image
        self.color = color
        self.peepOne = peepOne
        self.peepTwo = peepTwo
        self.peepThree = peepThree
        self.lat = lat
        self.long = long
        self.chatmessage = chatmessage
        self.timeStamp = timeStamp
        self.profPic = profPic
        self.userId = userId
        self._id = _id
        self.timeCode = timeCode
        self.isBiz = isBiz
    }
    
    
}

