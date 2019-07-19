//
//  SettingViewController.swift
//  OnboardingExample
//
//  Created by Irshadali Palsaniya on 10/07/19.
//  Copyright © 2019 Anitaa. All rights reserved.
//

import UIKit
import BottomDrawer
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase
import FirebaseAuth

class SettingViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {
    
    var movieURL : String?
    
    @IBOutlet weak var shareTheApp: UITableViewCell!
    @IBOutlet weak var signOut: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        signOut.layer.cornerRadius = signOut.frame.size.height / 2
        // Do any additional setup after loading the view.
    }
    
    @IBAction func singnOutAction(_ sender: UIButton) {
        do{
            let credential = FacebookAuthProvider.credential(withAccessToken: AccessToken.current?.tokenString ?? "")
            Auth.auth().currentUser?.link(with:credential,completion:nil)
            try! Auth.auth().signOut()
            Auth.auth().signInAnonymously()
            LoginManager().logOut()
            print("Logged Out Successfully")
        }catch{
            print("LogIn Error :-------------- \(error)")
        }
        
        UserDefaults.standard.set(false, forKey:"login")
        
        self.navigationController?.popViewController(animated: true)
        navigationController?.popToRootViewController(animated: true)
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SignInViewController") as? SignInViewController
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = vc
    }
    @IBAction func backButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "SharetheApp") as! UITableViewCell
            
            return cell
        }
        else if indexPath.row == 1{
            let cell = tableView.dequeueReusableCell(withIdentifier: "Question") as! UITableViewCell
            
            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "About") as! UITableViewCell
            
            return cell
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0{
            
            let text = "https://www.youtube.com/watch?v=\(movieURL!)"
            let textToShare = [text]
            let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view
            activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.mail, UIActivity.ActivityType.message]
            self.present(activityViewController, animated: true, completion: nil)
            
        }
        else if indexPath.row == 1{
        }
        else{
            
            let request = self.storyboard?.instantiateViewController(withIdentifier: "AboutViewController") as? AboutViewController
            let v = BottomController()
            request?.view.backgroundColor = .white
            v.destinationController = request
            v.sourceController = self
            v.startingHeight = 200
            v.cornerRadius = 10
            v.modalPresentationStyle = .overCurrentContext
            self.present(v, animated: true, completion: nil)
//
//
//            let viewControler : AboutViewController = self.storyboard?.instantiateViewController(withIdentifier: "AboutViewController") as! AboutViewController
//
//            self.navigationController?.pushViewController(viewControler, animated: true)
          
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 68
    }
}
