//
//  allPeeps.swift
//  People
//
//  Created by admin on 6/26/22.
//  Copyright © 2022 A Sirius Company. All rights reserved.
//

import UIKit

class allPeeps: UIView {
    @IBOutlet weak var peepOne: UIButton!
    @IBOutlet weak var peepTwo: UIButton!
    @IBOutlet weak var peepThree: UIButton!
    @IBOutlet weak var peepFour: UIButton!
    @IBOutlet weak var peepFive: UIButton!
    @IBOutlet weak var peepSix: UIButton!
    @IBOutlet weak var peepSeven: UIButton!
    @IBOutlet weak var peepEight: UIButton!
    @IBOutlet weak var peepNine: UIButton!
    @IBOutlet weak var peepTen: UIButton!
    @IBOutlet weak var peepEleven: UIButton!
    @IBOutlet weak var peepTwelve: UIButton!
    @IBOutlet weak var peepThirtheen: UIButton!
    @IBOutlet weak var peepFifteen: UIButton!
    @IBOutlet weak var peepSixteen: UIButton!
    private var choosenPeeps: [Int:Int] = [:]
    private var threePeeps = 0
    @IBAction func Charight(_ sender: UIButton) {  // 1
        peepTapped(peepButton: sender)
    }
    @IBAction func Cleanergy2(_ sender: UIButton) {
        peepTapped(peepButton: sender)
    }
    @IBAction func portflio3(_ sender: UIButton) {
        peepTapped(peepButton: sender)
    }
    @IBAction func spachip4(_ sender: UIButton) {
        peepTapped(peepButton: sender)
    }
    @IBAction func cupidity5(_ sender: UIButton) {
        peepTapped(peepButton: sender)
    }
    @IBAction func animalife6(_ sender: UIButton) {
        peepTapped(peepButton: sender)
    }
    @IBAction func theorize8(_ sender: UIButton) {
        peepTapped(peepButton: sender)
    }
    @IBAction func shelfie10(_ sender: UIButton) {
        peepTapped(peepButton: sender)
    }
    @IBAction func clouds9(_ sender: UIButton) {
        peepTapped(peepButton: sender)
    }
    @IBAction func travled11(_ sender: UIButton) {
        peepTapped(peepButton: sender)
    }
    @IBAction func myme12(_ sender: UIButton) {
        peepTapped(peepButton: sender)
    }
    @IBAction func alexie(_ sender: UIButton) { // 13
        peepTapped(peepButton: sender)
    }
    @IBAction func mucity15(_ sender: UIButton) {
        peepTapped(peepButton: sender)
    }
    @IBAction func awemem16(_ sender: UIButton) {
        peepTapped(peepButton: sender)
    }
    override func layoutSubviews() {
        choosenPeeps = [1:Person.Current.PeepOne,2:Person.Current.PeepTwo,3:Person.Current.PeepThree]
        threePeeps = 3
        for peepTag in choosenPeeps.values {
            let peep = viewWithTag(peepTag)
                peep?.transform = CGAffineTransform(scaleX: 1.2, y: 1.2)
        }
    }
    
    func peepTapped(peepButton:UIButton){
        peepButton.isEnabled = false
        switch peepButton.tag {
        case Person.Current.PeepOne:
            choosenPeeps[1] = 0
            UIView.animate(withDuration: 1.0, delay: 0.0) {
                peepButton.transform = CGAffineTransform.identity }
            threePeeps -= 1
        case Person.Current.PeepTwo:
            choosenPeeps[2] = 0
            UIView.animate(withDuration: 1.0, delay: 0.0) {
                peepButton.transform = CGAffineTransform.identity }
            threePeeps -= 1
        case Person.Current.PeepThree:
            choosenPeeps[3] = 0
            UIView.animate(withDuration: 1.0, delay: 0.0) {
                peepButton.transform = CGAffineTransform.identity }
            threePeeps -= 1
        default:
            if threePeeps < 3 {
                UIView.animate(withDuration: 1.0, delay: 0.0) {
                    peepButton.transform = CGAffineTransform(scaleX: 1.2, y: 1.2) }
                for i in 1...3 {
                    if choosenPeeps[i] == 0 {
                        choosenPeeps[i] = peepButton.tag
                        threePeeps += 1
                        switch i {
                        case 1:
                            if let peepTag = choosenPeeps[1] {
                                Person.Current.PeepOne = peepTag }
                        case 2:
                            if let peepTag = choosenPeeps[2] {
                                Person.Current.PeepTwo = peepTag  }
                        case 3:
                            if let peepTag = choosenPeeps[3] {
                                Person.Current.PeepThree = peepTag  }
                        default:
                            return
                        }
                        peepButton.isEnabled = true

                        Peeple.Settings.editedPeeps = true
                        return
                    }
                }
                
                
            }
        }
        peepButton.isEnabled = true
    }
    func savePeepSelect(){
    
    
    }
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "allPeeps", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
       }
}
