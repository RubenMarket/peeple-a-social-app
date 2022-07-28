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
    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var FirstPeepView: UIImageView!
    @IBOutlet weak var SecondPeepView: UIImageView!
    @IBOutlet weak var ThirdPeepView: UIImageView!
    @IBOutlet weak var progressCircle: CircularProgressView!
    @IBOutlet weak var mainTextLabel: UILabel!
    
    @IBOutlet weak var topLeftImageView: UIImageView!
   
    
    func setEventFeed(eventName:String,eventDes:String,eventColor:Int,peepOne:Int,peepTwo:Int,peepThree:Int,timePosted:Date,eventDuration:Int){
        topLeftImageView.isHidden = false
        mainImageView.borderColor(color: Peeple.Settings.Colors[eventColor])
        eventImage.tintColor = Peeple.Settings.Colors[eventColor]
        eventImage.image = UIImage(named: "event")
        FirstPeepView.image = UIImage(named: Peeple.Settings.PeepPics[peepOne])
        SecondPeepView.image = UIImage(named: Peeple.Settings.PeepPics[peepTwo])
        ThirdPeepView.image = UIImage(named: Peeple.Settings.PeepPics[peepThree])
//        peepOne.image = UIImage(named: Peeple.Settings.PeepPics[peep])
        let now = Date()
        let diffComponents = Calendar.current.dateComponents([.minute], from: timePosted, to: now)
        let minutes = diffComponents.minute ?? 0
        //1 hr long
        var timeLeft = 0
        if eventDuration == 1 {
            timeLeft = 60 - minutes
        } else {
            timeLeft = 120 - minutes
        }
        print(timeLeft)
        if timeLeft < 0 { timeLeft = 0 }
        progressCircle.progressColor = Peeple.Settings.Colors[eventColor]
        progressCircle.progress = Float(timeLeft / 6)
        progressCircle.timeToFill = Double(timeLeft)
        print(Float(timeLeft / 6))
        mainTextLabel.textColor = Peeple.Settings.Colors[eventColor]
        mainTextLabel.text = "\(eventName)\n"
        mainTextLabel.isHidden = false
    }
    func setGroups(groupName:String,groupColor:Int){
        mainImageView.image = UIImage(named: Peeple.Settings.GroupBoxImage)
        mainTextLabel.isHidden = false
        topLeftImageView.isHidden = true
        mainTextLabel.text = groupName
        mainImageView.borderColor(color: Peeple.Settings.Colors[groupColor])
        mainTextLabel.textColor = Peeple.Settings.Colors[groupColor]
        mainImageView.tintColor = Peeple.Settings.Colors[groupColor]
    }
    func setPeople(personName:String,personColor:Int,peepOne:Int,peepTwo:Int,peepThree:Int,personImage:String,isPrivate:Bool){
        mainImageView.image = UIImage(named: Peeple.Settings.PeoplecellImage)
            mainTextLabel.text = personName
        mainTextLabel.isHidden = true
        topLeftImageView.isHidden = true
        progressCircle.isHidden = !isPrivate
        FirstPeepView.image = UIImage(named: Peeple.Settings.PeepPics[peepOne])
        SecondPeepView.image = UIImage(named: Peeple.Settings.PeepPics[peepTwo])
        ThirdPeepView.image = UIImage(named: Peeple.Settings.PeepPics[peepThree])
        mainImageView.tintColor = Peeple.Settings.Colors[personColor]
        mainImageView.borderColor(color: Peeple.Settings.Colors[personColor])
    }
    func setGroupEvent(groupName:String,groupDes:String,peepOne:Int,peepTwo:Int,peepThree:Int,eventColor:Int,timePosted:Date,eventDuration:Int){
        topLeftImageView.isHidden = false
        FirstPeepView.image = UIImage(named: Peeple.Settings.PeepPics[peepOne])
        SecondPeepView.image = UIImage(named: Peeple.Settings.PeepPics[peepTwo])
        ThirdPeepView.image = UIImage(named: Peeple.Settings.PeepPics[peepThree])
        let now = Date()
        let diffComponents = Calendar.current.dateComponents([.minute], from: timePosted, to: now)
        let minutes = diffComponents.minute ?? 0
        //1 hr long
        var timeLeft = 0
        if eventDuration == 1 {
            timeLeft = 60 - minutes
        } else {
            timeLeft = 120 - minutes
        }
        if timeLeft < 0 { timeLeft = 0 }
        progressCircle.progressColor = Peeple.Settings.Colors[Person.Current.Color]
        progressCircle.progress = Float(timeLeft / 6)
        progressCircle.timeToFill = Double(timeLeft)
        mainTextLabel.textColor = Peeple.Settings.Colors[eventColor]
        mainTextLabel.text = "\(groupName): \(groupDes)."
        mainTextLabel.isHidden = false
    }
    var allEvents : Events! {
            didSet {
                setEventFeed(eventName: allEvents.eventName, eventDes: allEvents.eventDes, eventColor: allEvents.color,peepOne:allEvents.peepOne,peepTwo: allEvents.peepTwo,peepThree: allEvents.peepThree,timePosted: allEvents.timeCode, eventDuration: allEvents.eventDuration)
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
                setPeople(personName: myPeople.name, personColor: myPeople.color, peepOne:myPeople.peepOne,peepTwo: myPeople.peepTwo,peepThree: myPeople.peepThree, personImage: myPeople.image, isPrivate: false)
            }
        }
    var groupEvents : groupMessages! {
        didSet {
            setGroupEvent(groupName: groupEvents.chatName, groupDes: groupEvents.chatMessage, peepOne: groupEvents.peepOne,peepTwo: groupEvents.peepTwo,peepThree: groupEvents.peepThree, eventColor: groupEvents.color, timePosted: groupEvents.timeCode,eventDuration: groupEvents.eventDuration)
        }
    }
        var allPeople : allPeople! {
            didSet {
                setPeople(personName: allPeople.name, personColor: allPeople.color, peepOne: allPeople.peepOne,peepTwo: allPeople.peepTwo,peepThree: allPeople.peepThree, personImage: allPeople.image, isPrivate: allPeople.priv)
            }
        }
        var searchPeople : allPeople! {
            didSet {
                setPeople(personName: searchPeople.name, personColor: searchPeople.color, peepOne: searchPeople.peepOne,peepTwo: searchPeople.peepTwo,peepThree: searchPeople.peepThree, personImage: searchPeople.image, isPrivate: searchPeople.priv)
            }
        }
    override func prepareForReuse() {
        mainImageView.image = nil
        mainTextLabel.isHidden = true
        eventImage.image = nil
        topLeftImageView.isHidden = true
        mainImageView.layer.borderWidth = 0
        FirstPeepView.image = nil
        SecondPeepView.image = nil
        ThirdPeepView.image = nil
//
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
