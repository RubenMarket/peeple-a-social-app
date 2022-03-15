//
//  splish.swift
//  People
//
//  Created by Ruben Mercado on 5/17/19.
//  Copyright © 2019 Sirius Awe. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift
import AVFoundation



class splish : UIViewController{
    @IBOutlet weak var logo: UIImageView!
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent  }
    override var prefersStatusBarHidden: Bool {
        return true }
    override func viewDidLoad() {
       
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        if app.currentUser != nil {
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "splish", sender: nil)
            }
        } else {
            DispatchQueue.main.async {
                self.performSegue(withIdentifier: "splash", sender: nil)
            }
        }
    }
    override func viewWillDisappear(_ animated: Bool) {
        
    }
}

