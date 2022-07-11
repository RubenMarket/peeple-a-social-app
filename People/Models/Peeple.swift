//
//  Gobals.swift
//  People
//
//  Created by Ruben Mercado on 2/8/19.
//  Copyright © 2019 Sirius Awe. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation
import CoreLocation

class Peeple {
    static let Settings = Peeple()
    var zoomLevel:zoom = .max
    enum zoom { case one,two, max }
    enum EventOptions { case all, twentyfive,five }
    enum GroupOptions { case all, my, search }
    enum PeopleOptions { case all, my, search }
    enum ProfileOptions { case peepOne, peepTwo, peepThree }
    enum Page { case Event, Group, People, Profile, GroupChat, Person }
    enum prevPage { case Group, People }
    var PersonOption:ProfileOptions = .peepOne
    var CurrentPage:Page = Page.Event
    var fromPage:prevPage = prevPage.Group
    let Colors:[UIColor] = [.systemGray,#colorLiteral(red: 1, green: 0.3019607843, blue: 0.2549019608, alpha: 1),#colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1),#colorLiteral(red: 1, green: 0.9568627451, blue: 0.4862745098, alpha: 1),#colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1),#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1),#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1),#colorLiteral(red: 1, green: 0.7137254902, blue: 0.7568627451, alpha: 1),.systemGray6]
    // 1 out of below chance to post on click
    let Rarity:Int = 30
    var language:Int = UserDefaults.standard.integer(forKey: "language")
    // the views width divided by below number
    let CornerRadius:CGFloat = 17
    var plus:Bool = false
    var editedPeeps:Bool = false
    let Thickness:CGFloat = 0.0
    let RightPage:String = "rightavailable"
    let LeftPage:String = "leftavailable"
    let BothPage:String = "bothavailable"
    let EarthBackImg:String = "earthBack"
    var isLocationEnabled:Bool = UserDefaults.standard.bool(forKey: "isLocationEnabled")
    //language index defined
    let Languages: [Int: String] = [0:"english",1:"portugese",2:"spanish"]
    let PeepTags: [Int: String] = [1:"charight",2:"cleanergy",3:"Portoflio",4:"Spachip",5:"cupinge",6:"animlyfe",7:"blue soon",8:"theroy",9:"clnow",10:"wefie",11:"trevlly",12:"weme",13:"alli",14:"beattester",15:"mucity",16:"awemember",17:"blue soon"]
    let PeepPics: [String] = ["emptyRectangle","charight","cleanergy","Portoflio","Spachip","cupinge","animlyfe","blue soon","theroy","clnow","wefie","trevlly","weme","alli","beattester","mucity","awemember","blue soon"]
    let PeepBacks: [String] = ["earthBack","charBack","earthBack","portBack","Spacechip","Cupidity","Animalife","Comingsoon","Theorize","Clouds","Shelfie","Traveld","Myme","Alexia","Beta Tester","Musicity","Awe Member","blue soon"]
    //group
    var GroupisSetTo:GroupOptions = .all
    let GroupBoxImage:String = "groupimage"
//    var GroupLabel:String = "groupslabel"
    //people
    var PeopleisSetTo:PeopleOptions = .all
    let PeoplecellImage:String = "pers"
//    var PeopleLabel:String = "peoplabel"
    //profile
    var ProfileisSetTo:ProfileOptions = .peepOne
    var editPeepMode:Bool = false
    var peepSwitch:Int = 0
//    var ProfileLabel:String = "profilelabel"
    //planet
    var EventisSetTo:EventOptions = .all
    //event
//    var EventLabel:String = "eventslabel"
}
struct Portugese{
    static let EventLabel:String = "peventlabel"
    static let ProfileLabel:String = "pprofilelabel"
    static let PeopleLabel:String = "ppeoplelabel"
    static let GroupLabel:String = "pgrouplabel"
}
struct English {
    static let EventLabel:String = "eventslabel"
    static let ProfileLabel:String = "profilelabel"
    static let PeopleLabel:String = "peoplabel"
    static let GroupLabel:String = "groupslabel"
}
//struct Person {
//
//    static var ID:String = ""
//    static var name:String = ""
//    static var peepOne:Int = 0
//    static var peepTwo:Int = 0
//    static var peepThree:Int = 0
//    static var color:Int = 0
//    static var pic:String = ""
////    static var charight:charightChoice?
////    static var clenny:cleanergyClenny?
////    static var porty:portflioPost?
//}
class Person {
    static let Current = Person()
    static let Selected = Person()
    // deafults to 0 if empty
    var Color:Int = UserDefaults.standard.integer(forKey: "appColor")
    var ID:String = ""
    var isARActive:Bool = false
    var Beta:Bool = false
    var Priv:Bool = false
    var biz:Bool?
    var PeepOne:Int = 1
    var PeepTwo:Int = 2
    var PeepThree:Int = 3
    var Name:String = ""
    func setInfo(id:String,priv:Bool,peepOne:Int,peepTwo:Int,peepThree:Int,name:String,color:Int){
        ID = id
        Priv = priv
        Color = color
        PeepOne = peepOne
        PeepTwo = peepTwo
        PeepThree = peepThree
        Name = name
    }
}
class Peeps {
    static let Current = Peeps()
    static let Selected = Peeps()
    var charight:charightChoice?
    var clenny:cleanergyClenny?
    var porty:portflioPost?
}
struct Event {
    static var ID:String = ""
    static var latitude:CLLocationDegrees = 0.0
    static var longitude:CLLocationDegrees = 0.0
}
struct Group {
    static var ID:String = ""
    static var name:String = ""
    static var color:Int = 0
    static var pic:String = ""
    static var des:String = ""
}
struct Location {
    static var country:String = UserDefaults.standard.string(forKey: "country") ?? "earth"
    static var city:String = UserDefaults.standard.string(forKey: "city") ?? "peeple"
}
struct Errors {
    static var InvalidString:String = "Invalid String"
}

class MusicPlayer {
    static let shared = MusicPlayer()
    var audioPlayer: AVAudioPlayer?
    var peepPlayer: AVAudioPlayer?
    func startBackgroundMusic() {

        if let bundle = Bundle.main.path(forResource: "peepleSound", ofType: "wav") {
            let backgroundMusic = NSURL(fileURLWithPath: bundle)
            try? AVAudioSession.sharedInstance().setCategory(.ambient)
            try? AVAudioSession.sharedInstance().setActive(true)
            do {
                audioPlayer = try AVAudioPlayer(contentsOf:backgroundMusic as URL)
                guard let audioPlayer = audioPlayer else { return }
                audioPlayer.numberOfLoops = -1
                audioPlayer.volume = 0.5
                audioPlayer.prepareToPlay()
                audioPlayer.play()
            } catch {
                print(error)
            }
        }
    }
    func playPeep() {
        if let bundle = Bundle.main.path(forResource: "peepsound", ofType: "mp3") {
            try? AVAudioSession.sharedInstance().setCategory(.ambient)
            try? AVAudioSession.sharedInstance().setActive(true)
            let backgroundMusic = NSURL(fileURLWithPath: bundle)
            do {
                peepPlayer = try AVAudioPlayer(contentsOf:backgroundMusic as URL)
                guard let audioPlayer = peepPlayer else { return }
                audioPlayer.numberOfLoops = 0
                audioPlayer.volume = 0.5
                audioPlayer.prepareToPlay()
                audioPlayer.play()
            } catch {
                print(error)
            }
        }
    }
    func stopBackgroundMusic() {
        guard let audioPlayer = audioPlayer else { return }
        audioPlayer.stop()
    }
}

//private var sketchColorz:[UIColor] = [.white,#colorLiteral(red: 0.8156862745, green: 0.007843137255, blue: 0.1058823529, alpha: 1),#colorLiteral(red: 0.9607843137, green: 0.6509803922, blue: 0.137254902, alpha: 1),#colorLiteral(red: 0.9725490196, green: 0.9058823529, blue: 0.1098039216, alpha: 1),#colorLiteral(red: 0.4941176471, green: 0.8274509804, blue: 0.1294117647, alpha: 1),#colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1),#colorLiteral(red: 0.5647058824, green: 0.07450980392, blue: 0.9960784314, alpha: 1),#colorLiteral(red: 0, green: 0.4784313725, blue: 1, alpha: 1),.systemGray]
//private var appleColorz:[UIColor] = [.white,.systemRed,.systemOrange,.systemYellow,.systemGreen,.systemBlue,.systemPurple,.systemPink,.systemGray,.systemTeal]
//private var lightPalleteColorz:[UIColor] = [.white,#colorLiteral(red: 1, green: 0.3019607843, blue: 0.2549019608, alpha: 1),#colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1),#colorLiteral(red: 1, green: 0.9568627451, blue: 0.4862745098, alpha: 1),#colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1),#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1),#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1),#colorLiteral(red: 1, green: 0.7137254902, blue: 0.7568627451, alpha: 1),.systemGray]


//struct softPallete {
//    let red:UIColor = #colorLiteral(red: 1, green: 0.3019607843, blue: 0.2549019608, alpha: 1)
//    let orange:UIColor = #colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1)
//    let yellow:UIColor = #colorLiteral(red: 1, green: 0.9568627451, blue: 0.4862745098, alpha: 1)
//    let green:UIColor = #colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1)
//    let blue:UIColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1)
//    let purple:UIColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)
//    let pink:UIColor = #colorLiteral(red: 1, green: 0.7137254902, blue: 0.7568627451, alpha: 1)
//}
