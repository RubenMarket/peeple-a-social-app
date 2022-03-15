//
//  cities.swift
//  People
//
//  Created by admin on 10/6/21.
//  Copyright © 2021 A Sirius Company. All rights reserved.
//

import Foundation
import RealmSwift

class allCities:Object {
    @Persisted var name: String = ""
    @Persisted(primaryKey: true) var _id:String = ""
    
    convenience init(name: String,_id:String) {
        self.init()
        self.name = name
        self._id = _id
         }
    
}
