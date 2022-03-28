//
//  MainView.swift
//  People
//
//  Created by admin on 11/26/21.
//  Copyright © 2021 A Sirius Company. All rights reserved.
//

import UIKit
import RealmSwift
import AVFoundation
import CoreLocation
import MapKit

class MainPage: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,CLLocationManagerDelegate {
    // MARK: Variables and Constants
    private var stories: Results<earthFeed>?
    private var all_Groups: Results<allGroups>?
    private var search_Groups: Results<allGroups>?
    private var my_Groups: Results<myGroups>?
    private var all_People: Results<allPeople>?
    private var search_People: Results<allPeople>?
    private var my_People: Results<myPeople>?
    private var group_Events: Results<groupMessages>?
    private var all_Events: Results<groupMessages>?
    fileprivate var locationManager: CLLocationManager?
    lazy var geocoder = CLGeocoder()
    fileprivate var didPass:Bool = false
    private var myGroupLoaded:Bool = false
    private var myPeopleLoaded:Bool = false
    private var eventDuration:Int = 1
    // Peep Views
    private weak var peepOneView:UIView?
    private weak var peepTwoView:UIView?
    private weak var peepThreeView:UIView?
    private weak var personPeepOne:UIView?
    private weak var personPeepTwo:UIView?
    private weak var personPeepThree:UIView?
    // all pages
    // MARK: IBOutlets
    @IBOutlet weak var loadingIndicator: UIImageView!
    @IBOutlet weak var personPeepView: UIView!
    @IBOutlet weak var middleLabel: UILabel!
    @IBOutlet weak var PickPurchaseButton: UIButton!
    @IBOutlet weak var ARView: ARView!
    @IBOutlet weak var topWordLabel: UILabel!
    @IBOutlet weak var topRightLabel: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageOptionIndicator: UIImageView!
    // MARK: GroupPage
    @IBOutlet weak var addInfoView: UIView!
    @IBOutlet weak var infoTextField: UITextField!
    @IBOutlet weak var infoTextDescription: UITextField!
    @IBOutlet weak var eventDurationButton: UIButton!
    @IBOutlet weak var addInfoButton: UIButton!
    @IBAction func addInfo(_ sender: UIButton) {
        if Peeple.CurrentPage == .Group {
            if infoTextField.text == "" { return }
            
            guard let user = app.currentUser else { return }
            startLoading()
            guard let GroupName = infoTextField.text else { return }
            let groupDes:String = infoTextDescription.text ?? ""
            if GroupName.count >= 20 { return }
            let GroupCode:String = UUID().uuidString
            // if person is private add to all gorups
            if currentUser.priv == false {
                let now = Date()
                let partitionValue = "allGroups=\(Location.city)"
                // Get a sync configuration from the user object.
                let configuration = user.configuration(partitionValue: partitionValue)
                Realm.asyncOpen(configuration: configuration) { [self] (result) in
                    switch result {
                    case .failure(let error):
                        print(error.localizedDescription)
                        self.stopLoading()
                    case .success(let realm):
                        let newGroup = allGroups(name: GroupName, image: "", des: groupDes, userId: ID.my, color: currentUser.myAppColor,priv: currentUser.priv, dateMade: now,ID:GroupCode)
                        try! realm.write {
                            realm.add(newGroup,update: .modified)
                        }
                    }
                }
            }
            let partitionValue2 = "me=\(user.id)"
            // Get a sync configuration from the user object.
            let configuration2 = user.configuration(partitionValue: partitionValue2)
            Realm.asyncOpen(configuration: configuration2) { [self] (result) in
                switch result {
                case .failure(let error):
                    print(error)
                    self.stopLoading()
                case .success(let realm):
                    let myGroup = myGroups(name: GroupName, image: "", color: currentUser.myAppColor, des: infoTextDescription.text ?? "", userId: user.id, key: GroupCode)
                    if let me = realm.objects(mePerson.self).first {
                        try! realm.write {
                            me.myGroups.append(myGroup)
                        }
                    }
                    self.stopLoading()
                    self.infoTextField.text = ""
                    self.infoTextDescription.text = ""
                    self.addInfoView.isHidden = true
                    Peeple.GroupisSetTo = .my
                    fetchGroupData(user: user)
                }
                
            }
            
        }
        
        if Peeple.CurrentPage == .GroupChat {
            if Peeple.isLocationEnabled == false{
                locationManager?.requestWhenInUseAuthorization()
                return
            }
            
            locationManager?.startUpdatingLocation()
            addInfoView.isHidden = false
            if infoTextField.text == "" { return }
            guard let eventName = infoTextField.text else { return }
            if eventName.count >= 30 { return }
            let eventCode:String = UUID().uuidString
            guard let user = app.currentUser else { return }
            let now = Date()
            startLoading()
            print(now)
            let eventDes:String = infoTextDescription.text ?? ""
            let configuration1 = user.configuration(partitionValue: "groupMessages=\(Group.ID)")
            Realm.asyncOpen(configuration: configuration1) { [self] (result) in
                switch result {
                case .failure(let error):
                    print("Failed to open realm: \(error.localizedDescription)")
                    // Handle error...
                    self.stopLoading()
                case .success(let realm):
                    // Realm opened
                    let message = groupMessages(chatName: eventName, color: currentUser.myAppColor, peepOne: currentUser.peepOne, peepTwo: currentUser.peepTwo, peepThree: currentUser.peepThree, eventDuration: eventDuration, lat: Event.latitude, long: Event.longitude, chatMessage: eventDes, userId: user.id, isBiz: currentUser.biz, _id: eventCode, timeCode: now)
                    try! realm.write {
                        realm.add(message)
                    }
                    self.infoTextField.text = ""
                    self.infoTextDescription.text = ""
                    self.addInfoView.isHidden = true
                    self.eventDurationButton.isHidden = true
                    self.stopLoading()
                    self.collectionView.reloadData()
                }
            }
            if currentUser.priv == false {
                // write event to group page feed
                let configuration1 = user.configuration(partitionValue: "allEvents=\(Location.city)")
                Realm.asyncOpen(configuration: configuration1) { [self] (result) in
                    switch result {
                    case .failure(let error):
                        print("Failed to open realm: \(error.localizedDescription)")
                        // Handle error...
                        self.stopLoading()
                    case .success(let realm):
                        // Realm opened
                        let message = groupMessages(chatName: eventName, color: currentUser.myAppColor, peepOne: currentUser.peepOne, peepTwo: currentUser.peepTwo, peepThree: currentUser.peepThree, eventDuration: eventDuration, lat: Event.latitude, long: Event.longitude, chatMessage: eventDes, userId: user.id, isBiz: currentUser.biz, _id: eventCode, timeCode: now)
                        try! realm.write {
                            realm.add(message)
                        }
                    }
                }
            }
            
        }
        
    }
    func getEventDuration (from:Date) -> String {
        let now = Date()
        let diffComponents = Calendar.current.dateComponents([.minute], from: from, to: now)
        let minutes = diffComponents.minute ?? 0
        return "time elapsed \(minutes) minutes"
    }
    // MARK: ProfilePage
    @IBOutlet weak var profilePageView: UIView!
    @IBOutlet weak var editProfileView: UIView!
    @IBOutlet weak var MyCodeButton: UIButton!
    @IBOutlet weak var ARToggleButton: UIButton!
    @IBOutlet weak var ChangeColorButton: UIButton!
    @IBOutlet weak var PrivateToggleButton: UIButton!
    @IBOutlet weak var MyRequestsButton: UIButton!
    @IBOutlet weak var MyLocationButton: UIButton!
    @IBOutlet weak var pageTab: UIImageView!
    
    @IBAction func copyMyCode(_ sender: UIButton) {
        UIPasteboard.general.string = ID.my
        // Copied to Clipboard pop-up
        sender.isEnabled = false
        UIView.animate(withDuration: 0.8) {
            sender.isEnabled = true
        }
    }
    func setButtonColors(color:UIColor){
        MyCodeButton.setTitleColor(color, for: .normal)
        ARToggleButton.setTitleColor(color, for: .normal)
        ChangeColorButton.setTitleColor(color, for: .normal)
        PrivateToggleButton.setTitleColor(color, for: .normal)
        MyRequestsButton.setTitleColor(color, for: .normal)
        MyLocationButton.setTitleColor(color, for: .normal)
        PickPurchaseButton.setTitleColor(color, for: .normal)
    }
    @IBAction func ToggleAR(_ sender: UIButton) {
        currentUser.isARActive = !currentUser.isARActive
        UserDefaults.standard.set(currentUser.isARActive, forKey: "AR")
        startLoading()
        if currentUser.isARActive == false {
            view.backgroundColor = .systemGray6
            stopAR(on: ARView)
            stopLoading()
            sender.isEnabled = true
            sender.setTitle("turn on AR", for: .normal)
        } else {
            switch AVCaptureDevice.authorizationStatus(for: .video) {
            case .authorized: // the user has already authorized to access the camera.
                setUpAR()
                beginAR(on:ARView)
                stopLoading()
                sender.isEnabled = true
                sender.setTitle("turn off AR", for: .normal)
            case .notDetermined: // the user has not yet asked for camera access.
                AVCaptureDevice.requestAccess(for: .video) { [self] (granted) in
                    if granted { // if user has granted to access the
                        setUpAR()
                        beginAR(on: ARView)
                        stopLoading()
                        sender.isEnabled = true
                        sender.setTitle("turn off AR", for: .normal)
                    } else {
                        print("the user has not granted to access the camera")
                        sender.isEnabled = true
                    }
                }
            default:
                print("something has wrong due to we can't access the camera.")
                sender.isEnabled = true
                //                self.handleDismiss()
            }
            stopLoading()
        }
    }
    @IBAction func ChangeColor(_ sender: UIButton) {
        if currentUser.myAppColor >= 8 { currentUser.myAppColor = -1 }
        currentUser.myAppColor += 1
        UserDefaults.standard.set(currentUser.myAppColor, forKey: "appColor")
        pageOptionIndicator.tintColor = Peeple.colors[currentUser.myAppColor]
        pageTab.tintColor = Peeple.colors[currentUser.myAppColor]
        setButtonColors(color: Peeple.colors[currentUser.myAppColor])
        
    }
    
    @IBAction func TogglePrivate(_ sender: UIButton) {
        if currentUser.priv {
            sender.setTitle("enter private", for: .normal)
            currentUser.priv = false
        } else {
            currentUser.priv = true
            sender.setTitle("exit private", for: .normal)
        }
    }
    @IBAction func myRequests(_ sender: UIButton) {
    }
    @IBAction func ToggleLocation(_ sender: UIButton) {
        myCityPressed()
    }
    @IBAction func PickorPurchasePeeps(_ sender: UIButton) {
        middleLabel.text = "peeple pro - every peep in peeple for only $10. Press and Hold to purchase peeple pro for $10."
    }
    // MARK: Functions
    func addGestures(){
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        let zoomIn = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch(_:)))
        let hold = UILongPressGestureRecognizer(target: self, action: #selector(handleHold(_:)))
        leftSwipe.direction = .left
        rightSwipe.direction = .right
        upSwipe.direction = .up
        downSwipe.direction = .down
        hold.minimumPressDuration = 2
        view.addGestureRecognizer(hold)
        view.addGestureRecognizer(zoomIn)
        view.addGestureRecognizer(leftSwipe)
        view.addGestureRecognizer(rightSwipe)
        view.addGestureRecognizer(upSwipe)
        view.addGestureRecognizer(downSwipe)
    }
    // MARK: SwipeActions
    @objc func handlePinch(_ sender:UIPinchGestureRecognizer) {
        if sender.scale > 2 {
            Peeple.zoomLevel = .one
        }else if sender.scale > 0.5 && sender.scale < 1.5 {
            Peeple.zoomLevel = .two
        } else {
            // if sender.scale <= 0.7
            Peeple.zoomLevel = .max
        }
        collectionView.reloadData()
    }
    
    @objc func handleHold(_ sender:UILongPressGestureRecognizer) {
        if Peeple.CurrentPage == .GroupChat {
            if sender.state == .began {
                if Group.ID != "" {
                    guard let user = app.currentUser else { return }
                    let partitionValue2 = "me=\(user.id)"
                    startLoading()
                    let pasteboard = UIPasteboard.general
                    pasteboard.string = Group.ID
                    // Get a sync configuration from the user object.
                    let configuration2 = user.configuration(partitionValue: partitionValue2)
                    Realm.asyncOpen(configuration: configuration2) { [self] (result) in
                        switch result {
                        case .failure(let error):
                            print(error)
                            self.stopLoading()
                        case .success(let realm):
                            let myGroup = myGroups(name: Group.name, image: Group.pic, color: Group.color, des: Group.des, userId: user.id, key: Group.ID)
                            if let me = realm.objects(mePerson.self).first {
                                try! realm.write { me.myGroups.append(myGroup) } }
                            self.stopLoading()
                            let alert = UIAlertController(title: "\(Group.name) added to my groups", message: "\(Group.name) : copied to clipboard", preferredStyle: .alert)
                            self.myGroupLoaded = false
                            alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                        }
                    }
                }
                
            }
        }
        if Peeple.CurrentPage == .Group {
            if Peeple.GroupisSetTo == .search {
                if sender.state == .began {
                    guard let text = UIPasteboard.general.string else { return }
                    var didQuery:Bool = false
                    didQuery = findGroups(text: filterSearchString(text: text))
                    print("search success and did query is: \(didQuery)")
                }
            }
        }
        if Peeple.CurrentPage == .People {
            if sender.state == .began {
                guard let text = UIPasteboard.general.string else { return }
                var didQuery:Bool = false
                didQuery = findPeople(text: filterSearchString(text: text))
                print("search success and did query is: \(didQuery)")
                
            }
        }
        if Peeple.CurrentPage == .Profile {
            if sender.state == .began {
                
                
            }
            
        }
        if Peeple.CurrentPage == .Person {
            if sender.state == .began {
                if Person.ID != "" {
                    guard let user = app.currentUser else { return }
                    let partitionValue2 = "me=\(user.id)"
                    startLoading()
                    let pasteboard = UIPasteboard.general
                    pasteboard.string = Person.ID
                    // Get a sync configuration from the user object.
                    let configuration2 = user.configuration(partitionValue: partitionValue2)
                    Realm.asyncOpen(configuration: configuration2) { [self] (result) in
                        switch result {
                        case .failure(let error):
                            print(error)
                            self.stopLoading()
                        case .success(let realm):
                            let myPerson = myPeople(color: Person.color, image: "\(Person.color)", name: Person.name, bio: "", one: Person.peepOne, two: Person.peepTwo, three: Person.peepThree, _id: Person.ID)
                            if let me = realm.objects(mePerson.self).first {
                                try! realm.write { me.myPeople.append(myPerson) } }
                            self.stopLoading()
                            let alert = UIAlertController(title: "\(Person.name) added to my people", message: "\(Person.name) : copied to clipboard", preferredStyle: .alert)
                            self.myGroupLoaded = false
                            alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
                            self.present(alert, animated: true, completion: nil)
                        }
                    }
                    
                }
            }
            
        }
    }
    @objc func handleSwipes(_ sender:UISwipeGestureRecognizer) {
        guard let user = app.currentUser else { return }
        // alpha animating page switch with Util function
        MusicPlayer.shared.playPeep()
        switch sender.direction {
        case .left:
            // page to the right
            
            switch Peeple.CurrentPage {
            case .Planet:
                fetchGroupData(user: user)
            case .Group:
                fetchPeopleData(user: user)
            case .People:
                fetchProfileData(user:user)
            case .Profile:
                return
            case .GroupChat:
                fetchGroupData(user: user)
            case .Person:
                emptyPerson()
                for view in personPeepView.subviews {
                    view.removeFromSuperview()  }
                fetchPeopleData(user: user)
            }
        case .right:
            // page to the left
            print("page to the left | direction left")
            switch Peeple.CurrentPage {
            case .Planet:
                return
            case .Group:
                fetchPlanetData(user: user)
            case .People:
                fetchGroupData(user: user)
            case .Profile:
                fetchPeopleData(user: user)
            case .GroupChat:
                fetchGroupData(user: user)
            case .Person:
                emptyPerson()
                for view in personPeepView.subviews {
                    view.removeFromSuperview()  }
                fetchPeopleData(user: user)
            }
        case .up:
            //option UP
            // setting next option + refresh data
            print("option UP")
            switch Peeple.CurrentPage {
            case .Planet:
                switch Peeple.PlanetisSetTo {
                case .earth:
                    Peeple.PlanetisSetTo = .mars
                case .mars:
                    Peeple.PlanetisSetTo = .moon
                case .moon:
                    Peeple.PlanetisSetTo = .space
                case .space:
                    Peeple.PlanetisSetTo = .earth
                }
                fetchPlanetData(user: user)
            case .Group:
                switch Peeple.GroupisSetTo {
                case .all:
                    Peeple.GroupisSetTo = .my
                case .my:
                    Peeple.GroupisSetTo = .search
                case .search:
                    Peeple.GroupisSetTo = .make
                case .make:
                    Peeple.GroupisSetTo = .events
                    
                case .events:
                    Peeple.GroupisSetTo = .all
                }
                fetchGroupData(user: user)
            case .People:
                switch Peeple.PeopleisSetTo {
                case .all:
                    Peeple.PeopleisSetTo = .my
                case .my:
                    Peeple.PeopleisSetTo = .search
                case .search:
                    Peeple.PeopleisSetTo = .all
                }
                fetchPeopleData(user: user)
            case .Profile:
                switch Peeple.ProfileisSetTo {
                case .peepOne:
                    Peeple.ProfileisSetTo = .peepTwo
                case .peepTwo:
                    Peeple.ProfileisSetTo = .peepThree
                case .peepThree:
                    Peeple.ProfileisSetTo = .settings
                case .settings:
                    Peeple.ProfileisSetTo = .peepOne
                }
                peepSwitch(peepImage: pageOptionIndicator, peepOneView: peepOneView, peepTwoView: peepTwoView, peepThreeView: peepThreeView, optionsView: editProfileView, allPeepView: profilePageView, currentOption: Peeple.ProfileisSetTo,peepOne: currentUser.peepOne,peepTwo: currentUser.peepTwo,peepThree: currentUser.peepThree)
            case .GroupChat:
                fetchGroupData(user: user)
            case .Person:
                switch Person.currentOption {
                case .peepOne:
                    Person.currentOption = .peepTwo
                case .peepTwo:
                    Person.currentOption = .peepThree
                case .peepThree:
                    Person.currentOption = .settings
                case .settings:
                    Person.currentOption = .peepOne
                }
                peepSwitch(peepImage: pageOptionIndicator, peepOneView: personPeepOne, peepTwoView: personPeepTwo, peepThreeView: personPeepThree, optionsView: editProfileView, allPeepView: personPeepView, currentOption: Person.currentOption,peepOne: Person.peepOne,peepTwo: Person.peepTwo,peepThree: Person.peepThree)
            }
        case .down:
            //option down
            // setting next option + refresh data
            print("option DOWN")
            switch Peeple.CurrentPage {
            case .Planet:
                switch Peeple.PlanetisSetTo {
                case .earth:
                    Peeple.PlanetisSetTo = .space
                case .mars:
                    Peeple.PlanetisSetTo = .earth
                case .moon:
                    Peeple.PlanetisSetTo = .mars
                case .space:
                    Peeple.PlanetisSetTo = .moon
                }
                fetchPlanetData(user: user)
            case .Group:
                switch Peeple.GroupisSetTo {
                case .all:
                    Peeple.GroupisSetTo = .events
                case .my:
                    Peeple.GroupisSetTo = .all
                case .search:
                    Peeple.GroupisSetTo = .my
                case .make:
                    Peeple.GroupisSetTo = .search
                    
                case .events:
                    Peeple.GroupisSetTo = .make
                }
                fetchGroupData(user: user)
            case .People:
                switch Peeple.PeopleisSetTo {
                case .all:
                    Peeple.PeopleisSetTo = .search
                case .my:
                    Peeple.PeopleisSetTo = .all
                case .search:
                    Peeple.PeopleisSetTo = .my
                }
                fetchPeopleData(user: user)
            case .Profile:
                switch Peeple.ProfileisSetTo {
                case .peepOne:
                    Peeple.ProfileisSetTo = .settings
                case .peepTwo:
                    Peeple.ProfileisSetTo = .peepOne
                case .peepThree:
                    Peeple.ProfileisSetTo = .peepTwo
                case .settings:
                    Peeple.ProfileisSetTo = .peepThree
                }
                peepSwitch(peepImage: pageOptionIndicator, peepOneView: peepOneView, peepTwoView: peepTwoView, peepThreeView: peepThreeView, optionsView: editProfileView, allPeepView: profilePageView, currentOption: Peeple.ProfileisSetTo,peepOne: currentUser.peepOne,peepTwo: currentUser.peepTwo,peepThree: currentUser.peepThree)
            case .GroupChat:
                fetchGroupData(user: user)
            case .Person:
                switch Person.currentOption {
                case .peepOne:
                    Person.currentOption = .settings
                case .peepTwo:
                    Person.currentOption = .peepOne
                case .peepThree:
                    Person.currentOption = .peepTwo
                case .settings:
                    Person.currentOption = .peepThree
                }
                peepSwitch(peepImage: pageOptionIndicator, peepOneView: personPeepOne, peepTwoView: personPeepTwo, peepThreeView: personPeepThree, optionsView: editProfileView, allPeepView: personPeepView, currentOption: Person.currentOption,peepOne: Person.peepOne,peepTwo: Person.peepTwo,peepThree: Person.peepThree)
            }
            
        default:
            return
        }
    }
    
    func ARSetUp(){
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized: // the user has already authorized to access the camera.
            setUpAR()
            beginAR(on:ARView)
            currentUser.isARActive = true
            ARToggleButton.setTitle("turn off AR", for: .normal)
            stopLoading()
        case .notDetermined: // the user has not yet asked for camera access.
            AVCaptureDevice.requestAccess(for: .video) { [self] (granted) in
                if granted {
                    currentUser.isARActive = true
                    DispatchQueue.main.async {
                        setUpAR()
                        beginAR(on: ARView)
                        ARToggleButton.setTitle("turn off AR", for: .normal)
                        stopLoading()
                    }// if user has granted to access the
                    
                } else {
                    DispatchQueue.main.async {
                        print("the user has not granted to access the camera")
                        stopLoading()
                    }
                }
            }
        default:
            print("something has wrong due to we can't access the camera.")
            stopLoading()
        }
    }
    func layoutUI(){
        DispatchQueue.main.async { [self] in
            pageOptionIndicator.addShadow()
            pageTab.addShadow()
            topRightLabel.addShadow()
            pageOptionIndicator.layer.cornerRadius = Peeple.cornerRadius / 3
            pageOptionIndicator.tintColor = Peeple.colors[currentUser.myAppColor]
            pageTab.tintColor = Peeple.colors[currentUser.myAppColor]
            setButtonColors(color: Peeple.colors[currentUser.myAppColor])
            infoTextField.textColor = Peeple.colors[currentUser.myAppColor]
            addInfoButton.setTitleColor(Peeple.colors[currentUser.myAppColor], for: .normal)
            addInfoButton.buttonify(color: Peeple.colors[currentUser.myAppColor])
        }
    }
    override var prefersStatusBarHidden: Bool {
        return false
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    // MARK: ViewDidLoad
    override func viewDidLoad() {
        collectionView.delegate = self
        collectionView.dataSource = self
        layoutUI()
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        ID.my = UserDefaults.standard.string(forKey: "myCode") ?? ""
        currentUser.isARActive = UserDefaults.standard.bool(forKey: "AR")
        collectionView.register(UINib(nibName: "MainCell", bundle: nil), forCellWithReuseIdentifier: "MainCell")
        addGestures()
        currentUser.myAppColor = UserDefaults.standard.integer(forKey: "appColor")
        hideKeyboardWhenTappedAround()
        startLoading()
        ARSetUp()
        // Do any additional setup after loading the view.
        guard let user = app.currentUser else {
            stopLoading()
            print("no app current user")
            return }
        let partitionValue = "me=\(user.id)"
        // Get a sync configuration from the user object.
        let configuration = user.configuration(partitionValue: partitionValue)
        Realm.asyncOpen(configuration: configuration) { (result) in
            switch result {
            case .failure(let error):
                print("Failed to open realm: \(error.localizedDescription)")
            case .success(let Realm):
                if let me = Realm.objects(mePerson.self).first {
                    // loading profile peeps and hiding them
                    print("found mePerson")
                    UserDefaults.standard.set(user.id, forKey: "myCode")
                    currentUser.priv = me.priv
                    currentUser.ID = user.id
                    currentUser.peepOne = me.one
                    currentUser.name = me.name
                    currentUser.peepTwo = me.two
                    currentUser.peepThree = me.three
                    self.loadPeepData(one: me.one, two: me.two, three: me.three, uid: user.id)
                } else {
                    print("mePerson not found")
                }
                
            }
        }
        fetchPlanetData(user:user)
        
    }
    // MARK: ViewDidAppear
    override func viewDidAppear(_ animated: Bool) {
        locationManager?.delegate = self
    }
    // MARK: ItemsHeightandWidth
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch Peeple.CurrentPage {
        case .Planet:
            switch Peeple.zoomLevel{
            case .one:
                return CGSize(width: collectionView.frame.width, height: collectionView.frame.width)
            case .two:
                return CGSize(width: collectionView.frame.width, height: collectionView.frame.height/3)
            case .max:
                return CGSize(width: collectionView.frame.width, height: collectionView.frame.height/4)
            }
        case .Group:
            if Peeple.GroupisSetTo == .events { return CGSize(width: collectionView.frame.width, height: collectionView.frame.height/3) }
            switch Peeple.zoomLevel{
            case .one:
                return CGSize(width: collectionView.frame.width, height: collectionView.frame.height/2)
            case .two:
                return CGSize(width: collectionView.frame.width/2, height: collectionView.frame.height/4)
            case .max:
                return CGSize(width: collectionView.frame.width/3, height: collectionView.frame.height/5)
            }
            
        case .People:
            switch Peeple.zoomLevel{
            case .one:
                return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
            case .two:
                return CGSize(width: collectionView.frame.width/2, height: collectionView.frame.height/2)
            case .max:
                return CGSize(width: collectionView.frame.width/3, height: collectionView.frame.height/3)
            }
            
        case .Profile:
            return CGSize(width: 0, height: 0)
        case .GroupChat:
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height/3)
        case .Person:
            return CGSize(width: 0, height: 0)
        }
        
    }
    // MARK: ItemsInSection
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch Peeple.CurrentPage {
        case .Planet:
            switch Peeple.PlanetisSetTo {
            case .earth:
                return count(count: stories?.count ?? 0)
            case .mars:
                return 1
            case .moon:
                return 1
            case .space:
                return 1
                
            }
        case .Group:
            switch Peeple.GroupisSetTo {
            case .all:
                return count(count: all_Groups?.count ?? 0)
            case .my:
                return count(count: my_Groups?.count ?? 0)
            case .search:
                return count(count: search_Groups?.count ?? 0)
            case .make:
                return 0
            case .events:
                return count(count: all_Events?.count ?? 0)
            }
        case .People:
            switch Peeple.PeopleisSetTo{
            case .all:
                return count(count: all_People?.count ?? 0)
            case .my:
                return count(count: my_People?.count ?? 0)
            case .search:
                return count(count: search_People?.count ?? 0)
            }
        case .Profile:
            return 0
        case .GroupChat:
            return count(count: group_Events?.count ?? 0)
        case .Person:
            return 0
        }
        
    }
    // MARK: CellForItem
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCell", for: indexPath) as! MainViewCell
        cell.mainImageView.addShadow()
        switch Peeple.CurrentPage {
        case .Planet:
            switch Peeple.PlanetisSetTo {
            case .earth:
                cell.peeplePeeps = stories?[indexPath.row]
            case .mars:
                cell.mainImageView.image = UIImage(named: "mars")
            case .moon:
                cell.mainImageView.image = UIImage(named: "moon")
            case .space:
                cell.mainImageView.image = UIImage(named: "logopng")
            }
            return cell
        case .Group:
            switch Peeple.GroupisSetTo {
            case .all:
                cell.allGroups = all_Groups?[indexPath.row]
            case .my:
                cell.myGroups = my_Groups?[indexPath.row]
            case .search:
                return cell
            case .make:
                return cell
            case .events:
                cell.allEvents = all_Events?[indexPath.row]
            }
            return cell
        case .People:
            switch Peeple.PeopleisSetTo{
            case .all:
                cell.allPeople = all_People?[indexPath.row]
            case .my:
                cell.myPeople = my_People?[indexPath.row]
            case .search:
                cell.searchPeople = search_People?[indexPath.row] }
            return cell
        case .Profile:
            return cell
        case .GroupChat:
            cell.groupEvents = group_Events?[indexPath.row]
            return cell
        case .Person:
            return cell
        }
    }
    // MARK: DidSelectItem
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch Peeple.CurrentPage {
        case .Planet:
            switch Peeple.PlanetisSetTo {
            case .earth:
                guard let person = stories?[indexPath.row] else { return }
                // save previous page
                toPersonWith(ID: person._id, name: person.name, pic: person.imgeurl, color: person.color, one: person.peepone, two: person.peeptwo, three: person.peepthree)
            case .mars:
                return
            case .moon:
                return
            case .space:
                return
            }
        case .Group:
            // saving previus page
            switch Peeple.GroupisSetTo {
            case .all:
                guard let group = all_Groups?[indexPath.row] else { return }
                toGroupChatWith(ID: group._id, name: group.name, pic: group.image, color: group.color, des: group.des)
            case .my:
                guard let group = my_Groups?[indexPath.row] else { return }
                toGroupChatWith(ID: group.key, name: group.name, pic: group.image, color: group.color, des: group.des)
            case .search:
                return
            case .make:
                return
            case .events:
                guard let event = all_Events?[indexPath.row] else { return }
                // to event in maps
                print(getEventDuration(from: event.timeCode))
                let coordinates = CLLocationCoordinate2DMake(event.lat,event.long)
                
                let regionSpan =   MKCoordinateRegion(center: coordinates, latitudinalMeters: 1000, longitudinalMeters: 1000)
                
                let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
                
                let mapItem = MKMapItem(placemark: placemark)
                
                mapItem.name = "\(event.chatName) : \(event.chatMessage)"
                
                mapItem.openInMaps(launchOptions:[
                    MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center)
                ] as [String : Any])
            }
            
        case .People:
            // saving the previous page to return upon swipe back
            switch Peeple.PeopleisSetTo{
            case .all:
                guard let person = all_People?[indexPath.row] else { return }
                toPersonWith(ID: person._id, name: person.name, pic: person.image, color: person.color, one: person.one, two: person.two, three: person.three)
            case .my:
                guard let person = my_People?[indexPath.row] else { return }
                toPersonWith(ID: person._id, name: person.name, pic: person.image, color: person.color, one: person.one, two: person.two, three: person.three)
            case .search:
                guard let person = search_People?[indexPath.row] else { return }
                toPersonWith(ID: person._id, name: person.name, pic: person.image, color: person.color, one: person.one, two: person.two, three: person.three)
            }
        case .Profile:
            return
        case .GroupChat:
            guard let event = group_Events?[indexPath.row] else { return }
            // to event in maps
            print(getEventDuration(from: event.timeCode))
            let coordinates = CLLocationCoordinate2DMake(event.lat,event.long)
            
            let regionSpan =   MKCoordinateRegion(center: coordinates, latitudinalMeters: 1000, longitudinalMeters: 1000)
            
            let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
            
            let mapItem = MKMapItem(placemark: placemark)
            
            mapItem.name = "\(event.chatName) : \(event.chatMessage)"
            
            mapItem.openInMaps(launchOptions:[
                MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center)
            ] as [String : Any])
            
            
            
        case .Person:
            return
        }
    }
    
    
    
    // MARK: Location Manager
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print("here11")
        guard let location = locations.first else {
            return
        }
        if didPass {
            self.stopLoading()
            self.locationManager?.stopUpdatingLocation()
            return }
        Event.latitude = location.coordinate.latitude
        Event.longitude = location.coordinate.longitude
        
        UserDefaults.standard.set(true, forKey: "isLocationEnabled")
        Peeple.isLocationEnabled = true
        didPass = true
        geocoder.reverseGeocodeLocation(location) { (placemarks, error) in
            // Process Response
            self.processResponse(withPlacemarks: placemarks, error: error)
        }
        print("here1")
        
    }
    @nonobjc func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
        
    }
    private func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
        //This method does real time status monitoring.
        
        switch status {
        case .notDetermined:
            print(".NotDetermined")
            Peeple.isLocationEnabled = false
            break
            
        case .authorizedAlways:
            locationManager?.startUpdatingLocation()
            startLoading()
        case .denied:
            print(".Denied")
            Peeple.isLocationEnabled = false
            break
            
        case .authorizedWhenInUse:
            print(".whenisuse")
            locationManager?.startUpdatingLocation()
            startLoading()
        case .restricted:
            print(".Restricted")
            Peeple.isLocationEnabled = false
            break
            
        default:
            print("Unhandled authorization status")
            Peeple.isLocationEnabled = false
            break
            
        }
    }
    func processResponse(withPlacemarks placemarks: [CLPlacemark]?, error: Error?) {
        // Update View
        if let error = error {
            print("Unable to Reverse Geocode Location (\(error))")
            self.stopLoading()
            self.locationManager?.stopUpdatingLocation()
        } else {
            print("here3")
            if let placemarks = placemarks, let placemark = placemarks.first {
                if let City = placemark.city {
                    Location.city = City
                    UserDefaults.standard.set(City, forKey: "city")
                }
                if let country = placemark.country {
                    Location.country = country
                    UserDefaults.standard.set(country, forKey: "country")
                }
                self.stopLoading()
                if currentUser.priv == false {
                    addAllPerson()
                }
                MyLocationButton.isEnabled = false
                self.locationManager?.stopUpdatingLocation()
            } else {
                print("No Matching Addresses Found")
                self.stopLoading()
                MyLocationButton.isEnabled = false
                self.locationManager?.stopUpdatingLocation()
            }
        }
    }
    
    // MARK: loadingIndicator
    func stopLoading() {
        loadingIndicator.isHidden = true
        UIView.animate(withDuration: 0.5) { self.collectionView.alpha = 1 }
        timer?.invalidate()
        timer = nil
    }
    func startLoading() {
        loadingIndicator.isHidden = false
        UIView.animate(withDuration: 0.5) { self.collectionView.alpha = 0 }
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval:0.0, target: self, selector: #selector(animateView), userInfo: nil, repeats: false)
        }
    }
    var timer: Timer?
    
    @objc func animateView() {
        UIView.animate(withDuration: 0.7, delay: 0.0, options: .curveLinear, animations: {
            self.loadingIndicator.transform = self.loadingIndicator.transform.rotated(by: CGFloat(Double.pi))
        }, completion: { (finished) in
            if self.timer != nil {
                self.timer = Timer.scheduledTimer(timeInterval:0.0, target: self, selector: #selector(self.animateView), userInfo: nil, repeats: false)
            }
        })
    }
    // MARK: AR Mode
    var captureSession: AVCaptureSession?
    func beginAR(on:ARView){
        print("beginARCalled")
        guard let capt = captureSession else { return }
        on.videoPreviewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        on.videoPreviewLayer.frame = view.layer.bounds
        on.videoPreviewLayer.session = capt
        DispatchQueue.global(qos: .userInitiated).async { capt.startRunning() }
    }
    func stopAR(on:ARView){
        DispatchQueue.main.async {
            on.videoPreviewLayer.session = nil }
    }
    func setUpAR() {
        captureSession = AVCaptureSession()
        guard let capt = captureSession else { return }
        guard let captureDevice = AVCaptureDevice.default(for: AVMediaType.video) else { return }
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            capt.addInput(input)
        } catch {
            print(error)
        }
    }
}
extension MainPage {
    // MARK: Functions
    func myCityPressed(){
        let status = locationManager?.authorizationStatus
        switch status {
        case .notDetermined:
            locationManager?.requestWhenInUseAuthorization()
            locationManager?.startUpdatingLocation()
        case .authorizedAlways:
            print(".AuthorizedAlways")
            break
        case .denied:
            let alert = UIAlertController(title: "enable location in settings", message: "Settings -> peeple -> location", preferredStyle: .alert)
            //2. Add the text field. You can configure it however you need.
            alert.addAction(UIAlertAction(title: "NOPE", style: .cancel, handler: { (_) in
            }))
            alert.addAction(UIAlertAction(title: "SURE", style: .default, handler: { (_) in
            }))
            present(alert, animated: true, completion: nil)
        case .authorizedWhenInUse:
            locationManager?.startUpdatingLocation()
            startLoading()
        case .restricted:
            print(".Restricted")
            break
        default:
            locationManager?.requestWhenInUseAuthorization()
            locationManager?.startUpdatingLocation()
        }
        
    }
    func fetchPlanetData(user:User){
        
        Peeple.CurrentPage = .Planet
        addInfoView.isHidden = true
        pageTab.image = nil
        animateViews(labelImage: topRightLabel, collection: collectionView, topRightBut: pageOptionIndicator, middleLabel: middleLabel, peepView: profilePageView, completionHandler: { (true) in
            topRightLabel.image = UIImage(named: Peeple.PlanetLabel)
            profilePageView.isHidden = true
            pageTab.isHidden = false
            self.addInfoButton.isHidden = true
            middleLabel.isHidden = true
            collectionView.reloadData()
            pageOptionIndicator.image = nil
        })
        switch Peeple.PlanetisSetTo {
        case .earth:
            if self.stories == nil {
                guard let user = app.currentUser else { return }
                startLoading()
                // Get a sync configuration from the user object.
                let config = user.configuration(partitionValue: "earthFeed=\(Location.country)")
                // Open the realm asynchronously to ensure backend data is downloaded first.
                Realm.asyncOpen(configuration: config) { (result) in
                    switch result {
                    case .failure(let error):
                        print("Failed to open realm: \(error.localizedDescription)")
                        self.stopLoading()
                    case .success(let Realm):
                        self.stories = Realm.objects(earthFeed.self).sorted(byKeyPath: "_id")
                        
                        print("stories filled")
                        self.stopLoading()
                    }
                    self.collectionView.reloadData()
                }
            }
            if self.stories?.count == 0 {
                self.middleLabel.text = "nothing shared here yet : \(Location.country)"
                self.middleLabel.isHidden = false
            }
            collectionView.reloadData()
            
        case .mars:
            collectionView.reloadData()
        case .moon:
            collectionView.reloadData()
        case .space:
            collectionView.reloadData()
        }
    }
    func fetchGroupData(user:User){
        Peeple.CurrentPage = .Group
        pageTab.image = nil
        animateViews(labelImage: topRightLabel, collection: collectionView, topRightBut: pageOptionIndicator, middleLabel: middleLabel, peepView: profilePageView, completionHandler: { (true) in
            topRightLabel.image = UIImage(named: Peeple.GroupLabel)
            topRightLabel.isHidden = false
            profilePageView.isHidden = true
            pageTab.isHidden = false
            topWordLabel.text = ""
            addInfoButton.isHidden = true
            middleLabel.isHidden = true
            pageOptionIndicator.isHidden = false
            pageOptionIndicator.image = nil
            collectionView.reloadData()
        })
        switch Peeple.GroupisSetTo {
        case .all:
            addInfoView.isHidden = true
            if all_Groups == nil {
                startLoading()
                self.middleLabel.text = "all groups"
                self.middleLabel.isHidden = false
                // The partition determines which subset of data to access.
                let partitionValue = "allGroups=\(Location.city)"
                // Get a sync configuration from the user object.
                let configuration = user.configuration(partitionValue: partitionValue)
                Realm.asyncOpen(configuration: configuration) { (result) in
                    switch result {
                    case .failure(let error):
                        print("Failed to open realm: \(error.localizedDescription)")
                        self.stopLoading()
                    case .success(let Realm):
                        self.all_Groups = Realm.objects(allGroups.self).sorted(byKeyPath: "_id")
                        //                    self.middleLabel.isHidden = true
                        self.stopLoading()
                        self.collectionView.reloadData()
                    }
                } }
            if all_Groups?.count == 0 {
                self.middleLabel.text = "all groups"
                self.middleLabel.isHidden = false
            }
            self.collectionView.reloadData()
        case .my:
            addInfoView.isHidden = true
            if self.myGroupLoaded == false {
                self.middleLabel.text = "my groups"
                self.middleLabel.isHidden = false
                print("pre load check")
                startLoading()
                print("in loading")
                // The partition determines which subset of data to access.
                let partitionValue = "me=\(user.id)"
                // Get a sync configuration from the user object.
                let configuration = user.configuration(partitionValue: partitionValue)
                Realm.asyncOpen(configuration: configuration) { (result) in
                    switch result {
                    case .failure(let error):
                        print("Failed to open realm: \(error.localizedDescription)")
                        self.myGroupLoaded = true
                        self.stopLoading()
                    case .success(let Realm):
                        if let me = Realm.objects(mePerson.self).first {
                            print("mePerson found")
                            self.my_Groups = me.myGroups.sorted(byKeyPath: "des", ascending: false)
                            //                        self.middleLabel.isHidden = true
                            self.collectionView.reloadData()
                            self.myGroupLoaded = true
                            print("loaded from realm")
                        } else {
                            print("mePerson not found")
                        }
                        
                        self.stopLoading()
                    }
                }  }
            if my_Groups?.count == 0 {
                self.middleLabel.text = "my groups"
                self.middleLabel.isHidden = false
            }
            self.collectionView.reloadData()
        case .search:
            pageOptionIndicator.image = nil
            addInfoView.isHidden = true
            self.addInfoButton.isHidden = true
            middleLabel.text = "press and hold screen to search clipboard"
            middleLabel.isHidden = false
            collectionView.reloadData()
        case .make:
            
            addInfoButton.setTitle("Make Group", for: .normal)
            
            infoTextField.placeholder = "Group Name"
            infoTextDescription.placeholder = "Description"
            
            pageOptionIndicator.image = nil
            UIView.animate(withDuration: 1.0) {
                self.addInfoButton.isHidden = false
                self.addInfoView.isHidden = false
            }
            collectionView.reloadData()
        case .events:
            print("events")
            self.addInfoView.isHidden = true
            self.addInfoButton.isHidden = true
            topRightLabel.image = UIImage(named: Peeple.EventLabel)
            middleLabel.text = "live events near me : \(Location.city)"
            middleLabel.isHidden = false
            if all_Events == nil {
                startLoading()
                let configuration1 = user.configuration(partitionValue: "allEvents=\(Location.city)")
                Realm.asyncOpen(configuration: configuration1) { [self] (result) in
                    switch result {
                    case .failure(let error):
                        print("Failed to open realm: \(error.localizedDescription)")
                        // Handle error...
                        self.stopLoading()
                    case .success(let realm):
                        // Realm opened
                        let unfiltered_Events = realm.objects(groupMessages.self)
                        self.all_Events = filterLiveEvents(realm: realm, unfilteredArray: unfiltered_Events)
                        stopLoading()
                        collectionView.reloadData()
                        
                    }
                    
                }
                
            }
            if all_Events?.count == 0 {
                middleLabel.text = "no live events near me : \(Location.city)"
                middleLabel.isHidden = false
            }
            pageOptionIndicator.image = nil
            self.collectionView.reloadData()
        }
        
    }
    
    func fetchPeopleData(user:User){
        Peeple.CurrentPage = .People
        animateViews(labelImage: topRightLabel, collection: collectionView, topRightBut: pageOptionIndicator, middleLabel: middleLabel, peepView: profilePageView, completionHandler: { (true) in
            collectionView.reloadData()
            collectionView.isHidden = false
            // accessing all views relevant to peoplePage
            // hide all at first
            personPeepView.isHidden = true
            pageTab.image = nil
            self.addInfoButton.isHidden = true
            // setting pageLabel image
            topRightLabel.image = UIImage(named: Peeple.PeopleLabel)
            // unhiding label when from a persons profile
            topRightLabel.isHidden = false
            pageTab.isHidden = false
            //        middleLabel.isHidden = true
            pageOptionIndicator.isHidden = false
            pageOptionIndicator.image = nil
            // hiding group view
            addInfoView.isHidden = true
            // hiding profile page info
            editProfileView.isHidden = true
            //        middleLabel.isHidden = false
            profilePageView.isHidden = true
        })
        switch Peeple.PeopleisSetTo {
        case .all:
            if all_People == nil {
                startLoading()
                self.middleLabel.text = "all people"
                self.middleLabel.isHidden = false
                // The partition determines which subset of data to access.
                let partitionValue = "allPeople=\(Location.country)"
                // Get a sync configuration from the user object.
                let configuration = user.configuration(partitionValue: partitionValue)
                Realm.asyncOpen(configuration: configuration) { (result) in
                    switch result {
                    case .failure(let error):
                        print("Failed to open realm: \(error.localizedDescription)")
                        self.stopLoading()
                    case .success(let Realm):
                        self.all_People = Realm.objects(allPeople.self).sorted(byKeyPath: "_id")
                        self.middleLabel.isHidden = false
                        self.stopLoading()
                        self.collectionView.reloadData()
                    }
                } }
            if self.all_People?.count == 0 {
                self.middleLabel.text = "no people in this area : \(Location.country)"
                self.middleLabel.isHidden = false
            }
            self.collectionView.reloadData()
        case .my:
            if my_People == nil {
                self.middleLabel.text = "my people"
                self.middleLabel.isHidden = false
                if self.myPeopleLoaded { return }
                startLoading()
                // The partition determines which subset of data to access.
                let partitionValue = "me=\(user.id)"
                // Get a sync configuration from the user object.
                let configuration = user.configuration(partitionValue: partitionValue)
                Realm.asyncOpen(configuration: configuration) { (result) in
                    switch result {
                    case .failure(let error):
                        print("Failed to open realm: \(error.localizedDescription)")
                        self.myPeopleLoaded = true
                        self.stopLoading()
                    case .success(let Realm):
                        // fill my_people array
                        if let me = Realm.objects(mePerson.self).first {
                            self.my_People = me.myPeople.sorted(byKeyPath: "_id")
                            self.myPeopleLoaded = true
                        }
                        self.stopLoading()
                        self.collectionView.reloadData()
                        
                    }
                    
                }
                
            }
            if self.my_People?.count == 0 {
                self.middleLabel.text = "my people"
                self.middleLabel.isHidden = false
            }
            collectionView.reloadData()
        case .search:
            pageOptionIndicator.image = nil
            middleLabel.text = "hold screen to search clipboard"
            middleLabel.isHidden = false
            collectionView.reloadData()
        }
    }
    func fetchProfileData(user:User){
        Peeple.CurrentPage = .Profile
        Person.ID = currentUser.ID
        animateViews(labelImage: topRightLabel, collection: collectionView, topRightBut: pageOptionIndicator, middleLabel: middleLabel, peepView: profilePageView, completionHandler: { (true) in
            pageOptionIndicator.image = UIImage(named: Peeple.peepPics[currentUser.peepOne])
            pageTab.image = nil
            topRightLabel.image = UIImage(named: Peeple.ProfileLabel)
            collectionView.reloadData()
            profilePageView.isHidden = false
            collectionView.isHidden = true
            middleLabel.isHidden = true })
        if peepOneView == nil {
            self.peepOneView = loadPeep(num: currentUser.peepOne)
            self.peepTwoView = loadPeep(num: currentUser.peepTwo)
            self.peepThreeView = loadPeep(num: currentUser.peepThree)
            let peepViews:[UIView?] = [peepOneView,peepTwoView,peepThreeView]
            for peeps in peepViews {
                guard let view = peeps else { break }
                view.isHidden = true
                profilePageView.addSubview(view)
                profilePageView.sendSubviewToBack(view)
                view.snp.makeConstraints { (make) in make.edges.equalTo(profilePageView) }  }
            peepOneView?.isHidden = false
            editProfileView.isHidden = true
            profilePageView.isHidden = false
            stopLoading()
        } else {
            //                peepOneView?.layoutSubviews()
            peepOneView?.isHidden = false
            peepTwoView?.isHidden = true
            peepThreeView?.isHidden = true
            editProfileView.isHidden = true
            profilePageView.isHidden = false
            stopLoading()
        }
        
        
        
    }
    
    func toPersonWith(ID:String,name:String,pic:String,color:Int,one:Int,two:Int,three:Int){
        startLoading()
        Peeple.CurrentPage = .Person
        Person.currentOption = .peepOne
        Person.ID = ID
        Person.peepOne = one
        Person.peepTwo = two
        Person.peepThree = three
        Person.name = name
        Person.color = color
        Person.pic = pic
        topRightLabel.isHidden = true
        pageTab.isHidden = true
        personPeepView.isHidden = false
        profilePageView.isHidden = true
        collectionView.isHidden = true
        middleLabel.isHidden = true
        pageOptionIndicator.image = UIImage(named: Peeple.peepPics[one])
        //        loadPersonPeepData(one: one, two: two, three: three, id: ID)
        personPeepOne = loadPeep(num: one)
        personPeepTwo = loadPeep(num: two)
        personPeepThree = loadPeep(num: three)
        let peeps:[UIView?] = [personPeepOne,personPeepTwo,personPeepThree]
        for peep in peeps {
            guard let view = peep else {
                stopLoading()
                break }
            view.isHidden = true
            personPeepView.addSubview(view)
            personPeepView.sendSubviewToBack(view)
            view.snp.makeConstraints { (make) in
                make.edges.equalTo(personPeepView) }
        }
        personPeepOne?.isHidden = false
        personPeepOne?.layoutSubviews()
        stopLoading()
    }
    func peepSwitch(peepImage:UIImageView,peepOneView:UIView?,peepTwoView:UIView?,peepThreeView:UIView?,optionsView:UIView,allPeepView:UIView,currentOption:Peeple.ProfileOptions,peepOne:Int,peepTwo:Int,peepThree:Int){
        allPeepView.alpha = 0.0
        switch currentOption {
        case .peepOne:
            peepImage.image = UIImage(named: Peeple.peepPics[peepOne])
            if peepOneView != nil {
                peepOneView?.isHidden = false
                peepOneView?.layoutSubviews()
                peepTwoView?.isHidden = true
                peepThreeView?.isHidden = true
                optionsView.isHidden = true
                allPeepView.isHidden = false
                self.stopLoading()
            }
        case .peepTwo:
            peepImage.image = UIImage(named: Peeple.peepPics[peepTwo])
            if peepTwoView != nil {
                peepOneView?.isHidden = true
                peepTwoView?.layoutSubviews()
                peepTwoView?.isHidden = false
                peepThreeView?.isHidden = true
                optionsView.isHidden = true
                allPeepView.isHidden = false
            }
        case .peepThree:
            peepImage.image = UIImage(named: Peeple.peepPics[peepThree])
            if peepThreeView != nil {
                peepOneView?.isHidden = true
                peepTwoView?.isHidden = true
                peepThreeView?.isHidden = false
                peepThreeView?.layoutSubviews()
                optionsView.isHidden = true
                allPeepView.isHidden = false
            }
        case .settings:
            peepImage.image = UIImage(named: "pers")
            optionsView.isHidden = false
            allPeepView.isHidden = true
            collectionView.reloadData()
            
        }
        UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseIn) {
            allPeepView.alpha = 0.9
        } completion: { (true) in
            print("done")
        }
        
    }
    func toGroupChatWith(ID:String,name:String,pic:String,color:Int,des:String){
        Peeple.CurrentPage = .GroupChat
        startLoading()
        collectionView.reloadData()
        Group.ID = ID
        Group.name = name
        Group.color = color
        Group.pic = pic
        Group.des = des
        topRightLabel.isHidden = true
        pageTab.isHidden = true
        addInfoButton.isHidden = false
        addInfoButton.setTitle("Add Event", for: .normal)
        infoTextField.placeholder = "Event Name"
        infoTextDescription.placeholder = "description"
        middleLabel.isHidden = true
        pageOptionIndicator.image = UIImage(named: Peeple.GroupBoxImage)
        topWordLabel.textColor = Peeple.colors[color]
        topWordLabel.text = name
        guard let user = app.currentUser else {
            self.stopLoading()
            return }
        let configuration1 = user.configuration(partitionValue: "groupMessages=\(Group.ID)")
        Realm.asyncOpen(configuration: configuration1) { [self] (result) in
            switch result {
            case .failure(let error):
                print("Failed to open realm: \(error.localizedDescription)")
                // Handle error...
                self.stopLoading()
            case .success(let realm):
                // Realm opened
                let unfiltered_Events = realm.objects(groupMessages.self)
                self.group_Events = filterLiveEvents(realm: realm, unfilteredArray: unfiltered_Events)
                collectionView.reloadData()
                self.stopLoading()
            }
            if group_Events?.count == 0 {
                middleLabel.text = "no live events in this group"
                middleLabel.isHidden = false
            }
        }
        
    }
    func filterLiveEvents(realm:Realm,unfilteredArray:Results<groupMessages>?) -> Results<groupMessages>?{
        guard let events = unfilteredArray else {
            self.stopLoading()
            print("no events here")
            return nil}
        let now = Date()
        for event in events {
            let timePosted = event.timeCode
            let duration = event.eventDuration
            var timeLeft:Int = 0
            let diffComponents = Calendar.current.dateComponents([.minute], from: timePosted, to: now)
            let minutes = diffComponents.minute ?? 0
            //1 hr long
            if duration == 1 { timeLeft = 60 - minutes
            } else { timeLeft = 120 - minutes }
            if timeLeft <= 0 { try! realm.write { realm.delete(event) }  }
            
        }
        return events
        
    }
    func addAllPerson() {
        guard let user = app.currentUser else { return }
        let configuration2 = user.configuration(partitionValue: "allPeople=\(Location.country)")
        
        Realm.asyncOpen(configuration: configuration2) { (result) in
            switch result {
            case .failure(let error):
                print("Failed to open realm: \(error.localizedDescription)")
                // Handle error...
                let alert = UIAlertController(title: "error", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "what", style: .cancel, handler: nil))
                alert.addAction(UIAlertAction(title: "ok", style: .default, handler: { action in
                    //                    self.stopLoading(loadingView: self.loadingIndicator)
                }))
                self.stopLoading()
                self.present(alert, animated: true, completion: nil)
            case .success(let realm):
                // Realm opened
                let task = allPeople(color: currentUser.myAppColor, image: "", name: currentUser.name, biz: false, bio: "",one : currentUser.peepOne,two: currentUser.peepTwo,three: currentUser.peepThree,priv:false, ID: user.id)
                try! realm.write { realm.add(task,update: .modified) }
                
                print("Successfully logged in as user \(user)")
            }
        }
    }
    func findPeople(text: String) -> Bool{
        if text == "" {
            print("String empty or Did not pass Requirements")
            return false }
        guard let user = app.currentUser else { return false}
        // The partition determines which subset of data to access.
        let partitionValue = "allPeople=\(Location.country)"
        // Get a sync configuration from the user object.
        let configuration = user.configuration(partitionValue: partitionValue)
        Realm.asyncOpen(configuration: configuration) { (result) in
            switch result {
            case .failure(let error):
                print("Failed to open realm: \(error.localizedDescription)")
                // Handle error...
            case .success(let Realm):
                self.search_People = Realm.objects(allPeople.self).filter("_id == '\(text)'")
            }
            self.collectionView.reloadData()
        }
        return true
    }
    func findGroups(text: String) -> Bool {
        if text == "" {
            print("String empty or Did not pass Requirements")
            return false }
        guard let user = app.currentUser else { return false}
        // The partition determines which subset of data to access.
        let partitionValue = "allGroups=\(Location.city)"
        // Get a sync configuration from the user object.
        let configuration = user.configuration(partitionValue: partitionValue)
        Realm.asyncOpen(configuration: configuration) { (result) in
            switch result {
            case .failure(let error):
                print("Failed to open realm: \(error.localizedDescription)")
                // Handle error...
                let alert = UIAlertController(title: "No Group Found for code in \(Location.city)", message: "\(text)", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "\(error.localizedDescription))", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            case .success(let Realm):
                self.search_Groups = Realm.objects(allGroups.self).filter("_id == '\(text)'")
                if let group = self.search_Groups?.first {
                    self.toGroupChatWith(ID: group._id, name: group.name, pic: group.image, color: group.color, des: group.des) }
                
            }
        }
        return true
    }
    func filterSearchString(text:String) -> String {
        // extra checks and text filters here
        
        // less than 20 characters dont pass
        if text.count <= 20 { return "" }
        //longer than 43 doesnt pass
        if text.count >= 43 { return "" }
        // all tests passed. return text
        return text
    }
    
    func filterInputString(text:String) -> String {
        // extra checks and text filters here
        
        
        // less than 20 characters dont pass
        
        //longer than 43 doesnt pass
        if text.count >= 50 { return "" }
        // all tests passed. return text
        return text
    }
    func loadPeepData(one:Int,two:Int,three:Int,uid:String){
        guard let user = app.currentUser else { return }
        let thePeeps:[Int] = [one,two,three]
        let partitionValue = "peeps=\(uid)"
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
                            if let cleanergy = peeps.cleanergy {  Peeps.clenny = cleanergy }
                        case 3:
                            if let porty = peeps.portflio {  Peeps.porty = porty }
                        default:
                            print("no peep")
                            
                        }
                    }
                    
                }
                
                
            }
        }
    }
    //    func loadPersonPeepData(one:Int,two:Int,three:Int,id:String){
    //        guard let user = app.currentUser else { return }
    //        let thePeeps:[Int] = [one,two,three]
    //        let partitionValue = "peeps=\(id)"
    //        let configuration = user.configuration(partitionValue: partitionValue)
    //        Realm.asyncOpen(configuration: configuration) { (result) in
    //            switch result {
    //            case .failure(let error):
    //                print("Failed to open realm: \(error.localizedDescription)")
    //                // Handle error...
    //            case .success(let realm):
    //                // Realm opened
    //                if let peeps = realm.objects(myPeeps.self).first {
    //                    for Peep in thePeeps {
    //                        switch Peep {
    //                        case 1:
    //                            if let charight = peeps.charight {  Person.charight = charight }
    //                        case 2:
    //                            if let cleanergy = peeps.cleanergy {  Person.cleanergy = cleanergy }
    //                        case 3:
    //                            if let cleanergy = peeps.cleanergy {  Person.cleanergy = cleanergy }
    //                        default:
    //                            print("no peep")
    //
    //                        }
    //                    }
    //
    //                }
    //
    //
    //            }
    //        }
    //    }
    
}

