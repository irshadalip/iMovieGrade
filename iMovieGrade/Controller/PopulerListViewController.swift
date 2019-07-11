//
//  PopulerListViewController.swift
//  OnboardingExample
//
//  Created by Irshadali Palsaniya on 09/07/19.
//  Copyright © 2019 Anitaa. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class PopulerListViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{

    @IBOutlet weak var populerCollectionView: UICollectionView!
    
    let db = Firestore.firestore()
    var listOfData = [MoviesModel]()
    
    var populers = ["arrival","pampage","hostiles","jigsaw","spiderman homecoming","thor ragnarok","rememory","hotel transylvania"]
    var populerText = ["justice league","pampage","hostiles","jigsaw","spiderman homecoming","thor ragnarok","rememory","hotel transylvania"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let itemSize = UIScreen.main.bounds.width / 3 - 10
        
        let layout = UICollectionViewFlowLayout()
        
        layout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
        
        layout.itemSize = CGSize(width: itemSize, height: itemSize + 50)
        
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        
        populerCollectionView.collectionViewLayout = layout
        
        readData()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.hidesBackButton = false
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listOfData.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
//        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopulerSubListCell", for: indexPath) as! PopulerSubListViewController
//
//        cell.iamgeSubPopuler.image = UIImage(named: populers[indexPath.row])
//
//        return cell
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopulerSubListCell", for: indexPath) as! PopulerSubListViewController
        cell.iamgeSubPopuler.image = listOfData[indexPath.row].image
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let viewControler : NowItemViewController = self.storyboard?.instantiateViewController(withIdentifier: "NowItemViewController") as! NowItemViewController
//
//        self.navigationController?.pushViewController(viewControler, animated: true)
    }

}

extension PopulerListViewController{
    
    func readData() {
        self.populers.removeAll()
        db.collection("popular").getDocuments() { (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
                
            } else {
                for document in querySnapshot!.documents {
                    // most Important
                    let newitem = MoviesModel()
                    newitem.movieURL = (document.data()["url"] as! String)
                    newitem.name = (document.data()["name"] as! String)
                    // feching data
                    let storeRef = Storage.storage().reference(withPath: "populerlist/\(newitem.name!).png")//document.documentID
                    
                    print("nowlist/\(newitem.name!).png")
                    
                    storeRef.getData(maxSize: 4 * 1024 * 1024, completion: {(data, error) in
                        if let error = error {
                            print("error-------- \(error.localizedDescription)")
                            
                            return
                        }
                        if let data = data {
                            print("Main data\(data)")
                            newitem.image  = UIImage(data: data)!
                            self.populerCollectionView.reloadData()
                        }
                    })
                    //self.nows.append(newitem.image!)
                    self.listOfData.append(newitem)
                    DispatchQueue.main.async {
                        self.populerCollectionView.reloadData()
                        
                    }
                    self.populerCollectionView.reloadData()
                    print("Data Print:- \(document.documentID) => \(document.data())")
                    
                }
            }
        }
    }
}

