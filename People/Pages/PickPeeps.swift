//
//  pickpeeps.swift
//  People
//
//  Created by Ruben Mercado on 6/3/20.
//  Copyright © 2020 Sirius Awe. All rights reserved.
//

import UIKit
import Foundation
import RealmSwift
import AVFoundation

class pickpeeps: UIViewController {
    
    @IBOutlet var peepbuts: [UIButton]!
    @IBOutlet weak var pickpeeplabel: UILabel!
    @IBOutlet weak var arview: ARView!
    @IBOutlet weak var donebut: UIButton!
    private var captureSession: AVCaptureSession?
    private var winningminiapps: [Int] = []
    private var threecheckmarks1 = 0
    var peepToSwitch:Int?
    var peepOne:Int?
    var peepTwo:Int?
    var peepThree:Int?
    private var uploaddone:Bool = false
    @IBAction func done(_ sender: Any) {
        savepeeps()
    }
    
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
        arview.videoPreviewLayer.videoGravity = AVLayerVideoGravity.resizeAspectFill
        arview.videoPreviewLayer.frame = view.layer.bounds
        arview.videoPreviewLayer.session = capt
        DispatchQueue.global(qos: .userInitiated).async {
        capt.startRunning()
        }
    }
    override var prefersStatusBarHidden: Bool {
        return true
    }
    override func viewWillAppear(_ animated: Bool) {
        if Person.Current.isARActive {
            view.backgroundColor = .black
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        switch peepToSwitch{
            //disable peeps to keep
        case 1:
            for peep in peepbuts{
                if peep.tag == peepTwo {
                    peep.isEnabled = false }
                if peep.tag == peepThree {
                    peep.isEnabled = false }  }
        case 2:
            for peep in peepbuts{
                if peep.tag == peepOne {
                    peep.isEnabled = false  }
                if peep.tag == peepThree {
                    peep.isEnabled = false } }
        case 3:
            for peep in peepbuts{
                if peep.tag == peepTwo {
                    peep.isEnabled = false }
                if peep.tag == peepOne {
                    peep.isEnabled = false } }
        default:
            return
        }
        if Person.Current.isARActive {
            view.backgroundColor = .black
            ARModeActivate()
        }
        donebut.setTitleColor(Peeple.Settings.Colors[Person.Current.Color], for: .normal)
        
    }
    override func viewDidLayoutSubviews() {
        
    }
    @IBAction func peep(_ sender: UIButton) {
//        guard let user = app.currentUser else { return }
//        let partitionValue = "me=\(user.id)"
//        let configuration2 = user.configuration(partitionValue: partitionValue)
//        switch peepToSwitch {
//        case 1:
//            peepOne = sender.tag
//            
//            Realm.asyncOpen(configuration: configuration2) { (result) in
//                switch result {
//                case .failure(let error):
//                    print("Failed to open realm: \(error.localizedDescription)")
//                    // Handle error...
//                case .success(let realm):
//                    // Realm opened
//                    if let me = realm.object(ofType: mePerson.self, forPrimaryKey: user.id) {
//                        try! realm.write {
//                            me.one = self.peepOne!
//                        }
//                    }
//                    DispatchQueue.main.async {
//                        self.dismiss(animated: false, completion: nil)
//                    }
//                    
//                }
//            }
//        case 2:
//            peepTwo = sender.tag
//            Realm.asyncOpen(configuration: configuration2) { (result) in
//                switch result {
//                case .failure(let error):
//                    print("Failed to open realm: \(error.localizedDescription)")
//                    // Handle error...
//                case .success(let realm):
//                    // Realm opened
//                    if let me = realm.object(ofType: mePerson.self, forPrimaryKey: user.id) {
//                        try! realm.write {
//                            me.peep = self.peepTwo!
//                        }
//                    }
//                    DispatchQueue.main.async {
//                        self.dismiss(animated: false, completion: nil)
//                    }
//                    
//                }
//            }
//        case 3:
//            peepThree = sender.tag
//            Realm.asyncOpen(configuration: configuration2) { (result) in
//                switch result {
//                case .failure(let error):
//                    print("Failed to open realm: \(error.localizedDescription)")
//                    // Handle error...
//                case .success(let realm):
//                    // Realm opened
//                    if let me = realm.object(ofType: mePerson.self, forPrimaryKey: user.id) {
//                        try! realm.write {
//                            me.one = self.peepThree!
//                        }
//                    }
//                    DispatchQueue.main.async {
//                        self.dismiss(animated: false, completion: nil)
//                    }
//                    
//                }
//            }
//        default:
//            return
//        }
//        
        
//        func greencheckmark() {
//            if sender.transform != CGAffineTransform.identity{
//                sender.transform = CGAffineTransform.identity
//
//                        self.threecheckmarks1 -= 1
//                        self.winningminiapps = self.winningminiapps.filter{$0 != sender.tag }
//                    }else if self.threecheckmarks1 == 3{
//                        sender.transform = CGAffineTransform.identity
//                    }else if sender.layer.borderWidth == 0{
//                        sender.transform = CGAffineTransform(scaleX: 1.4, y: 1.4)
//                        self.threecheckmarks1 += 1
//                        self.winningminiapps.append(sender.tag)
//
//                    }
//                }
//                    switch sender.tag {
//                    case 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17:
//                        greencheckmark()
//                        print(threecheckmarks1)
//                    default:
//                        print("not one")
//
//                    print("not purchased")
//                }
//                print("these are the three winning apps \(self.winningminiapps)")
    }
    func savepeeps(){
           if self.threecheckmarks1 == 3 {
               peepOne = winningminiapps[0]
               peepTwo = winningminiapps[1]
               peepThree = winningminiapps[2]
           
               
//
           } else if threecheckmarks1 == 0 {
            
            DispatchQueue.main.async {
                self.dismiss(animated: false, completion: nil)
            }
            
            
            
            
        }
             
       }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
