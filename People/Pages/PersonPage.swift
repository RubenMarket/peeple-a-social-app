//
//  userfound.swift
//  People
//
//  Created by Ruben Mercado on 1/10/19.
//  Copyright © 2019 Sirius Awe. All rights reserved.
//

import Foundation
import RealmSwift
import SDWebImage
import AVFoundation
import SafariServices

class founduser: UIViewController,UIGestureRecognizerDelegate,SFSafariViewControllerDelegate {
    func addPhoto(at index: IndexPath) {
        print("here")
    }
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
    @IBOutlet weak var firstbut: UIButton!
    @IBOutlet weak var secondbut: UIButton!
    @IBOutlet weak var thirdbut: UIButton!
    @IBOutlet weak var profimage1: UIImageView!
    @IBOutlet weak var fullname1: UILabel!
    @IBOutlet weak var bio1: UILabel!
    @IBOutlet weak var placeholderview: ARView!
    @IBOutlet weak var homebut: UIButton!
    @IBOutlet weak var optionbut: UIButton!
    private var fromevent:Bool = false
    private var chosenpeep:Int = 0
    private var fromfavs: Bool = false
    private var portflioPics : List<portflioPost>?
    private var blockedtime: String = ""
    private var storyprof:String = ""
    var fromhome:Bool = false
    // index 0 is the peep button itself
    // index 1 is the inside of a peep
    private var sharedPeep:Bool = false
    private weak var oneView:UIView?
    private weak var twoView:UIView?
    private weak var threeView:UIView?
    @IBAction func backtosearch(_ sender: Any) {
        ID.selected = ""
        DispatchQueue.main.async {
        self.dismiss(animated: true, completion: nil)
        }
    }
    
    func peep(numer:Int,time:String){
        if Int.random(in: 1...Peeple.settings.rarity) == 1 && !sharedPeep {
            sharedPeep = true
            guard let user = app.currentUser else { return }
               // The partition determines which subset of data to access.
            let partitionValue = "earthFeed=\(Location.continent)"
               // Get a sync configuration from the user object.
               let configuration = user.configuration(partitionValue: partitionValue)
               // Open the realm asynchronously to ensure backend data is downloaded first.
            Realm.asyncOpen(configuration: configuration) { [self] (result) in
                   switch result {
                   case .failure(let error):
                       print("Failed to open realm: \(error.localizedDescription)")
                       // Handle error...
                   case .success(let Realm):
                       // Realm opened
                    let earrf = earthFeed(text: "", name: Person.Selected.name, time: time, imgeurl: "", peepone: Person.Selected.one, peeptwo: Person.Selected.two, peepthree: Person.Selected.three, color: Person.Selected.color, biz: false, peep: numer, lotag: "", userID: ID.selected, _id: "\(Int.random(in: 1...21))")
                    print("success Realm open")
                        try! Realm.write {
                            Realm.add(earrf, update: .modified)
                            NotificationCenter.default.post(name: .refreshdata, object: nil)
                            self.sharedPeep = true
                        }
                        
                    
                   }
               }
        
            
        }
        
    }
    @IBAction func tominiapp(_ sender: UIButton) {
        let generator = UIImpactFeedbackGenerator(style: .light)
        generator.impactOccurred()
        oneView?.isHidden = true
        twoView?.isHidden = true
        threeView?.isHidden = true
        UIView.animate(withDuration: 0.8) {
            self.firstbut.transform = CGAffineTransform.identity
            self.secondbut.transform = CGAffineTransform.identity
            self.thirdbut.transform = CGAffineTransform.identity
            sender.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        } completion: { (true) in
        }
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "YY, MMM d, HH:mm:ss"
        let timestuu:String = formatter.string(from: date)
        
        switch sender.tag {
        case 100:
            guard let view = oneView else { return }
            self.placeholderview.bringSubviewToFront(view)
            view.isHidden = false
            peep(numer: Person.Selected.one, time: timestuu)
        case 200 :
            guard let view = twoView else { return }
            self.placeholderview.bringSubviewToFront(view)
            view.isHidden = false
            peep(numer: Person.Selected.two, time: timestuu)
        case 300 :
            guard let view = threeView else { return }
            self.placeholderview.bringSubviewToFront(view)
            view.isHidden = false
            peep(numer: Person.Selected.three, time: timestuu)
        default:
            print("end")
        }
    }
    
    @IBAction func optionbut(_ sender: UIButton) {
        let alert1 = UIAlertController(title: "options", message: nil, preferredStyle: .alert)
        let user = app.currentUser!
        alert1.addAction(UIAlertAction(title: "request to be close", style: .default, handler: { (action) in
            
               // The partition determines which subset of data to access.
            let partitionValue = "requests=\(ID.selected)"
               // Get a sync configuration from the user object.
               let configuration = user.configuration(partitionValue: partitionValue)
                            Realm.asyncOpen(configuration: configuration) { (result) in
                                switch result {
                                case .failure(let error):
                                    print("Failed to open realm: \(error.localizedDescription)")
                                    // Handle error...
                                case .success(let Realm):
                                    let request = request(color: Peeple.settings.myAppColor,name: Person.Current.name, pic: Person.Current.pic, one: Person.Current.one, two: Person.Current.two, three: Person.Current.three,_id: ID.my)
                                        try! Realm.write {
                                            Realm.add(request,update: .modified)
                                        }
                                }
                            }
                        
        }))
        alert1.addAction(UIAlertAction(title: "report profile image", style: .default, handler: { (action) in
//            let partitionValue = "reports=\(SelectedUser.ID)"
               // Get a sync configuration from the user object.
//               let configuration = user.configuration(partitionValue: partitionValue)
//                            Realm.asyncOpen(configuration: configuration) { (result) in
//                                switch result {
//                                case .failure(let error):
//                                    print("Failed to open realm: \(error.localizedDescription)")
//                                    // Handle error...
//                                case .success(let Realm):
//                                    let request = request(color: currentUser.color, personPic: currentUser.pic, one: currentUser.one, two: currentUser.two, three: currentUser.three,_id: currentUser.ID)
//                                        try! Realm.write {
//                                            Realm.add(request,update: .modified)
//                                        }
//                                }
//                            }
        }))
        alert1.addAction(UIAlertAction(title: "report an event", style: .default, handler: { (action) in
        
            
            
            
        }))
        alert1.addAction(UIAlertAction(title: "report peep content", style: .default, handler: { (action) in
        
            
            
            
        }))
        alert1.addAction(UIAlertAction(title: "none", style: .cancel, handler: { (action) in
        
            
            
            
        }))
        present(alert1, animated: true)
        
    }
    
   
    
   
    var originalx:CGFloat = 0.0
    @objc func hidepeeps(_ sender: UISwipeGestureRecognizer) {
           print("here")
           if sender.direction == .right  {
               UIView.animate(withDuration: 1.0,delay: 0 ,options: [.curveEaseOut], animations: {
                   
                   self.firstbut.center.x = self.firstbut.frame.origin.x + (self.view.frame.width -  self.firstbut.frame.origin.x + self.firstbut.frame.width)
                   self.secondbut.center.x = self.secondbut.frame.origin.x + (self.view.frame.width -  self.secondbut.frame.origin.x + self.secondbut.frame.width)
                   self.thirdbut.center.x = self.thirdbut.frame.origin.x + (self.view.frame.width -  self.thirdbut.frame.origin.x + self.thirdbut.frame.width)
                   
               })
               
           } else if sender.direction == .left {
               UIView.animate(withDuration: 1.0,delay: 0 ,options: [.curveEaseIn], animations: {
                   
                   self.firstbut.center.x = self.originalx
                   self.secondbut.center.x = self.originalx
                   self.thirdbut.center.x = self.originalx
                   
               })
               
           }
       }
    func swipeddd() {
        let swipe = UISwipeGestureRecognizer(target: self, action: #selector(founduser.hidepeeps(_:)))
        swipe.delegate = self
        self.view.addGestureRecognizer(swipe)
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(founduser.hidepeeps(_:)))
        swipeLeft.direction = .left
        swipeLeft.delegate = self
        self.view.addGestureRecognizer(swipeLeft)
    }
    override func viewDidLayoutSubviews() {
        
        self.originalx = self.firstbut.center.x
    }
    override func viewWillAppear(_ animated: Bool) {
        
    }
    private var captureSession: AVCaptureSession?
    private func ARModeActivate(){
        captureSession = AVCaptureSession()
        guard let capt = self.captureSession else { return }
        guard let captureDevice = AVCaptureDevice.default(for: AVMediaType.video) else { return }
        do {
          let input = try AVCaptureDeviceInput(device: captureDevice)
            capt.addInput(input)
        } catch {
          print(error)
        }
        placeholderview.videoPreviewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        placeholderview.videoPreviewLayer.frame = view.layer.bounds
        placeholderview.videoPreviewLayer.session = capt
        DispatchQueue.global(qos: .userInitiated).async {
        capt.startRunning()
        }
        
    }
    func addSwipeGestures(){
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        leftSwipe.direction = .left
        rightSwipe.direction = .right
        upSwipe.direction = .up
        downSwipe.direction = .down
        view.addGestureRecognizer(leftSwipe)
        view.addGestureRecognizer(rightSwipe)
        view.addGestureRecognizer(upSwipe)
        view.addGestureRecognizer(downSwipe)
    }
    @objc func handleSwipes(_ sender:UISwipeGestureRecognizer) {
        
        if sender.direction == .right {
            // to middle page
            self.dismiss(animated: false, completion: nil)
        }
        if sender.direction == .left {
            // to middle page
            self.dismiss(animated: false, completion: nil)
        }
        if sender.direction == .down {
            // to middle page
            self.dismiss(animated: false, completion: nil)
        }
        if sender.direction == .up {
            // to middle page
            self.dismiss(animated: false, completion: nil)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPeepTwo(two: Person.Selected.two)
        loadPeepOne(one: Person.Selected.one)
        loadPeepThree(three: Person.Selected.three)
        addSwipeGestures()
        if Peeple.settings.isARMode { view.backgroundColor = .black }
        // Open the realm asynchronously to ensure backend data is downloaded first.
        self.fullname1.text = Person.Selected.name
        self.optionbut.setTitleColor(Peeple.settings.colors[Person.Selected.color], for: .normal)
        profimage1.image = UIImage(named: "pers")
        profimage1.tintColor = Peeple.settings.colors[Person.Selected.color]
        profimage1.borderColor(color: Peeple.settings.colors[Person.Selected.color])
//        if Person.Selected.pic != "" {
//            let imageURL = URL(string: "\(Person.Selected.pic)")
//            profimage1.sd_setImage(with: imageURL, placeholderImage: UIImage(named: Peeple.picColors[Person.Selected.color]))
//        } else {
//            if Peeple.biz { profimage1.image = UIImage(named: "biz") } else {
//                profimage1.image = UIImage(named: Peeple.picColors[SelectedUser.color])
//            }
//        }
        
        secondbut.setBackgroundImage(UIImage(named: Peeple.settings.peepPics[Person.Selected.two]), for: .normal)
        firstbut.setBackgroundImage(UIImage(named: Peeple.settings.peepPics[Person.Selected.one]), for: .normal)
        thirdbut.setBackgroundImage(UIImage(named: Peeple.settings.peepPics[Person.Selected.three]), for: .normal)
        profimage1.setPeepleCorners()
        optionbut.circle()
        homebut.layer.masksToBounds = true
        if 1 == Int.random(in: 1...Peeple.settings.rarity) {
        guard let user = app.currentUser else {  return }
        let configuration = user.configuration(partitionValue: "topPeople=\(Location.city)")
    Realm.asyncOpen(configuration: configuration) { (result) in
        switch result {
        case .failure(let error):
            print("Failed to open realm: \(error.localizedDescription)")
            // Handle error...
        case .success(let realm):
            // Realm opened
            let topPerson = topPeopleV2(color: Person.Selected.color, image: Person.Selected.pic, name: Person.Selected.name, biz: Person.Selected.biz, one: Person.Selected.one, two: Person.Selected.two, three: Person.Selected.three, ID: ID.selected, priv: Person.Selected.priv, numberPerson: "\(ID.selected)")
                do {
                    try realm.write({
                        realm.add(topPerson,update: .modified)
                    })
                } catch  {
                    print("error")
                }
            
            
        }
    }
        }
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
//        UIView.animate(withDuration: 0.5) {
//            self.homebut.alpha = 1
//        }
        if Peeple.settings.isARMode {
            ARModeActivate()
        } else {
            view.backgroundColor = .systemGray6
        }
        MusicPlayer.shared.playPeep()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        ID.selected = ""
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
}

extension founduser {
    
    func loadPeepOne(one:Int){
        switch one {
        case 1 :
            oneView = charightview.instanceFromNib()
            guard let view = oneView else { return }
            self.placeholderview.addSubview(view)
            view.snp.makeConstraints { (make) in
                make.edges.equalTo(placeholderview) }
        case 2 :
            oneView = cleanergy.instanceFromNib()
            guard let view = oneView else { return }
            self.placeholderview.addSubview(view)
            view.snp.makeConstraints { (make) in
                make.edges.equalTo(placeholderview) }
        case 3 :
            let porty = portoflio()
            oneView = porty.instanceFromNib()
            guard let view = oneView else { return }
            self.placeholderview.addSubview(view)
            view.snp.makeConstraints { (make) in
                make.edges.equalTo(placeholderview) }
        case 4 :
            oneView = spacechip.instanceFromNib()
            guard let view = oneView else { return }
            self.placeholderview.addSubview(view)
            view.snp.makeConstraints { (make) in
                make.edges.equalTo(placeholderview) }
        case 8 :
            oneView = theorize.instanceFromNib()
            guard let view = oneView else { return }
            self.placeholderview.addSubview(view)
            view.snp.makeConstraints { (make) in
                make.edges.equalTo(placeholderview) }
        case 10 :
            oneView = shelfiecontroller.instanceFromNib()
            guard let view = oneView else { return }
            self.placeholderview.addSubview(view)
            view.snp.makeConstraints { (make) in
                make.edges.equalTo(placeholderview)  }
        case 12 :
            oneView = mymecontroller.instanceFromNib()
            guard let view = oneView else { return }
            self.placeholderview.addSubview(view)
            view.snp.makeConstraints { (make) in
                make.edges.equalTo(placeholderview) }
        case 14 :
            oneView = betatester.instanceFromNib()
            guard let view = oneView else { return }
            self.placeholderview.addSubview(view)
            view.snp.makeConstraints { (make) in
                make.edges.equalTo(placeholderview) }
        case 16 :
            oneView = awemember.instanceFromNib()
            guard let view = oneView else { return }
            self.placeholderview.addSubview(view)
            view.snp.makeConstraints { (make) in
                make.edges.equalTo(placeholderview) }
        default :
            oneView = comingsoon.instanceFromNib()
            guard let view = oneView else { return }
            self.placeholderview.addSubview(view)
            view.snp.makeConstraints { (make) in
                make.edges.equalTo(placeholderview) }
        }
    }
    func loadPeepThree(three:Int){
        switch three {
        case 1 :
            threeView = charightview.instanceFromNib()
            guard let view = threeView else { return }
            self.placeholderview.addSubview(view)
            view.snp.makeConstraints { (make) in
                make.edges.equalTo(placeholderview) }
        case 2 :
            threeView = cleanergy.instanceFromNib()
            guard let view = threeView else { return }
            self.placeholderview.addSubview(view)
            view.snp.makeConstraints { (make) in
                make.edges.equalTo(placeholderview) }
        case 3 :
            let porty = portoflio()
            threeView = porty.instanceFromNib()
            guard let view = threeView else { return }
            self.placeholderview.addSubview(view)
            view.snp.makeConstraints { (make) in
                make.edges.equalTo(placeholderview) }
        case 4 :
            threeView = spacechip.instanceFromNib()
            guard let view = threeView else { return }
            self.placeholderview.addSubview(view)
            view.snp.makeConstraints { (make) in
                make.edges.equalTo(placeholderview) }
        case 8 :
            threeView = theorize.instanceFromNib()
            guard let view = threeView else { return }
            self.placeholderview.addSubview(view)
            view.snp.makeConstraints { (make) in
                make.edges.equalTo(placeholderview)
            }
        case 10 :
            threeView = shelfiecontroller.instanceFromNib()
            guard let view = threeView else { return }
            self.placeholderview.addSubview(view)
            view.snp.makeConstraints { (make) in
                make.edges.equalTo(placeholderview)  }
        case 12 :
            threeView = mymecontroller.instanceFromNib()
            guard let view = threeView else { return }
            self.placeholderview.addSubview(view)
            view.snp.makeConstraints { (make) in
                make.edges.equalTo(placeholderview) }
        case 14 :
            threeView = betatester.instanceFromNib()
            guard let view = threeView else { return }
            self.placeholderview.addSubview(view)
            view.snp.makeConstraints { (make) in
                make.edges.equalTo(placeholderview) }
        case 16 :
            threeView = awemember.instanceFromNib()
            guard let view = threeView else { return }
            self.placeholderview.addSubview(view)
            view.snp.makeConstraints { (make) in
                make.edges.equalTo(placeholderview) }
        default :
            threeView = comingsoon.instanceFromNib()
            guard let view = threeView else { return }
            self.placeholderview.addSubview(view)
            view.snp.makeConstraints { (make) in
                make.edges.equalTo(placeholderview) }
        }
        oneView?.isHidden = true
        threeView?.isHidden = true
    }
    func loadPeepTwo(two:Int) {
        switch two {
        case 1 :
            twoView = charightview.instanceFromNib()
            guard let view = twoView else { return }
            self.placeholderview.addSubview(view)
            view.snp.makeConstraints { (make) in
                make.edges.equalTo(placeholderview) }
        case 2 :
            twoView = cleanergy.instanceFromNib()
            guard let view = twoView else { return }
            self.placeholderview.addSubview(view)
            view.snp.makeConstraints { (make) in
                make.edges.equalTo(placeholderview) }
        case 3 :
            let porty = portoflio()
            twoView = porty.instanceFromNib()
            guard let view = twoView else { return }
            self.placeholderview.addSubview(view)
            view.snp.makeConstraints { (make) in
                make.edges.equalTo(placeholderview) }
        case 4 :
            twoView = spacechip.instanceFromNib()
            guard let view = twoView else { return }
            self.placeholderview.addSubview(view)
            view.snp.makeConstraints { (make) in
                make.edges.equalTo(placeholderview) }
        case 8 :
            twoView = theorize.instanceFromNib()
            guard let view = twoView else { return }
            self.placeholderview.addSubview(view)
            view.snp.makeConstraints { (make) in
                make.edges.equalTo(placeholderview)
            }
        case 10 :
            twoView = shelfiecontroller.instanceFromNib()
            guard let view = twoView else { return }
            self.placeholderview.addSubview(view)
            view.snp.makeConstraints { (make) in
                make.edges.equalTo(placeholderview)  }
        case 12 :
            twoView = mymecontroller.instanceFromNib()
            guard let view = twoView else { return }
            self.placeholderview.addSubview(view)
            view.snp.makeConstraints { (make) in
                make.edges.equalTo(placeholderview) }
        case 14 :
            twoView = betatester.instanceFromNib()
            guard let view = twoView else { return }
            self.placeholderview.addSubview(view)
            view.snp.makeConstraints { (make) in
                make.edges.equalTo(placeholderview)  }
        case 16 :
            twoView = awemember.instanceFromNib()
            guard let view = twoView else { return }
            self.placeholderview.addSubview(view)
            view.snp.makeConstraints { (make) in
                make.edges.equalTo(placeholderview)  }
        default :
            twoView = comingsoon.instanceFromNib()
            guard let view = twoView else { return }
            self.placeholderview.addSubview(view)
            view.snp.makeConstraints { (make) in
                make.edges.equalTo(placeholderview) }
        }
        
    }
    
    
}
    
