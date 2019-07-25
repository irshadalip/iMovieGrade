//
//  ThirdTapViewController.swift
//  OnboardingExample
//
//  Created by Irshadali Palsaniya on 10/07/19.
//  Copyright © 2019 Anitaa. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class ThirdTapViewController: UIViewController {
    
    var movieURL : String?
    var profile : UIImage?
    var profileName : String?
    var commentCount : Int?
    var watchCount : String?
    var likeCount : String?
    
    let dbPopuler = Firestore.firestore()
    var imageStore = [String]()
    var listOfDataPopuler = [CharMovieModel]()
    var CharacterMovies = ["char-movie-1"]
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameOfProfile: UILabel!
    @IBOutlet weak var characterProfileCollectionView: UICollectionView!
    @IBOutlet weak var commentOutlet: UILabel!
    @IBOutlet weak var watchOutlet: UILabel!
    @IBOutlet weak var likeOutlet: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        readDataPopuler()
        ViewDidLoadTask()

    }
    override func viewWillAppear(_ animated: Bool) {

        if profileImage.image == nil{
            profileImage.image = UIImage(named: "profile_pic")
        }
        if nameOfProfile.text != profileName{
            nameOfProfile.text = "Not Have Any Profile Yet."
        }
    }
    
    @IBAction func SettingButton(_ sender: UIButton) {
        
        let viewController: SettingViewController = self.storyboard?.instantiateViewController(withIdentifier: "SettingViewController") as! SettingViewController
        viewController.movieURL = movieURL
        navigationController?.pushViewController(viewController, animated: true)
    }
    
    func ViewDidLoadTask() {
        profileImage.image = profile
        nameOfProfile.text = profileName
        commentOutlet.text = String(commentCount ?? 0)
        watchOutlet.text = String(watchCount ?? "0")
        likeOutlet.text = String(likeCount ?? "0")
        
        let itemSize = UIScreen.main.bounds.width / 4 - 10
        
        
        let layout = UICollectionViewFlowLayout()
        
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        
        layout.itemSize = CGSize(width: itemSize, height: itemSize + 50)
        
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        
        characterProfileCollectionView.collectionViewLayout = layout
        
        profileImage.layer.cornerRadius = profileImage.frame.size.height / 2
        profileImage.clipsToBounds = true
    }
}
//MARK:- CollectionView Delegates
extension ThirdTapViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listOfDataPopuler.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileCharacterCell", for: indexPath) as! ProfileCharacterCell
        cell.imageProfile.image = listOfDataPopuler[indexPath.row].image
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let viewControler : NowItemViewController = self.storyboard?.instantiateViewController(withIdentifier: "NowItemViewController") as! NowItemViewController
        viewControler.movieID = listOfDataPopuler[indexPath.row].movieURL
        viewControler.moviename = listOfDataPopuler[indexPath.row].name
        viewControler.movieImage = listOfDataPopuler[indexPath.row].image
        self.navigationController?.pushViewController(viewControler, animated: true)
    }
}

//MARK:- FireBase Fuctions
extension ThirdTapViewController{

    func readDataPopuler() {
        self.CharacterMovies.removeAll()
        
        dbPopuler.collection("charactermovies").getDocuments() { (querySnapshot, err) in
            
            if let err = err {
                print("Error getting documents: \(err)")
                
            } else {
                for document in querySnapshot!.documents {
                    let newitem = CharMovieModel()

                    newitem.name = (document.data()["name"] as! String)
    
                    if newitem.name == self.nameOfProfile.text{
                        self.imageStore = (document.data()["moviearray"] as! Array<String>)
                        
                        self.getImage()

                    }
                }
            }
        }
    }
    func getImage() {
        for movie in imageStore{
            
            let newitem = CharMovieModel()
            
            
            let storeRef = Storage.storage().reference(withPath: "allmovies/\(movie).png")//document.documentID
        
            storeRef.getData(maxSize: 4 * 1024 * 1024, completion: {(data, error) in
                if let error = error {
                    print("error-------- \(error.localizedDescription)")
                    
                    return
                }
                if let data = data {
                    print("Main data\(data)")
                    newitem.image  = UIImage(data: data)!
                    self.characterProfileCollectionView.reloadData()
                }
            })
            self.listOfDataPopuler.append(newitem)
            self.characterProfileCollectionView.reloadData()
        }
    }
}
