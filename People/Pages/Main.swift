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
import Qonversion
class MainPage: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,CLLocationManagerDelegate {
    // MARK: Variables and Constants
    private var all_Groups: Results<allGroups>?
    private var search_Groups: Results<allGroups>?
    private var my_Groups: Results<myGroups>?
    private var all_People: Results<allPeople>?
    private var search_People: Results<allPeople>?
    private var my_People: Results<myPeople>?
    private var group_Events: Results<groupMessages>?
    private var all_Events: Results<Events>?
    
    fileprivate var locationManager: CLLocationManager?
    lazy var geocoder = CLGeocoder()
    fileprivate var didPass:Bool = false
    private var myGroupLoaded:Bool = false
    private var myPeopleLoaded:Bool = false
    private var eventDuration:Int = 1
    private var endBackAni:Bool = false
    // Peep Views
    private weak var peepOneView:UIView?
        private weak var peepTwoView:UIView?
        private weak var peepThreeView:UIView?
        private weak var personPeepOne:UIView?
        private weak var personPeepTwo:UIView?
        private weak var personPeepThree:UIView?
    private weak var peeplePlusView:UIView?
    private weak var allPeepView:UIView?
    // all pages
    // MARK: IBOutlets
    @IBOutlet weak var loadingIndicator: UIImageView!
    @IBOutlet weak var personPeepView: UIView!
    @IBOutlet weak var middleLabel: UILabel!
    @IBOutlet weak var bottomLeftImage: UIImageView!
    @IBOutlet weak var PickPurchaseButton: UIButton!
    @IBOutlet weak var ARView: ARView!
    @IBOutlet weak var backImage: UIImageView!
    @IBOutlet weak var topLeftOptionButton: UIButton!
    @IBOutlet weak var topWordLabel: UILabel!
    @IBOutlet weak var shareEventButton: UIButton!
    @IBOutlet weak var topRightLabel: UIImageView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var pageOptionIndicator: UIImageView!
    // MARK: GroupPage
    @IBOutlet weak var addInfoView: UIView!
    @IBOutlet weak var infoTextField: UITextField!
    @IBOutlet weak var infoTextDescription: UITextField!
    @IBOutlet weak var eventDurationButton: UIButton!
    @IBOutlet weak var addInfoButton: UIButton!
    @IBAction func ShareEvent(_ sender: UIButton) {
        guard let user = app.currentUser else { return }
        if Peeple.Settings.CurrentPage == .Group {
            let eventName = infoTextField.text ?? ""
            print("here2")
            guard let GroupName = infoTextField.text else { return }
            
            let groupDes:String = infoTextDescription.text ?? ""
            if GroupName.count >= 20 { return }
            let GroupCode:String = UUID().uuidString
            startLoading()
            self.addInfoButton.isEnabled = false
            // if person is private add to all gorups
            if Person.Current.Priv == false {
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
                        let newGroup = allGroups(name: GroupName, image: "", des: groupDes, userId: Person.Current.ID, color: Person.Current.Color,priv: Person.Current.Priv, dateMade: now,ID:GroupCode)
                        try! realm.write {
                            realm.add(newGroup,update: .modified)
                        }
                    }
                }
            }
//            let partitionValue2 = "me=\(user.id)"
//            // Get a sync configuration from the user object.
//            let configuration2 = user.configuration(partitionValue: partitionValue2)
//            Realm.asyncOpen(configuration: configuration2) { [self] (result) in
//                switch result {
//                case .failure(let error):
//                    print(error)
//                    self.stopLoading()
//                case .success(let realm):
//                    let myGroup = myGroups(name: GroupName, image: "", color: Person.Current.Color, des: infoTextDescription.text ?? "", userId: user.id, key: GroupCode)
//                    if let me = realm.objects(mePerson.self).first {
//                        try! realm.write {
//                            me.myGroups.append(myGroup)
//                        }
//                    }
//                    self.stopLoading()
//                    self.infoTextField.text = ""
//                    self.infoTextDescription.text = ""
//                    self.addInfoView.isHidden = true
//                    self.addInfoButton.isEnabled = true
//                    self.all_Groups = nil
//                    fetchGroupData(user: user)
//                    setGroupPage(user: user)
//                }
//                self.addInfoButton.isEnabled = true
//                
//            }
            
        }
        
       
        if Peeple.Settings.CurrentPage == .GroupChat {
            // write event to group page feed
            print("here")
            if Peeple.Settings.isLocationEnabled == false {
                print("here1")
                locationManager?.requestWhenInUseAuthorization()
                return }
            locationManager?.startUpdatingLocation()
            let eventName = infoTextField.text ?? ""
            print("here2")
            print("here3")
            let eventDes = infoTextDescription.text ?? ""
            if eventName.count >= 30 { return }
            let eventCode:String = UUID().uuidString
            let now = Date()
            startLoading()
            addInfoButton.isEnabled = false
            print(now)
            let configuration1 = user.configuration(partitionValue: "groupMessages=\(Group.ID)")
            Realm.asyncOpen(configuration: configuration1) { [self] (result) in
                switch result {
                case .failure(let error):
                    print("Failed to open realm: \(error.localizedDescription)")
                    // Handle error...
                    self.stopLoading()
                case .success(let realm):
                    // Realm opened
                    let message = groupMessages(chatName: eventName, color: Person.Current.Color, peepOne: Person.Current.PeepOne, peepTwo: Person.Current.PeepTwo, peepThree: Person.Current.PeepThree, eventDuration: eventDuration, lat: Event.latitude, long: Event.longitude, chatMessage: eventDes, userId: user.id, isBiz: Person.Current.biz, _id: eventCode, timeCode: now)
                    try! realm.write {
                        realm.add(message)
                    }
                    self.infoTextField.text = ""
                    self.infoTextDescription.text = ""
                    showEventView(eventView: addInfoView)
                    self.eventDurationButton.isHidden = true
                    self.addInfoButton.isEnabled = true
                    self.stopLoading()
                    self.collectionView.reloadData()
                }
            }
        }
        if Peeple.Settings.CurrentPage == .Event {
            // write event to group page feed
            print("here")
            if Peeple.Settings.isLocationEnabled == false {
                print("here1")
                locationManager?.requestWhenInUseAuthorization()
                return }
            locationManager?.startUpdatingLocation()
            let eventName = infoTextField.text ?? ""
            print("here2")
            print("here3")
            let eventDes = infoTextDescription.text ?? ""
            if eventName.count >= 30 { return }
            let eventCode:String = UUID().uuidString
            let now = Date()
            startLoading()
            addInfoButton.isEnabled = false
            print(now)
            let configuration1 = user.configuration(partitionValue: "allEvents=\(Location.city)")
            Realm.asyncOpen(configuration: configuration1) { [self] (result) in
                switch result {
                case .failure(let error):
                    print("Failed to open realm: \(error.localizedDescription)")
                    // Handle error...
                    self.stopLoading()
                case .success(let realm):
                    // Realm opened
                    let message = Events(eventName: eventName, color: Person.Current.Color, peepOne: Person.Current.PeepOne,peepTwo: Person.Current.PeepTwo,peepThree: Person.Current.PeepThree, eventDuration: eventDuration, lat: Event.latitude, long: Event.longitude, eventDes: eventDes, userId: user.id, isBiz: Person.Current.biz, _id: eventCode, timeCode: now)
                    try! realm.write {
                        realm.add(message)
                    }
                    self.infoTextField.text = ""
                    self.infoTextDescription.text = ""
                    showEventView(eventView: addInfoView)
                    self.eventDurationButton.isHidden = true
                    self.addInfoButton.isEnabled = true
                    self.stopLoading()
                    self.collectionView.reloadData()
                }
            }
        }

    }
    @IBAction func topLeftOptions(_ sender: UIButton) {
        guard let user = app.currentUser else { return }
        // alpha animating page switch with Util function
        if Peeple.Settings.CurrentPage == .Person {
            emptySelectedPerson()
            for view in personPeepView.subviews {
                view.removeFromSuperview()  }
            setPeoplePage(user: user)
        }
        return
        switch Peeple.Settings.CurrentPage {
        case .Event:
            return
        case .Group:
            switch Peeple.Settings.GroupisSetTo {
            case .all:
                Peeple.Settings.GroupisSetTo = .my
            case .my:
                Peeple.Settings.GroupisSetTo = .all
                
            case .search:
                return
            }
            setGroupPage(user: user)
        case .People:
            switch Peeple.Settings.PeopleisSetTo {
            case .all:
                Peeple.Settings.PeopleisSetTo = .my
            case .my:
                Peeple.Settings.PeopleisSetTo = .all
            case .search:
                return
            }
            setPeoplePage(user: user)
        case .Profile:
            return
            
            
            
        case .GroupChat:
            setGroupPage(user: user)
        case .Person:
            emptySelectedPerson()
            for view in personPeepView.subviews {
                view.removeFromSuperview()  }
            setPeoplePage(user: user)
        }
//    case .down:
//        //option down
//        // setting next option + refresh data
//        print("option DOWN")
//        switch Peeple.CurrentPage {
//        case .Event:
//            switch Peeple.EventisSetTo {
//            case .all:
//                Peeple.EventisSetTo = .five
//            case .twentyfive:
//                Peeple.EventisSetTo = .all
//            case .five:
//                Peeple.EventisSetTo = .twentyfive
//            }
//            fetchEventData(user: user)
//        case .Group:
//            switch Peeple.GroupisSetTo {
//            case .all:
//                Peeple.GroupisSetTo = .make
//            case .my:
//                Peeple.GroupisSetTo = .all
//            case .search:
//                Peeple.GroupisSetTo = .my
//            case .make:
//                Peeple.GroupisSetTo = .search
//            }
//            fetchGroupData(user: user)
//        case .People:
//            switch Peeple.PeopleisSetTo {
//            case .all:
//                Peeple.PeopleisSetTo = .search
//            case .my:
//                Peeple.PeopleisSetTo = .all
//            case .search:
//                Peeple.PeopleisSetTo = .my
//            }
//            fetchPeopleData(user: user)
//        case .Profile:
//            switch Peeple.ProfileisSetTo {
//            case .peepOne:
//                Peeple.ProfileisSetTo = .peepThree
//            case .peepTwo:
//                Peeple.ProfileisSetTo = .peepOne
//            case .peepThree:
//                Peeple.ProfileisSetTo = .peepTwo
//            }
//            peepSwitch(peepImage: pageOptionIndicator, peepOneView: peepOneView, peepTwoView: peepTwoView, peepThreeView: peepThreeView, allPeepView: profilePageView, currentOption: Peeple.ProfileisSetTo,peepOne: currentUser.peepOne,peepTwo: currentUser.peepTwo,peepThree: currentUser.peepThree)
//        case .GroupChat:
//            fetchGroupData(user: user)
//        case .Person:
//            switch Person.currentOption {
//            case .peepOne:
//                Person.currentOption = .peepThree
//            case .peepTwo:
//                Person.currentOption = .peepOne
//            case .peepThree:
//                Person.currentOption = .peepTwo
//            }
//            peepSwitch(peepImage: pageOptionIndicator, peepOneView: personPeepOne, peepTwoView: personPeepTwo, peepThreeView: personPeepThree, allPeepView: personPeepView, currentOption: Person.currentOption,peepOne: Person.peepOne,peepTwo: Person.peepTwo,peepThree: Person.peepThree)
//        case .Settings:
//            return
//        }
        
    }
    @IBAction func addInfo(_ sender: UIButton) {
        guard let user = app.currentUser else { return }
        if Peeple.Settings.isLocationEnabled == false {
            print("here1")
            locationManager?.requestWhenInUseAuthorization()
            return }
        locationManager?.startUpdatingLocation()
        if Peeple.Settings.CurrentPage == .Profile {
            if peeplePlusView != nil {
                //show peepleplus purchase xib
                peeplePlusView?.isHidden = true
                peeplePlusView?.removeFromSuperview()
                peeplePlusView = nil
                if Peeple.Settings.plus {
                    self.PickPurchaseButton.setTitle("pick peeple", for: .normal)
                    self.ChangeColorButton.isHidden = false
                    self.ARToggleButton.isHidden = false
                }
                // hide editprofile view
            }
            if allPeepView != nil {
                allPeepView?.isHidden = true
                allPeepView?.removeFromSuperview()
                allPeepView = nil
            }
            if Peeple.Settings.editedPeeps == true {
                //savePeeps
                for view in profilePageView.subviews {
                    view.removeFromSuperview()
                }
                peepOneView = nil
                peepTwoView = nil
                peepThreeView = nil
                savePeepSelection(user:user)
                Peeple.Settings.editedPeeps = false
            }
                setSettings(user: user)
        } else {
            showEventView(eventView: addInfoView)
        }
        
    }
    func showEventView(eventView:UIView){
        if eventView.isHidden == true {
            UIView.animate(withDuration: 1.0) {
                eventView.isHidden = false
                eventView.alpha = 1
                self.middleLabel.isHidden = true
                self.collectionView.isHidden = true
            }
            return
        }
        UIView.animate(withDuration: 1.0) {
        eventView.isHidden = true
            eventView.alpha = 0
            self.collectionView.isHidden = false
            self.middleLabel.isHidden = false
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
    
    @IBAction func copyMyCode(_ sender: UIButton) {
        UIPasteboard.general.string = Person.Current.ID
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
        Person.Current.isARActive = !Person.Current.isARActive
        UserDefaults.standard.set(Person.Current.isARActive, forKey: "AR")
        startLoading()
        if Person.Current.isARActive == false {
            view.backgroundColor = .systemGray6
            stopAR(on: ARView)
            stopLoading()
            sender.isEnabled = true
        } else {
            switch AVCaptureDevice.authorizationStatus(for: .video) {
            case .authorized: // the user has already authorized to access the camera.
               
                beginAR(ARview:ARView)
                stopLoading()
                sender.isEnabled = true
            case .notDetermined: // the user has not yet asked for camera access.
                AVCaptureDevice.requestAccess(for: .video) { [self] (granted) in
                    if granted { // if user has granted to access the
                        
                        beginAR(ARview: ARView)
                        stopLoading()
                        sender.isEnabled = true
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
        if Person.Current.Color >= 8 { Person.Current.Color = -1 }
        Person.Current.Color += 1
        UserDefaults.standard.set(Person.Current.Color, forKey: "appColor")
        addInfoButton.setTitleColor(Peeple.Settings.Colors[Person.Current.Color], for: .normal)
        setButtonColors(color: Peeple.Settings.Colors[Person.Current.Color])
        topLeftOptionButton.tintColor = Peeple.Settings.Colors[Person.Current.Color]
        
        
    }
    
    @IBAction func TogglePrivate(_ sender: UIButton) {
        if Person.Current.Priv {
            sender.setTitle("enter private", for: .normal)
            Person.Current.Priv = false
        } else {
            Person.Current.Priv = true
            sender.setTitle("exit private", for: .normal)
        }
    }
    @IBAction func myRequests(_ sender: UIButton) {
        var index = Peeple.Settings.language + 1
        if index == 2 {
            index = 0 }
        setLanguage(index: index)
    }
    @IBAction func ToggleLocation(_ sender: UIButton) {
        myCityPressed()
    }
    @IBAction func PickorPurchasePeeps(_ sender: UIButton) {
        if Peeple.Settings.plus == false {
            peeplePlusView = peeplePlus.instanceFromNib()
            if let plusView = peeplePlusView {
            view.addSubview(plusView)
                plusView.snp.makeConstraints { (make) in
                make.edges.equalTo(editProfileView) } }
            editProfileView.isHidden = true
        } else {
            allPeepView = allPeeps.instanceFromNib()
            if let peepView = allPeepView {
            view.addSubview(peepView)
                peepView.snp.makeConstraints { (make) in
                make.edges.equalTo(editProfileView) } }
            editProfileView.isHidden = true
        }
    }
    // MARK: Functions
    func addGestures(){
//        let pageTap = UITapGestureRecognizer(target: self, action: #selector(pageTapped(_:)))
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(labelSwipedL(_:)))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(labelSwipedR(_:)))
        let rightOpTap = UITapGestureRecognizer(target: self, action: #selector(rightOpTapped(_:)))
        let zoomIn = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch(_:)))
        let hold = UILongPressGestureRecognizer(target: self, action: #selector(handleHold(_:)))
        hold.minimumPressDuration = 2
        leftSwipe.direction = .left
        topRightLabel.addGestureRecognizer(leftSwipe)
        rightSwipe.direction = .right
        topRightLabel.addGestureRecognizer(rightSwipe)
//        topRightLabel.addGestureRecognizer(pageTap)
        pageOptionIndicator.isUserInteractionEnabled = true
        pageOptionIndicator.addGestureRecognizer(rightOpTap)
        view.addGestureRecognizer(hold)
        view.addGestureRecognizer(zoomIn)
    }
    // MARK: SwipeActions
    @objc func rightOpTapped(_ sender:UITapGestureRecognizer)
    {
        guard let user = app.currentUser else { return }
        if Peeple.Settings.CurrentPage == .Event {
            self.all_Events = nil
            fetchEventData(user: user)
        }
        if Peeple.Settings.CurrentPage == .Group {
                    guard let text = UIPasteboard.general.string else { return }
                    var didQuery:Bool = false
                    didQuery = findGroups(text: filterSearchString(text: text))
                    print("search success and did query is: \(didQuery)")
                
            
        }
        if Peeple.Settings.CurrentPage == .People {
                guard let text = UIPasteboard.general.string else { return }
                var didQuery:Bool = false
                didQuery = findPeople(text: filterSearchString(text: text))
                print("search success and did query is: \(didQuery)")
                
            
        }
        if Peeple.Settings.CurrentPage == .GroupChat {
            if Peeple.Settings.isLocationEnabled == false{
                locationManager?.requestWhenInUseAuthorization()
                return
            }
            locationManager?.startUpdatingLocation()
            let eventName = infoTextField.text ?? ""
            if eventName == "" {
                showEventView(eventView: addInfoView)
                return
            }
            let eventDes:String = infoTextDescription.text ?? ""
            if eventName.count >= 30 { return }
            let eventCode:String = UUID().uuidString
            
            let now = Date()
            startLoading()
            addInfoButton.isEnabled = false
            print(now)
            
            let configuration1 = user.configuration(partitionValue: "groupMessages=\(Group.ID)")
            Realm.asyncOpen(configuration: configuration1) { [self] (result) in
                switch result {
                case .failure(let error):
                    print("Failed to open realm: \(error.localizedDescription)")
                    // Handle error...
                    self.stopLoading()
                case .success(let realm):
                    // Realm opened
                    let message = groupMessages(chatName: eventName, color: Person.Current.Color, peepOne: Person.Current.PeepOne,peepTwo: Person.Current.PeepTwo,peepThree: Person.Current.PeepThree, eventDuration: eventDuration, lat: Event.latitude, long: Event.longitude, chatMessage: eventDes, userId: user.id, isBiz: Person.Current.biz, _id: eventCode, timeCode: now)
                    try! realm.write {
                        realm.add(message)
                    }
                    self.infoTextField.text = ""
                    self.infoTextDescription.text = ""
                    self.addInfoView.isHidden = true
                    self.middleLabel.isHidden = false
                    self.eventDurationButton.isHidden = true
                    self.addInfoButton.isEnabled = true
                    self.stopLoading()
                    self.collectionView.reloadData()
                }
            }
        }
//        if Peeple.Settings.CurrentPage == .Profile {
//            switch Peeple.Settings.ProfileisSetTo {
//                        case .peepOne:
//                            Peeple.Settings.ProfileisSetTo = .peepTwo
//                        case .peepTwo:
//                            Peeple.Settings.ProfileisSetTo = .peepThree
//                        case .peepThree:
//                            Peeple.Settings.ProfileisSetTo = .peepOne
//            case .settings:
//                return
//                        }
//            peepSwitch(peepOneView: peepOneView, peepTwoView: peepTwoView, peepThreeView: peepThreeView, allPeepView: profilePageView, currentOption: Peeple.Settings.ProfileisSetTo,peepOne: Person.Current.PeepOne,peepTwo: Person.Current.PeepTwo,peepThree: Person.Current.PeepThree)
//        }
//        if Peeple.Settings.CurrentPage == .Person {
//            switch Peeple.Settings.PersonOption {
//                        case .peepOne:
//                Peeple.Settings.PersonOption = .peepTwo
//                        case .peepTwo:
//                Peeple.Settings.PersonOption = .peepThree
//                        case .peepThree:
//                Peeple.Settings.PersonOption = .peepOne
//            case .settings:
//                return
//                        }
//            peepSwitch(peepOneView: personPeepOne, peepTwoView: personPeepTwo, peepThreeView: personPeepThree, allPeepView: personPeepView, currentOption: Peeple.Settings.PersonOption,peepOne: Person.Selected.PeepOne,peepTwo: Person.Selected.PeepTwo,peepThree: Person.Selected.PeepThree)
//        }
    }

    @objc func labelSwipedL(_ sender:UISwipeGestureRecognizer)
    {
        guard let user = app.currentUser else { return }
        // alpha animating page switch with Util function
        MusicPlayer.shared.playPeep()
        switch Peeple.Settings.CurrentPage {
        case .Event:
            setGroupPage(user: user)
        case .Group:
            setPeoplePage(user: user)
        case .People:
            setProfile(user:user)
        case .Profile:
            switch Peeple.Settings.ProfileisSetTo {
                        case .peepOne:
                            Peeple.Settings.ProfileisSetTo = .peepTwo
                        case .peepTwo:
                            Peeple.Settings.ProfileisSetTo = .peepThree
                        case .peepThree:
                            Peeple.Settings.ProfileisSetTo = .settings
            case .settings:
                return
                            
                        }
            peepSwitch(peepOneView: peepOneView, peepTwoView: peepTwoView, peepThreeView: peepThreeView, allPeepView: profilePageView, currentOption: Peeple.Settings.ProfileisSetTo,peepOne: Person.Current.PeepOne,peepTwo: Person.Current.PeepTwo,peepThree: Person.Current.PeepThree,user: user)
        case .GroupChat:
            setGroupPage(user: user)
        case .Person:
            emptySelectedPerson()
            for view in personPeepView.subviews {
                view.removeFromSuperview()  }
            setPeoplePage(user: user)
        
        }
    }
    @objc func labelSwipedR(_ sender:UISwipeGestureRecognizer)
    {
        guard let user = app.currentUser else { return }
        // alpha animating page switch with Util function
        MusicPlayer.shared.playPeep()
            switch Peeple.Settings.CurrentPage {
            case .Event:
                return
            case .Group:
                fetchEventData(user: user)
            case .People:
                setGroupPage(user: user)
            case .Profile:
                switch Peeple.Settings.ProfileisSetTo {
                case .settings:
                    Peeple.Settings.ProfileisSetTo = .peepThree
                            case .peepThree:
                                Peeple.Settings.ProfileisSetTo = .peepTwo
                            case .peepTwo:
                                Peeple.Settings.ProfileisSetTo = .peepOne
                            case .peepOne:
                                setPeoplePage(user: user)
                                return
                            }
                peepSwitch(peepOneView: peepOneView, peepTwoView: peepTwoView, peepThreeView: peepThreeView, allPeepView: profilePageView, currentOption: Peeple.Settings.ProfileisSetTo,peepOne: Person.Current.PeepOne,peepTwo: Person.Current.PeepTwo,peepThree: Person.Current.PeepThree,user: user)
                
            case .GroupChat:
                setGroupPage(user: user)
            case .Person:
                emptySelectedPerson()
                for view in personPeepView.subviews {
                    view.removeFromSuperview()  }
                setPeoplePage(user: user)
            }
        
    }
    @objc func handlePinch(_ sender:UIPinchGestureRecognizer) {
        if sender.scale > 2 {
            Peeple.Settings.zoomLevel = .one
        }else if sender.scale > 0.5 && sender.scale < 1.5 {
            Peeple.Settings.zoomLevel = .two
        } else {
            // if sender.scale <= 0.7
            Peeple.Settings.zoomLevel = .max
        }
        collectionView.reloadData()
    }
    
    @objc func handleHold(_ sender:UILongPressGestureRecognizer) {
        if Peeple.Settings.CurrentPage == .GroupChat {
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
        if Peeple.Settings.CurrentPage == .Person {
            if Person.Selected.ID != "" {
                guard let user = app.currentUser else { return }
                let partitionValue2 = "me=\(user.id)"
                startLoading()
                let pasteboard = UIPasteboard.general
                pasteboard.string = Person.Selected.ID
                // Get a sync configuration from the user object.
                let configuration2 = user.configuration(partitionValue: partitionValue2)
                Realm.asyncOpen(configuration: configuration2) { [self] (result) in
                    switch result {
                    case .failure(let error):
                        print(error)
                        self.stopLoading()
                    case .success(let realm):
                        let myPerson = myPeople(color: Person.Selected.Color, image: "", name: Person.Selected.Name, bio: "", peepOne: Person.Selected.PeepOne,peepTwo: Person.Selected.PeepTwo,peepThree: Person.Selected.PeepThree, _id: Person.Selected.ID)
                        if let me = realm.objects(mePerson.self).first {
                            try! realm.write { me.myPeople.append(myPerson) } }
                        self.stopLoading()
                        let alert = UIAlertController(title: "\(Person.Selected.Name) added to my people", message: "\(Person.Selected.ID) : copied to clipboard", preferredStyle: .alert)
                        self.myGroupLoaded = false
                        alert.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                }
                
            }
        }
        
    }
    
    func ARSetUp(){
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized: // the user has already authorized to access the camera.
            
            beginAR(ARview:ARView)
            Person.Current.isARActive = true
            stopLoading()
        case .notDetermined: // the user has not yet asked for camera access.
            AVCaptureDevice.requestAccess(for: .video) { [self] (granted) in
                if granted {
                    Person.Current.isARActive = true
                    DispatchQueue.main.async { [self] in
                        
                        beginAR(ARview: ARView)
                        stopLoading()
                    }// if user has granted to access the
                    
                } else {
                    DispatchQueue.main.async {
                        print("the user has not granted to access the camera")
                        self.stopLoading()
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
            view.backgroundColor = .systemGray6
            pageOptionIndicator.addShadow()
            topRightLabel.addShadow()
            pageOptionIndicator.tintColor = .white
            setButtonColors(color: Peeple.Settings.Colors[Person.Current.Color])
            infoTextField.textColor = .white
            addInfoButton.setTitleColor(Peeple.Settings.Colors[Person.Current.Color], for: .normal)
            addInfoButton.setTitle("Make", for: .normal)
            infoTextField.textColor = Peeple.Settings.Colors[Person.Current.Color]
            infoTextDescription.textColor = Peeple.Settings.Colors[Person.Current.Color]
            infoTextField.addTextShadow()
            topRightLabel.tintColor = Peeple.Settings.Colors[Person.Current.Color]
            loadingIndicator.tintColor = Peeple.Settings.Colors[Person.Current.Color]
            middleLabel.textColor = Peeple.Settings.Colors[Person.Current.Color]
            infoTextDescription.addTextShadow()
//            infoTextField.buttonify(color: Peeple.Settings.Colors[Person.Current.Color])
//            infoTextDescription.buttonify(color: Peeple.Settings.Colors[Person.Current.Color])
            shareEventButton.buttonify(color: Peeple.Settings.Colors[Person.Current.Color])
            middleLabel.addTextShadow()
            addInfoButton.buttonify(color: .white)
            addInfoButton.addTextShadow()
            MyCodeButton.buttonify(color: .white)
            MyCodeButton.addTextShadow()
            ARToggleButton.buttonify(color: .white)
            ARToggleButton.addTextShadow()
            topWordLabel.addTextShadow()
            ChangeColorButton.addTextShadow()
            PrivateToggleButton.addTextShadow()
            MyRequestsButton.addTextShadow()
            MyLocationButton.buttonify(color: .white)
            MyLocationButton.addTextShadow()
            shareEventButton.buttonify(color: .white)
            shareEventButton.addTextShadow()
            shareEventButton.setTitleColor(Peeple.Settings.Colors[Person.Current.Color], for: .normal)
            PickPurchaseButton.buttonify(color: .white)
            PickPurchaseButton.addTextShadow()
            topLeftOptionButton.tintColor = Peeple.Settings.Colors[Person.Current.Color]
//            topLeftOptionButton.isHidden = true
            topLeftOptionButton.addTextShadow()
        }
//        setLanguage(index: Peeple.Settings.language)
    }
//    func setUpBackAni(){
//        if endBackAni { return }
//        let distance = self.view.frame.width
//            UIView.animate(withDuration: 120, delay: 0.0, options: .autoreverse) {
//                self.backImage.frame.origin.x = self.backImage.frame.origin.x + distance
//            } completion: { (true) in
//                self.setUpBackAni()
//        }
//    }
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
        locationManager = CLLocationManager()
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.delegate = self
        Person.Current.isARActive = UserDefaults.standard.bool(forKey: "AR")
        collectionView.register(UINib(nibName: "MainCell", bundle: nil), forCellWithReuseIdentifier: "MainCell")
        addGestures()
        hideKeyboardWhenTappedAround()
        startLoading()
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
                    Person.Current.setInfo(id:user.id,priv: me.priv,peepOne: me.peepOne,peepTwo:me.peepTwo,peepThree:me.peepThree,name: me.name,color:UserDefaults.standard.integer(forKey: "appColor"))
                    Qonversion.identify(user.id)
                    self.loadPeepData(one: me.peepOne, two: me.peepTwo, three: me.peepThree, user: user)
                } else {
                    print("mePerson not found")
                }
                
            }
        }
        layoutUI()
        beginAR(ARview: ARView)
        checkPeeplePlus()
        fetchEventData(user:user)
        fetchGroupData(user:user)
        fetchPeopleData(user: user)
        
    }
    // MARK: ViewDidAppear
    override func viewDidAppear(_ animated: Bool) {
        
        locationManager?.delegate = self
    }
    override func viewDidLayoutSubviews() {
//        setUpBackAni()
    }
    
    // MARK: ItemsHeightandWidth
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        switch Peeple.Settings.CurrentPage {
        case .Event:
            switch Peeple.Settings.zoomLevel{
            case .one:
                return CGSize(width: collectionView.frame.width, height: collectionView.frame.width/3)
            case .two:
                return CGSize(width: collectionView.frame.width, height: collectionView.frame.height/3)
            case .max:
                return CGSize(width: collectionView.frame.width, height: collectionView.frame.height/3)
            }
        case .Group:
//            if Peeple.GroupisSetTo == .events { return CGSize(width: collectionView.frame.width, height: collectionView.frame.height/4) }
            switch Peeple.Settings.zoomLevel{
            case .one:
                return CGSize(width: collectionView.frame.width/2, height: collectionView.frame.height/4)
            case .two:
                return CGSize(width: collectionView.frame.width/2, height: collectionView.frame.height/4)
            case .max:
                return CGSize(width: collectionView.frame.width/2, height: collectionView.frame.height/4)
            }
            
        case .People:
            switch Peeple.Settings.zoomLevel{
            case .one:
                return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
            case .two:
                return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
            case .max:
                return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
            }
            
        case .Profile:
            return CGSize(width: 0, height: 0)
        case .GroupChat:
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.height/4)
        case .Person:
            return CGSize(width: 0, height: 0)
        }
        
    }
    // MARK: ItemsInSection
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch Peeple.Settings.CurrentPage {
        case .Event:
            switch Peeple.Settings.EventisSetTo {
            case .all:
                return count(count: all_Events?.count ?? 0)
            case .twentyfive:
                return 0
            case .five:
                return 0
                
            }
        case .Group:
            switch Peeple.Settings.GroupisSetTo {
            case .all:
                return count(count: all_Groups?.count ?? 0)
            case .my:
                return count(count: my_Groups?.count ?? 0)
            case .search:
                return count(count: search_Groups?.count ?? 0)
//            case .events:
//                return count(count: all_Events?.count ?? 0)
            }
        case .People:
            switch Peeple.Settings.PeopleisSetTo{
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
//        cell.mainImageView.addShadow()
        cell.mainTextLabel.addTextShadow()
//        cell.mainImageView.setPeepleCorners()
        cell.setPeepleCorners()
        cell.addShadow()
        switch Peeple.Settings.CurrentPage {
        case .Event:
            switch Peeple.Settings.EventisSetTo {
            case .all:
                cell.allEvents = all_Events?[indexPath.row]
            case .twentyfive:
                return cell
            case .five:
                return cell
            }
            return cell
        case .Group:
            switch Peeple.Settings.GroupisSetTo {
            case .all:
                cell.allGroups = all_Groups?[indexPath.row]
            case .my:
                cell.myGroups = my_Groups?[indexPath.row]
            case .search:
                return cell
//            case .events:
//                cell.allEvents = all_Events?[indexPath.row]
            }
            return cell
        case .People:
            switch Peeple.Settings.PeopleisSetTo{
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
        switch Peeple.Settings.CurrentPage {
        case .Event:
            switch Peeple.Settings.EventisSetTo {
            case .all:
                                guard let event = all_Events?[indexPath.row] else { return }
                                // to event in maps
                                print(getEventDuration(from: event.timeCode))
                                let coordinates = CLLocationCoordinate2DMake(event.lat,event.long)
                
                                let regionSpan =   MKCoordinateRegion(center: coordinates, latitudinalMeters: 1000, longitudinalMeters: 1000)
                
                                let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
                
                                let mapItem = MKMapItem(placemark: placemark)
                
                                mapItem.name = "\(event.eventName) : \(event.eventDes)"
                let alert = UIAlertController(title: "\(event.eventName):\(event.eventDes)", message: "Exercise cation when visitng unkown places and only go to public areas. ", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "continue to maps", style: .default, handler: { action in
                    mapItem.openInMaps(launchOptions:[
                        MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center)
                    ] as [String : Any])
                }))
                alert.addAction(UIAlertAction(title: "report event", style: .default, handler: { action in
                    //report
                }))
                alert.addAction(UIAlertAction(title: "back", style: .cancel, handler: { action in
                }))
                self.present(alert, animated: true, completion: nil)
                                
            case .twentyfive:
                return
            case .five:
                return
            }
        case .Group:
            // saving previus page
            switch Peeple.Settings.GroupisSetTo {
            case .all:
                guard let group = all_Groups?[indexPath.row] else { return }
                toGroupChatWith(ID: group._id, name: group.name, pic: group.image, color: group.color, des: group.des)
            case .my:
                guard let group = my_Groups?[indexPath.row] else { return }
                toGroupChatWith(ID: group.key, name: group.name, pic: group.image, color: group.color, des: group.des)
            case .search:
                return
//            case .events:

            }
            
        case .People:
            // saving the previous page to return upon swipe back
            switch Peeple.Settings.PeopleisSetTo{
            case .all:
                guard let person = all_People?[indexPath.row] else { return }
                setPerson(ID: person._id, name: person.name, pic: person.image, priv: person.priv, color: person.color, one: person.peepOne,two: person.peepTwo,three: person.peepThree)
            case .my:
                guard let person = my_People?[indexPath.row] else { return }
                setPerson(ID: person._id, name: person.name, pic: person.image, priv: false, color: person.color,one: person.peepOne,two: person.peepTwo,three: person.peepThree)
            case .search:
                guard let person = search_People?[indexPath.row] else { return }
                setPerson(ID: person._id, name: person.name, pic: person.image, priv: person.priv, color: person.color,one: person.peepOne,two: person.peepTwo,three: person.peepThree)
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
        Event.latitude = location.coordinate.latitude
        Event.longitude = location.coordinate.longitude
        if didPass {
            self.stopLoading()
            self.locationManager?.stopUpdatingLocation()
            return }
        print("here12")
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
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .notDetermined:
            print(".NotDetermined")
            Peeple.Settings.isLocationEnabled = false
        case .authorizedAlways:
            print("here7")
            UserDefaults.standard.set(true, forKey: "isLocationEnabled")
            Peeple.Settings.isLocationEnabled = true
            locationManager?.startUpdatingLocation()
        case .denied:
            print(".Denied")
            Peeple.Settings.isLocationEnabled = false
            
        case .authorizedWhenInUse:
            print(".whenisuse")
            print("here6")
            UserDefaults.standard.set(true, forKey: "isLocationEnabled")
            Peeple.Settings.isLocationEnabled = true
            locationManager?.startUpdatingLocation()
        case .restricted:
            print(".Restricted")
            Peeple.Settings.isLocationEnabled = false
            break
            
        default:
            print("Unhandled authorization status")
            Peeple.Settings.isLocationEnabled = false
            break
            
        }
        
        
    }
    private func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        
        //This method does real time status monitoring.
        print("here5")
        switch status {
        case .notDetermined:
            print(".NotDetermined")
            Peeple.Settings.isLocationEnabled = false
        case .authorizedAlways:
            print("here7")
            UserDefaults.standard.set(true, forKey: "isLocationEnabled")
            Peeple.Settings.isLocationEnabled = true
            locationManager?.startUpdatingLocation()
        case .denied:
            print(".Denied")
            Peeple.Settings.isLocationEnabled = false
            
        case .authorizedWhenInUse:
            print(".whenisuse")
            print("here6")
            UserDefaults.standard.set(true, forKey: "isLocationEnabled")
            Peeple.Settings.isLocationEnabled = true
            locationManager?.startUpdatingLocation()
        case .restricted:
            print(".Restricted")
            Peeple.Settings.isLocationEnabled = false
            break
            
        default:
            print("Unhandled authorization status")
            Peeple.Settings.isLocationEnabled = false
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
//                    if country == "Brazil" {
//                        setLanguage(index:1)
//
//                    }
                    UserDefaults.standard.set(country, forKey: "country")
                }
                self.stopLoading()
                if Person.Current.Priv == false {
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
        UIView.animate(withDuration: 0.5) {
            self.loadingIndicator.isHidden = true
            self.collectionView.alpha = 1 }
        timer?.invalidate()
        timer = nil
    }
    func startLoading() {
        UIView.animate(withDuration: 0.5) {
            self.loadingIndicator.isHidden = false
            self.collectionView.alpha = 0 }
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
    func beginAR(ARview:ARView){
        captureSession = AVCaptureSession()
        guard let capt = captureSession else { return }
        guard let captureDevice = AVCaptureDevice.default(for: AVMediaType.video) else { return }
        do {
            let input = try AVCaptureDeviceInput(device: captureDevice)
            capt.addInput(input)
        } catch {
            print(error)
        }
        ARview.videoPreviewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        ARview.videoPreviewLayer.frame = view.layer.bounds
        ARview.videoPreviewLayer.session = capt
        Person.Current.isARActive = true
        UserDefaults.standard.set(Person.Current.isARActive, forKey: "AR")
        DispatchQueue.global(qos: .userInitiated).async { capt.startRunning() }
    }
    func stopAR(on:ARView){
        DispatchQueue.main.async {
            on.videoPreviewLayer.session = nil }
        captureSession = nil
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
    func fetchEventData(user:User){
        Peeple.Settings.CurrentPage = .Event
        addInfoView.isHidden = true
        animateViews(labelImage: topRightLabel, collection: collectionView, topRightBut: pageOptionIndicator, middleLabel: middleLabel, topLeftOpts: topLeftOptionButton, peepView: profilePageView, completionHandler: { (true) in
            collectionView.isHidden = false
            bottomLeftImage.isHidden = false
            topRightLabel.image = UIImage(named: Peeple.Settings.RightPage)
            profilePageView.isHidden = true
            addInfoButton.isHidden = false
            editProfileView.isHidden = true
            collectionView.reloadData()
            pageOptionIndicator.image = nil
        })
        switch Peeple.Settings.EventisSetTo {
        case .all:
            middleLabel.text = "Local live events\n\n\(Location.city)"
            middleLabel.isHidden = false
            topLeftOptionButton.isHidden = false
            pageOptionIndicator.image = UIImage(named: "earth")
                        
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
                                    let unfiltered_Events = realm.objects(Events.self)
                                    self.all_Events = filterLiveEvents(realm: realm, unfilteredArray: unfiltered_Events)
                                    stopLoading()
                                    collectionView.reloadData()
            
                                }
            
                            }
            
                        }
                        if all_Events?.count == 0 {
                            middleLabel.text = "Local live events\n\n\(Location.city)"
                            middleLabel.isHidden = false
                        }
            collectionView.reloadData()
            
        case .twentyfive:
            pageOptionIndicator.image = UIImage(named: "mars")
            collectionView.reloadData()
        case .five:
            pageOptionIndicator.image = UIImage(named: "moon")
            collectionView.reloadData()
        }
    }
    func setGroupPage(user:User){
        Peeple.Settings.CurrentPage = .Group
        
        animateViews(labelImage: topRightLabel, collection: collectionView, topRightBut: pageOptionIndicator, middleLabel: middleLabel, topLeftOpts: addInfoButton, peepView: profilePageView, completionHandler: { (true) in
            topRightLabel.image = UIImage(named: Peeple.Settings.BothPage)
            bottomLeftImage.isHidden = true
            profilePageView.isHidden = true
            topWordLabel.text = ""
            addInfoButton.isHidden = false
            middleLabel.isHidden = true
            addInfoButton.setTitle("Make", for: .normal)
            pageOptionIndicator.isHidden = true
            pageOptionIndicator.image = UIImage(named: "search")
            collectionView.reloadData()
        })
        switch Peeple.Settings.GroupisSetTo {
        case .all:
            addInfoView.isHidden = true
            topLeftOptionButton.isHidden = true
            self.middleLabel.text = "Groups in this area\n\n\(Location.city)"
            self.middleLabel.isHidden = false
            if all_Groups == nil {
                startLoading()
               
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
                self.middleLabel.text = "Groups in this area\n\n\(Location.city)"
                self.middleLabel.isHidden = false
            }
            self.collectionView.reloadData()
        case .my:
            addInfoView.isHidden = true
//            topLeftOptionButton.setTitle("my", for: .normal)
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
            topLeftOptionButton.setTitle("", for: .normal)
            pageOptionIndicator.image = nil
            addInfoView.isHidden = true
            self.addInfoButton.isHidden = true
            middleLabel.text = "press and hold screen to search clipboard"
            middleLabel.isHidden = false
            collectionView.reloadData()
 
        }
        
    }
    func fetchGroupData(user:User){
        self.all_Groups = nil
        // The partition determines which subset of data to access.
        let partitionValue = "allGroups=\(Location.city)"
        // Get a sync configuration from the user object.
        let configuration = user.configuration(partitionValue: partitionValue)
        Realm.asyncOpen(configuration: configuration) { (result) in
            switch result {
            case .failure(let error):
                print("Failed to open realm: \(error.localizedDescription)")
            case .success(let Realm):
                self.all_Groups = Realm.objects(allGroups.self).sorted(byKeyPath: "_id")
            }
        }
    }
    func setPeoplePage(user:User){
        Peeple.Settings.CurrentPage = .People
        animateViews(labelImage: topRightLabel, collection: collectionView, topRightBut: pageOptionIndicator, middleLabel: middleLabel, topLeftOpts: topLeftOptionButton, peepView: profilePageView, completionHandler: { (true) in
            collectionView.reloadData()
            collectionView.isHidden = false
            // accessing all views relevant to peoplePage
            // hide all at first
            personPeepView.isHidden = true
            addInfoButton.isHidden = true
            // setting pageLabel image
            pageOptionIndicator.isHidden = true
//            topLeftOptionButton.setBackgroundImage(nil, for: .normal)
            topLeftOptionButton.isHidden = true
            topRightLabel.image = UIImage(named: Peeple.Settings.BothPage)
            // unhiding label when from a persons profile
            topRightLabel.isHidden = false
            //        middleLabel.isHidden = true
            pageOptionIndicator.isHidden = true
            pageOptionIndicator.image = UIImage(named: "search")
            // hiding group view
            addInfoView.isHidden = true
            // hiding profile page info
            editProfileView.isHidden = true
            //        middleLabel.isHidden = false
            profilePageView.isHidden = true
        })

        switch Peeple.Settings.PeopleisSetTo {
        case .all:
            
            self.middleLabel.text = "People in this area\n\n\(Location.country)"
            self.middleLabel.isHidden = false
//            topLeftOptionButton.setTitle("all", for: .normal)
            if all_People == nil {
                startLoading()
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
            self.collectionView.reloadData()
        case .my:
            topLeftOptionButton.setTitle("my", for: .normal)
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
    func fetchPeopleData(user:User){
        self.all_People = nil
        let partitionValue = "allPeople=\(Location.country)"
        // Get a sync configuration from the user object.
        let configuration = user.configuration(partitionValue: partitionValue)
        Realm.asyncOpen(configuration: configuration) { (result) in
            switch result {
            case .failure(let error):
                print("Failed to open realm: \(error.localizedDescription)")
            case .success(let Realm):
                self.all_People = Realm.objects(allPeople.self).sorted(byKeyPath: "_id")
            }
        }
    }
    func setProfile(user:User){
        Peeple.Settings.CurrentPage = .Profile
        editProfileView.isHidden = true
        self.middleLabel.text = ""
        collectionView.reloadData()
        
        animateViews(labelImage: topRightLabel, collection: collectionView, topRightBut: pageOptionIndicator, middleLabel: middleLabel, topLeftOpts: addInfoButton, peepView: profilePageView, completionHandler: { (true) in
            pageOptionIndicator.isHidden = false
            pageOptionIndicator.image = UIImage(named: "pers")
            topRightLabel.image = UIImage(named: Peeple.Settings.LeftPage)
            collectionView.reloadData()
            addInfoButton.isHidden = true
            profilePageView.isHidden = false
            collectionView.isHidden = true
            middleLabel.isHidden = true
            
        })
        middleLabel.isHidden = true
        if peepOneView == nil {
            middleLabel.isHidden = true
            self.peepOneView = loadPeep(num: Person.Current.PeepOne)
            self.peepTwoView = loadPeep(num: Person.Current.PeepTwo)
            self.peepThreeView = loadPeep(num: Person.Current.PeepThree)
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
            middleLabel.isHidden = true
            peepOneView?.isHidden = false
            peepTwoView?.isHidden = true
            peepThreeView?.isHidden = true
            editProfileView.isHidden = true
            profilePageView.isHidden = false
            stopLoading()
        }
        
        middleLabel.isHidden = true
        
    }
    func setSettings(user:User){
        if editProfileView.isHidden == true {
            editProfileView.isHidden = false
            UIView.animate(withDuration: 1.0, delay: 0.0) {
                self.editProfileView.alpha = 0.8
            }
        pageOptionIndicator.image = UIImage(named: "pers")
//        backImage.image = UIImage(named: "earthBack")
            middleLabel.isHidden = true
            topRightLabel.isHidden = false
        
            addInfoButton.setTitle("back", for: .normal)
        profilePageView.isHidden = true
            collectionView.reloadData() } else {
                topRightLabel.isHidden = false
                setProfile(user: user)
            }
        if Peeple.Settings.plus {
            self.PickPurchaseButton.setTitle("choose peeple", for: .normal)
            self.ChangeColorButton.isHidden = false
            self.ARToggleButton.isHidden = false
        }
        if peeplePlusView != nil {
            //show peepleplus purchase xib
            peeplePlusView?.isHidden = true
            peeplePlusView?.removeFromSuperview()
            peeplePlusView = nil
            if Peeple.Settings.plus {
                self.PickPurchaseButton.setTitle("pick peeple", for: .normal)
                self.ChangeColorButton.isHidden = false
                self.ARToggleButton.isHidden = false
            }
            // hide editprofile view
        }
        if allPeepView != nil {
            allPeepView?.isHidden = true
            allPeepView?.removeFromSuperview()
            allPeepView = nil
        }
        if Peeple.Settings.editedPeeps == true {
            //savePeeps
            for view in profilePageView.subviews {
                view.removeFromSuperview()
            }
            peepOneView = nil
            peepTwoView = nil
            peepThreeView = nil
            savePeepSelection(user:user)
            Peeple.Settings.editedPeeps = false
        }
        
    }
    func checkPeeplePlus(){
        Qonversion.checkPermissions { (permissions, error) in
          if let error = error {
            // handle error
              print(error)
            return
          }
            
          if let premium: Qonversion.Permission = permissions["Peeple Plus"], premium.isActive {
            switch premium.renewState {
               case .willRenew, .nonRenewable:
                Peeple.Settings.plus = true
                self.PickPurchaseButton.setTitle("pick peeple", for: .normal)
                self.ChangeColorButton.isHidden = false
                self.ARToggleButton.isHidden = false
                 // .willRenew is the state of an auto-renewable subscription
                 // .nonRenewable is the state of consumable/non-consumable IAPs that could unlock lifetime access
                 break
               case .billingIssue:
                 // Grace period: permission is active, but there was some billing issue.
                 // Prompt the user to update the payment method.
                 break
               case .cancelled:
                 // The user has turned off auto-renewal for the subscription, but the subscription has not expired yet.
                 // Prompt the user to resubscribe with a special offer.
                 break
               default: break
            }
          }
        }
       
    }
    func setPerson(ID:String,name:String,pic:String,priv:Bool,color:Int,one:Int,two:Int,three:Int){
            startLoading()
        Peeple.Settings.CurrentPage = .Person
            Peeple.Settings.PersonOption = .peepOne
        Person.Selected.setInfo(id: ID, priv: priv, peepOne: one, peepTwo: two, peepThree: three, name: name, color: color)
        topRightLabel.image = UIImage(named: Peeple.Settings.RightPage)
            personPeepView.isHidden = false
            profilePageView.isHidden = true
            collectionView.isHidden = true
            middleLabel.isHidden = true
        pageOptionIndicator.image = UIImage(named: Peeple.Settings.PeepPics[one])
//            topLeftOptionButton.setTitle("back", for: .normal)
        topLeftOptionButton.isHidden = false
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
    func peepSwitch(peepOneView:UIView?,peepTwoView:UIView?,peepThreeView:UIView?,allPeepView:UIView,currentOption:Peeple.ProfileOptions,peepOne:Int,peepTwo:Int,peepThree:Int,user:User){
        allPeepView.alpha = 0.0
        switch currentOption {
        case .peepOne:
            backImage.image = UIImage(named: Peeple.Settings.PeepBacks[peepOne])
            if peepOneView != nil {
                peepOneView?.isHidden = false
                peepOneView?.layoutSubviews()
                peepTwoView?.isHidden = true
                peepThreeView?.isHidden = true
                allPeepView.isHidden = false
                self.stopLoading()
            }
        case .peepTwo:
            backImage.image = UIImage(named: Peeple.Settings.PeepBacks[peepTwo])
            if peepTwoView != nil {
                peepOneView?.isHidden = true
                peepTwoView?.layoutSubviews()
                peepTwoView?.isHidden = false
                peepThreeView?.isHidden = true
                allPeepView.isHidden = false
            }
        case .peepThree:
            backImage.image = UIImage(named: Peeple.Settings.PeepBacks[peepThree])
            if peepThreeView != nil {
                peepOneView?.isHidden = true
                peepTwoView?.isHidden = true
                peepThreeView?.isHidden = false
                peepThreeView?.layoutSubviews()
                allPeepView.isHidden = false
            }
            if editProfileView.isHidden == false {
                UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveLinear) {
                    self.editProfileView.alpha = 0
                } completion: { (true) in
                    self.editProfileView.isHidden = true
                }
            }
            if peeplePlusView != nil {
                //show peepleplus purchase xib
                peeplePlusView?.isHidden = true
                peeplePlusView?.removeFromSuperview()
                peeplePlusView = nil
                if Peeple.Settings.plus {
                    self.PickPurchaseButton.setTitle("pick peeple", for: .normal)
                    self.ChangeColorButton.isHidden = false
                    self.ARToggleButton.isHidden = false
                }
                // hide editprofile view
            }
        case .settings:
            
            setSettings(user: user)
            
        }
        UIView.animate(withDuration: 1.0, delay: 0.0, options: .curveEaseIn) {
            allPeepView.alpha = 0.9
        } completion: { (true) in
            print("done")
        }
        
    }
    func toGroupChatWith(ID:String,name:String,pic:String,color:Int,des:String){
        Peeple.Settings.CurrentPage = .GroupChat
        startLoading()
        collectionView.reloadData()
        Group.ID = ID
        Group.name = name
        Group.color = color
        Group.pic = pic
        Group.des = des
        addInfoButton.isHidden = false
//        topLeftOptionButton.setTitle("back", for: .normal)
        topRightLabel.image = UIImage(named: Peeple.Settings.BothPage)
        middleLabel.isHidden = true
        pageOptionIndicator.image = UIImage(named: Peeple.Settings.GroupBoxImage)
        topWordLabel.textColor = Peeple.Settings.Colors[color]
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
                self.group_Events = filterGroupEvents(realm: realm, unfilteredArray: unfiltered_Events)
                collectionView.reloadData()
                self.stopLoading()
            }
            if group_Events?.count == 0 {
                middleLabel.text = "Live events in this group"
                middleLabel.isHidden = false
            }
        }
        
    }
    func filterGroupEvents(realm:Realm,unfilteredArray:Results<groupMessages>?) -> Results<groupMessages>?{
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
    func filterLiveEvents(realm:Realm,unfilteredArray:Results<Events>?) -> Results<Events>?{
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
                let task = allPeople(color: Person.Current.Color, image: "", name: Person.Current.Name, peepOne: Person.Current.PeepOne,peepTwo: Person.Current.PeepTwo,peepThree: Person.Current.PeepThree, biz: false, bio: "",priv:false, ID: user.id)
                try! realm.write { realm.add(task,update: .modified) }
                
                print("Successfully logged in as user \(user)")
            }
        }
    }
    func savePeepSelection(user:User){
        startLoading()
        let partitionValue2 = "me=\(user.id)"
        // Get a sync configuration from the user object.
        let configuration2 = user.configuration(partitionValue: partitionValue2)
        Realm.asyncOpen(configuration: configuration2) { [self] (result) in
            switch result {
            case .failure(let error):
                print(error)
                DispatchQueue.main.async {
                    self.stopLoading()
                }
                
            case .success(let realm):
                if let me = realm.objects(mePerson.self).first {
                    try! realm.write {
                        me.peepOne = Person.Current.PeepOne
                        me.peepTwo = Person.Current.PeepTwo
                        me.peepThree = Person.Current.PeepThree
                    }
                    DispatchQueue.main.async {
                        self.stopLoading() }
                }
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
        Peeple.Settings.PeopleisSetTo = .search
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
        Peeple.Settings.GroupisSetTo = .search
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
    func setLanguage(index:Int){
        UserDefaults.standard.set(index, forKey: "language")
        Peeple.Settings.language = index
        switch index {
        case 0:
            //english
            return
            //set image labels for portugese
            //set text labels for portugese
        case 1:
            //portugese
            return
            //set image labels for portugese
            //set text labels for portugese
        case 2:
            //set image labels for spanish
            //set text lables for spanish
            return
        default:
            return
        }
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
   
    func loadPeepData(one:Int,two:Int,three:Int,user:User){
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
                                if let charight = peeps.charight {  Peeps.Current.charight = charight }
                            case 2:
                                if let cleanergy = peeps.cleanergy {  Peeps.Current.clenny = cleanergy }
                            case 3:
                                if let porty = peeps.portflio {  Peeps.Current.porty = porty }
                            default:
                                print("no peep data")
                                
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

