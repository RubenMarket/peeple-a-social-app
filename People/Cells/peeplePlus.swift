//
//  peeplePlus.swift
//  People
//
//  Created by admin on 6/26/22.
//  Copyright © 2022 A Sirius Company. All rights reserved.
//

import UIKit
import Qonversion
class peeplePlus: UIView {
    private var products: [Qonversion.Product] = []
    @IBOutlet weak var peeplePlusImage: UIImageView!
    @IBOutlet weak var peeplePlusLabel: UILabel!
    @IBOutlet weak var peeplePlusButton: UIButton!
    @IBAction func purchasePeeplePlus(_ sender: UIButton) {
        Qonversion.purchaseProduct(products[0]) { (permissions, error, isCancelled) in
          
          if let premium: Qonversion.Permission = permissions["Peeple Plus"], premium.isActive {
            // Flow for success state
              Peeple.Settings.plus = true
              self.peeplePlusLabel.text = """
                                     Peeple Plus Active
                                     
                                     - All of the Peeple
                                                                    
                                     - App color customization
                                     """
              self.peeplePlusButton.isEnabled = false
              self.peeplePlusButton.setTitle("Peeple Plus Member", for: .normal)
          }
        }
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    override func layoutSubviews() {
        Qonversion.offerings { (offerings, error) in
            // Display products for sale
            if let productss = offerings?.main?.products {
              // Display products for sale
                self.products = productss
            }
            if let error = error {
              // Handle error
                print(error)
            }
          
        }
        peeplePlusLabel.text = """
                               - Access all of the Peeple
                               
                               - App color customization
                               """
        peeplePlusLabel.addTextShadow()
        peeplePlusButton.addTextShadow()
        peeplePlusLabel.textColor = Peeple.Settings.Colors[Person.Current.Color]
        peeplePlusButton.setTitleColor(Peeple.Settings.Colors[Person.Current.Color], for: .normal)
    }
    class func instanceFromNib() -> UIView {
        return UINib(nibName: "PeeplePlus", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
       }
}
