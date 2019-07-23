//
//  PlayVideoViewController.swift
//  iMovieGrade
//
//  Created by Irshadali Palsaniya on 11/07/19.
//  Copyright © 2019 Anitaa. All rights reserved.
//

import UIKit
import YouTubePlayer

class PlayVideoViewController: UIViewController {
    
    var url: String?
    var movieID: String?
  

    @IBOutlet var playView: YouTubePlayerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //r9-DM9uBtVI
        //url = movieURL[]
        //print(movieID)
        
        playView.loadVideoID("\(movieID!)")    //r9-DM9uBtVI
    }
}
