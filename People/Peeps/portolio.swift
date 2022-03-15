//
//  portolio.swift
//  People
//
//  Created by Ruben Mercado on 6/4/20.
//  Copyright © 2020 Sirius Awe. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift


class portoflio : UIView{
    @IBOutlet weak var gameNameLabel1: UILabel!
    @IBOutlet weak var usernameOrIDBut1: UIButton!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var midView: UIView!
    @IBOutlet weak var bottomView: UIView!
    private var num = 0
    @IBOutlet weak var gameNameLabel2: UILabel!
    @IBOutlet weak var usernameOrIDBut2: UIButton!
    @IBOutlet weak var gameNameLabel3: UILabel!
    @IBOutlet weak var usernameOrIDBut3: UIButton!
    private var sharedPeep:Bool = false
    private var sharedPeepNum:Int = 0
    private var profimage:String = ""
    private var fullname : String = ""
    private var topic1Index:Int = 0
    private var topic2Index:Int = 1
    private var topic3Index:Int = 2
    private var topics:[String] = ["Photography","Sports","Movies and TV","Nature","Video Games","Fitness"]
    @IBAction func copyUsernameOrID1(_ sender: UIButton) {
    }
    @IBAction func copyUsernameOrID2(_ sender: UIButton) {
    }
    
    @IBAction func copyUsernameOrID3(_ sender: UIButton) {
    }
    
    func isEditMode(isEditing:Bool){
        UIView.animate(withDuration: 1.0) {
            self.gameNameLabel1.isHidden = isEditing
            self.gameNameLabel2.isHidden = isEditing
            self.gameNameLabel3.isHidden = isEditing
            self.usernameOrIDBut1.isHidden = isEditing
            self.usernameOrIDBut2.isHidden = isEditing
            self.usernameOrIDBut3.isHidden = isEditing
        }
        if isEditing == false {
            let user = app.currentUser!
            let partitionValue = "peeps=\(ID.my)"
            let configuration = user.configuration(partitionValue: partitionValue)
            Realm.asyncOpen(configuration: configuration) { [self] (result) in
                switch result {
                case .failure(let error):
                    print("Failed to open realm: \(error.localizedDescription)")
                    // Handle error...
                case .success(let realm):
                    // Realm opened
                    let games = portflioPost(topic1: topics[topic1Index], topic2: topics[topic2Index], topic3: topics[topic3Index])
                    if let me = realm.objects(myPeeps.self).first {
                        try! realm.write({
                            me.portflio = games
                        })
                    } else {
                        let myPeeps = myPeeps(portflio: games, _id: ID.my)
                        try! realm.write({
                            realm.add(myPeeps)
                        })
                    }
                    
                    
                }
            }
        }
        return
    }
    @objc func updatefeed(_ notification:Notification) {
        
    }
    func roundCornersP(){
        self.gameNameLabel1.setPeepleCorners()
        self.gameNameLabel2.setPeepleCorners()
        self.gameNameLabel3.setPeepleCorners()
        self.usernameOrIDBut1.setPeepleCorners()
        self.usernameOrIDBut2.setPeepleCorners()
        self.usernameOrIDBut3.setPeepleCorners()
        self.gameNameLabel1.addShadow()
        self.gameNameLabel2.addShadow()
        self.gameNameLabel3.addShadow()
        self.usernameOrIDBut1.addShadow()
        self.usernameOrIDBut2.addShadow()
        self.usernameOrIDBut3.addShadow()
        
    }
//    func updateMyData(){
//        guard let Porty = Peeps.portlio else { return }
//        let topic1 = Porty.topic1
//        let topic2 = Porty.topic2
//        let topic3 = Porty.topic3
//        self.gameNameLabel1.text = topic1
//        self.gameNameLabel2.text = topic2
//        self.gameNameLabel3.text = topic3
//        
//    }
//    func addPersonData(){
//        guard let Porty = Person.portlio else { return }
//        let topic1 = Porty.topic1
//        let topic2 = Porty.topic2
//        let topic3 = Porty.topic3
//        self.gameNameLabel1.text = topic1
//        self.gameNameLabel2.text = topic2
//        self.gameNameLabel3.text = topic3
//    }
    override func layoutSubviews() {
        roundCornersP()
        self.sharedPeepNum = Int.random(in: 1...Peeple.rarity)
//        switch ID.selected {
//        case "":
//            updateMyData()
//        default:
//            addPersonData()
//        }
    }
    deinit {
        print("denitittittted portfolio")
    }
    
    override func didMoveToSuperview() {
//        UIView.animate(withDuration: 40.0, delay: 0.0,options:.autoreverse, animations: {
//            self.peepload.frame.origin.x = self.peepload.frame.origin.x + self.frame.width * 2
//        }) { (finished) in
//
//        }
//        UIView.animate(withDuration: 55.0, delay: 0.0,options:.autoreverse, animations: {
//            self.peeploadback.frame.origin.x = self.peeploadback.frame.origin.x + self.frame.height*1.5
//        }) { (finished) in
//
//        }
//        UIView.animate(withDuration: 3.0) {
//            self.peeploadimage.alpha = 0.0
//        } completion: { (true) in
//            self.peeploadimage.isHidden = true
//        }

        
    }
    func instanceFromNib() -> UIView {
        return UINib(nibName: "Portfolio", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
    }
}
