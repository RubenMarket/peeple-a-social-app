//
//  MainController.swift
//  People
//
//  Created by admin on 11/24/21.
//  Copyright © 2021 A Sirius Company. All rights reserved.
//

import UIKit
import AVFoundation
import RealmSwift
class MainController:UIViewController{
    
   
    
   
    // MARK: loading Indicaator
    
    
    
    
    
}
//extension MainController {
//    
//    func loadPeepOne(one:Int){
//        switch one {
//        case 1 :
//            let view = charightview.instanceFromNib()
//            self.view.addSubview(view)
//            view.snp.makeConstraints { (make) in
//                make.edges.equalTo(view) }
//        case 2 :
//            let view = cleanergy.instanceFromNib()
//            self.view.addSubview(view)
//            view.snp.makeConstraints { (make) in
//                make.edges.equalTo(view) }
//        case 3 :
//            let porty = portoflio()
//            oneView = porty.instanceFromNib()
//            guard let view = oneView else { return }
//            self.placeholderview.addSubview(view)
//            view.snp.makeConstraints { (make) in
//                make.edges.equalTo(placeholderview) }
//        case 4 :
//            oneView = spacechip.instanceFromNib()
//            guard let view = oneView else { return }
//            self.placeholderview.addSubview(view)
//            view.snp.makeConstraints { (make) in
//                make.edges.equalTo(placeholderview) }
//        case 8 :
//            oneView = theorize.instanceFromNib()
//            guard let view = oneView else { return }
//            self.placeholderview.addSubview(view)
//            view.snp.makeConstraints { (make) in
//                make.edges.equalTo(placeholderview) }
//        case 10 :
//            oneView = shelfiecontroller.instanceFromNib()
//            guard let view = oneView else { return }
//            self.placeholderview.addSubview(view)
//            view.snp.makeConstraints { (make) in
//                make.edges.equalTo(placeholderview)  }
//        case 12 :
//            oneView = mymecontroller.instanceFromNib()
//            guard let view = oneView else { return }
//            self.placeholderview.addSubview(view)
//            view.snp.makeConstraints { (make) in
//                make.edges.equalTo(placeholderview) }
//        case 14 :
//            oneView = betatester.instanceFromNib()
//            guard let view = oneView else { return }
//            self.placeholderview.addSubview(view)
//            view.snp.makeConstraints { (make) in
//                make.edges.equalTo(placeholderview) }
//        case 16 :
//            oneView = awemember.instanceFromNib()
//            guard let view = oneView else { return }
//            self.placeholderview.addSubview(view)
//            view.snp.makeConstraints { (make) in
//                make.edges.equalTo(placeholderview) }
//        default :
//            oneView = comingsoon.instanceFromNib()
//            guard let view = oneView else { return }
//            self.placeholderview.addSubview(view)
//            view.snp.makeConstraints { (make) in
//                make.edges.equalTo(placeholderview) }
//        }
//    }
//    func loadPeepThree(three:Int){
//        switch three {
//        case 1 :
//            threeView = charightview.instanceFromNib()
//            guard let view = threeView else { return }
//            self.placeholderview.addSubview(view)
//            view.snp.makeConstraints { (make) in
//                make.edges.equalTo(placeholderview) }
//        case 2 :
//            threeView = cleanergy.instanceFromNib()
//            guard let view = threeView else { return }
//            self.placeholderview.addSubview(view)
//            view.snp.makeConstraints { (make) in
//                make.edges.equalTo(placeholderview) }
//        case 3 :
//            let porty = portoflio()
//            threeView = porty.instanceFromNib()
//            guard let view = threeView else { return }
//            self.placeholderview.addSubview(view)
//            view.snp.makeConstraints { (make) in
//                make.edges.equalTo(placeholderview) }
//        case 4 :
//            threeView = spacechip.instanceFromNib()
//            guard let view = threeView else { return }
//            self.placeholderview.addSubview(view)
//            view.snp.makeConstraints { (make) in
//                make.edges.equalTo(placeholderview) }
//        case 8 :
//            threeView = theorize.instanceFromNib()
//            guard let view = threeView else { return }
//            self.placeholderview.addSubview(view)
//            view.snp.makeConstraints { (make) in
//                make.edges.equalTo(placeholderview)
//            }
//        case 10 :
//            threeView = shelfiecontroller.instanceFromNib()
//            guard let view = threeView else { return }
//            self.placeholderview.addSubview(view)
//            view.snp.makeConstraints { (make) in
//                make.edges.equalTo(placeholderview)  }
//        case 12 :
//            threeView = mymecontroller.instanceFromNib()
//            guard let view = threeView else { return }
//            self.placeholderview.addSubview(view)
//            view.snp.makeConstraints { (make) in
//                make.edges.equalTo(placeholderview) }
//        case 14 :
//            threeView = betatester.instanceFromNib()
//            guard let view = threeView else { return }
//            self.placeholderview.addSubview(view)
//            view.snp.makeConstraints { (make) in
//                make.edges.equalTo(placeholderview) }
//        case 16 :
//            threeView = awemember.instanceFromNib()
//            guard let view = threeView else { return }
//            self.placeholderview.addSubview(view)
//            view.snp.makeConstraints { (make) in
//                make.edges.equalTo(placeholderview) }
//        default :
//            threeView = comingsoon.instanceFromNib()
//            guard let view = threeView else { return }
//            self.placeholderview.addSubview(view)
//            view.snp.makeConstraints { (make) in
//                make.edges.equalTo(placeholderview) }
//        }
//        oneView?.isHidden = true
//        threeView?.isHidden = true
//    }
//    func loadPeepTwo(two:Int) {
//        switch two {
//        case 1 :
//            twoView = charightview.instanceFromNib()
//            guard let view = twoView else { return }
//            self.placeholderview.addSubview(view)
//            view.snp.makeConstraints { (make) in
//                make.edges.equalTo(placeholderview) }
//        case 2 :
//            twoView = cleanergy.instanceFromNib()
//            guard let view = twoView else { return }
//            self.placeholderview.addSubview(view)
//            view.snp.makeConstraints { (make) in
//                make.edges.equalTo(placeholderview) }
//        case 3 :
//            let porty = portoflio()
//            twoView = porty.instanceFromNib()
//            guard let view = twoView else { return }
//            self.placeholderview.addSubview(view)
//            view.snp.makeConstraints { (make) in
//                make.edges.equalTo(placeholderview) }
//        case 4 :
//            twoView = spacechip.instanceFromNib()
//            guard let view = twoView else { return }
//            self.placeholderview.addSubview(view)
//            view.snp.makeConstraints { (make) in
//                make.edges.equalTo(placeholderview) }
//        case 8 :
//            twoView = theorize.instanceFromNib()
//            guard let view = twoView else { return }
//            self.placeholderview.addSubview(view)
//            view.snp.makeConstraints { (make) in
//                make.edges.equalTo(placeholderview)
//            }
//        case 10 :
//            twoView = shelfiecontroller.instanceFromNib()
//            guard let view = twoView else { return }
//            self.placeholderview.addSubview(view)
//            view.snp.makeConstraints { (make) in
//                make.edges.equalTo(placeholderview)  }
//        case 12 :
//            twoView = mymecontroller.instanceFromNib()
//            guard let view = twoView else { return }
//            self.placeholderview.addSubview(view)
//            view.snp.makeConstraints { (make) in
//                make.edges.equalTo(placeholderview) }
//        case 14 :
//            twoView = betatester.instanceFromNib()
//            guard let view = twoView else { return }
//            self.placeholderview.addSubview(view)
//            view.snp.makeConstraints { (make) in
//                make.edges.equalTo(placeholderview)  }
//        case 16 :
//            twoView = awemember.instanceFromNib()
//            guard let view = twoView else { return }
//            self.placeholderview.addSubview(view)
//            view.snp.makeConstraints { (make) in
//                make.edges.equalTo(placeholderview)  }
//        default :
//            twoView = comingsoon.instanceFromNib()
//            guard let view = twoView else { return }
//            self.placeholderview.addSubview(view)
//            view.snp.makeConstraints { (make) in
//                make.edges.equalTo(placeholderview) }
//        }
//        
//    }
//    
//    
//}
