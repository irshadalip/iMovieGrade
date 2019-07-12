//
//  CommentsViewController.swift
//  iMovieGrade
//
//  Created by Irshadali Palsaniya on 12/07/19.
//  Copyright © 2019 Anitaa. All rights reserved.
//

import UIKit

class CommentsViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        let nib = UINib(nibName: "ReviewsTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "ReviewsTableViewCell")

    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.hidesBackButton = false
    }
    

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewsTableViewCell", for: indexPath) as! ReviewsTableViewCell
        
//        cell.postLabelOut.text = listOfData[indexPath.row].post
//        cell.ImageOfCell.image = listOfData[indexPath.row].img

        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        //return UITableView.automaticDimension
        return 100
    }

}
