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

struct Peeple {
    static var zoomLevel:zoom = .two
    enum zoom { case one,two, max }
    enum PlanetOptions { case earth, mars, moon,space }
    enum GroupOptions { case all, my, search, make,events }
    enum PeopleOptions { case all, my, search }
    enum ProfileOptions { case peepOne, peepTwo, peepThree, settings }
    enum Page { case Planet, Group, People, Profile, GroupChat, Person }
    enum prevPage { case Group, People }
    static var CurrentPage:Page = Page.Planet
    static var fromPage:prevPage = prevPage.Group
    static let colors:[UIColor] = [.white,#colorLiteral(red: 1, green: 0.3019607843, blue: 0.2549019608, alpha: 1),#colorLiteral(red: 0.9686274529, green: 0.78039217, blue: 0.3450980484, alpha: 1),#colorLiteral(red: 1, green: 0.9568627451, blue: 0.4862745098, alpha: 1),#colorLiteral(red: 0.721568644, green: 0.8862745166, blue: 0.5921568871, alpha: 1),#colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1),#colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1),#colorLiteral(red: 1, green: 0.7137254902, blue: 0.7568627451, alpha: 1),.systemGray6]
    // 1 out of below chance to post on click
    static let rarity:Int = 30
    // the views width divided by below number
    static let cornerRadius:CGFloat = 22
    static let Thickness:CGFloat = 2
    static var isLocationEnabled:Bool = UserDefaults.standard.bool(forKey: "isLocationEnabled")
    static let peepTags: [Int: String] = [1:"charight",2:"cleanergy",3:"Portoflio",4:"Spacechip",5:"Cupidity",6:"Animalife",7:"Comingsoon",8:"Theorize",9:"Clouds",10:"Shelfie",11:"Traveld",12:"Myme",13:"Alexia",14:"Beta Tester",15:"Musicity",16:"Awe Member",17:"blue soon"]
    static let peepPics: [String] = ["emptyRectangle","charight","cleanergy","Portoflio","Spacechip","Cupidity","Animalife","Comingsoon","Theorize","Clouds","Shelfie","Traveld","Myme","Alexia","Beta Tester","Musicity","Awe Member","blue soon"]
   
    static let allImage:String = "all"
    static let topImage:String = "top"
    static let myImage:String = "my"
    //group
    static var GroupisSetTo:GroupOptions = .all
    static let GroupTabImage:String = "TabGroups"
    static let GroupBoxImage:String = "groupimage"
    static let GroupLabel:String = "groupslabel"
    //people
    static var PeopleisSetTo:PeopleOptions = .all
    static let PeopleTabImage:String = "TabPeople"
    static let PeoplecellImage:String = "pers"
    static let PeopleLabel:String = "peoplabel"
    //profile
    static var ProfileisSetTo:ProfileOptions = .peepOne
    static var editPeepMode:Bool = false
    static var peepSwitch:Int = 0
    static let ProfileTabImage:String = "TabProfile"
    static let ProfileLabel:String = "profilelabel"
    //planet
    static var PlanetisSetTo:PlanetOptions = .earth
    static let PlanetTabImage:String = "TabPlanet"
    static let PlanetLabel:String = "planetlabel"
    //event
    static let EventLabel:String = "eventslabel"
   
   
}

struct Person {
    static var currentOption:Peeple.ProfileOptions = .peepOne
    static var ID:String = ""
    static var name:String = ""
    static var peepOne:Int = 0
    static var peepTwo:Int = 0
    static var peepThree:Int = 0
    static var color:Int = 0
    static var pic:String = ""
    static var charight:charightChoice?
    static var clenny:cleanergyClenny?
    static var porty:portflioPost?
}
struct currentUser {
    static var ID:String = ""
    static var isARActive:Bool = false
    static let beta:Bool = false
    static var Pro:Bool = false
    static var priv:Bool = false
    static var biz:Bool?
    // deafults to 0 if empty
    static var myAppColor:Int = UserDefaults.standard.integer(forKey: "appColor")
    static var peepOne:Int = 1
    static var peepTwo:Int = 2
    static var peepThree:Int = 3
    static var name:String = ""
}
struct Peeps {
    static var charight:charightChoice?
    static var clenny:cleanergyClenny?
    static var porty:portflioPost?
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
struct ID {
    static var my:String = ""
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
                audioPlayer.volume = 0.3
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
