//
//  CommentsViewController.swift
//  iMovieGrade
//
//  Created by Irshadali Palsaniya on 12/07/19.
//  Copyright © 2019 Anitaa. All rights reserved.
//

import UIKit
import FBSDKCoreKit
import FBSDKLoginKit
import Firebase
import FirebaseAuth

class CommentsViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    
    var ProfileImage : UIImage?
    
    var comment = ["arrival"]
    var allURL = ["justice league"]
    
    var commentShort: String?
    
    var listOfData = [ReviewModel]()
    
    let db = Firestore.firestore()
    var postId = ""
    var movieID: String?

    @IBOutlet weak var reviewText: UITextField!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        let nib = UINib(nibName: "ReviewsTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "ReviewsTableViewCell")
        
        self.tableView.estimatedRowHeight = 60
        
//        self.tableView.estimatedRowHeight = 150
//        self.tableView.rowHeight = UITableView.UITableViewAutomaticDimension
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        readComments()
        
        let url = Auth.auth().currentUser?.photoURL
        print(url as Any)
        
        if let data = try? Data(contentsOf: url!){
            if let image = UIImage(data: data){
                ProfileImage = image
                
            }
        }
        //profileName.text = Auth.auth().currentUser?.displayName
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.hidesBackButton = false

        print(comment.count)
        
        
        
        
    }
 
    @IBAction func sendAction(_ sender: UIButton) {
  
        if reviewText.text?.count != 0{
            uploadReview()
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfData.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewsTableViewCell", for: indexPath) as! ReviewsTableViewCell
        
//        cell.postLabelOut.text = listOfData[indexPath.row].post
//        cell.ImageOfCell.image = listOfData[indexPath.row].img
        
        cell.reviews.text = listOfData[indexPath.row].discription
        cell.profileImage.image = ProfileImage
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
        //return 100
    }
    func uploadReview() {
        var ref: DocumentReference? = nil
        
        // Add a new document with a generated ID
        ref = db.collection("comment").addDocument(data: [ "description": "\(reviewText.text ?? "")", "url": "\(movieID!)"]) { err in
            if let err = err {
                print("Error adding document: \(err)")
                
            } else {
                print("Document added with ID: \(ref!.documentID)")
                
                //self.readComments()
                let commentitem = ReviewModel()
                commentitem.discription = self.reviewText.text
                self.listOfData.append(commentitem)
                self.tableView.reloadData()
                
                self.reviewText.text = ""
                    
                
            }
//            self.tableView.reloadData()
        }
        
        postId = ref!.documentID
        
    }
    func readComments() {
        self.comment.removeAll()
        self.allURL.removeAll()
        
        db.collection("comment").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                
            } else {
                for document in querySnapshot!.documents {
                    // most Important
                    let commentitem = ReviewModel()
                    
                    
                    commentitem.movieURL = (document.data()["url"] as! String)
                    commentitem.discription = (document.data()["description"] as! String)
                    
                    
                    if self.movieID == document.data()["url"] as! String{
                         self.listOfData.append(commentitem)
                        self.tableView.reloadData()
                    }
                    
//                    for i in 0..<comment.count{
//                        if listOfData[i].movieURL == movieID {
//                            commentShort?.append(comment[i])
//
//                            print(listOfData[i].movieURL)
//                            print(movieID)
//                            print(commentShort)
//
//                        }
//                    }
                    self.tableView.reloadData()
                   
                    
                    
                    
                    
                    
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        
                    }
                    self.tableView.reloadData()
                    print("Data Print:- \(document.documentID) => \(document.data())")
                    
                }
            }
        }
    }

}
