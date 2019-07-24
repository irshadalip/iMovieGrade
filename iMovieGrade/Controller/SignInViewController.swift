//
//  SignInViewController.swift
//  OnboardingExample
//
//  Created by Irshadali Palsaniya on 08/07/19.
//  Copyright © 2019 Anitaa. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase
import FirebaseAuth


class SignInViewController: UIViewController, LoginButtonDelegate{

    var loginStatus : Bool = false
    var gradientLayer: CAGradientLayer!
    
    @IBOutlet weak var gmailOutlet: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loginButton = FBLoginButton()
        loginButton.center = view.center
        view.addSubview(loginButton)
        
        
        
        loginButton.delegate = self
        loginButton.frame = CGRect(x: 16, y: 500, width: view.frame.width - 32, height: 50)
        
        if UserDefaults.standard.bool(forKey: "login") == true{
            let viewController:TapViewController = self.storyboard?.instantiateViewController(withIdentifier: "TapViewController") as! TapViewController
            self.navigationController?.pushViewController(viewController, animated: true)
        }
        
        // Do any additional setup after loading the view.
        createGradientLayer()
        gmailOutlet.layer.borderWidth = 1
        gmailOutlet.backgroundColor = .clear
        gmailOutlet.layer.borderColor = UIColor.white.cgColor
        gmailOutlet.layer.cornerRadius = 5
        
        gmailOutlet.isHidden = true
    }
    
    @IBAction func gmailButton(_ sender: UIButton) {
        let actionCodeSettings = ActionCodeSettings()
        actionCodeSettings.url = URL(string: "https://solutionanalysts.page.link")
        // The sign-in operation has to always be completed in the app.
        actionCodeSettings.handleCodeInApp = true
        actionCodeSettings.setIOSBundleID(Bundle.main.bundleIdentifier!)
        actionCodeSettings.setAndroidPackageName("com.example.android",
                                                 installIfNotAvailable: false, minimumVersion: "12")
        
//        Auth.auth().sendSignInLink(toEmail:email,
//                                   actionCodeSettings: actionCodeSettings) { error in
//                                    // ...
//                                    if let error = error {
//                                        self.showMessagePrompt(error.localizedDescription)
//                                        return
//                                    }
//                                    // The link was successfully sent. Inform the user.
//                                    // Save the email locally so you don't need to ask the user for it again
//                                    // if they open the link on the same device.
//                                    UserDefaults.standard.set(email, forKey: "Email")
//                                    self.showMessagePrompt("Check your email for link")
//                                    // ...
//        }

    }
    
    
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        
        if let error = error {
            print(error.localizedDescription)
            
            return
        }
        else{
            let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current!.tokenString)
            
            Auth.auth().signIn(with: credential) { (authResult, error) in
                if error != nil {
                    print("ERROR------------")
                    
                    return
                }
            }
        }
        
        UserDefaults.standard.set(true, forKey: "login")
        let viewController:TapViewController = self.storyboard?.instantiateViewController(withIdentifier: "TapViewController") as! TapViewController
        self.navigationController?.pushViewController(viewController, animated: true)
        
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        UserDefaults.standard.set(false, forKey: "login")
        print("Logout")
        
    }

    func createGradientLayer() {

        let topColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let bottomColor = UIColor(red: 255, green: 37, blue: 219, alpha: 1)
        gradientLayer = CAGradientLayer()
        gradientLayer.frame = self.view.bounds
        gradientLayer.colors = [topColor.cgColor, bottomColor.cgColor]
        //backView.layer.addSublayer(gradientLayer)

        //let topColor = UIColor(red: 1, green: 0.92, blue: 0.56, alpha: 1)
        //let bottomColor = UIColor(red: 0.18, green: 0.18, blue: 0.18, alpha: 1)
    }
}
