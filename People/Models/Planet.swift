//
//  Story.swift
//  People
//
//  Created by Ruben Mercado on 7/22/18.
//  Copyright © 2018 Sirius Awe. All rights reserved.
//

import Foundation
import RealmSwift

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
