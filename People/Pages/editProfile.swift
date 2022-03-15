//
//  editProfile.swift
//  People
//
//  Created by admin on 11/29/21.
//  Copyright © 2021 A Sirius Company. All rights reserved.
//

import UIKit

class editProfile: UIView {

    @IBOutlet weak var OneButton: UIButton!
    @IBOutlet weak var TwoButton: UIButton!
    @IBOutlet weak var ThreeButton: UIButton!
    @IBOutlet weak var FourButton: UIButton!
    @IBOutlet weak var FiveButton: UIButton!
  
    @IBAction func OnePressed(_ sender: UIButton) {
        UIPasteboard.general.string = Person.Current.ID
        sender.isEnabled = false
    }
    @IBAction func TwoPressed(_ sender: Any) {
    }
    @IBAction func ThreePressed(_ sender: Any) {
    }
    @IBAction func FourPressed(_ sender: Any) {
    }
    @IBAction func FivePressed(_ sender: Any) {
    }
    override func layoutSubviews() {
        if Person.Current.ID != "" {
            OneButton.isHidden = false
        }
        
        
    }
    
    
    

}
