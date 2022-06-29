//
//  PurchasePeeplePro.swift
//  People
//
//  Created by admin on 1/5/22.
//  Copyright © 2022 A Sirius Company. All rights reserved.
//

import UIKit
import Qonversion
class PurchasePeeplePro: UIViewController {
    @IBOutlet weak var peeplePlusLabel: UILabel!
    @IBOutlet weak var peeplePlusButton: UIButton!
//    var permissions: [String: Qonversion.Permission] = [:]
      
    
    @IBAction func purchasePlus(_ sender: Any) {
        
    }
    func restore(){
        Qonversion.restore { [weak self] (permissions, error) in
          if let error = error {
            // Handle error
              print(error)
          }
          
          if let permission: Qonversion.Permission = permissions["Peeple Plus"], permission.isActive {
            // Restored and permission is active
          }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        peeplePlusLabel.text = """
                               """
        
        // Do any additional setup after loading the view.
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
