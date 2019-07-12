//
//  PlayVideo__2.swift
//  iMovieGrade
//
//  Created by Irshadali Palsaniya on 12/07/19.
//  Copyright © 2019 Anitaa. All rights reserved.
//

import UIKit
import YouTubePlayer

class PlayVideo__2: UIViewController {

    var url: String?
    var movieID: String?

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
    }

}
