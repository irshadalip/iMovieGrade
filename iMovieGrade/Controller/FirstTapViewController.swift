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

class FirstTapViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {
    
    let dbMovie = Firestore.firestore()
    var listOfDataMovie = [MovieModel]()
    
    let dbNow = Firestore.firestore()
    var listOfDataNow = [NowModel]()
    var listOfCURRENT = [NowModel]()
    
    let dbPopuler = Firestore.firestore()
    var listOfDataPopuler = [PopulerModel]()
    
    var IsHide = false
    
    
    var movies = ["movie-1"]
    var nows = ["justice league",]
    var nowText = ["justice league"]

    
    var populers = ["populer-1"]
    var populerText = ["populer-1"]
    
    @IBOutlet weak var populerLabel: UIButton!
    @IBOutlet weak var nowlabel: UIButton!
    @IBOutlet weak var movieLabel: UILabel!
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet weak var moviesCollection: UICollectionView!
    @IBOutlet weak var nowsCollection: UICollectionView!
    @IBOutlet weak var populerCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //searchBar.delegate = self

        moviesCollection.delegate = self
        moviesCollection.dataSource = self
        
        nowsCollection.delegate = self
        nowsCollection.dataSource = self
        
        populerCollection.delegate = self
        populerCollection.dataSource = self
        // Do any additional setup after loading the view.
        
        readDataMovie()
        readDataNow()
        readDataPopuler()

    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        //self.navigationItem.leftBarButtonItem = nil
        //self.navigationItem.hidesBackButton = true
    }
    func setUpSearchBar() {
        
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        
    }
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int){
        
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
        
        if IsHide == true{
            self.moviesCollection.isHidden = true
            self.nowsCollection.isHidden = true
            self.populerCollection.isHidden = true
            
            populerLabel.setTitle("", for: .normal)
            nowlabel.setTitle("", for: .normal)
            movieLabel.text = ""
        }
        else{
            self.moviesCollection.isHidden = false
            self.nowsCollection.isHidden = false
            self.populerCollection.isHidden = false
            
            populerLabel.setTitle("Populer", for: .normal)
            nowlabel.setTitle("Now", for: .normal)
            movieLabel.text = "MOVIES"
        }
        
        if collectionView == self.moviesCollection {
            return listOfDataMovie.count
        }
        else if collectionView == self.nowsCollection {
            return listOfDataNow.count
        }
        else{
            return listOfDataPopuler.count
        }
        if IsHide == true {
            return listOfDataNow.count
        }
    }
   
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

            if collectionView == self.moviesCollection {
                
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MoviesCollectionViewCell
                cell.imageMovie.image = listOfDataMovie[indexPath.row].image
                return cell
            }
            else if collectionView == self.nowsCollection {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NowCell", for: indexPath) as! NowCollectionViewCell
                cell.nowimageView.image = listOfDataNow[indexPath.row].image
                cell.nowLabel.text = listOfDataNow[indexPath.row].name
                
                return cell
                
            }
            else {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopulerCell", for: indexPath) as! PopulerCollectionViewCell
                cell.imagePopuler.image = listOfDataPopuler[indexPath.row].image
                cell.populerLabel.text = listOfDataPopuler[indexPath.row].name
                
                return cell
            }
        if IsHide == true {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as! SearchCollectionViewCell
//            cell.searchIname = listOfCURRENT[indexPath.row].image
//            cell.searchLabel = listOfCURRENT[indexPath.row].name
            
            return cell
        }
    
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
            if collectionView == self.moviesCollection {
                //            let viewControler : NowItemViewController = self.storyboard?.instantiateViewController(withIdentifier: "NowItemViewController") as! NowItemViewController
                //
                //            viewControler.movieID = listOfDataMovie[indexPath.row].movieURL
                //            viewControler.moviename = listOfDataMovie[indexPath.row].name
                //            viewControler.movieImage = listOfDataMovie[indexPath.row].image
                //            self.navigationController?.pushViewController(viewControler, animated: true)
                
            }
            else if collectionView == self.nowsCollection {
                let viewControler : NowItemViewController = self.storyboard?.instantiateViewController(withIdentifier: "NowItemViewController") as! NowItemViewController
                viewControler.movieID = listOfDataNow[indexPath.row].movieURL
                viewControler.moviename = listOfDataNow[indexPath.row].name
                viewControler.movieImage = listOfDataNow[indexPath.row].image
                self.navigationController?.pushViewController(viewControler, animated: true)
                
            }
            else {
                let viewControler : NowItemViewController = self.storyboard?.instantiateViewController(withIdentifier: "NowItemViewController") as! NowItemViewController
                
                viewControler.movieID = listOfDataPopuler[indexPath.row].movieURL
                viewControler.moviename = listOfDataPopuler[indexPath.row].name
                viewControler.movieImage = listOfDataPopuler[indexPath.row].image
                self.navigationController?.pushViewController(viewControler, animated: true)
                
            }
        if IsHide == true {
            let viewControler : NowItemViewController = self.storyboard?.instantiateViewController(withIdentifier: "NowItemViewController") as! NowItemViewController
            
            viewControler.movieID = listOfDataPopuler[indexPath.row].movieURL
            viewControler.moviename = listOfDataPopuler[indexPath.row].name
            viewControler.movieImage = listOfDataPopuler[indexPath.row].image
            self.navigationController?.pushViewController(viewControler, animated: true)
        }

        
    }
}

extension FirstTapViewController{
    
    func readDataNow() {
        self.nows.removeAll()
        
        dbNow.collection("movies").getDocuments() { (querySnapshot, err) in

            if let err = err {
                print("Error getting documents: \(err)")
                
            } else {
                for document in querySnapshot!.documents {
                    // most Important
                    let nownewitem = NowModel()
                    nownewitem.movieURL = (document.data()["url"] as! String)
                    nownewitem.name = (document.data()["name"] as! String)
                    // feching data
                    let storeRef = Storage.storage().reference(withPath: "nowlist/\(nownewitem.name!).png")//document.documentID
                    
                    print("nowlist/\(nownewitem.name!).png")
                    
                    storeRef.getData(maxSize: 4 * 1024 * 1024, completion: {(data, error) in
                        if let error = error {
                            print("error-------- \(error.localizedDescription)")
                            
                            return
                        }
                        if let data = data {
                            print("Main data\(data)")
                            nownewitem.image  = UIImage(data: data)!
                            self.nowsCollection.reloadData()
                        }
                    })
                    //self.nows.append(nownewitem.image!)
                    self.listOfDataNow.append(nownewitem)
                    self.listOfCURRENT = self.listOfDataNow
                    
                    DispatchQueue.main.async {
                        self.nowsCollection.reloadData()
                        
                    }
                    self.nowsCollection.reloadData()
                    print("Data Print:- \(document.documentID) => \(document.data())")
                    
                }
            }
        }
    }
    func readDataPopuler() {
        self.populers.removeAll()
        
        dbPopuler.collection("popular").getDocuments() { (querySnapshot, err) in
            
            if let err = err {
                print("Error getting documents: \(err)")
                
            } else {
                for document in querySnapshot!.documents {
                    // most Important
                    let populernewitem = PopulerModel()
                    populernewitem.movieURL = (document.data()["url"] as! String)
                    populernewitem.name = (document.data()["name"] as! String)
                    // feching data
                    let storeRef = Storage.storage().reference(withPath: "populerlist/\(populernewitem.name!).png")//document.documentID
                    
                    print("populerlist/\(populernewitem.name!).png")
                    
                    storeRef.getData(maxSize: 4 * 1024 * 1024, completion: {(data, error) in
                        if let error = error {
                            print("error-------- \(error.localizedDescription)")
                            
                            return
                        }
                        if let data = data {
                            print("Main data\(data)")
                            populernewitem.image  = UIImage(data: data)!
                            self.populerCollection.reloadData()
                        }
                    })
                    //self.nows.append(nownewitem.image!)
                    self.listOfDataPopuler.append(populernewitem)
                    DispatchQueue.main.async {
                        self.populerCollection.reloadData()
                        
                    }
                    self.populerCollection.reloadData()
                    print("Data Print:- \(document.documentID) => \(document.data())")
                    
                }
            }
        }
    }
    func readDataMovie() {
        self.movies.removeAll()
        
        dbMovie.collection("moviesbig").getDocuments() { (querySnapshot, err) in
            
            if let err = err {
                print("Error getting documents: \(err)")
                
            } else {
                for document in querySnapshot!.documents {
                    // most Important
                    let movienewitem = MovieModel()
                    movienewitem.movieURL = (document.data()["url"] as! String)
                    movienewitem.name = (document.data()["name"] as! String)
                    // feching data
                    let storeRef = Storage.storage().reference(withPath: "movielist/\(movienewitem.name!).png")//document.documentID
                    
                    print("movielist/\(movienewitem.name!).png")
                    
                    storeRef.getData(maxSize: 4 * 1024 * 1024, completion: {(data, error) in
                        if let error = error {
                            print("error-------- \(error.localizedDescription)")
                            
                            return
                        }
                        if let data = data {
                            print("Main data\(data)")
                            movienewitem.image  = UIImage(data: data)!
                            self.moviesCollection.reloadData()
                        }
                    })
                    //self.nows.append(nownewitem.image!)
                    self.listOfDataMovie.append(movienewitem)
                    DispatchQueue.main.async {
                        self.populerCollection.reloadData()
                        
                    }
                    self.populerCollection.reloadData()
                    print("Data Print:- \(document.documentID) => \(document.data())")
                    
                }
            }
        }
    }
}
