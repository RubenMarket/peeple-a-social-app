//
//  peepView.swift
//  People
//
//  Created by admin on 1/28/22.
//  Copyright © 2022 A Sirius Company. All rights reserved.
//

import UIKit
import RealmSwift

class peepView: UIView {

        func loadMyPeepData(one:Int,two:Int,three:Int){
            guard let user = app.currentUser else { return }
            let thePeeps:[Int] = [one,two,three]
            let partitionValue = "peeps=\(user.id)"
            let configuration = user.configuration(partitionValue: partitionValue)
            Realm.asyncOpen(configuration: configuration) { (result) in
                switch result {
                case .failure(let error):
                    print("Failed to open realm: \(error.localizedDescription)")
                    // Handle error...
                case .success(let realm):
                    // Realm opened
                    if let peeps = realm.objects(myPeeps.self).first {
                        for Peep in thePeeps {
                            switch Peep {
                            case 1:
                                if let charight = peeps.charight {  Peeps.charight = charight }
                            case 2:
                                if let cleanergy = peeps.cleanergy {  Peeps.cleanergy = cleanergy }
                            case 3:
                                if let cleanergy = peeps.cleanergy {  Peeps.cleanergy = cleanergy }
                            default:
                                print("no peep")
    
                            }
                        }
    
                    }
    
    
                }
            }
        }
}
