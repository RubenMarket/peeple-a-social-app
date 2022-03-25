//
//  ChatPage.swift
//  People
//
//  Created by admin on 1/5/22.
//  Copyright © 2022 A Sirius Company. All rights reserved.
//

import UIKit
import AVFoundation
import RealmSwift

class ChatPage: UIViewController {

    private var messages: Results<groupMessages>?
    
    @IBOutlet weak var ARView: ARView!
    
    func loadGroupChats(){
//        startLoading()
        if UserDefaults.standard.bool(forKey: "isLocationEnabled") {
        // show share event location button
        }
     
    }
    @objc func handleSwipes(_ sender:UISwipeGestureRecognizer) {
        switch sender.direction {
        case .left:
            // page to the right
            print("page to the right | direction right")
            self.dismiss(animated: false, completion: nil)
        case .right:
            // page to the left
            print("page to the left | direction left")
            self.dismiss(animated: false, completion: nil)
        case .up:
            //option UP
            // setting next option + refresh data
            print("option UP")
        case .down:
            //option down
            // setting next option + refresh data
            print("option DOWN")
        
        default:
            return
        }
       
    }
    @objc func handleHold(_ sender:UILongPressGestureRecognizer) {
       return
    }
    func addGestures(){
        let leftSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        let rightSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        let upSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        let downSwipe = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes(_:)))
        let hold = UILongPressGestureRecognizer(target: self, action: #selector(handleHold(_:)))
        leftSwipe.direction = .left
        rightSwipe.direction = .right
        upSwipe.direction = .up
        downSwipe.direction = .down
        hold.minimumPressDuration = 1
        view.addGestureRecognizer(hold)
        view.addGestureRecognizer(leftSwipe)
        view.addGestureRecognizer(rightSwipe)
        view.addGestureRecognizer(upSwipe)
        view.addGestureRecognizer(downSwipe)
    }
    func emptyGroupChat(){
        Group.ID = ""
        Group.name = ""
        Group.color = 0
        Group.pic = ""
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        loadGroupChats()
        addGestures()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        emptyGroupChat()
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
