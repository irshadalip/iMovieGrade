//
//  PlayVideo__2.swift
//  iMovieGrade
//
//  Created by Irshadali Palsaniya on 12/07/19.
//  Copyright © 2019 Anitaa. All rights reserved.
//

import UIKit
import YouTubePlayer
import FirebaseAuth
import Firebase

class PlayVideo__2: UIViewController {

    var url: String?
    var movieID: String?
    var moviename: String?

    let dbWatchInDatabase = Firestore.firestore()
    
    @IBOutlet weak var videoView: YouTubePlayerView!
    override func viewDidLoad() {
        super.viewDidLoad()

        //r9-DM9uBtVI
        //url = movieURL[]
        print(movieID)
        
        videoView.loadVideoID("\(movieID!)")
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.hidesBackButton = false
        
        updateLikeInDatabase()
    }
    
    func updateLikeInDatabase(){
        
        dbWatchInDatabase.collection("total").getDocuments(){ (querySnapshot, err) in
            if let err = err {
                print("Error getting documents: \(err)")
            } else {
                
                for document in querySnapshot!.documents {
                    // most Important
                    let newitem = watchModel()
                    
                    newitem.url = (document.data()["url"] as! String)
                    newitem.watch = (document.data()["watch"] as! String)
                    
                    var watchCont = 0
                    
                    if self.movieID == newitem.url{
                        watchCont = Int(newitem.watch!)! + 1
                        self.dbWatchInDatabase.collection("total").document(self.moviename!).updateData(["watch": "\(watchCont)"])
                    }
                    
                }
            }
        }
    }

}
