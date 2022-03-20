//
//  cleanergy.swift
//  People
//
//  Created by Ruben Mercado on 9/14/20.
//  Copyright © 2020 A Sirius Company. All rights reserved.
//

import UIKit
import RealmSwift

class cleanergy: UIView {
    @IBOutlet weak var clennyrecycleback: UIImageView!
    @IBOutlet weak var clennyview: UIView!
    @IBOutlet weak var clennycloudfront: UIImageView!
    var cleanSwitch:Bool = false
    @objc func editPeep(_ notification:Notification) {
        
        if Peeple.editPeepMode {
            UIView.animate(withDuration: 1.0) {
//                self.layoutSubviews()
            }
        }
        if !Peeple.editPeepMode {
            UIView.animate(withDuration: 1.0) {
//                self.layoutSubviews()
            }
            guard let user = app.currentUser else { return }
            let partitionValue = "peeps=\(user.id)"
            let configuration = user.configuration(partitionValue: partitionValue)
            Realm.asyncOpen(configuration: configuration) { [self] (result) in
                switch result {
                case .failure(let error):
                    print("Failed to open realm: \(error.localizedDescription)")
                    // Handle error...
                case .success(let realm):
                    // Realm opened
                    let cleanergy = cleanergyClenny(clearClouds: cleanSwitch)
                    if let me = realm.objects(myPeeps.self).first {
                        try! realm.write {
                            me.cleanergy = cleanergy
                        }
                        
                    }
                    
                    
                }
            }
        }
    }
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        // Your action
    }
    func updateMyData(){
        if let Clenny = Peeps.clenny  {
        if Clenny.clearClouds {
            cleanPlanet()
        } else {
            dirtyPlanet()
        }
        }
    }
    func addPersonData(){
        if let Clenny = Person.clenny  {
        if Clenny.clearClouds {
            cleanPlanet()
        } else {
            dirtyPlanet()
        }
        }
    }
    override func layoutSubviews() {
        clennyview.setPeepleCorners()
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
            clennyrecycleback.isUserInteractionEnabled = true
        clennyrecycleback.addGestureRecognizer(tapGestureRecognizer)
        switch Person.ID {
        case "":
            updateMyData()
        default:
            addPersonData()
        }
        
       
       }
    private func cleanPlanet(){
        clennycloudfront.image = nil
//            UIImage(named: "")
        clennyrecycleback.image = UIImage(named: "clennnyrecycleback")
//        clennycloudfront.isHidden = true
//        clennyrecycleback.isHidden = false
//        clennyplane.isHidden = true
//        clennyview.isHidden = true
    }
    private func dirtyPlanet(){
        clennycloudfront.image = UIImage(named: "dark2")
        clennyrecycleback.image = UIImage(named: "clennnynonrecycleback")
    }
    override func didMoveToSuperview() {
        
//        UIView.animate(withDuration: 40, delay: 0, options: .autoreverse) {
//            self.clennyclouds.frame.origin.x = self.clennyclouds.frame.origin.x + self.frame.width
//        } completion: { (true) in
//
//        }
//        UIView.animate(withDuration: 30.0,delay: 0 , options: .autoreverse) {
//            self.clennyplane.frame.origin.x = self.frame.width * 2
//            self.clennycloudfront.frame.origin.x = self.clennycloudfront.frame.origin.x + self.frame.width
//        } completion: { (finished) in
//
//        }
//           UIView.animate(withDuration: 2.0, animations: {
//               self.peeploadimage.alpha = 0
//           }) { (finished) in
//               self.peeploadimage.isHidden = true
//            self.peeploadimage.alpha = 1
//           }
//        UIView.animate(withDuration: 5.0) {
//            self.peeploadimage.alpha = 0.0
//        } completion: { (true) in
//            self.peeploadimage.isHidden = true
//        }
    }
    
       class func instanceFromNib() -> UIView {
        return UINib(nibName: "Cleanergy", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
       }
    deinit {
        print("denitittittted clenaergy")
    }
       
}
