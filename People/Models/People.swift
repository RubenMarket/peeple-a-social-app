//
//  people.swift
//  People
//
//  Created by Ruben Mercado on 2/17/20.
//  Copyright © 2020 Sirius Awe. All rights reserved.
//

import Foundation
import RealmSwift

enum TaskStatus: String {
  case Open
  case InProgress
  case Complete
}
//class topPeople: Object {
//    @Persisted var image:String = ""
//    @Persisted var color:Int = 0
//    @Persisted var name: String = ""
//    @Persisted var ID: String = ""
//    @Persisted var one = 0
//    @Persisted var two = 0
//    @Persisted var three = 0
//    @Persisted var priv:Bool = false
//    @Persisted var biz:Bool?
//    @Persisted(primaryKey: true) var _id:Int = 0
//    convenience init(color:Int ,image:String, name:String, biz:Bool?,one : Int, two: Int, three: Int,ID: String,priv:Bool,numberPerson:Int) {
//         self.init()
//        self.color = color
//        self.name = name
//        self.biz = biz
//        self.one = one
//        self.two = two
//        self.three = three
//        self.ID = ID
//        self.image = image
//        self.priv = priv
//        self._id = numberPerson
//        
//    }
//
class allPeople: Object {
    @Persisted var image:String = ""
    @Persisted var color:Int = 0
    @Persisted var name: String = ""
    @Persisted var ID: String = ""
    @Persisted var peepOne:Int = 1
    @Persisted var peepTwo:Int = 2
    @Persisted var peepThree:Int = 3
    @Persisted var biz:Bool?
    @Persisted var priv:Bool = false
    @Persisted(primaryKey: true) var _id:String = UUID().uuidString
    convenience init(color:Int ,image:String, name:String,peepOne:Int,peepTwo:Int,peepThree:Int, biz:Bool?, bio:String,priv: Bool,ID : String) {
        self.init()
        self.color = color
        self.name = name
        self.biz = biz
        self.image = image
        self.peepOne = peepOne
        self.peepTwo = peepTwo
        self.peepThree = peepThree
        self.priv = priv
        self.ID = ID
    }
}
class mePerson: Object {
    @Persisted var name: String = ""
    @Persisted var peepOne:Int = 1
    @Persisted var peepTwo:Int = 2
    @Persisted var peepThree:Int = 3
    @Persisted var biz:Bool?
    @Persisted var priv:Bool = false
    @Persisted var myGroups : List<myGroups>
    @Persisted var myPeople : List<myPeople>
    @Persisted(primaryKey: true) var _id:String = ""
    convenience init(name:String,biz:Bool?,peepOne:Int,peepTwo:Int,peepThree:Int,priv:Bool,beta:Bool,_id:String) {
        self.init()
        self.name = name
        self.biz = biz
        self.peepOne = peepOne
        self.peepTwo = peepTwo
        self.peepThree = peepThree
        self.priv = priv
        self._id = _id
    }
    convenience init(myGroups: [myGroups]) {
        self.init()
        self.myGroups.append(objectsIn: myGroups)
    }
    convenience init(myPeople: [myPeople]) {
        self.init()
        self.myPeople.append(objectsIn: myPeople)
    }
}
class myPeople:EmbeddedObject {
    @Persisted var color:Int = 4
    @Persisted var name: String = ""
    @Persisted var image:String = ""
    @Persisted var bio:String = ""
    @Persisted var peepOne:Int = 1
    @Persisted var peepTwo:Int = 2
    @Persisted var peepThree:Int = 3
    @Persisted var _id:String = ""
    convenience init(color:Int,image:String,name:String,bio:String,peepOne:Int,peepTwo:Int,peepThree:Int,_id:String) {
    self.init()
        self.color = color
        self.name = name
        self.image = image
        self.peepOne = peepOne
        self.peepTwo = peepTwo
        self.peepThree = peepThree
        self.bio = bio
        self._id = _id
    }
    
}
