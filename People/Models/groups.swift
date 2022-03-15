//
//  groups.swift
//  People
//
//  Created by Ruben Mercado on 2/25/20.
//  Copyright © 2020 Sirius Awe. All rights reserved.
//

import Foundation
import Firebase
import FirebaseStorage
import FirebaseDatabase
import FirebaseAuth
//class peeplegroups {
//
//    var groupname: String = ""
//    var groupdes: String = ""
//    var userid: String = ""
//    var groupimage: String = ""
//    var groupkey: String = ""
//    var key : String = ""
//    let ref: DatabaseReference!
//
//    init(groupname: String, groupdes: String, userid: String, groupimage: String,groupkey: String) {
//        self.groupname = groupname
//        self.groupdes = groupdes
//        self.userid = userid
//        self.groupimage = groupimage
//        self.groupkey = groupkey
//        ref = Database.database().reference().child("PeepleGroups").childByAutoId()
//        self.key = ref.key!
//    }
//
//    init(snapshot: DataSnapshot)
//    {
//        ref = snapshot.ref
//        key = ref.key!
//        if let value = snapshot.value as? [String : Any] {
//
//            groupname = value["Group Name"] as! String
//            groupdes = value["Description"] as! String
//
//            if value["Group Maker"] as? String != nil {
//            userid = value["Group Maker"] as! String
//            }
//
//            if value["Group Image"] as? String != nil {
//            groupimage = value["Group Image"] as! String
//            }
//            if value["Group Key"] as? String != nil {
//            groupkey = value["Group Key"] as! String
//            }
//
//        }else{
//            print("no group")
//        }
//    }
//    deinit {
//      print("Deallocating Story Group at \(groupname)")
//    }
//
//    func save(completion: @escaping (Bool)-> Void) {
//        ref.setValue(toDictionary()) { (error, ref) in
//
//            completion(true)
//
//        }
//
//    }
//
//    func toDictionary() -> [String : Any]
//    {
//        return [
//            "Group Name" : groupname,
//            "Description" : groupdes,
//            "Group Maker" : userid,
//            "Group Image" : groupimage,
//            "Group Key" : groupkey
//
//        ]
//    }
//
//
//
//
//}
