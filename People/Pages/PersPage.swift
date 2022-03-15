//
//  PersPage.swift
//  People
//
//  Created by admin on 1/5/22.
//  Copyright © 2022 A Sirius Company. All rights reserved.
//

import UIKit
import AVFoundation

class PersPage: UIViewController {

    @IBOutlet weak var topLeftImageView: UIImageView!
    @IBOutlet weak var topLeftButton: UIButton!
    @IBOutlet weak var ARView: ARView!
    @IBOutlet weak var PeepView: UIView!
    
    @IBOutlet weak var personOptionView: UIView!
    
    @IBAction func PersPressed(_ sender: UIButton) {
    }
    private var peepOneView:UIView?
    private var peepTwoView:UIView?
    private var peepThreeView:UIView?
    enum peeps {  case one,two,three,options }
    private var peepIsSetoTo:peeps = .one
    func loadPersonData(){
        //loading all peeps + showing peepOne
        self.topLeftImageView.image = UIImage(named:Peeple.peepPics[Person.peepOne])
        self.peepOneView = self.loadPeep(num: Person.peepOne)
        self.peepTwoView = self.loadPeep(num: Person.peepTwo)
        self.peepThreeView = self.loadPeep(num: Person.peepThree)
        self.peepOneView?.isHidden = false
        self.peepTwoView?.isHidden = true
        self.peepThreeView?.isHidden = true
        self.PeepView.addSubview(self.peepOneView!)
        self.PeepView.sendSubviewToBack(self.peepOneView!)
        self.peepOneView!.snp.makeConstraints { (make) in
            make.edges.equalTo(self.PeepView) }
        self.PeepView.addSubview(self.peepTwoView!)
        self.PeepView.sendSubviewToBack(self.peepTwoView!)
        self.peepTwoView!.snp.makeConstraints { (make) in
            make.edges.equalTo(self.PeepView) }
        self.PeepView.addSubview(self.peepThreeView!)
        self.PeepView.sendSubviewToBack(self.peepThreeView!)
        self.peepThreeView!.snp.makeConstraints { (make) in
            make.edges.equalTo(self.PeepView) }
        PeepView.isHidden = false

    }
    func loadPeep(num:Int) -> UIView {
        switch num {
        case 1 :
            return charightview.instanceFromNib()
        case 2 :
            return cleanergy.instanceFromNib()
        case 3 :
            let porty = portoflio()
            return porty.instanceFromNib()
        case 4 :
            return spacechip.instanceFromNib()
        case 8 :
            return theorize.instanceFromNib()
        case 10 :
            return shelfiecontroller.instanceFromNib()
        case 12 :
            return mymecontroller.instanceFromNib()
        case 14 :
            return betatester.instanceFromNib()
        case 16 :
            return awemember.instanceFromNib()
        default :
            return comingsoon.instanceFromNib()
        }
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
    @objc func handleHold(_ sender:UILongPressGestureRecognizer) {
        UIPasteboard.general.string = Person.ID
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
            switch peepIsSetoTo {
            case .one:
                peepIsSetoTo = .two
            case .two:
                peepIsSetoTo = .three
            case .three:
                peepIsSetoTo = .options
            case .options:
                peepIsSetoTo = .one  }
            showPeep()
        case .down:
            //option down
            // setting next option + refresh data
            print("option DOWN")
            switch peepIsSetoTo {
            case .one:
                peepIsSetoTo = .options
            case .two:
                peepIsSetoTo = .one
            case .three:
                peepIsSetoTo = .two
            case .options:
                peepIsSetoTo = .three
            }
            showPeep()
        default:
            return
        }
       
    }
    func showPeep(){
        switch peepIsSetoTo {
        case .one:
            self.PeepView.isHidden = false
            personOptionView.isHidden = true
            peepTwoView?.isHidden = true
            peepThreeView?.isHidden = true
            peepOneView?.isHidden = false
            self.topLeftImageView.image = UIImage(named:Peeple.peepPics[Person.peepOne])
        case .two:
            peepTwoView?.isHidden = false
            peepThreeView?.isHidden = true
            peepOneView?.isHidden = true
            self.topLeftImageView.image = UIImage(named:Peeple.peepPics[Person.peepTwo])
        case .three:
            self.PeepView.isHidden = false
            personOptionView.isHidden = true
            peepTwoView?.isHidden = true
            peepThreeView?.isHidden = false
            peepOneView?.isHidden = true
            self.topLeftImageView.image = UIImage(named:Peeple.peepPics[Person.peepThree])
        case .options:
            self.PeepView.isHidden = true
            self.topLeftImageView.image = UIImage(named:"pers")
            personOptionView.isHidden = false
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPersonData()
        addGestures()
        // Do any additional setup after loading the view.
    }
    func emptyPerson(){
        Person.ID = ""
        Person.name = ""
        Person.peepOne = 0
        Person.peepTwo = 0
        Person.peepThree = 0
        Person.color = 0
        Person.pic = ""
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        emptyPerson()
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
