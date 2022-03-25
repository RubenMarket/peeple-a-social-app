//
//  charight.swift
//  People
//
//  Created by Ruben Mercado on 6/3/20.
//  Copyright © 2020 Sirius Awe. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import RealmSwift

class charightview : UIView {
    @IBOutlet weak var firstcharview: UIView!
    @IBOutlet weak var secondViewY: NSLayoutConstraint!
    @IBOutlet weak var firstViewY: NSLayoutConstraint!
    @IBOutlet weak var backImage: UIImageView!
    private var centerxp:CGFloat = 0.0
    private var startBack:CGFloat = 0.0
    private var fullname: String = ""
    @IBOutlet var charightbuttons: [UIButton]!
    private var profpic:String = ""
    @IBOutlet weak var buttonView: UIView!
    private var editPeep:Bool = true
    private var sharedPeepNum = 0
    private var topChar:Bool = true
    private var bottomChar:Bool = true
    private var animate:Bool = false
    private let causes:[Int:String] = [-1:"choose a cause",0:"climate change",1:"autism awareness",2:"self awareness",3:"knowledge and information",4:"race equality",5:"police reform",6:"LGBTQ equality",7:"animal preservation",8:"mental health awareness",9:"poverty",10:"natural disater relief",11:"breast cancer awareness"]
    private let causeImages:[String] = ["climate","autism","awareness","infoknowledge","racism","pbrutal","lgbtqe","wildlife", "mentalhealth", "poverty","naturaldis","bcancer"]
    private var selectedTags:[Int] = [0,1]
    @IBOutlet weak var secondcharview: UIView!
    @IBOutlet weak var firstcharbut: UIButton!
    @IBOutlet weak var firstcharimage: UIImageView!
    @IBAction func selectCharightitie(_ sender: UIButton) {
        if selectedTags[1] == sender.tag {
            return
        }
        if selectedTags[0] == sender.tag {
            return
        }
        if selectedTags[1] == -1 {
            secondcharimage.image = UIImage(named:causeImages[sender.tag])
                secondcharbut.setTitle(causes[sender.tag], for: .normal)
                selectedTags[1] = sender.tag
            return
        }
        if selectedTags[0] == -1 {
            firstcharimage.image = UIImage(named:causeImages[selectedTags[1]])
                firstcharbut.setTitle(causes[selectedTags[1]], for: .normal)
                selectedTags[0] = selectedTags[1]
            secondcharimage.image = UIImage(named:causeImages[sender.tag])
            secondcharbut.setTitle(causes[sender.tag], for: .normal)
            selectedTags[1] = sender.tag
            return
        }
        if selectedTags[0] != -1 {
            firstcharimage.image = UIImage(named:causeImages[selectedTags[1]])
                firstcharbut.setTitle(causes[selectedTags[1]], for: .normal)
                selectedTags[0] = selectedTags[1]
            secondcharimage.image = UIImage(named:causeImages[sender.tag])
            secondcharbut.setTitle(causes[sender.tag], for: .normal)
            selectedTags[1] = sender.tag
            return
        }
        
    }
    
    
    @IBAction func firstchar(_ sender: UIButton) {
        if Person.ID == "" {
            editPeep(isEditing: editPeep)
        } else {
            if sharedPeepNum == 2 {
                let times = NSDate().timeIntervalSince1970
                let myTimeInterval = TimeInterval(times)
                let time = NSDate(timeIntervalSince1970: TimeInterval(myTimeInterval))
                let formatter = DateFormatter()
                formatter.dateStyle = .medium
                formatter.timeStyle = .short
            guard let user = app.currentUser else { return }
                   // Get a sync configuration from the user object.
                let config = user.configuration(partitionValue: "earthFeed=\(Location.continent)")
                   // Open the realm asynchronously to ensure backend data is downloaded first.
                Realm.asyncOpen(configuration: config) { [self] (result) in
                       switch result {
                       case .failure(let error):
                           print("Failed to open realm: \(error.localizedDescription)")
                       case .success(let Realm):
                           let share = earthFeed(text: causes[selectedTags[1]]!, name: Person.name, time: formatter.string(from: time as Date), imgeurl: "charryMainCell", peepone: Person.peepOne, peeptwo: Person.peepTwo, peepthree: Person.peepThree, color: Person.color, biz: false, peep: 1, lotag: "", userID: Person.ID, _id: "\(Int.random(in: 1...30))")
                           try! Realm.write {
                               Realm.add(share,update: .modified)
                           
                       }
                           print("stories filled")
                       }
                   }
        }
        }
        
        print("char 1")
    }
    
    @IBOutlet weak var secondcharbut: UIButton!
    @IBOutlet weak var secondcharimage: UIImageView!
    
    @IBAction func secondchar(_ sender: UIButton) {
        if Person.ID == "" {
            editPeep(isEditing: editPeep)
        } else {
            if sharedPeepNum == 1 {
                let times = NSDate().timeIntervalSince1970
                let myTimeInterval = TimeInterval(times)
                let time = NSDate(timeIntervalSince1970: TimeInterval(myTimeInterval))
                let formatter = DateFormatter()
                formatter.dateStyle = .medium
                formatter.timeStyle = .short
            guard let user = app.currentUser else { return }
                   // Get a sync configuration from the user object.
                let config = user.configuration(partitionValue: "earthFeed=\(Location.continent)")
                   // Open the realm asynchronously to ensure backend data is downloaded first.
                Realm.asyncOpen(configuration: config) { [self] (result) in
                       switch result {
                       case .failure(let error):
                           print("Failed to open realm: \(error.localizedDescription)")
                       case .success(let Realm):
                           let share = earthFeed(text: causes[selectedTags[0]]!, name: Person.name, time: formatter.string(from: time as Date), imgeurl: "charryMainCell", peepone: Person.peepOne, peeptwo: Person.peepTwo, peepthree: Person.peepThree, color: Person.color, biz: false, peep: 1, lotag: "", userID: Person.ID, _id: "\(Int.random(in: 1...30))")
                           try! Realm.write {
                               Realm.add(share,update: .modified)
                           
                       }
                           print("stories filled")
                       }
                   }
        }
        }
        
        print("char 2")
    }
    
   private func swipedd(){
       
       let swipe = UISwipeGestureRecognizer(target: self, action: #selector(charightview.centercontent(_:)))
       self.addGestureRecognizer(swipe)
       
       let swipel = UISwipeGestureRecognizer(target: self, action: #selector(charightview.centercontent(_:)))
        swipel.direction = .left
        swipel.cancelsTouchesInView = false
        
       self.addGestureRecognizer(swipel)
       
       }
    func editPeep(isEditing:Bool) {
//        let partitionValue = "peeps=\(user.id)"
////        UserDefaults.standard.set(true, forKey: "firstPeeplePlus")
////        UserDefaults.standard.set(true, forKey: "needsTutorial")
//        let configuration = user.configuration(partitionValue: partitionValue)
//        Realm.asyncOpen(configuration: configuration) { (result) in
//            switch result {
//            case .failure(let error):
//                print("Failed to open realm: \(error.localizedDescription)")
//                // Handle error...
//                DispatchQueue.main.async {
////                    self.stopLoading(loadingView: self.loadingIndicator)
//                }
//            case .success(let realm):
//                // Realm opened
//                let clenny = cleanergyClenny(clearClouds: true)
//                let charight = charightChoice(choice1: 0, choice2: 1)
//                let porty = portflioPost(topic1: "Photography", topic2: "Sports", topic3: "Nature")
//                let myPeep = myPeeps(cleanergy: clenny, charight: charight,portflio:porty, _id: user.id)
//                    try! realm.write {
//                        realm.add(myPeep,update: .modified)
//
//                }
//
//            }
//        }
        if isEditing {
            UIView.animate(withDuration: 1.0) {
                self.buttonView.isHidden = false
                self.buttonView.alpha = 1
                self.backImage.alpha = 0
                self.firstViewY.constant = self.firstY - 50
                self.secondViewY.constant = self.secondY + 50
                self.layoutSubviews()
            }
            editPeep = false
        }
        if isEditing == false {
            UIView.animate(withDuration: 1.0) {
                self.buttonView.isHidden = true
                self.buttonView.alpha = 0
                self.backImage.alpha = 1
                self.firstViewY.constant = self.firstY
                self.secondViewY.constant = self.secondY
                self.layoutSubviews()
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
                    let charight = charightChoice(choice1: selectedTags[1], choice2: selectedTags[0])
                    if let me = realm.objects(myPeeps.self).first {
                        try! realm.write {
                            me.charight = charight
                        }
                        self.firstcharbut.setTitle(causes[selectedTags[0]], for: .normal)
                        self.secondcharbut.setTitle(causes[selectedTags[1]], for: .normal)
                    }
                    
                    
                }
            }
            editPeep = true
        }
        
        
    }
    func updateMyData(){
        if let Charight = Peeps.charight {
            let one = Charight.choice1
            let two = Charight.choice2
            if two != -1 { firstcharimage.image = UIImage(named:causeImages[two]) }
            self.firstcharbut.setTitle(causes[two], for: .normal)
            self.selectedTags[1] = one
            if one != -1 {  secondcharimage.image = UIImage(named:causeImages[one]) }
            self.secondcharbut.setTitle(causes[one], for: .normal)
            self.selectedTags[0] = two
        } else {
           defaultViews()
        }
        
    }
    func addPersonData(){
        if let Charight = Person.charight {
            let one = Charight.choice1
            let two = Charight.choice2
            if two != -1 { firstcharimage.image = UIImage(named:causeImages[two]) }
            self.firstcharbut.setTitle(causes[two], for: .normal)
            self.selectedTags[1] = one
            if one != -1 {  secondcharimage.image = UIImage(named:causeImages[one]) }
            self.secondcharbut.setTitle(causes[one], for: .normal)
            self.selectedTags[0] = two
        } else {
           defaultViews()
        }
    }
    func defaultViews(){
        let one = selectedTags[1]
        let two = selectedTags[0]
        if two != -1 { firstcharimage.image = UIImage(named:causeImages[two]) }
        self.firstcharbut.setTitle(causes[two], for: .normal)
        self.selectedTags[1] = one
        if one != -1 {  secondcharimage.image = UIImage(named:causeImages[one]) }
        self.secondcharbut.setTitle(causes[one], for: .normal)
        self.selectedTags[0] = two
    }
//    func animateBack(){
//        while animate {
//            backImage.frame.x + = 1
//            
//            
//        }
//        
//    }
    override func layoutSubviews() {
        super.layoutSubviews()
//        swipedd()
        firstcharview.addShadow()
        secondcharview.addShadow()
        switch Person.ID {
        case "":
            updateMyData()
        default:
            addPersonData()
        }
        self.sharedPeepNum = Int.random(in: 1...Peeple.rarity)
        self.centerxp = self.firstcharview.center.x
        
        
    }
    @objc func centercontent(_ sender: UISwipeGestureRecognizer) {
        print("here")
    if sender.direction == .right {
                
        UIView.animate(withDuration: 1.1,delay: 0 ,options: [.curveLinear], animations: {
            self.firstcharview.center.x = self.center.x
            self.secondcharview.center.x = self.center.x
            
            self.layoutIfNeeded()
        }) { (true) in
            
            
        }
    
    } else if sender.direction == .left {
        
        UIView.animate(withDuration: 1.1,delay: 0 ,options: [.curveEaseOut], animations: {
            self.firstcharview.center.x = self.centerxp
            self.secondcharview.center.x = self.centerxp
            
            self.layoutIfNeeded()
        }) { (true) in
            
            
        }
        
        
        
        
        }
        
       
        
    }
    var firstY = CGFloat(0.0)
    var secondY = CGFloat(0.0)
    deinit {
        print("denitittittted charight")
    }
    override func didMoveToSuperview() {
//        UIView.animate(withDuration: 40.0, delay: 0.0, options: .autoreverse) {
//            self.peeploadimage.frame.origin.x = self.peeploadimage.frame.origin.x + self.frame.width
//        } completion: { (true) in
//
//        }
        
        firstY = firstViewY.constant
        secondY = secondViewY.constant
//        UIView.animate(withDuration: 55.0, delay: 1.0, options: .autoreverse) {
//            self.iconview.frame.origin.x = self.iconview.frame.origin.x + self.frame.width / 2
//        } completion: { (true) in
//
//        }
//        
//        UIView.animate(withDuration: 3.0) {
//            self.peepload.alpha = 0.0
//        } completion: { (true) in
//            self.peepload.isHidden = true
//        }
    }
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "Charight", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
       }
    
    
    
    
    
    
    
}

//databaseRef.child("peepstuff").child(peeple.CurrentUser).child("Charight").child("causeOne").observeSingleEvent(of: .value) { (snapshot) in
//            if let one = snapshot.value as? Int {
//                self.causeOneLabel.text = self.causes[one]
//                self.causeOneImage.image = self.causeImages[one]
//                UserDefaults.standard.set(one, forKey: "causeOne")
//                self.labels[0] = 1
//            }
//        }
//        databaseRef.child("peepstuff").child(peeple.CurrentUser).child("Charight").child("causeTwo").observeSingleEvent(of: .value) { (snapshot) in
//            if let two = snapshot.value as? Int {
//                self.causeTwoLabel.text = self.causes[two]
//                self.causeTwoImage.image = self.causeImages[two]
//                UserDefaults.standard.set(two, forKey: "causeTwo")
//                self.labels[1] = 1
//            }
//        }
