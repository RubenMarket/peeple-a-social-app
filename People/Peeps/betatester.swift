//
//  betatester.swift
//  People
//
//  Created by Ruben Mercado on 6/25/20.
//  Copyright © 2020 Sirius Awe. All rights reserved.
//

import UIKit
import RealmSwift

class betatester: UIView {

    @IBOutlet weak var betalabel: UILabel!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override func layoutSubviews() {
        let user = app.currentUser!
        let partitionValue = "peeps=\(Person.Selected.ID)"
        let configuration = user.configuration(partitionValue: partitionValue)
        Realm.asyncOpen(configuration: configuration) { [self] (result) in
            switch result {
            case .failure(let error):
                print("Failed to open realm: \(error.localizedDescription)")
                // Handle error...
            case .success(let realm):
                // Realm opened
                if let me = realm.objects(myPeeps.self).first {
                    if let beta = me.beta {
                        self.betalabel.text = "\(Person.Selected.ID) downloaded peeple a social app beta on \(beta.dateDownloaded)"
                    } else {
                        let times = NSDate().timeIntervalSince1970
                        let myTimeInterval = TimeInterval(times)
                        let time = NSDate(timeIntervalSince1970: TimeInterval(myTimeInterval))
                        let formatter = DateFormatter()
                        formatter.dateStyle = .medium
                        formatter.timeStyle = .short
                        let currentDateTime:String = formatter.string(from: time as Date)
                        let beta = betaTester(dateDownloaded: currentDateTime)
                        try! realm.write{
                            me.beta = beta
                        }
                        
                        self.betalabel.text = "\(Person.Selected.ID) downloaded peeple a social app beta on \(currentDateTime)"
                        
                    }
                }
                
                
            }
        }
        self.betalabel.layer.masksToBounds = true
        
        
    }
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "betatester", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
       }
    
 

}
