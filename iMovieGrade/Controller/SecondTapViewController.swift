//
//  SecondTapViewController.swift
//  iMovieGrade
//
//  Created by Irshadali Palsaniya on 12/07/19.
//  Copyright © 2019 Anitaa. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class SecondTapViewController: UIViewController {
    
    var movies = ["populer"]

    @IBOutlet weak var movieSubCollectionView: UICollectionView!
    let dbMovie = Firestore.firestore()
    var listOfDataMovie = [MovieModel]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
        viewDidLoadTask()
        readDataMovie()

    }
    
    func viewDidLoadTask(){
        let itemSize = UIScreen.main.bounds.width / 3 - 10
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        layout.itemSize = CGSize(width: itemSize, height: itemSize + 80)
        layout.minimumInteritemSpacing = 2
        layout.minimumLineSpacing = 2
        
        movieSubCollectionView.collectionViewLayout = layout
    }
    
}

//MARK:- Collection Delegates
extension SecondTapViewController : UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listOfDataMovie.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieSubListCell", for: indexPath) as! MovieSubCollectionViewCell
        cell.imageSubMovie.image = listOfDataMovie[indexPath.row].image
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        // Not Given this Scree For makeing
        /*        let viewControler : NowItemViewController = self.storyboard?.instantiateViewController(withIdentifier: "NowItemViewController") as! NowItemViewController
                viewControler.movieID = listOfDataMovie[indexPath.row].movieURL
                viewControler.moviename = listOfDataMovie[indexPath.row].name
                viewControler.movieImage = listOfDataMovie[indexPath.row].image
                self.navigationController?.pushViewController(viewControler, animated: true)*/
 
    }
}

//MARK:- FireBase Fuctions
extension SecondTapViewController{
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
                    let storeRef = Storage.storage().reference(withPath: "moviesublist/\(movienewitem.name!).png")//document.documentID
                    
                    print("moviesublist/\(movienewitem.name!).png")
                    
                    storeRef.getData(maxSize: 4 * 1024 * 1024, completion: {(data, error) in
                        if let error = error {
                            print("error-------- \(error.localizedDescription)")
                            
                            return
                        }
                        if let data = data {
                            print("Main data\(data)")
                            movienewitem.image  = UIImage(data: data)!
                            self.movieSubCollectionView.reloadData()
                        }
                    })
                    //self.nows.append(nownewitem.image!)
                    self.listOfDataMovie.append(movienewitem)
                    DispatchQueue.main.async {
                        self.movieSubCollectionView.reloadData()
                        
                    }
                    self.movieSubCollectionView.reloadData()
                    print("Data Print:- \(document.documentID) => \(document.data())")
                    
                }
            }
        }
    }
}
