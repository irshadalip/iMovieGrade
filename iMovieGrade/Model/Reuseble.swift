//
//  Reuseble.swift
//  iMovieGrade
//
//  Created by Irshadali Palsaniya on 12/07/19.
//  Copyright © 2019 Anitaa. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase

class Reuseble {
    
//    var nows = [String].self
//    
//    let dbMovie = Firestore.firestore()
//    var listOfDataMovie = [NowModel]()
//        
//    let db = Firestore.firestore()
//    var listOfDataNow = [NowModel]()
//    
//    let dbPopuler = Firestore.firestore()
//    var listOfDataPopuler = [NowModel]()
//    
    
    
//    func readData() {
//
//        nows.removeAll()
//
//        db.collection("movies").getDocuments() { (querySnapshot, err) in
//            if let err = err {
//                print("Error getting documents: \(err)")
//
//            } else {
//                for document in querySnapshot!.documents {
//                    // most Important
//                    let nownewitem = NowModel()
//                    nownewitem.movieURL = (document.data()["url"] as! String)
//                    nownewitem.name = (document.data()["name"] as! String)
//                    // feching data
//                    let storeRef = Storage.storage().reference(withPath: "nowlist/\(nownewitem.name!).png")//document.documentID
//
//                    print("nowlist/\(nownewitem.name!).png")
//
//                    storeRef.getData(maxSize: 4 * 1024 * 1024, completion: {(data, error) in
//                        if let error = error {
//                            print("error-------- \(error.localizedDescription)")
//
//                            return
//                        }
//                        if let data = data {
//                            print("Main data\(data)")
//                            nownewitem.image  = UIImage(data: data)!
//                            self.nowsCollection.reloadData()
//                        }
//                    })
//                    //self.nows.append(nownewitem.image!)
//                    self.listOfDataNow.append(nownewitem)
//                    DispatchQueue.main.async {
//                        self.nowsCollection.reloadData()
//
//                    }
//                    self.nowsCollection.reloadData()
//                    print("Data Print:- \(document.documentID) => \(document.data())")
//
//                }
//            }
//        }
//    }
}
