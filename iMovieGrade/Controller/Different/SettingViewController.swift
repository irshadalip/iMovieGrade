//
//  SettingViewController.swift
//  OnboardingExample
//
//  Created by Irshadali Palsaniya on 10/07/19.
//  Copyright © 2019 Anitaa. All rights reserved.
//

import UIKit

class SettingViewController: UIViewController, UITableViewDataSource,UITableViewDelegate {
    
    
    @IBOutlet weak var shareTheApp: UITableViewCell!
    @IBOutlet weak var signOut: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        signOut.layer.cornerRadius = signOut.frame.size.height / 2
        // Do any additional setup after loading the view.
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
            
            let text = "Share Action"
            let textToShare = [text]
            let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
            activityViewController.popoverPresentationController?.sourceView = self.view
            activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.mail, UIActivity.ActivityType.message]
            self.present(activityViewController, animated: true, completion: nil)
            
        }
        else if indexPath.row == 1{
            
        }
        else{
            let viewControler : AboutViewController = self.storyboard?.instantiateViewController(withIdentifier: "AboutViewController") as! AboutViewController
            
            self.navigationController?.pushViewController(viewControler, animated: true)
          
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 68
    }
}
