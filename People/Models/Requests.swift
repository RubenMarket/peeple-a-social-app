//
//  directmessage.swift
//  People
//
//  Created by Ruben Mercado on 5/7/19.
//  Copyright © 2019 Sirius Awe. All rights reserved.
//

import Foundation
import RealmSwift

class request: Object {
    @Persisted var pic:String = ""
    @Persisted var name: String = ""
    @Persisted var one:Int = 0
    @Persisted var two:Int = 0
    @Persisted var three:Int = 0
    @Persisted var color:Int = 0
    @Persisted(primaryKey: true) var _id:String = ""
    
    convenience init(color:Int,name:String,pic:String,one:Int,two:Int,three:Int,_id:String) {
    self.init()
        self.color = color
        self.pic = pic
        self.name = name
        self.one = one
        self.two = two
        self.three = three
        self._id = _id
    }
    
}
