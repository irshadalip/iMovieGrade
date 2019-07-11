//
//  FirstTapViewController.swift
//  OnboardingExample
//
//  Created by Irshadali Palsaniya on 09/07/19.
//  Copyright © 2019 Anitaa. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class FirstTapViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    let db = Firestore.firestore()
    var listOfData = [MoviesModel]()
    
    var movies = ["movie-1","movie-2","movie-3","movie-4","movie-5","movie-6"]
    var nows = ["justice league","pampage","hostiles","jigsaw","spiderman homecoming","thor ragnarok","rememory","hotel transylvania"]
    var nowText = ["justice league","pampage","hostiles","jigsaw","spiderman homecoming","thor ragnarok","rememory","hotel transylvania"]

    
    var populers = ["populer-1","populer-2","populer-3","populer-4","populer-5","populer-6","populer-7","populer-8","populer-9","populer-10","populer-11"]
    var populerText = ["populer-1","populer-2","populer-3","populer-4","populer-5","populer-6","populer-7","populer-8","populer-9","populer-10","populer-11"]
    
    @IBOutlet weak var moviesCollection: UICollectionView!
    @IBOutlet weak var nowsCollection: UICollectionView!
    @IBOutlet weak var populerCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        moviesCollection.delegate = self
        moviesCollection.dataSource = self
        
        nowsCollection.delegate = self
        nowsCollection.dataSource = self
        
        populerCollection.delegate = self
        populerCollection.dataSource = self
        // Do any additional setup after loading the view.
        
        readData()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        //self.navigationItem.leftBarButtonItem = nil
        //self.navigationItem.hidesBackButton = true
    }
    
    @IBAction func nowButton(_ sender: UIButton) {
       
        let viewController: NowListViewController = self.storyboard?.instantiateViewController(withIdentifier: "NowListViewController") as! NowListViewController
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    @IBAction func populerButton(_ sender: UIButton) {
        let viewController: PopulerListViewController = self.storyboard?.instantiateViewController(withIdentifier: "PopulerListViewController") as! PopulerListViewController
        self.navigationController?.pushViewController(viewController, animated: true)
    }
}

//MARK:- COLLECTIONVIEW ELEGATES
extension FirstTapViewController{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == self.moviesCollection {
            return movies.count
        }
        else if collectionView == self.nowsCollection {
            return listOfData.count
        }
        else{
            return populers.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.moviesCollection {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MoviesCollectionViewCell
            
            cell.imageMovie.image = UIImage(named: movies[indexPath.row])

            return cell
        }
        else if collectionView == self.nowsCollection {
//            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NowCell", for: indexPath) as! NowCollectionViewCell
//
//            cell.nowimageView.image = UIImage(named: nows[indexPath.row])
//            cell.nowLabel.text = nowText[indexPath.row]
//
//            return cell
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NowCell", for: indexPath) as! NowCollectionViewCell
            cell.nowimageView.image = listOfData[indexPath.row].image
            cell.nowLabel.text = listOfData[indexPath.row].name
            
            return cell
            
        }
        else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopulerCell", for: indexPath) as! PopulerCollectionViewCell
            
            cell.imagePopuler.image = UIImage(named: populers[indexPath.row])
            cell.populerLabel.text = populerText[indexPath.row]
            
            return cell
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if collectionView == self.moviesCollection {
            
        }
        else if collectionView == self.nowsCollection {
            let viewControler : NowItemViewController = self.storyboard?.instantiateViewController(withIdentifier: "NowItemViewController") as! NowItemViewController
            
            viewControler.movieID = listOfData[indexPath.row].movieURL
            //let temp = listOfData.name
            self.navigationController?.pushViewController(viewControler, animated: true)
            
        }
        else {
         
        }
        
    }
}

extension FirstTapViewController{
    
    func readData() {
        self.nows.removeAll()
        db.collection("movies").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                
            } else {
                for document in querySnapshot!.documents {
                    // most Important
                    let newitem = MoviesModel()
                    newitem.movieURL = (document.data()["url"] as! String)
                    newitem.name = (document.data()["name"] as! String)
                    // feching data
                    let storeRef = Storage.storage().reference(withPath: "nowlist/\(newitem.name!).png")//document.documentID
                    
                    print("nowlist/\(newitem.name!).png")
                    
                    storeRef.getData(maxSize: 4 * 1024 * 1024, completion: {(data, error) in
                        if let error = error {
                            print("error-------- \(error.localizedDescription)")
                            
                            return
                        }
                        if let data = data {
                            print("Main data\(data)")
                            newitem.image  = UIImage(data: data)!
                            self.nowsCollection.reloadData()
                        }
                    })
                    //self.nows.append(newitem.image!)
                    self.listOfData.append(newitem)
                    DispatchQueue.main.async {
                        self.nowsCollection.reloadData()
                        
                    }
                    self.nowsCollection.reloadData()
                    print("Data Print:- \(document.documentID) => \(document.data())")
                    
                }
            }
        }
    }
}
