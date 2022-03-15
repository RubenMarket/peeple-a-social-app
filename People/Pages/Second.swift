//
//  GroupPeoplePage.swift
//  People
//
//  Created by admin on 12/21/21.
//  Copyright © 2021 A Sirius Company. All rights reserved.
//

import UIKit
import AVFoundation

class Second: UIViewController {
    @IBOutlet weak var ARView: ARView!
    @IBOutlet weak var topLeftImage: UIImageView!
    
    @IBOutlet weak var topLeftButton: UIButton!
    
    @IBOutlet weak var peepView: UIView!
    @IBOutlet weak var middlePeep: UIButton!
    @IBOutlet weak var topPeep: UIButton!
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var bottomPeep: UIButton!
    @IBAction func topLeftButtonPress(_ sender: UIButton) {
    }
    
    
    @IBAction func topPeepPress(_ sender: UIButton) {
    }
    
    @IBAction func midPeepPress(_ sender: Any) {
    }
    
    @IBAction func bottomPeepPress(_ sender: Any) {
    }
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
    func setUpGroupChat(){
        peepView.isHidden = true
        topPeep.isHidden = true
        middlePeep.isHidden = true
        bottomPeep.isHidden = true
    }
    func setUpPersonPage(){
        
    }
    func ARSetUp(){
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized: // the user has already authorized to access the camera.
            setUpAR()
            beginAR(on:ARView)
        case .notDetermined: // the user has not yet asked for camera access.
//            AVCaptureDevice.requestAccess(for: .video) { [self] (granted) in
//                if granted { // if user has granted to access the
//                    setUpAR()
//                    beginAR(on: ARView)
//                } else {
//                    print("the user has not granted to access the camera")
//                }
//            }
            print("notDetermined.")
        default:
            print("something has wrong due to we can't access the camera.")
        }
    }
    @objc func handleSwipes(_ sender:UISwipeGestureRecognizer) {
        self.dismiss(animated: false)
        }
    func addGestures(){
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
    override func viewDidLoad() {
        super.viewDidLoad()
        ARSetUp()
        addGestures()
        switch Peeple.SecondisSetTo {
        case .GroupChat:
            setUpGroupChat()
        case .Person:
            setUpPersonPage()
        }
        // Do any additional setup after loading the view.
    }
//    init(isGroup: Bool,groupOrPerson:AnyObject) {
//        if isGroup {
//
//        }
//           self.photo = photo
//           super.init(nibName: "PhotoDetailViewController2", bundle: nil)
//       }
//
//       required init?(coder: NSCoder) {
//           fatalError("init(coder:) is not supported")
//       }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
