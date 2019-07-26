//
//  NovListViewController.swift
//  OnboardingExample
//
//  Created by Irshadali Palsaniya on 09/07/19.
//  Copyright © 2019 Anitaa. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class NowListViewController: UIViewController  {

    

    @IBOutlet weak var nowListCollectionView: UICollectionView!
    
    var listOfData = [NowModel]()
    
    
    var nows = ["justice league"]
    var nowText = ["justice league"]
    var nows2 = ["justice league"]
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        viewDidLoadTask()
        readData()

    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.hidesBackButton = false
    }
    func viewDidLoadTask() {
        let itemSize = UIScreen.main.bounds.width / 3 - 10
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        layout.itemSize = CGSize(width: itemSize, height: itemSize + 50)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        
        nowListCollectionView.collectionViewLayout = layout
    }
    
    

}


//MARK:- CollectionView Delegates
extension NowListViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listOfData.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NowSubListCell", for: indexPath) as! NowSubListViewController
        cell.imageSubNow.image = listOfData[indexPath.row].image
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let viewControler : NowItemViewController = self.storyboard?.instantiateViewController(withIdentifier: "NowItemViewController") as! NowItemViewController
        
        viewControler.movieID = listOfData[indexPath.row].movieURL
        viewControler.moviename = listOfData[indexPath.row].name
        viewControler.movieImage = listOfData[indexPath.row].image
        self.navigationController?.pushViewController(viewControler, animated: true)
    }
}


//MARK:- FireBase Fuctions
extension NowListViewController{

    func readData() {
        self.nows.removeAll()
        db.collection("movies").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")

            } else {
                ReusebaleMethods.sharedInstance.showLoader()
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
                            print("error whene get Image \(error.localizedDescription)")

                            ReusebaleMethods.sharedInstance.hideLoader()
                            return
                        }
                        if let data = data {
                            print("Main data\(data)")
                            nownewitem.image  = UIImage(data: data)!
                            self.nowListCollectionView.reloadData()
                        }
                        ReusebaleMethods.sharedInstance.hideLoader()
                    })
                    
                    self.listOfData.append(nownewitem)
                    DispatchQueue.main.async {
                        self.nowListCollectionView.reloadData()

                    }
                    self.nowListCollectionView.reloadData()
                    print("Data Print:- \(document.documentID) => \(document.data())")

                }
                
            }
        }
    }
}
