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

class FirstTapViewController: UIViewController, UITextFieldDelegate {
    
    let dbMovie = Firestore.firestore()
    let dbNow = Firestore.firestore()
    let dbPopuler = Firestore.firestore()
    let db = Firestore.firestore()
    
    var listOfCURRENT = [NowModel]()
    var listOfDataNow = [NowModel]()
    var listOfDataPopuler = [NowModel]()
    var listOfDataMovie = [NowModel]()
    var listOfAll = [NowModel]()
    
    let profileName = Auth.auth().currentUser?.displayName

    var IsHide = false
    var movies = ["movie-1"]
    var nows = ["justice league",]
    var nowText = ["justice league"]
    var search = ["justice league","justice league"]
    var populers = ["populer-1"]
    var populerText = ["populer-1"]
    
    @IBOutlet weak var ScrollView: UIScrollView!
    @IBOutlet weak var searchText: UITextField!
    @IBOutlet weak var populerLabel: UIButton!
    @IBOutlet weak var nowlabel: UIButton!
    @IBOutlet weak var movieLabel: UILabel!
    @IBOutlet var searchBar: UISearchBar!
    @IBOutlet weak var moviesCollection: UICollectionView!
    @IBOutlet weak var nowsCollection: UICollectionView!
    @IBOutlet weak var populerCollection: UICollectionView!
    @IBOutlet weak var searchCollection: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        viewDidLoadTask()
        
        readDataMovie()
        readDataNow()
        readDataPopuler()
        AllUsers()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
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


//MARK:- Functions
extension FirstTapViewController{
    func viewDidLoadTask() {
        moviesCollection.delegate = self
        moviesCollection.dataSource = self
        nowsCollection.delegate = self
        nowsCollection.dataSource = self
        populerCollection.delegate = self
        populerCollection.dataSource = self
        searchCollection.delegate = self
        searchCollection.dataSource = self
        searchText.delegate = self
  
        let itemSize = UIScreen.main.bounds.width / 3 - 10
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        layout.itemSize = CGSize(width: itemSize, height: itemSize + 100)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        searchCollection.collectionViewLayout = layout
 
        searchBar.setImage(UIImage(named: "search_icon"), for: .search, state: .normal)
        searchBar.layoutIfNeeded()
        self.view.addSubview(searchBar)
        
        let searchTextField:UITextField = searchBar.subviews[0].subviews.last as! UITextField
        searchTextField.layer.cornerRadius = 15
        searchTextField.textAlignment = NSTextAlignment.left
        let image:UIImage = UIImage(named: "search_icon")!
        let imageView:UIImageView = UIImageView.init(image: image)
        searchTextField.leftView = nil
        searchTextField.placeholder = "search"
        searchTextField.rightView = imageView
        searchTextField.rightViewMode = UITextFieldViewMode.always
        
        
        let searchImage = UIImage(named: "search_icon")
        //addLeftImage(txtField: searchText, andImage: searchImage!)
        
        for subView in searchBar.subviews {
            for subViewInSubView in subView.subviews {
                subViewInSubView.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
            }
        }
    }
    func addLeftImage(txtField: UITextField, andImage img: UIImage) {
        let  leftImageView = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: img.size.width, height: img.size.height))
        leftImageView.image = img
        txtField.leftView = leftImageView
        txtField.leftViewMode = .always
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }
    
}

//MARK:- CollectionView Delegates
extension FirstTapViewController: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if IsHide == true{
            self.moviesCollection.isHidden = true
            self.nowsCollection.isHidden = true
            self.populerCollection.isHidden = true
            self.searchCollection.isHidden = false
            
            populerLabel.setTitle("", for: .normal)
            nowlabel.setTitle("", for: .normal)
        }
        else{
            self.moviesCollection.isHidden = false
            self.nowsCollection.isHidden = false
            self.populerCollection.isHidden = false
            self.searchCollection.isHidden = true
            
            populerLabel.setTitle("Populer", for: .normal)
            nowlabel.setTitle("Now", for: .normal)
            //movieLabel.text = "MOVIES"
        }
        
        if IsHide == false {
            if collectionView == self.moviesCollection {
                return listOfDataMovie.count
            }
            else if collectionView == self.nowsCollection {
                return listOfDataNow.count
                
            }
            else{
                return listOfDataPopuler.count
            }
        }
        else{
            return listOfCURRENT.count
        }
    }
   
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

         if IsHide == false {
            if collectionView == self.moviesCollection {
                
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCell", for: indexPath) as! MoviesCollectionViewCell
                cell.imageMovie.image = listOfDataMovie[indexPath.row].image
                return cell
            }
            else if collectionView == self.nowsCollection {
                let cell = nowsCollection.dequeueReusableCell(withReuseIdentifier: "NowCell", for: indexPath) as! NowCollectionViewCell
                cell.nowimageView.image = listOfDataNow[indexPath.row].image
                cell.nowLabel.text = listOfDataNow[indexPath.row].name

                return cell
                
            }
            else {
                let cell = populerCollection.dequeueReusableCell(withReuseIdentifier: "PopulerCell", for: indexPath) as! PopulerCollectionViewCell
                cell.imagePopuler.image = listOfDataPopuler[indexPath.row].image
                cell.populerLabel.text = listOfDataPopuler[indexPath.row].name
                
                return cell
            }
        }
        else {
            let cell = searchCollection.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as! SearchCollectionViewCell
            cell.searchImage.image = listOfCURRENT[indexPath.row].image
            cell.searchLabel.text = listOfCURRENT[indexPath.row].name
            return cell
        }
        
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if IsHide == false {
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
        }
        else {
            let viewControler : NowItemViewController = self.storyboard?.instantiateViewController(withIdentifier: "NowItemViewController") as! NowItemViewController
            viewControler.movieID = listOfCURRENT[indexPath.row].movieURL
            viewControler.moviename = listOfCURRENT[indexPath.row].name
            viewControler.movieImage = listOfCURRENT[indexPath.row].image
            self.navigationController?.pushViewController(viewControler, animated: true)
            
            
        }
    }
}

//MARK:- FireBase Fuctions
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
                    self.listOfCURRENT.append(nownewitem)
                    self.listOfAll = self.listOfCURRENT
                    
                    self.nowsCollection.reloadData()
                    self.searchCollection.reloadData()
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
                    let populernewitem = NowModel()
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
                            self.searchCollection.reloadData()
                        }
                    })
                    //self.nows.append(nownewitem.image!)
                    self.listOfDataPopuler.append(populernewitem)
                    self.listOfCURRENT.append(populernewitem)
                    self.listOfAll = self.listOfCURRENT
                  
                    self.populerCollection.reloadData()
                    self.searchCollection.reloadData()
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
                    let movienewitem = NowModel()
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
    func creatUser() {
        var ref: DocumentReference? = nil
        
        
        // Add a new document with a generated ID
        ref = db.collection("allUsers").addDocument(data: [ "username": "\(profileName!)"])
        { err in
            if let err = err {
                print("Error adding document: \(err)")
            } else {
                print("Document added with ID: \(ref!.documentID)")
            }
        }
        
        
    }
    func AllUsers(){
        
        db.collection("allUsers").getDocuments(){ (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                var haveUser = false
                
                for document in querySnapshot!.documents {
                    
                    let doc = document.data()
                    // most Important
                    let newitem = AllUsersModel()
                    newitem.username = (doc["username"] as! String)

                    if self.profileName == newitem.username{
  
                        haveUser = true
                    }
                }
                if haveUser == false{
                    self.creatUser()
                }
            }
        }
    }
}


//MARK:- TaxtField-Delegate   // # Not Currently In Use This Extention
extension FirstTapViewController{
    
    func textFieldShouldClear(_ textField: UITextField) -> Bool{
        searchText.resignFirstResponder()
        searchText.text = ""
        self.listOfCURRENT.removeAll()
        for str in listOfAll{
            listOfCURRENT.append(str)
            searchCollection.reloadData()
        }
        return true
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        
        if searchText.text?.count == 0{
            IsHide = false
            searchCollection.reloadData()
            nowsCollection.reloadData()
            populerCollection.reloadData()
        }
        else{
            IsHide = true
            searchCollection.reloadData()
            nowsCollection.reloadData()
            populerCollection.reloadData()
        }
        if searchText.text?.count != 0 {self.listOfCURRENT.removeAll()
            for str in listOfAll{
                let range = str.name?.range(of: textField.text!, options: .caseInsensitive, range: nil, locale: nil)
                if range != nil{
                    self.listOfCURRENT.append(str)
                    searchCollection.reloadData()
                }
            }
            
        }
        else{
        }
        searchCollection.reloadData()
        
        return true
    }
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool{
        return true
    }
}


//MARK:- SearchBar Delegate
extension FirstTapViewController: UISearchBarDelegate{

    func setUpSearchBar() {
        searchBar.delegate = self
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
        
        if searchText.isEmpty == true{
            IsHide = false
            searchCollection.reloadData()
            nowsCollection.reloadData()
            populerCollection.reloadData()
            
            for subView in searchBar.subviews {
                for subViewInSubView in subView.subviews {
                    subViewInSubView.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
                }
            }
        }
        else{
            IsHide = true
            searchCollection.reloadData()
            nowsCollection.reloadData()
            populerCollection.reloadData()
            
            for subView in searchBar.subviews {
                for subViewInSubView in subView.subviews {
                    subViewInSubView.backgroundColor = UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
                }
            }
        }
        //============
        guard !searchText.isEmpty else {listOfCURRENT = listOfAll
            //IsHide = false
            searchCollection.reloadData()
            return}
        listOfCURRENT = listOfAll.filter({nowText -> Bool in
            nowText.name!.uppercased().contains(searchText.uppercased())
            
        })
        searchCollection.reloadData()
    }
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int){
        for subView in searchBar.subviews {
            for subViewInSubView in subView.subviews {
                subViewInSubView.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
            }
        }
    }
}
