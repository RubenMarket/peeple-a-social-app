//
//  Extensions.swift
//  People
//
//  Created by Ruben Mercado on 3/7/20.
//  Copyright © 2020 Sirius Awe. All rights reserved.
//

import Foundation
import UIKit
import Photos
 import Realm
import SwiftUI

extension CLPlacemark {
    
    var city: String? {
        var result = ""
        if let city = locality {
            result += "\(city)"
            if let country = country {
                if country == "United States" {
                    result += ",US"
                    return result
                } else {
                    result += ",\(country)"
                    return result
                }
                
            }
            return result
        }
        return nil
    }
    
}
class ARView: UIView {
    override class var layerClass: AnyClass {
        return AVCaptureVideoPreviewLayer.self
    }
    
    /// Convenience wrapper to get layer as its statically known type.
    var videoPreviewLayer: AVCaptureVideoPreviewLayer {
        return layer as! AVCaptureVideoPreviewLayer
    }
}
extension UIView {
    func borderColor(color:UIColor){
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = 1.0
    }
    func backColor(color:UIColor){
        self.backgroundColor = color
    }
    
    func circle() {
        self.layer.cornerRadius = self.frame.height / 4
        self.layer.masksToBounds = true  }
    func lightgreyborder() {
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 0.5  }
    // OUTPUT 1
    func dropShadow(scale: Bool = true) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.systemGray.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowOffset = CGSize(width: 1, height: -1)
        layer.shadowRadius = 2
        
        
        layer.shadowPath = UIBezierPath(rect: bounds).cgPath
        layer.shouldRasterize = true
        layer.rasterizationScale = scale ? UIScreen.main.scale : 1
}
    func buttonbordercolor(color:UIColor) {
        
        
        self.layer.borderColor = color.cgColor
        
        
        
    }
    func addShadow() {
        layer.shadowOffset = CGSize(width: 0.3, height: 0.3)
        layer.shadowRadius = 0.3
        layer.shadowOpacity = 1
        layer.shadowColor = UIColor.black.cgColor
        layer.rasterizationScale = UIScreen.main.scale
        layer.shouldRasterize = true
    }
    func addBorderr(side: UIButtonBorderSide, color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        
        switch side {
        case .Top:
            border.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: width)
        case .Bottom:
            border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: width)
        case .Left:
            border.frame = CGRect(x: 0, y: 0, width: width, height: self.frame.size.height)
        case .Right:
            border.frame = CGRect(x: self.frame.size.width - width, y: 0, width: width, height: self.frame.size.height)
        }
        self.layer.masksToBounds = true
        self.layer.addSublayer(border)
        
    }
    func removeBorderr() {
       
        
    }
}
//extension RealmSwift {
//    func deleteObject(object: Object, completionClosure: () -> ()) {
//        if let realm = object.realm {
//            do {
//                try realm.write({
//                    realm.delete(object)
//                    completionClosure()
//                })
//            } catch {
//                print(error)
//            }
//        }
//    }
//    func writeObject(object: Object, completionClosure: () -> ()) {
//        if let realm = object.realm {
//            do {
//                try realm.write({
//                    realm.delete(object)
//                    completionClosure()
//                })
//            } catch {
//                print(error)
//            }
//        }
//    }
//}
public enum UIButtonBorderSide {
    case Top, Bottom, Left, Right
}

extension UIButton {
    
    public func addBorder(side: UIButtonBorderSide, color: UIColor, width: CGFloat) {
        let border = CALayer()
        border.backgroundColor = color.cgColor
        
        switch side {
        case .Top:
            border.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: width)
        case .Bottom:
            border.frame = CGRect(x: 0, y: self.frame.size.height - width, width: self.frame.size.width, height: width)
        case .Left:
            border.frame = CGRect(x: 0, y: 0, width: width, height: self.frame.size.height)
        case .Right:
            border.frame = CGRect(x: self.frame.size.width - width, y: 0, width: width, height: self.frame.size.height)
        }
        self.layer.masksToBounds = true
        self.layer.addSublayer(border)
    }
}
extension UIViewController {
    func count(count:Int)-> Int{
        if count > 15 {
            return 15
        } else {
            return count
        }
    }
    func emptyPerson(){
        Person.ID = ""
        Person.peepOne = 0
        Person.peepTwo = 0
        Person.peepThree = 0
        Person.name = ""
        Person.color = 0
        Person.pic = ""
    }
    func animateViews(labelImage:UIImageView,collection:UICollectionView,topRightBut:UIImageView,middleLabel:UILabel,peepView:UIView?,completionHandler:(Bool) -> Void) {
        labelImage.alpha = 0
        middleLabel.alpha = 0
        collection.alpha = 0
        topRightBut.alpha = 0
        peepView?.alpha = 0
        UIView.animate(withDuration: 0.7, delay: 0, options: .curveEaseIn) {
            labelImage.alpha = 0.9
            collection.alpha = 0.9
            topRightBut.alpha = 0.9
            middleLabel.alpha = 0.5
            peepView?.alpha = 0.9
        } 
        completionHandler(true)

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
    func checkPermission() {
              let photoAuthorizationStatus = PHPhotoLibrary.authorizationStatus()
              switch photoAuthorizationStatus {
              case .authorized:
                  print("Access is granted by user")
              case .notDetermined:
                  PHPhotoLibrary.requestAuthorization({
                      (newStatus) in
                      print("status is \(newStatus)")
                      if newStatus ==  PHAuthorizationStatus.authorized {
                          /* do stuff here */
                          print("success")
                      }
                  })
                  print("It is not determined until now")
              case .restricted:
                  // same same
                  print("Restricted access to photo album.")
              case .limited:
                  // same same
                  print("Limited access to photo album.")
              case .denied:
                  // same same
                  print("User has denied the permission.")
              @unknown default:
                  print("unknown pic")
                  }
          }
    
    
//    func notifications() {
//    let content = UNMutableNotificationContent()
//    let userNotificationCenter = UNUserNotificationCenter.current()
//                    content.title = "Peeple - A Social App "
//
//                    content.subtitle = "11:11"
//                   content.sound = UNNotificationSound.default
//                   content.badge = 1
//
//                    // 2
//                    let imageName = "peeple1"
//
//                    guard let imageURL = Bundle.main.url(forResource: imageName, withExtension: "png") else { return }
//
//                    let attachment = try! UNNotificationAttachment(identifier: imageName, url: imageURL, options: .none)
//
//                    content.attachments = [attachment]
//
//                    // 3
//                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
//                    let request = UNNotificationRequest(identifier: "notification.id.01", content: content, trigger: trigger)
//
//                    // 4
//                    userNotificationCenter.add(request) { (error) in
//                               if let error = error {
//                                   print("Notification Error: ", error)
//                               }
//                           }
//    }
    func removeChild() {
        self.children.forEach {
            $0.didMove(toParent: nil)
            $0.view.removeFromSuperview()
            $0.removeFromParent()
        }
    }
}



extension UIImage {
    
    
    func rotate(_ radians: CGFloat) -> UIImage {
        let cgImage = self.cgImage!
        let LARGEST_SIZE = CGFloat(max(self.size.width, self.size.height))
        let context = CGContext.init(data: nil, width:Int(LARGEST_SIZE), height:Int(LARGEST_SIZE), bitsPerComponent: cgImage.bitsPerComponent, bytesPerRow: 0, space: cgImage.colorSpace!, bitmapInfo: cgImage.bitmapInfo.rawValue)!
        
        var drawRect = CGRect.zero
        drawRect.size = self.size
        let drawOrigin = CGPoint(x: (LARGEST_SIZE - self.size.width) * 0.5,y: (LARGEST_SIZE - self.size.height) * 0.5)
        drawRect.origin = drawOrigin
        var tf = CGAffineTransform.identity
        tf = tf.translatedBy(x: LARGEST_SIZE * 0.5, y: LARGEST_SIZE * 0.5)
        tf = tf.rotated(by: CGFloat(radians))
        tf = tf.translatedBy(x: LARGEST_SIZE * -0.5, y: LARGEST_SIZE * -0.5)
        context.concatenate(tf)
        context.draw(cgImage, in: drawRect)
        var rotatedImage = context.makeImage()!
        
        drawRect = drawRect.applying(tf)
        
        rotatedImage = rotatedImage.cropping(to: drawRect)!
        let resultImage = UIImage(cgImage: rotatedImage)
        return resultImage
    }
}
extension UIView {
    func eventview(){
        layer.cornerRadius = frame.height / 5
        layer.masksToBounds = true
    }
    
    func rotatean(){
          let rotation: CABasicAnimation = CABasicAnimation(keyPath: "transform.rotation.z")
         
        rotation.duration = 1 // or however long you want ...
          rotation.autoreverses = true
       
          rotation.repeatCount = 2
         rotation.toValue = Double.pi * 4
          layer.add(rotation, forKey: "rotationAnimation")
    }
    func shake(){
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.07
        animation.repeatCount = 3
        animation.autoreverses = true
        animation.fromValue = NSValue(cgPoint: CGPoint(x: self.center.x - 10, y: self.center.y + 10))
        animation.toValue = NSValue(cgPoint: CGPoint(x: self.center.x + 10, y: self.center.y - 10))
      
        self.layer.add(animation, forKey: "position")
    }

    func wiggle(){
        let transformAnim  = CAKeyframeAnimation(keyPath:"transform")
        transformAnim.values  = [NSValue(caTransform3D: CATransform3DMakeRotation(0.27, 0.0, 0.0, 1.0)),NSValue(caTransform3D: CATransform3DMakeRotation(-0.27 , 0, 0, 1))]
        transformAnim.autoreverses = true
        transformAnim.duration  =  0.27
        transformAnim.repeatCount = 2.7
        self.layer.add(transformAnim, forKey: "transform")
    }
    
    func wiggle1(){
          let transformAnim  = CAKeyframeAnimation(keyPath:"transform")
          transformAnim.values  = [NSValue(caTransform3D: CATransform3DMakeRotation(0.09, 0.0, 0.0, 1.0)),NSValue(caTransform3D: CATransform3DMakeRotation(-0.09 , 0, 0, 1))]
          transformAnim.autoreverses = true
        transformAnim.duration  =  0.18
        transformAnim.repeatCount = 0.09
          self.layer.add(transformAnim, forKey: "transform")
      }
}


extension String
{
    func replace(target: String, withString: String) -> String
    {
        return self.replacingOccurrences(of: target, with: withString, options: NSString.CompareOptions.literal, range: nil)
    }
}

extension UIImage {
    func inverseImage(cgResult: Bool) -> UIImage? {
        let coreImage = UIKit.CIImage(image: self)
        guard let filter = CIFilter(name: "CIColorInvert") else { return nil }
        filter.setValue(coreImage, forKey: kCIInputImageKey)
        guard let result = filter.value(forKey: kCIOutputImageKey) as? UIKit.CIImage else { return nil }
        if cgResult { // I've found that UIImage's that are based on CIImages don't work with a lot of calls properly
            return UIImage(cgImage: CIContext(options: nil).createCGImage(result, from: result.extent)!)
        }
        return UIImage(ciImage: result)
    }
}


extension UIView{
    func animShow(){
        UIView.animate(withDuration: 1.0,
                       animations: {
                        self.center.y -= ((self.bounds.height + 100) * 2)
                        self.layoutIfNeeded()
        }, completion: nil)
        self.isHidden = false
    }
    func animHide(){
        UIView.animate(withDuration: 2, delay: 0, options: [.curveLinear],
                       animations: {
                        self.center.y += self.bounds.height
                        self.layoutIfNeeded()
                        
        },  completion: {(_ completed: Bool) -> Void in
            self.isHidden = true
        })
    }
 func animShowy(){
    UIView.animate(withDuration: 0.7, delay: 0, options: [.curveEaseIn],
                       animations: {
                        self.center.x -= self.bounds.width
                        self.layoutIfNeeded()
        }, completion: nil)
        self.isHidden = false
    }
    func animHidey(){
        UIView.animate(withDuration: 0.7, delay: 0, options: [.curveLinear],
                       animations: {
                        self.center.x += self.bounds.width
                        self.layoutIfNeeded()

        },  completion: {(_ completed: Bool) -> Void in
        self.isHidden = true
            })
    }
    
    
    func setGradientBackground(colorTop: UIColor, colorBottom: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorBottom.cgColor, colorTop.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.locations = [0, 1]
        gradientLayer.frame = bounds
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    
    
    func setGradient(colorTop: UIColor, colorBottom: UIColor) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorBottom.cgColor, colorTop.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        gradientLayer.locations = [0, 0]
        gradientLayer.frame = bounds
        
        layer.insertSublayer(gradientLayer, at: 0)
    }
    
    


    func shake(duration: CFTimeInterval) {
        let translation = CAKeyframeAnimation(keyPath: "transform.translation.x");
        translation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        translation.values = [-3, 3, -3, 3, -2, 2, -1, 1, 0]
        
        let rotation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        rotation.values = [-3, 3, -3, 3, -2, 2, -1, 1, 0].map {
            ( degrees: Double) -> Double in
            let radians: Double = (.pi * degrees) / 180.0
            return radians
        }
        
        let shakeGroup: CAAnimationGroup = CAAnimationGroup()
        shakeGroup.animations = [translation, rotation]
        shakeGroup.duration = duration
        self.layer.add(shakeGroup, forKey: "shakeIt")
    }
    func rshake(duration: CFTimeInterval) {
        let translation = CAKeyframeAnimation(keyPath: "transform.translation.x");
        translation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        translation.values = [3, -3, 3, -3, 2, -2, 1, -1, 0]
        
        let rotation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        rotation.values = [3, -3, 3, -3, 2, -2, 1, -1, 0].map {
            ( degrees: Double) -> Double in
            let radians: Double = (.pi * degrees) / 180.0
            return radians
        }
        
        let shakeGroup: CAAnimationGroup = CAAnimationGroup()
        shakeGroup.animations = [translation, rotation]
        shakeGroup.duration = duration
        self.layer.add(shakeGroup, forKey: "shakeIt")
    }
    func shake1(duration: CFTimeInterval) {
        let translation = CAKeyframeAnimation(keyPath: "transform.translation.x");
        translation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        translation.values = [2, -2, 1, -1, 1, -1, 0, 0, 0]
        
        let rotation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        rotation.values = [2, -2, 1, -1, 1, -1, 0, 0, 0].map {
            ( degrees: Double) -> Double in
            let radians: Double = (.pi * degrees) / 180.0
            return radians
        }
        
        let shakeGroup: CAAnimationGroup = CAAnimationGroup()
        shakeGroup.animations = [translation, rotation]
        shakeGroup.duration = duration
        self.layer.add(shakeGroup, forKey: "shakeIt")
    }
    func circlein() {
       let x = layer.cornerRadius
        UIView.animate(withDuration: 1.0) { [self] in
            layer.cornerRadius = frame.height / 2.0
        } completion: { (true) in
            UIView.animate(withDuration: 0.5) { [self] in
                layer.cornerRadius = x
            }
        }

        
        
    }
}


extension UIViewController {
    
    func createDate(day: Int, month : Int, hour: Int, minute: Int, year: Int)->Date{

    var components = DateComponents()
    components.hour = hour
    components.minute = minute
    components.year = year
    components.day = day
    components.month = month

    components.timeZone = .current

    let calendar = Calendar(identifier: .gregorian)
    return calendar.date(from: components)!
    }

    
//    func scheduleNotification(at date: Date, identifierUnic : String, body: String, titles:String) {
//
//    let triggerWeekly = Calendar.current.dateComponents([.day, .month, .hour,.minute, .year], from: date)
//
//    let trigger = UNCalendarNotificationTrigger(dateMatching: triggerWeekly, repeats: true)
//
//    let content = UNMutableNotificationContent()
//    content.title = titles
//    content.body = body
//    content.sound = UNNotificationSound.default
//    content.categoryIdentifier = "todoList2"
//
//    let request = UNNotificationRequest(identifier: identifierUnic, content: content, trigger: trigger)
//
//    UNUserNotificationCenter.current().delegate = self as? UNUserNotificationCenterDelegate
//
//    /// UNUserNotificationCenter.current().removeDeliveredNotifications(withIdentifiers: ["textNotification2"])
//    /// UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
//    UNUserNotificationCenter.current().add(request) {(error) in
//    if let error = error {
//    print(" We had an error: \(error)")
//    }}
//    }

   
//    scheduleNotification(at: createDate(day : 11, month : 2, hour: 15, minute: 5, year: 2018), identifierUnic: "unic1", body: "Notification day", titles: "Notification titles1")
    
    
    
    
}
extension UIView {
    func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
        layer.masksToBounds = true
    }
}
extension UILabel {
    func underlineMyText() {
        if let textString = self.text {
            let attributedString = NSMutableAttributedString(string: textString)
            attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: NSRange(location: 0, length: attributedString.length - 1))
            attributedText = attributedString
        }
    }
}
var aView: UIView?
extension UIView {
    
    func showthaspinner() {
         aView = UIView(frame: self.bounds)
        
        let ai = UIActivityIndicatorView()
        ai.center = aView!.center
        ai.style = .large
        ai.color = .systemGray
        ai.startAnimating()
        aView?.addSubview(ai)
        self.addSubview(aView!)
        
    }
    func startLoading() {
        aView = UIView(frame: self.bounds)
        
        let ai = UIImageView()
        ai.image = UIImage(named: "peepleLoad")
        ai.center = aView!.center
        aView?.addSubview(ai)
        self.addSubview(aView!)
        
    }
    func removethaspinner() {
        
        aView?.removeFromSuperview()
        aView = nil
        
        
        
        
    }
    
    
}

extension UIScrollView {

    var scrolledToTop: Bool {
        let topEdge = 0 - contentInset.top
        return contentOffset.y <= topEdge
    }

    var scrolledToBottom: Bool {
        let bottomEdge = contentSize.height + contentInset.bottom - bounds.height
        return contentOffset.y >= bottomEdge
    }

}

extension UIImageView {
    public func maskCircle(anyImage: UIImage) {
        self.contentMode = UIView.ContentMode.scaleAspectFill
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.masksToBounds = false
        self.clipsToBounds = true
        
        // make square(* must to make circle),
        // resize(reduce the kilobyte) and
        // fix rotation.
        self.image = anyImage
    }
}

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
        
        
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    



}


extension UIImageView {
    
    func circleimage() {
        
        self.layer.cornerRadius = self.frame.height / 2
        self.layer.masksToBounds = true
        
    }
    
}
extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat) {
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}
extension UIViewController {
    func showAlert(withTitle title: String?, message: String?) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}



extension Date {
    func dayNumberOfWeek() -> Int? {
        return Calendar.current.dateComponents([.weekday], from: self).weekday
    }
}



extension UIView {
    func shakecell(duration: CFTimeInterval){
        let translation = CAKeyframeAnimation(keyPath: "transform.translation.x");
        translation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        translation.values = [-3, 3, -3, 3, -2, 2, -1, 1, 0]
        
        let rotation = CAKeyframeAnimation(keyPath: "transform.rotation.z")
        rotation.values = [-3, 3, -3, 3, -2, 2, -1, 1, 0].map {
            ( degrees: Double) -> Double in
            let radians: Double = (.pi * degrees) / 180.0
            return radians
        }
        
        let shakeGroup: CAAnimationGroup = CAAnimationGroup()
        shakeGroup.animations = [translation, rotation]
        shakeGroup.duration = duration
        self.layer.add(shakeGroup, forKey: "shakeIt")
    }
    
    func homecell(){
        
        layer.borderColor = UIColor.white.cgColor
        layer.borderWidth = 0.37
        layer.masksToBounds = true
        
        
        
    }
    func buttonify(color:UIColor){
        layer.borderWidth = Peeple.Thickness
        layer.borderColor = color.cgColor
        layer.cornerRadius = Peeple.cornerRadius
        layer.masksToBounds = true
    }
    func takeScreenshot() -> UIImage {

        // Begin context
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)

        // Draw view in that context
        drawHierarchy(in: self.bounds, afterScreenUpdates: true)

        // And finally, get image
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        if (image != nil)
        {
            return image!
        }
        return UIImage()
    }
    
    func standardStuff() {
        
        
        layer.cornerRadius = 9
        layer.borderColor = UIColor.systemGray.cgColor
        layer.borderWidth = 1.5
        layer.masksToBounds = true
        
        
        
    }
    
    
    
    func iscircle (){
        
        layer.cornerRadius = frame.height / 2
        layer.masksToBounds = true
    }
    func setPeepleCorners(){
        layer.cornerRadius = Peeple.cornerRadius
        layer.masksToBounds = true
    }
    func iscube (){
        
        layer.cornerRadius = frame.height / 3
        layer.masksToBounds = true
    }
    func ispeep() {
        
        layer.cornerRadius = frame.height / 2
        layer.masksToBounds = true
    }
    
    func allgru() {
          
          
         
          layer.borderColor = UIColor.systemGray.cgColor
          layer.borderWidth = 1.5
          
          
          
          
      }
    
    
    func standardStuff1() {
        
        
        layer.cornerRadius = 3
        layer.borderColor = UIColor.systemGray.cgColor
        layer.borderWidth = 0.7
        layer.masksToBounds = true
        
        
        
    }
    
    func standardStuff11() {
           
           
           layer.cornerRadius = 3
           layer.borderColor = UIColor.lightGray.cgColor
           layer.borderWidth = 0.4
           layer.masksToBounds = true
           
           
           
       }
    func standardStuff111() {
             
             
             layer.cornerRadius = 15
             layer.borderColor = UIColor.lightGray.cgColor
             layer.borderWidth = 0.4
             layer.masksToBounds = true
             
             
             
         }
    func newsbc(bc: CGColor) {
                
                layer.borderColor = bc
                
                
                
                
            }
    func bg(color: CGColor) {
                layer.backgroundColor = color
            }
    func newsbutlay11() {
            
    backgroundColor = .white
            layer.cornerRadius = 7
            layer.borderWidth = 0.7
            layer.masksToBounds = true
            
            
            
        }
    
    func open() {
                
                
        layer.cornerRadius = frame.height / 3
                layer.borderColor = UIColor.darkGray.cgColor
                layer.borderWidth = 0.1
                layer.masksToBounds = true
                
                
                
            }
    func standardStuff1111() {
        
        
        layer.cornerRadius = frame.height / 7
        layer.masksToBounds = true
        
        
        
    }
    func standardStuff2() {
        
        
        layer.cornerRadius = frame.height / 3.5
        layer.borderWidth = 0.7
        layer.masksToBounds = true
        
        
        
    }
    func createPage() {
           
         layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 0.2
           layer.masksToBounds = true
           
           
           
       }
    func photoview() {
        layer.cornerRadius = frame.width / 11
         layer.borderColor = UIColor.white.cgColor
           layer.borderWidth = 1
           layer.masksToBounds = true
           
           
           
       }
    func peepviewstuff() {
        
        
     layer.cornerRadius = frame.height / 9
      layer.borderColor = UIColor.darkGray.cgColor
        layer.borderWidth = 0.0
        layer.masksToBounds = true
        
        
        
    }
    func circlecorners() {
              
              
           layer.cornerRadius = frame.height / 2
            layer.borderColor = UIColor.lightGray.cgColor
              layer.borderWidth = 1
              layer.masksToBounds = true
              
              
              
          }
    func logfields() {
             
             
             layer.borderColor = UIColor.systemGray3.cgColor
        layer.borderWidth = 0.2
             
             
             
         }
    func loginbut() {
               
               layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 0.2
               
               
               
           }
    
    func emaiview() {
               
               
               layer.cornerRadius = 9
               layer.borderColor = UIColor.clear.cgColor
               layer.borderWidth = 0.5
               layer.masksToBounds = true
               
               
               
           }
    
    func standardStuff3() {
          
          
          layer.cornerRadius = 2
          layer.borderColor = UIColor.systemGray.cgColor
          layer.borderWidth = 0.3
          layer.masksToBounds = true
          
        layer.backgroundColor = UIColor.white.cgColor
          
      }
    
    
    
}

class SegueFromRight: UIStoryboardSegue {
    override func perform() {
        let src = self.source
        let dst = self.destination

        src.view.superview?.insertSubview(dst.view, aboveSubview: src.view)
        dst.view.transform = CGAffineTransform(translationX: src.view.frame.size.width, y: 0) //Double the X-Axis
        UIView.animate(withDuration: 0.27, delay: 0.0, options: UIView.AnimationOptions.curveEaseInOut, animations: {
            dst.view.transform = CGAffineTransform(translationX: 0, y: 0)
            src.view.transform = CGAffineTransform(translationX: -(src.view.frame.size.width), y: 0)
        }) { (finished) in
            src.present(dst, animated: false, completion: nil)
        }
    }
}
    
class SegueFromLeft: UIStoryboardSegue {
    override func perform() {
        let src = self.source       //new enum
        let dst = self.destination  //new enum

        src.view.superview?.insertSubview(dst.view, aboveSubview: src.view)
        dst.view.transform = CGAffineTransform(translationX: -src.view.frame.size.width, y: 0) //Method call changed
        
        UIView.animate(withDuration: 0.27, delay: 0.0, options: UIView.AnimationOptions.curveEaseInOut, animations: {
            dst.view.transform = CGAffineTransform(translationX: 0, y: 0)
            src.view.transform = CGAffineTransform(translationX: src.view.frame.size.width, y: 0)
        }) { (finished) in
            src.present(dst, animated: false, completion: nil) //Method call changed
        }
    }
}
    
extension UIImage {

    public func rounded(radius: CGFloat) -> UIImage {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        UIBezierPath(roundedRect: rect, cornerRadius: radius).addClip()
        draw(in: rect)
        return UIGraphicsGetImageFromCurrentImageContext()!
    }

}
extension Date {
    func toMillis() -> Int64! {
        return Int64(self.timeIntervalSince1970 * 1000)
    }
}
//final class AnimatableCircleView: UIButton {
//
//  // MARK: - UI objects
//
//  private lazy var circleView: UIView = {
//    let view = UIView()
//    view.translatesAutoresizingMaskIntoConstraints = false
//    view.backgroundColor = .red
//    view.clipsToBounds = true
//    return view
//  }()
//
//  private lazy var miniCircleView: UIView = {
//    let view = UIView()
//    view.translatesAutoresizingMaskIntoConstraints = false
//    view.backgroundColor = .orange
//    return view
//  }()
//
//  // MARK: - Initializers and Life cycle
//
//  required init?(coder: NSCoder) {
//    super.init(coder: coder)
//    self.setup()
//  }
//
//  private func setup() {
//    self.clipsToBounds = false
//
//    self.addSubview(self.circleView)
//    NSLayoutConstraint.activate([
//      self.circleView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
//      self.circleView.topAnchor.constraint(equalTo: self.topAnchor),
//      self.circleView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
//      self.circleView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
//    ])
//
//    self.addSubview(self.miniCircleView)
//    NSLayoutConstraint.activate([
//      self.miniCircleView.widthAnchor.constraint(equalToConstant: 24),
//      self.miniCircleView.heightAnchor.constraint(equalToConstant: 24)
//    ])
//  }
//
//  override func layoutSubviews() {
//    super.layoutSubviews()
//    self.circleView.layer.cornerRadius = self.circleView.frame.width / 2.0
//    self.miniCircleView.layer.cornerRadius = self.miniCircleView.frame.width / 2.0
//
//    self.miniCircleView.center = self.getPoint(for: -90)
//  }
//
//  // MARK: - Animation
//
//  func startAnimating() {
//    // 1
//    let path = UIBezierPath()
//
//    // 2
//    let initialPoint = self.getPoint(for: -90)
//    path.move(to: initialPoint)
//
//    // 3
//    for angle in -89...0 { path.addLine(to: self.getPoint(for: angle)) }
//    for angle in 1...270 { path.addLine(to: self.getPoint(for: angle)) }
//
//    // 4
//    path.close()
//
//    // 5
//    self.animate(view: self.miniCircleView, path: path)
//  }
//
//  private func animate(view: UIView, path: UIBezierPath) {
//    // 1
//    let animation = CAKeyframeAnimation(keyPath: "position")
//
//    // 2
//    animation.path = path.cgPath
//
//    // 3
//    animation.repeatCount = 1
//
//    // 4
//    animation.duration = 5
//
//    // 5
//    view.layer.add(animation, forKey: "animation")
//  }
//
//  private func getPoint(for angle: Int) -> CGPoint {
//    // 1
//    let radius = Double(self.circleView.layer.cornerRadius)
//
//    // 2
//    let radian = Double(angle) * Double.pi / Double(180)
//
//    // 3
//    let newCenterX = radius + radius * cos(radian)
//    let newCenterY = radius + radius * sin(radian)
//
//    return CGPoint(x: newCenterX, y: newCenterY)
//  }
//}
//extension UIImage {
//    class func colorForNavBar(color: UIColor) -> UIImage {
//        let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 1.0)
//        //    Or if you need a thinner border :
//        //    let rect = CGRect(x: 0.0, y: 0.0, width: 1.0, height: 0.5)
//        UIGraphicsBeginImageContext(rect.size)
//        let context = UIGraphicsGetCurrentContext()
//
//        context!.setFillColor(color.cgColor)
//        context!.fill(rect)
//
//        let image = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//
//        return image!
//    }
//}

    
//extension NSDate
//{
//    func hour() -> Int
//    {
//        //Get Hour
//        let calendar = NSCalendar.current
//        let components = calendar.components(.hour, from: self as Date)
//        let hour = components.hour
//
//        //Return Hour
//        return hour
//    }
//
//
//    func minute() -> Int
//    {
//        //Get Minute
//        let calendar = NSCalendar.current
//        let components = calendar.components(.Minute, from: self as Date)
//        let minute = components.minute
//
//        //Return Minute
//        return minute
//    }
//
//    func toShortTimeString() -> String
//    {
//        //Get Short Time String
//        let formatter = NSDateFormatter()
//        formatter.timeStyle = .ShortStyle
//        let timeString = formatter.stringFromDate(self)
//
//        //Return Short Time String
//        return timeString
//    }
//}

    
    
    
    
    
    
    
    
    
    
