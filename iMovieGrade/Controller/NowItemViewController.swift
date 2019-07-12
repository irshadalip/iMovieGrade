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
    
    
    var characters = ["charecter-1"]
    let db = Firestore.firestore()
    var listOfCharecter = [CharacterModel]()
    
    
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
        movieimage.image = movieImage
        
        
        readCharacter()
//        likeButton_1.layer.cornerRadius = likeButton_1.frame.size.height / 2
//        likeButton_2.layer.cornerRadius = likeButton_2.frame.height / 2
//        likeButton_3.layer.cornerRadius = likeButton_3.frame.height / 2
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.hidesBackButton = true
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
        
    }
    @IBAction func commentButton(_ sender: UIButton) {
        let viewControler : CommentsViewController = self.storyboard?.instantiateViewController(withIdentifier: "CommentsViewController") as! CommentsViewController
        self.navigationController?.pushViewController(viewControler, animated: true)
        
    }
   
    @IBAction func shareButton(_ sender: UIButton) {
        let text = "https://www.youtube.com/watch?v=\(movieID)"
        //let text = "share text"
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
        self.navigationController?.pushViewController(viewControler, animated: true)
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listOfCharecter.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NowCharacterViewCell", for: indexPath) as! NowCharacterViewCell
//
//        cell.imageCharacter.image = UIImage(named: nowCharacterText[indexPath.row])
//        cell.nowCharacterText.text = nowCharacterText[indexPath.row]
//
//        return cell
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NowCharacterViewCell", for: indexPath) as! NowCharacterViewCell
        cell.imageCharacter.image = listOfCharecter[indexPath.row].image
        cell.nowCharacterText.text = listOfCharecter[indexPath.row].name
        
        return cell
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewControler : ThirdTapViewController = self.storyboard?.instantiateViewController(withIdentifier: "ThirdTapViewController") as! ThirdTapViewController
        
        //viewControler.profile.image =
        viewControler.profile = listOfCharecter[indexPath.row].image
        viewControler.profileName = listOfCharecter[indexPath.row].name
        
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.hidesBackButton = false
        
        self.navigationController?.pushViewController(viewControler, animated: true)
       
        
        
        
    }

}

extension NowItemViewController{
    
    func readCharacter() {
        self.characters.removeAll()
        db.collection("character").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")

            } else {
                for document in querySnapshot!.documents {
                    // most Important
                    let charNewitem = CharacterModel()
                    
                    charNewitem.name = (document.data()["name"] as! String)
                    //charNewitem.movieURL = (document.data()["name"] as! String)
                    // feching data
                    let storeRef = Storage.storage().reference(withPath: "character/\(charNewitem.name!).png")//document.documentID

                    print("character/\(charNewitem.name!).png")

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
                    //self.nows.append(charNewitem.image!)
                    self.listOfCharecter.append(charNewitem)
                    DispatchQueue.main.async {
                        self.characterCollectionView.reloadData()

                    }
                    self.characterCollectionView.reloadData()
                    print("Data Print:- \(document.documentID) => \(document.data())")

                }
            }
        }
    }
}
