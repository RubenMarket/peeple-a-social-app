//
//  peeps.swift
//  People
//
//  Created by Ruben Mercado on 9/22/20.
//  Copyright © 2020 A Sirius Company. All rights reserved.
//

import Foundation
import RealmSwift

class myPeeps: Object {
    @Persisted var portflio : portflioPost?
    @Persisted var charight: charightChoice?
    @Persisted var cleanergy: cleanergyClenny?
    @Persisted var betaTester: betaTester?
    @Persisted(primaryKey: true) var _id:String = ""
    convenience init(cleanergy:cleanergyClenny, _id:String) {
        self.init()
        self._id = _id
        self.cleanergy = cleanergy
    }
    convenience init(charight:charightChoice, _id:String) {
        self.init()
        self._id = _id
        self.charight = charight
    }
    convenience init(cleanergy:cleanergyClenny,charight:charightChoice,portflio:portflioPost, _id:String) {
        self.init()
        self._id = _id
        self.cleanergy = cleanergy
        self.portflio = portflio
        self.charight = charight
    }
    convenience init(betaTester:betaTester, _id:String) {
        self.init()
        self._id = _id
        self.betaTester = betaTester
    }
    convenience init(portflio: portflioPost,_id:String) {
        self.init()
        self._id = _id
        self.portflio = portflio
    }
}
class portflioPost:EmbeddedObject {
    @Persisted var topic1 : String = ""
    @Persisted var topic2 : String = ""
    @Persisted var topic3 : String = ""
   convenience init(topic1: String,topic2: String,topic3: String) {
        self.init()
        self.topic1 = topic1
        self.topic2 = topic2
    self.topic3 = topic3
    }
     
    
}

class charightChoice:EmbeddedObject {
    @Persisted var choice1 : Int = 0
    @Persisted var choice2 : Int = 1
   convenience init(choice1: Int,choice2: Int) {
        self.init()
        self.choice1 = choice1
        self.choice2 = choice2
    }
    
}
class betaTester:EmbeddedObject {
    @Persisted var dateDownloaded : String = ""
   convenience init(dateDownloaded: String) {
        self.init()
        self.dateDownloaded = dateDownloaded
    }
    
}
class cleanergyClenny:EmbeddedObject {
    @Persisted var clearClouds : Bool = false
   convenience init(clearClouds: Bool) {
        self.init()
        self.clearClouds = clearClouds
    }
    
}
