//
//  Story.swift
//  People
//
//  Created by Ruben Mercado on 7/22/18.
//  Copyright © 2018 Sirius Awe. All rights reserved.
//

import Foundation
import RealmSwift

class Events:Object {
    @Persisted var color: Int = 0
    @Persisted var peepOne: Int = 0
    @Persisted var peepTwo: Int = 0
    @Persisted var peepThree: Int = 0
    @Persisted var eventDuration: Int = 0
    @Persisted var lat: Double = 0
    @Persisted var long: Double = 0
    @Persisted var eventDes: String = ""
    @Persisted var eventName: String = ""
    @Persisted var timeCode : Date = Date()
    @Persisted var isBiz: Bool?
    @Persisted var userId : String = ""
    @Persisted(primaryKey: true) var _id : String
    
    convenience init(eventName:String,color:Int,peepOne:Int,peepTwo:Int,peepThree:Int,eventDuration:Int,lat:Double,long:Double, eventDes: String, userId: String,isBiz:Bool?,_id:String,timeCode:Date) {
    self.init()
        self.eventName = eventName
        self.color = color
        self.peepOne = peepOne
        self.peepTwo = peepTwo
        self.peepThree = peepThree
        self.eventDuration = eventDuration
        self.lat = lat
        self.long = long
        self.eventDes = eventDes
        self.userId = userId
        self._id = _id
        self.timeCode = timeCode
        self.isBiz = isBiz
    }
    
    
}

class earthFeed: Object {
    @Persisted var text: String = ""
    @Persisted var name: String = ""
    @Persisted var time: String = ""
    @Persisted var imgeurl: String = ""
    @Persisted var peepone: Int = 0
    @Persisted var peeptwo: Int = 0
    @Persisted var peepthree: Int = 0
    @Persisted var color: Int = 0
    @Persisted var biz: Bool = false
    @Persisted var peep: Int = 0
    @Persisted var lotag: String?
    @Persisted var userID: String = ""
    @Persisted(primaryKey: true) var _id:String = ""
    
    convenience init(text: String, name: String, time: String, imgeurl: String, peepone:Int, peeptwo:Int, peepthree:Int, color:Int, biz: Bool, peep: Int, lotag: String?,userID:String,_id:String) {
        self.init()
        self.text = text
        self.name = name
        self.time = time
        self.imgeurl = imgeurl
        self.peepone = peepone
        self.peeptwo = peeptwo
        self.peepthree = peepthree
        self.color = color
        self.biz = biz
        self.peep = peep
        self.lotag = lotag
        self.userID = userID
        self._id = _id
    }
    
    deinit {
        print("Deallocating Story Feed at \(time)")
    }
}
