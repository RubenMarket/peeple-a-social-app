//
//  loginSignup.swift
//  peeple - a social app
//
//  Created by Ruben Mercado on 5/24/18.
//  Copyright © 2018 Sirius Awe. All rights reserved.
//

import UIKit
import Foundation
import NotificationCenter
import RealmSwift
import AVFoundation
import AuthenticationServices
import SafariServices
import QuartzCore
import SnapKit

class LoginPage: UIViewController,ASAuthorizationControllerDelegate,ASAuthorizationControllerPresentationContextProviding,SFSafariViewControllerDelegate{
    // MARK: IBOutlets
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var peepleLogo: UIImageView!
    @IBOutlet weak var pwdField: UITextField!
    @IBOutlet weak var emailview: UIView!
    @IBOutlet weak var forgottext: UIButton!
    @IBOutlet weak var loadingIndicator: UIImageView!
    // MARK: variables and constants
    private var startx: CGFloat = 0.0
    private var startxx: CGFloat = 0.0
    private var name:String? = ""
    
    @IBAction func forgotpass(_ sender: UIButton) {
    }
    
    
    func textFieldShouldReturn(_ scoreText: UITextField) -> Bool {
        self.view.endEditing(true)
        return true
    }
    @IBOutlet weak var backlog: UIButton!
    @IBAction func backlog(_ sender: UIButton) {
        
        let alert = UIAlertController(title: "legal stuff", message: "", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "EULA", style: .default, handler: { action in
            let urlString = "https://asirius.co/EULA.html"
            if let url = URL(string: urlString) {
                let vc = SFSafariViewController(url: url)
                vc.delegate = self
                
                self.present(vc, animated: true)
            }
        }))
        alert.addAction(UIAlertAction(title: "privacy policy", style: .default, handler: { action in
            let urlString = "https://asirius.co/PP.html"
            if let url = URL(string: urlString) {
                let vc = SFSafariViewController(url: url)
                vc.delegate = self
                
                self.present(vc, animated: true)
            }
        }))
        alert.addAction(UIAlertAction(title: "done", style: .cancel, handler: { action in
        }))
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func loginbtn(_ sender: UIButton) {
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
    func authorizationController(controller: ASAuthorizationController, didCompleteWithAuthorization authorization: ASAuthorization) {
        if let appleIDCredential = authorization.credential as?  ASAuthorizationAppleIDCredential {
            let userIdentifier = appleIDCredential.user
            let fullName = appleIDCredential.fullName
            let email = appleIDCredential.email
print(userIdentifier)
            startLoading()
            print(fullName as Any)
            print(email as Any)
            self.name = fullName?.givenName
            guard let appleToken = appleIDCredential.identityToken else { return }
//            startLoading(loadingView: loadingIndicator)
            let IDTOken = String(data: appleToken, encoding: .utf8)
            let credentials = Credentials.apple(idToken: IDTOken!)
            app.login(credentials: credentials) { (result) in
                switch result {
                case .failure(let error):
                    print("Login failed: \(error.localizedDescription)")
                    DispatchQueue.main.async {
                        self.stopLoading()
                    }
//                    let alert = UIAlertController(title: "error", message: error.localizedDescription, preferredStyle: .alert)
//                    alert.addAction(UIAlertAction(title: "what", style: .cancel, handler: nil))
//
//                    alert.addAction(UIAlertAction(title: "ok", style: .default, handler: { action in
////                        self.stopLoading(loadingView: self.loadingIndicator)
//
//                    }))
//                    self.present(alert, animated: true, completion: nil)
                case .success(let user):
                    print("Successfully logged in as user \(user)")
                    Person.Current.ID = user.id
                    UserDefaults.standard.set(user.id, forKey: "myCode")
                    self.returningPersonCheck(user: user)
                        
                // Remember to dispatch to main if you are doing anything on the UI thread
                }
            }
        }
    }
    @objc func handleAppleIdRequest() {
        let appleIDProvider = ASAuthorizationAppleIDProvider()
        let request = appleIDProvider.createRequest()
        request.requestedScopes = [.fullName, .email]
        let authorizationController = ASAuthorizationController(authorizationRequests: [request])
        authorizationController.delegate = self
        authorizationController.performRequests()
        
    }
    func setUpSignInAppleButton() {
      let authorizationButton = ASAuthorizationAppleIDButton()
      authorizationButton.addTarget(self, action: #selector(handleAppleIdRequest), for: .touchUpInside)
        authorizationButton.layer.cornerRadius = authorizationButton.frame.height / 2
        authorizationButton.layer.masksToBounds = true
      //Add button on some view or stack
        self.emailview.addSubview(authorizationButton)
        authorizationButton.snp.makeConstraints { (make) in
            make.edges.equalTo(pwdField)
        }
    }
    func authorizationController(controller: ASAuthorizationController, didCompleteWithError error: Error) {
    // Handle error.
        stopLoading()
        print(error.localizedDescription)
//        let alert = UIAlertController(title: "error", message: error.localizedDescription, preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "what", style: .cancel, handler: nil))
//        alert.addAction(UIAlertAction(title: "ok", style: .default, handler: { action in
////            self.stopLoading(loadingView: self.loadingIndicator)
//
//
//        }))
//        self.present(alert, animated: true, completion: nil)
    }
    func returningPersonCheck(user:User){
        let partitionValue = "me=\(user.id)"
        let configuration = user.configuration(partitionValue: partitionValue)
        Realm.asyncOpen(configuration: configuration) {  (result) in
            switch result {
            case .failure(let error):
                print("Failed to open realm: \(error.localizedDescription)")
                // Handle error...
                
                let alert = UIAlertController(title: "error", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "what", style: .cancel, handler: nil))
                alert.addAction(UIAlertAction(title: "ok", style: .default, handler: { action in
                    DispatchQueue.main.async {
                        self.stopLoading()
                    }
                }))
                self.present(alert, animated: true, completion: nil)
            case .success(let realm):
                // Realm opened
                if let me = realm.objects(mePerson.self).first {
                    print("returning user : mePerson found")
                    if me.priv == false {
                        self.addAllPerson(user: user, name: me.name)
                    }
                    DispatchQueue.main.async {
                        self.stopLoading()
                        self.performSegue(withIdentifier: "tohome", sender: nil)
                    }
                } else {
                    print("non returning user : mePerson not found")
                    let mePeep = mePerson(name: self.name ?? "",biz: false,peepOne: 1,peepTwo: 2,peepThree: 3, priv: false, beta: false,_id: user.id)
                    try! realm.write {
                        realm.add(mePeep, update: .all)
                    }
                    UserDefaults.standard.set("yup", forKey: "new")
                    UserDefaults.standard.set(true, forKey: "made")
                    UserDefaults.standard.set(0, forKey: "appColor")
                                DispatchQueue.main.async {
                                    self.stopLoading()
                                    self.performSegue(withIdentifier: "tohome", sender: nil)
                                }
                }
            }
        }
        
    }
    func addAllPerson(user:User,name:String) {
        let configuration2 = user.configuration(partitionValue: "allPeople=\(Location.country)")
      
        Realm.asyncOpen(configuration: configuration2) { (result) in
            switch result {
            case .failure(let error):
                print("Failed to open realm: \(error.localizedDescription)")
                // Handle error...
                let alert = UIAlertController(title: "error", message: error.localizedDescription, preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "what", style: .cancel, handler: nil))
                alert.addAction(UIAlertAction(title: "ok", style: .default, handler: { action in
//                    self.stopLoading(loadingView: self.loadingIndicator)
                }))
                self.stopLoading()
                self.present(alert, animated: true, completion: nil)
            case .success(let realm):
                // Realm opened
                let task = allPeople(color: 0,image: "",name:name,peepOne:1,peepTwo:2,peepThree: 3,biz:false, bio:"",priv:false,ID:user.id)
                try! realm.write { realm.add(task,update: .modified) }
            
                print("Successfully logged in as user \(user)")
            }
        }
    }
    func stopLoading() {
        
        timer?.invalidate()
        timer = nil
    }
    func startLoading() {
        
        if timer == nil {
            timer = Timer.scheduledTimer(timeInterval:0.0, target: self, selector: #selector(animateView), userInfo: nil, repeats: false)
        }
    }
    var timer: Timer?
    
    @objc func animateView() {
        UIView.animate(withDuration: 0.7, delay: 0.0, options: .curveLinear, animations: {
            self.loadingIndicator.transform = self.loadingIndicator.transform.rotated(by: CGFloat(Double.pi))
        }, completion: { (finished) in
            if self.timer != nil {
                self.timer = Timer.scheduledTimer(timeInterval:0.0, target: self, selector: #selector(self.animateView), userInfo: nil, repeats: false)
            }
        })
    }
    override var prefersStatusBarHidden: Bool {
        return false }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideKeyboardWhenTappedAround()
        emailField.addShadow()
        pwdField.addShadow()
        setUpSignInAppleButton()
        peepleLogo.addShadow()
    }
    func presentationAnchor(for controller: ASAuthorizationController) -> ASPresentationAnchor {
        return self.view.window!
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
    }
    
    
    
}

extension String {
    func utf8DecodedString()-> String {
        let data = self.data(using: .utf8)
        let message = String(data: data!, encoding: .nonLossyASCII) ?? ""
        return message
    }
    
    func utf8EncodedString()-> String {
        let messageData = self.data(using: .nonLossyASCII)
        let text = String(data: messageData!, encoding: .utf8) ?? ""
        return text
    }
}



