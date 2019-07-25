//
//  AboutViewController.swift
//  OnboardingExample
//
//  Created by Irshadali Palsaniya on 10/07/19.
//  Copyright © 2019 Anitaa. All rights reserved.
//

import UIKit
import BottomDrawer

class AboutViewController: BottomController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func crossButton(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

}
