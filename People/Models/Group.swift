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
    @Persisted var dateMade : Date?
    @Persisted(primaryKey: true) var _id:String = ""
    
    convenience init(name: String,image:String, des: String, userId: String,color:Int,priv:Bool,dateMade:Date,ID:String) {
        self.init()
        self.name = name
        self.image = image
        self.des = des
        self.userId = userId
        self.priv = priv
        self.dateMade = dateMade
        self.color = color
        self._id = ID
         }
    
}

class myGroups:EmbeddedObject {
    @Persisted var name: String = ""
    @Persisted var des: String = ""
    @Persisted var image: String = ""
    @Persisted var color: Int = 3
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

class groupMessagesV2:Object {
    @Persisted var color: Int = 0
    @Persisted var peepOne: Int = 0
    @Persisted var peepTwo: Int = 0
    @Persisted var peepThree: Int = 0
    @Persisted var eventDuration: Int = 0
    @Persisted var lat: Double = 0
    @Persisted var long: Double = 0
    @Persisted var chatMessage: String = ""
    @Persisted var chatName: String = ""
    @Persisted var timeCode : Date?
    @Persisted var isBiz: Bool?
    @Persisted var userId : String = ""
    @Persisted(primaryKey: true) var _id : String
    
    convenience init(chatName:String,color:Int,peepOne:Int,peepTwo:Int,peepThree:Int,eventDuration:Int,lat:Double,long:Double, chatMessage: String, userId: String,isBiz:Bool?,_id:String,timeCode:Date) {
    self.init()
        self.chatName = chatName
        self.color = color
        self.peepOne = peepOne
        self.peepTwo = peepTwo
        self.peepThree = peepThree
        self.eventDuration = eventDuration
        self.lat = lat
        self.long = long
        self.chatMessage = chatMessage
        self.userId = userId
        self._id = _id
        self.timeCode = timeCode
        self.isBiz = isBiz
    }
    
    
}

