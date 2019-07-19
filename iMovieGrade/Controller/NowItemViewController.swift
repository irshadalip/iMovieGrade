//
//  NowItemViewController.swift
//  OnboardingExample
//
//  Created by Irshadali Palsaniya on 10/07/19.
//  Copyright © 2019 Anitaa. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class NowItemViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    var movieID : String?
    var moviename : String?
    var movieImage : UIImage?
    var movieCommentCount : Int?
    var movieWatchCount : Int = 0
    var movieLikeCount : Int = 0
    
    var imageStore = [String]()
    
    var characters = ["charecter-1"]
    var charArray = ["char-1"]
    
    var commentcount = ["commentcount-1"]
    var watchcount = "00"
    var likecount = "00"
    var descrip : String = ""
    var totalWatch = "444"
    
    let db = Firestore.firestore()
    let dbchar = Firestore.firestore()
    let dbWatch = Firestore.firestore()
    let dbdescrip = Firestore.firestore()
    let dbLikeInDatabase = Firestore.firestore()
    
    var listOfCharecter = [CharacterModel]()
    
    var listOfComments = [commentModel]()
    
    @IBOutlet weak var starButtonLabel: UILabel!
    @IBOutlet weak var likeButtonLabel: UILabel!
    @IBOutlet weak var commentButtonLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var likeButton_1: UIButton!
    @IBOutlet weak var likeButton_2: UIButton!
    @IBOutlet weak var likeButton_3: UIButton!
    
    @IBOutlet weak var characterCollectionView: UICollectionView!
    @IBOutlet weak var movieimage: UIImageView!
    @IBOutlet weak var movieNameLabel: UILabel!
    var nowCharacter = ["char-1"]
    var nowCharacterText = ["char-1"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.hidesBackButton = true
        
        movieNameLabel.text = moviename
        
        readCharacter()
        readBigImage()
        readMovieDescription()
        readCommentCount()
        updateLike()
        StarInitVale()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.hidesBackButton = true
        
        InitWatchCount()
    }
    
    @IBAction func likeButtonAction(_ sender: UIButton) {
        updateLikeInDatabase()

    }
    @IBAction func starAction(_ sender: UIButton) {
        updateStarInDatabase()

    }
    @IBAction func backButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
        
    }
    @IBAction func commentButton(_ sender: UIButton) {
        let viewControler : CommentsViewController = self.storyboard?.instantiateViewController(withIdentifier: "CommentsViewController") as! CommentsViewController
        
        viewControler.movieID = movieID
        self.navigationController?.pushViewController(viewControler, animated: true)
        
    }
    
    @IBAction func shareButton(_ sender: UIButton) {
        let text = "https://www.youtube.com/watch?v=\(movieID!)"
       
        let textToShare = [text]
        let activityViewController = UIActivityViewController(activityItems: textToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.mail, UIActivity.ActivityType.message]
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    
    @IBAction func playMovieButton(_ sender: UIButton) {
        
        //let viewControler : PlayVideoViewController = self.storyboard?.instantiateViewController(withIdentifier: "PlayVideoViewController") as! PlayVideoViewController
        let viewControler : PlayVideo__2 = self.storyboard?.instantiateViewController(withIdentifier: "PlayVideo__2") as! PlayVideo__2
        
        
        viewControler.movieID = movieID
        viewControler.moviename = moviename
        self.navigationController?.pushViewController(viewControler, animated: true)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageStore.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NowCharacterViewCell", for: indexPath) as! NowCharacterViewCell
        cell.imageCharacter.image = listOfCharecter[indexPath.row].image
        cell.nowCharacterText.text = imageStore[indexPath.row]
        
        //
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewControler : ThirdTapViewController = self.storyboard?.instantiateViewController(withIdentifier: "ThirdTapViewController") as! ThirdTapViewController

        viewControler.movieURL = movieID
        viewControler.commentCount = listOfComments.count
        viewControler.watchCount = totalWatch
        viewControler.likeCount = likecount
        viewControler.profile = listOfCharecter[indexPath.row].image
        viewControler.profileName = imageStore[indexPath.row]
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.hidesBackButton = false
        
        self.navigationController?.pushViewController(viewControler, animated: true)
        
        
        
        
    }
    
}

extension NowItemViewController{
    
    func readCharacter() {
        self.charArray.removeAll()
        self.characters.removeAll()
        db.collection("moviewithchar").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                
            } else {
                
                for document in querySnapshot!.documents {
                    
                    if document.documentID == self.moviename{
                        // most Important
                        let charNewitem = CharacterModel()
                        
                        charNewitem.nameArray = (document.data()["name"] as! Array<String>)
                        self.imageStore = (document.data()["name"] as! Array<String>)
                        self.getImage()
                    }
                }
            }
        }
    }
    func getImage() {
        for char in imageStore{
            
            let charNewitem = CharacterModel()
            
            
            let storeRef = Storage.storage().reference(withPath: "character/\(char).png")//document.documentID
            
            storeRef.getData(maxSize: 4 * 1024 * 1024, completion: {(data, error) in
                if let error = error {
                    print("error-------- \(error.localizedDescription)")
                    
                    return
                }
                if let data = data {
                    print("Main data\(data)")
                    charNewitem.image  = UIImage(data: data)!
                    self.characterCollectionView.reloadData()
                }
            })
            //self.nows.append(nownewitem.image!)
            self.listOfCharecter.append(charNewitem)
            self.characterCollectionView.reloadData()
        }
    }

    func readBigImage() {
        //self.movieImage.removeAll()
        db.collection("movies").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                
            } else {
                for document in querySnapshot!.documents {
                    // most Important
                    let charNewitem = CharacterModel()
                    
                    charNewitem.name = (document.data()["name"] as! String)
                    
                    let storeRef = Storage.storage().reference(withPath: "moviebigimage/\(charNewitem.name!).jpg")//document.documentID
                    
                    print("moviebigimage/\(charNewitem.name!).png")
                    
                    storeRef.getData(maxSize: 4 * 1024 * 1024, completion: {(data, error) in
                        if let error = error {
                            print("error========= \(error.localizedDescription)")
                            
                            return
                        }
                        if let data = data {
                            print("Main data\(data)")
                            if charNewitem.name == self.moviename{
                                charNewitem.image  = UIImage(data: data)!
                                self.movieimage.image = charNewitem.image
                            }
                            
                        }
                    })
                    
                }
            }
        }
        db.collection("popular").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                
            } else {
                for document in querySnapshot!.documents {
                    // most Important
                    let charNewitem = CharacterModel()
                    
                    charNewitem.name = (document.data()["name"] as! String)
                    
                    let storeRef = Storage.storage().reference(withPath: "moviebigimage/\(charNewitem.name!).jpg")//document.documentID
                    
                    print("moviebigimage/\(charNewitem.name!).png")
                    
                    storeRef.getData(maxSize: 4 * 1024 * 1024, completion: {(data, error) in
                        if let error = error {
                            print("error==++++++++==== \(error.localizedDescription)")
                            
                            return
                        }
                        if let data = data {
                            print("Main data\(data)")
                            if charNewitem.name == self.moviename{
                                charNewitem.image  = UIImage(data: data)!
                                self.movieimage.image = charNewitem.image
                            }
                            
                        }
                    })
                    
                }
            }
        }
        db.collection("moviesbig").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                
            } else {
                for document in querySnapshot!.documents {
                    // most Important
                    let charNewitem = CharacterModel()
                    
                    charNewitem.name = (document.data()["name"] as! String)
                    
                    let storeRef = Storage.storage().reference(withPath: "moviebigimage/\(charNewitem.name!).jpg")//document.documentID
                    
                    print("moviebigimage/\(charNewitem.name!).png")
                    
                    storeRef.getData(maxSize: 4 * 1024 * 1024, completion: {(data, error) in
                        if let error = error {
                            print("error==++++++++==== \(error.localizedDescription)")
                            
                            return
                        }
                        if let data = data {
                            print("Main data\(data)")
                            if charNewitem.name == self.moviename{
                                charNewitem.image  = UIImage(data: data)!
                                self.movieimage.image = charNewitem.image
                            }
                            
                        }
                    })
                    
                }
            }
        }
    }
    func readMovieDescription() {
        self.descrip.removeAll()
        
        dbdescrip.collection("movies").getDocuments() { (querySnapshot, err) in
            
            if let err = err {
                print("Error getting documents: \(err)")
                
            } else {
                for document in querySnapshot!.documents {
                    // most Important
                    let nownewitem = NowModel()
                    nownewitem.name = (document.data()["name"] as? String)
                    nownewitem.description = (document.data()["description"] as? String)
                    
                    // feching data
                    
                    //self.nows.append(nownewitem.image!)
                    if nownewitem.name == self.moviename{
                        self.descrip = nownewitem.description!
                        self.descriptionLabel.text = nownewitem.description!
                    }
                    
                }
            }
        }
        dbdescrip.collection("popular").getDocuments() { (querySnapshot, err) in
            
            if let err = err {
                print("Error getting documents: \(err)")
                
            } else {
                for document in querySnapshot!.documents {
                    // most Important
                    let nownewitem = NowModel()
                    nownewitem.name = (document.data()["name"] as? String)
                    nownewitem.description = (document.data()["description"] as? String)
                    
                    // feching data
                    
                    //self.nows.append(nownewitem.image!)
                    if nownewitem.name == self.moviename{
                        self.descrip = nownewitem.description!
                        self.descriptionLabel.text = nownewitem.description!
                    }
                    
                }
            }
        }
        dbdescrip.collection("moviesbig").getDocuments() { (querySnapshot, err) in
            
            if let err = err {
                print("Error getting documents: \(err)")
                
            } else {
                for document in querySnapshot!.documents {
                    // most Important
                    let nownewitem = NowModel()
                    nownewitem.name = (document.data()["name"] as? String)
                    nownewitem.description = (document.data()["description"] as? String)
                    
                    // feching data
                    
                    //self.nows.append(nownewitem.image!)
                    if nownewitem.name == self.moviename{
                        self.descrip = nownewitem.description!
                        self.descriptionLabel.text = nownewitem.description!
                    }
                    
                }
            }
        }
    }
    //==========================================
    func readCommentCount() {
        self.commentcount.removeAll()
        db.collection("comment").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    // most Important
                    let newitem = commentModel()
                    newitem.name = (document.data()["url"] as! String)
                    
                    
                    
                    if self.movieID == newitem.name{
                        self.listOfComments.append(newitem)
                    }
                    //self.listOfComments.append(newitem)
                    DispatchQueue.main.async {
                        
                    }
                    print(self.listOfComments.count)
                    self.commentButtonLabel.text = String(self.listOfComments.count)

                    self.likeButtonLabel.text = self.likecount
                    
                }
            }
        }
    }
    func updateLike(){
        
        self.likecount.removeAll()
        db.collection("total").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                for document in querySnapshot!.documents {
                    // most Important
                    let newitem = watchModel()
                    newitem.like = (document.data()["like"] as? String)
                    newitem.url = (document.data()["url"] as? String)
                    newitem.state = (document.data()["state"] as? String)
                    
                    
                    
                    if self.movieID == newitem.url{
                        
                        if newitem.state == "0"{
                            self.likeButton_1.setImage(UIImage(named: "like-11"), for: .normal)
                            self.likeButtonLabel.text = newitem.like
                        }
                        else{
                            self.likeButton_1.setImage(UIImage(named: "like_fill"), for: .normal)
                            self.likeButtonLabel.text = newitem.like
                        }
                        
                        self.likecount = newitem.like ?? "00"
                    }
                }
            }
        }
    }
}
extension NowItemViewController{
    
    func InitWatchCount(){
        
        dbLikeInDatabase.collection("total").getDocuments(){ (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                
                for document in querySnapshot!.documents {
                
                    let newitem = watchModel()
                    newitem.url = (document.data()["url"] as! String)
                    newitem.watch = (document.data()["watch"] as! String)
           
                    if self.movieID == newitem.url{
                        
                        self.totalWatch = newitem.watch!
                    }
                    
                }
            }
        }
    }
    
    func updateLikeInDatabase(){
        
        dbLikeInDatabase.collection("total").getDocuments(){ (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                
                for document in querySnapshot!.documents {
                    // most Important
                    let newitem = watchModel()
                    newitem.like = (document.data()["like"] as? String)
                    newitem.url = (document.data()["url"] as! String)
                    newitem.state = (document.data()["state"] as! String)
                    newitem.watch = (document.data()["watch"] as! String)
                    
                    
                    if self.movieID == newitem.url{//{"r9-DM9uBtVI"
                        
                        self.totalWatch = newitem.watch!
                        self.likecount = newitem.like ?? "00"
                        
                        if document.exists {
                            let property = document.get("like")
                            var likeCont = 0
                            if newitem.state == "1"{
                                likeCont = Int(newitem.like!)! - 1
                                self.likeButtonLabel.text = String(likeCont)
                                self.likecount = String(likeCont)
                                self.db.collection("total").document(self.moviename!).updateData(["state": "0"])
                                self.likeButton_1.setImage(UIImage(named: "like-11"), for: .normal)
                                print(self.moviename!)
                                
                            }
                            else{
                                likeCont = Int(newitem.like!)! + 1
                                
                                self.likeButtonLabel.text = String(likeCont)
                                self.likecount = String(likeCont)
                                self.db.collection("total").document(self.moviename!).updateData(["state": "1"])
                                self.likeButton_1.setImage(UIImage(named: "like_fill"), for: .normal)
                                 print(self.moviename!)
                                
                            }
                
                            self.db.collection("total").document(self.moviename!).updateData(["like": "\(likeCont)"])
                            
                        } else {
                            print("Document does not exist")
                        }
                    }
                }
            }
        }
    }
    func updateStarInDatabase(){
        
        dbLikeInDatabase.collection("users").getDocuments(){ (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                
                for document in querySnapshot!.documents {
                    let doc = document.data()
                    // most Important
                    let newitem = FavoriteModel()
                    newitem.movieArray = (doc["favoritemovie"] as! Array<String>)

                    var starCont = 0
                    var starStr = "0"
                    
                    for key in newitem.movieArray! {
                        
                        if key == self.moviename{
                            self.db.collection("users").document("user_1").updateData(["favoritemovie": FieldValue.arrayRemove([key])])
                            starStr = "2"
                            
                            starCont = (newitem.movieArray?.count)! - 1
                            self.starButtonLabel.text = String(starCont)
                            self.watchcount = String(starCont)
                            self.likeButton_2.setImage(UIImage(named: "like-22"), for: .normal)
                            print(self.moviename!)
                        }
                    }
                    if starStr == "2"{
                        
                    }
                    else{
                        
                        self.db.collection("users").document("user_1").updateData(["favoritemovie": FieldValue.arrayUnion(["\(self.moviename!)"])])
                        
                        starCont = (newitem.movieArray?.count)! + 1
                        self.starButtonLabel.text = String(starCont)
                        self.watchcount = String(starCont)
                        self.likeButton_2.setImage(UIImage(named: "like_fill_22"), for: .normal)
                        print(self.moviename!)
                        
                    }
                }
            }
        }
    }
    func StarInitVale(){
        
        dbLikeInDatabase.collection("users").getDocuments(){ (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                
                for document in querySnapshot!.documents {
                    let doc = document.data()
                    // most Important
                    let newitem = FavoriteModel()
                    newitem.movieArray = (doc["favoritemovie"] as! Array<String>)
                    //newitem.dic = (doc["state"] as! Dictionary)
                    print(newitem.movieArray?.count)
                    
                    var starCont = 0
                    var starStr = "0"
     
                    for key in newitem.movieArray! {
                        
                        if key == self.moviename{
                            
                            starCont = (newitem.movieArray?.count)!
                            self.starButtonLabel.text = String(starCont)
                            self.watchcount = String(starCont)
                            self.likeButton_2.setImage(UIImage(named: "like_fill_22"), for: .normal)
                            print(self.moviename!)
                            
                        }
                    }
                    starCont = (newitem.movieArray!.count)
                    self.starButtonLabel.text = String(starCont)
                   print(starCont)
                    
                }
            }
        }
    }

    
}
