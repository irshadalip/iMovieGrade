//
//  ThirdTapViewController.swift
//  OnboardingExample
//
//  Created by Irshadali Palsaniya on 10/07/19.
//  Copyright © 2019 Anitaa. All rights reserved.
//

import UIKit

class ThirdTapViewController: UIViewController,UICollectionViewDelegate, UICollectionViewDataSource {

    var nowCharacter = ["char-movie-1","char-movie-2","char-movie-3","char-movie-4","char-movie-5","char-movie-6","char-movie-7","char-movie-8","char-movie-1","char-movie-2","char-movie-3","char-movie-4","char-movie-5","char-movie-6","char-movie-7","char-movie-8"]
    
    @IBOutlet weak var characterProfileCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let itemSize = UIScreen.main.bounds.width / 4 - 10

        
        let layout = UICollectionViewFlowLayout()
        
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        layout.itemSize = CGSize(width: itemSize, height: itemSize + 50)
        
        layout.minimumInteritemSpacing = 2
        layout.minimumLineSpacing = 2
        
        characterProfileCollectionView.collectionViewLayout = layout

        // Do any additional setup after loading the view.
    }
    
    @IBAction func SettingButton(_ sender: UIButton) {
        
        let viewController: SettingViewController = self.storyboard?.instantiateViewController(withIdentifier: "SettingViewController") as! SettingViewController
        navigationController?.pushViewController(viewController, animated: true)
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return nowCharacter.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProfileCharacterCell", for: indexPath) as! ProfileCharacterCell
        
        cell.imageProfile.image = UIImage(named: nowCharacter[indexPath.row])
        
        return cell
    }
}

//MARK:- COLLECTIONVIEW ELEGATES


