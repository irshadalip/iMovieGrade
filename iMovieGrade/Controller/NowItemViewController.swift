//
//  NowItemViewController.swift
//  OnboardingExample
//
//  Created by Irshadali Palsaniya on 10/07/19.
//  Copyright © 2019 Anitaa. All rights reserved.
//

import UIKit

class NowItemViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{

    var movieID : String?
    
    
    @IBOutlet weak var likeButton_1: UIButton!
    @IBOutlet weak var likeButton_2: UIButton!
    @IBOutlet weak var likeButton_3: UIButton!
    
    var nowCharacter = ["char-1","char-2","char-3","char-1","char-2","char-3","char-1","char-2","char-3","char-1","char-2","char-3","char-1","char-2","char-3"]
    var nowCharacterText = ["char-1","char-2","char-3","char-1","char-2","char-3","char-1","char-2","char-3","char-1","char-2","char-3","char-1","char-2","char-3"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.hidesBackButton = true
//        
//        likeButton_1.layer.cornerRadius = likeButton_1.frame.size.height / 2
//        likeButton_2.layer.cornerRadius = likeButton_2.frame.height / 2
//        likeButton_3.layer.cornerRadius = likeButton_3.frame.height / 2
    }
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.hidesBackButton = true
    }
    
    @IBAction func backButton(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
        
    }
    @IBAction func playMovieButton(_ sender: UIButton) {
        
        let viewControler : PlayVideoViewController = self.storyboard?.instantiateViewController(withIdentifier: "PlayVideoViewController") as! PlayVideoViewController
        
        viewControler.movieID = movieID
        self.navigationController?.pushViewController(viewControler, animated: true)
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nowCharacter.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NowCharacterViewCell", for: indexPath) as! NowCharacterViewCell
        
        cell.imageCharacter.image = UIImage(named: nowCharacterText[indexPath.row])
        cell.nowCharacterText.text = nowCharacterText[indexPath.row]
        
        return cell
    }

}
