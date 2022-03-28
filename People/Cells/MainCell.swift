//
//  CollectionViewCell.swift
//  People
//
//  Created by admin on 11/26/21.
//  Copyright © 2021 A Sirius Company. All rights reserved.
//

import UIKit

class MainViewCell: UICollectionViewCell {
    @IBOutlet weak var mainImageView: UIImageView!
    @IBOutlet weak var peepOne: UIImageView!
    @IBOutlet weak var peepTwo: UIImageView!
    @IBOutlet weak var peepThree: UIImageView!
    @IBOutlet weak var lockImageView: UIImageView!
    @IBOutlet weak var mainTextLabel: UILabel!
    
    @IBOutlet weak var topLeftImageView: UIImageView!
   
    
    func setEarthFeed(peep:Int,image:String,text:String){
        topLeftImageView.isHidden = false
        mainImageView.buttonify(color: .white)
        mainImageView.image = UIImage(named: image)
        peepTwo.image = UIImage(named: Peeple.peepPics[peep])
    }
    func setGroups(groupName:String,groupColor:Int){
        mainImageView.image = UIImage(named: Peeple.GroupBoxImage)
        mainTextLabel.isHidden = false
        topLeftImageView.isHidden = true
        mainTextLabel.text = groupName
        mainImageView.buttonify(color: Peeple.colors[groupColor])
        mainTextLabel.textColor = Peeple.colors[groupColor]
        mainImageView.tintColor = Peeple.colors[groupColor]
    }
    func setPeople(personName:String,personColor:Int,peep1:Int,peep2:Int,peep3:Int,personImage:String,isPrivate:Bool){
        mainImageView.buttonify(color: Peeple.colors[personColor])
        mainImageView.image = UIImage(named: Peeple.PeoplecellImage)
            mainTextLabel.text = personName
        mainTextLabel.isHidden = true
        topLeftImageView.isHidden = true
            lockImageView.isHidden = !isPrivate
        peepOne.image = UIImage(named: Peeple.peepPics[peep1])
        peepTwo.image = UIImage(named: Peeple.peepPics[peep2])
        peepThree.image = UIImage(named: Peeple.peepPics[peep3])
        mainImageView.tintColor = Peeple.colors[personColor]
    }
    func setGroupEvent(groupName:String,groupDes:String,peep1:Int,peep2:Int,peep3:Int,eventColor:Int,timePosted:Date,eventDuration:Int){
            mainImageView.buttonify(color: Peeple.colors[eventColor])
        topLeftImageView.isHidden = false
        lockImageView.image = UIImage(named: "eventsele")
        lockImageView.isHidden = false
        let now = Date()
        var timeLeftText:String = ""
        let diffComponents = Calendar.current.dateComponents([.minute], from: timePosted, to: now)
        let minutes = diffComponents.minute ?? 0
        //1 hr long
        if eventDuration == 1 {
            let timeLeft = 60 - minutes
            timeLeftText = "\(timeLeft)"
        } else {
            let timeLeft = 120 - minutes
            timeLeftText = "\(timeLeft)"
        }
        mainTextLabel.textColor = Peeple.colors[eventColor]
        mainTextLabel.text = "\(groupName) - \(groupDes).       time remaining : \(timeLeftText) minutes"
        mainTextLabel.isHidden = false
    }
    var peeplePeeps : earthFeed! {
            didSet {
                setEarthFeed(peep: peeplePeeps.peep, image: peeplePeeps.imgeurl,text: peeplePeeps.text)
            }
    }
        var myGroups : myGroups! {
            didSet {
                setGroups(groupName: myGroups.name, groupColor: myGroups.color)
                
            }
        }
        var allGroups : allGroups! {
            didSet {
                setGroups(groupName: allGroups.name, groupColor: allGroups.color)
            }
        }
        var searchGroups : allGroups! {
            didSet {
                setGroups(groupName: searchGroups.name, groupColor: searchGroups.color)
            }
        }
   
    
        var myPeople : myPeople! {
            didSet {
                setPeople(personName: myPeople.name, personColor: myPeople.color, peep1: myPeople.one, peep2: myPeople.two, peep3: myPeople.three, personImage: myPeople.image, isPrivate: false)
            }
        }
    var groupEvents : groupMessages! {
        didSet {
            setGroupEvent(groupName: groupEvents.chatName, groupDes: groupEvents.chatMessage, peep1: groupEvents.peepOne, peep2: groupEvents.peepTwo, peep3: groupEvents.peepThree, eventColor: groupEvents.color, timePosted: groupEvents.timeCode,eventDuration: groupEvents.eventDuration)
        }
    }
    var allEvents : groupMessages! {
        didSet {
            setGroupEvent(groupName: allEvents.chatName, groupDes: allEvents.chatMessage, peep1: allEvents.peepOne, peep2: allEvents.peepTwo, peep3: allEvents.peepThree, eventColor: allEvents.color, timePosted: allEvents.timeCode,eventDuration: allEvents.eventDuration)
        }
    }
        var allPeople : allPeople! {
            didSet {
                setPeople(personName: allPeople.name, personColor: allPeople.color, peep1: allPeople.one, peep2: allPeople.two, peep3: allPeople.three, personImage: allPeople.image, isPrivate: allPeople.priv)
            }
        }
        var searchPeople : allPeople! {
            didSet {
                setPeople(personName: searchPeople.name, personColor: searchPeople.color, peep1: searchPeople.one, peep2: searchPeople.two, peep3: searchPeople.three, personImage: searchPeople.image, isPrivate: searchPeople.priv)
            }
        }
    override func prepareForReuse() {
        mainImageView.image = nil
        mainTextLabel.isHidden = true
        peepOne.image = nil
        topLeftImageView.isHidden = true
        peepTwo.image = nil
        peepThree.image = nil
        lockImageView.isHidden = true
    }
}
//class peeplegroupcell: UICollectionViewCell  {
//    @IBOutlet weak var groupname: UILabel!
//    @IBOutlet weak var groupimage: UIImageView!
//    @IBOutlet weak var lockedim: UIImageView!
//    @IBOutlet weak var celldescription: UILabel!
//    var delegate:entergroupDelegate!
//    var indexPath:IndexPath!
//    var indexPath1:IndexPath!
//
//    var topGroups : topGroups! {
//        didSet {
//            groupname.text = topGroups.name
//            groupname.textColor = Peeple.colors[topGroups.color]
//            groupimage.borderColor(color: Peeple.colors[topGroups.color])
//            groupimage.backColor(color: Peeple.colors[topGroups.color])
//            celldescription.text = topGroups.des
//        }
//    }
//    var myGroups : myGroups! {
//        didSet {
//            groupname.text = myGroups.name
//            groupname.textColor = Peeple.colors[myGroups.color]
//            groupimage.borderColor(color: Peeple.colors[myGroups.color])
//            groupimage.backColor(color: Peeple.colors[myGroups.color])
//            celldescription.text = myGroups.des
//        }
//    }
//    var allGroups : allGroups! {
//        didSet {
//            groupname.text = allGroups.name
//            groupname.textColor = Peeple.colors[allGroups.color]
//            groupimage.borderColor(color: Peeple.colors[allGroups.color])
//            groupimage.backColor(color: Peeple.colors[allGroups.color])
//            celldescription.text = allGroups.des
//        }
//    }
//    var searchGroups : allGroups! {
//        didSet {
//            groupname.text = searchGroups.name
//            groupname.textColor = Peeple.colors[searchGroups.color]
//            groupimage.borderColor(color: Peeple.colors[searchGroups.color])
//            groupimage.backColor(color: Peeple.colors[searchGroups.color])
//            celldescription.text = searchGroups.des
//        }
//    }
//    func showlock(){
//        lockedim.alpha = 0
//        lockedim.isHidden = false
//        UIView.animate(withDuration: 0.5) {
//            self.lockedim.alpha = 1
//        }
//    }
//    override func prepareForReuse() {
//        lockedim.isHidden = true
//    }
//
//    override func layoutSubviews() {
//
//
//    }
//
//
//}
//class StoryTableviewcell: UICollectionViewCell{
//    @IBOutlet weak var textLabel: UILabel!
//    @IBOutlet weak var peepPic: UIImageView!
//
//    func peep(){
//            UIView.animate(withDuration: 1.0) { [self] in
//                self.peepPic.transform = self.peepPic.transform.scaledBy(x: 0.9, y: 0.9)
//            } completion: { (true) in
//                UIView.animate(withDuration: 1.0) { [self] in
//                    self.peepPic.transform = CGAffineTransform.identity
//                }
//            }
//
//    }
//    override func layoutSubviews() {
//
//    }
//
//
//
//}
//class UserCell: UICollectionViewCell {
//
//    @IBOutlet weak var FullName: UILabel!
//    @IBOutlet weak var onemini: UIImageView!
//
//    @IBOutlet weak var threemini: UIImageView!
//    @IBOutlet weak var twomini: UIImageView!
//
//    @IBOutlet weak var photo: UIImageView!
//    @IBOutlet weak var lockedim: UIImageView!
//
//    var indexPath:IndexPath!
//
//    var search: allPeopleV2! {
//
//        didSet{
//
//            FullName.text = search.name
//        }
//
//    }
//
//    var allPeople: allPeopleV2! {
//            didSet {
//                FullName.text = allPeople.name
//
//
//
//
//
//
//            }
//
//    }
//
//
//    func showlock(){
//
//        lockedim.alpha = 0
//        lockedim.isHidden = false
//
//        UIView.animate(withDuration: 0.5) {
//            self.lockedim.alpha = 1
//        }
//    }
//    func shakein(){
//        onemini.shake1(duration: 1.0)
//        twomini.shake1(duration: 1.0)
//        threemini.shake1(duration: 1.0)
//    }
//
//    override func prepareForReuse() {
//        lockedim.isHidden = true
//        photo.image = nil
//        onemini.image = nil
//        twomini.image = nil
//        threemini.image = nil
//    }
//
//
//    override func layoutSubviews() {
//
////        layer.masksToBounds = false
////        layer.shadowOffset = CGSize(width: 0, height: 2)
////        layer.shadowRadius = 2
////        layer.shadowOpacity = 0.4
////        layer.shadowColor = UIColor.black.cgColor
////        layer.rasterizationScale = UIScreen.main.scale
////        layer.shouldRasterize = true
//    }
////        func updateAppearanceFor(_ image: UIImage?) {
////            DispatchQueue.main.async { [unowned self] in
////                self.displayImage(image)
////            }
////        }
////
////        private func displayImage(_ image: UIImage?) {
////            if let _image = image {
////                photo.image = _image
////
////            } else {
////    //            loadingIndicator.startAnimating()
////                photo.image = .none
////            }
////        }
////    fileprivate func setupViews() {
////
////        contentView.topAnchor.constraint(equalTo: namegradient.topAnchor, constant: 0).isActive = true
////        contentView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor).isActive = true
////        contentView.heightAnchor.constraint(equalToConstant: 100).isActive = true
////        contentView.widthAnchor.constraint(equalToConstant: 100).isActive = true
////
////        if let lastSubview = contentView.subviews.last {
////            contentView.bottomAnchor.constraint(equalTo: lastSubview.bottomAnchor, constant: 10).isActive = true
////        }
////    }
//
//}
