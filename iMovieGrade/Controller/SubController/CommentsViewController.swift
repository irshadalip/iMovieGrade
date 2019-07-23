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
    var allphotourl = [UIImage]()
    var allphotoname = [String]()
    
    var commentShort: String?
    
    var listOfData = [ReviewModel]()
    
    let db = Firestore.firestore()
    var postId = ""
    var movieID: String?
    var profileName : String?
    
    var url : URL?
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()

    @IBOutlet weak var reviewText: UITextField!
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        
        let nib = UINib(nibName: "ReviewsTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "ReviewsTableViewCell")
        
        self.tableView.estimatedRowHeight = 60
        
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        readComments()
        
        url = Auth.auth().currentUser!.photoURL
        //print(url as Any)
        
        if let data = try? Data(contentsOf: url!){
            if let image = UIImage(data: data){
                ProfileImage = image
                
            }
        }
        profileName = Auth.auth().currentUser?.displayName
        
        
        //profileName.text = Auth.auth().currentUser?.displayName
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.hidesBackButton = false

        print(comment.count)
        
        
        allphotourl = []
        allphotoname = []
        
    }
 
    @IBAction func sendAction(_ sender: UIButton) {
  
        if reviewText.text?.count != 0{
            activityIndicator.startAnimating()
            uploadReview()
        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfData.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewsTableViewCell", for: indexPath) as! ReviewsTableViewCell
        
        cell.reviews.text = listOfData[indexPath.row].discription
        cell.profileName.text = listOfData[indexPath.row].profilename
        cell.profileImage.image = allphotourl[indexPath.row]
        
        
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
        //return 100
    }
    func uploadReview() {
        var ref: DocumentReference? = nil
        
        //print(url)
        
        // Add a new document with a generated ID
        ref = db.collection("comment").addDocument(data: [ "review": "\(reviewText.text ?? "")", "url": "\(movieID!)", "photourl": "\(url!)", "username": "\(profileName!)"]) { err in
            if let err = err {
                print("Error adding document: \(err)")
                
            } else {
                
                print("Document added with ID: \(ref!.documentID)")
                
                //self.readComments()
                let commentitem = ReviewModel()
                
                
                commentitem.discription = self.reviewText.text
                commentitem.profilename = self.profileName

                //////////
                let url = self.url
                if let data = try? Data(contentsOf: url!){
                    if let image = UIImage(data: data){
                        self.allphotourl.append(image)

                        self.tableView.reloadData()
                    }
                }
                self.listOfData.append(commentitem)
                self.reviewText.text = ""

            }
            self.activityIndicator.stopAnimating()
            self.tableView.reloadData()
        }
        
    }

    func readComments() {
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()

        
        self.comment.removeAll()
        //self.allphotourl.removeAll()
        
        db.collection("comment").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                
            } else {
                var count = 0
                for document in querySnapshot!.documents {
                    // most Important
                    let commentitem = ReviewModel()
                    
                    
                    commentitem.movieURL = (document.data()["url"] as! String)
                    commentitem.discription = (document.data()["review"] as! String)
                    commentitem.userimage = (document.data()["photourl"] as! String)
                    commentitem.profilename = (document.data()["username"] as? String)
                    
                    
                    let url = URL(string: commentitem.userimage!)
                    if self.movieID == (document.data()["url"] as! String){
                        if let data = try? Data(contentsOf: url!){
                            if let image = UIImage(data: data){
                                self.allphotourl.append(image)


                                //self.tableView.reloadData()

                            }
                        }
                         self.listOfData.append(commentitem)
                        //self.allphotourl.append(commentitem.userimage!)
                        self.tableView.reloadData()
                    }
                    
                    //self.tableView.reloadData()
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        
                    }
                    self.tableView.reloadData()
                    print("Data Print:- \(document.documentID) => \(document.data())")
                    
                    count = count + 1
                }
            }
            self.activityIndicator.stopAnimating()
        }
    }

}
