//
//  IntroViewController.swift
//  iMovieGrade
//
//  Created by Irshadali Palsaniya on 24/07/19.
//  Copyright © 2019 Anitaa. All rights reserved.
//

import UIKit

class IntroViewController : UIViewController{
    
    @IBOutlet weak var introCollectionView: UICollectionView!
    @IBOutlet weak var IntroCollection: UICollectionView!
    
    @IBOutlet weak var pageButton_1: UIButton!
    @IBOutlet weak var pageButton_2: UIButton!
    @IBOutlet weak var pageButton_3: UIButton!
    var count = 0
    
    var images = [UIImage(named: "ic_onboarding_1"),UIImage(named: "ic_onboarding_2"),UIImage(named: "ic_onboarding_3")]
    var buttonimages = ["Next_icon-1","Next_icon-1","Next_icon"]
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewDidLoadTask()
    }
    func viewDidLoadTask(){
        self.navigationController?.isNavigationBarHidden = true
        self.navigationItem.leftBarButtonItem = nil
        self.navigationItem.hidesBackButton = true
        
        if UserDefaults.standard.bool(forKey: "login") == true{
            let viewController:TapViewController = self.storyboard?.instantiateViewController(withIdentifier: "TapViewController") as! TapViewController
            self.navigationController?.pushViewController(viewController, animated: true)
        }
        
        pageButton_1.setImage(UIImage(named: "Mask"), for: .normal)
        pageButton_2.setImage(UIImage(named: "Mask_NotSelected"), for: .normal)
        pageButton_3.setImage(UIImage(named: "Mask_NotSelected"), for: .normal)
    }
 
    @objc func buttonClick(sender: UIButton)  {
        if count == 0{
            count += 1
            
            let index = IndexPath.init(item: count, section: 0)
            self.IntroCollection.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            
            pageButton_1.setImage(UIImage(named: "Mask_NotSelected"), for: .normal)
            pageButton_2.setImage(UIImage(named: "Mask"), for: .normal)
            pageButton_3.setImage(UIImage(named: "Mask_NotSelected"), for: .normal)
            
        }else if count == 1{
            count += 1

            
            let index = IndexPath.init(item: count, section: 0)
            self.IntroCollection.scrollToItem(at: index, at: .centeredHorizontally, animated: true)
            
            pageButton_1.setImage(UIImage(named: "Mask_NotSelected"), for: .normal)
            pageButton_2.setImage(UIImage(named: "Mask_NotSelected"), for: .normal)
            pageButton_3.setImage(UIImage(named: "Mask"), for: .normal)
        }
        else if count == 2{
            let viewController = storyboard?.instantiateViewController(withIdentifier: "SignInViewController") as! SignInViewController
            self.navigationController?.pushViewController(viewController, animated: true)
        }
    }
    
}


//MARK:- CollectionView Delegates
extension IntroViewController : UICollectionViewDelegate, UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "IntroCollectionViewCell", for: indexPath) as! IntroCollectionViewCell
        cell.imageView.image = images[indexPath.row]
        cell.nextButton.setImage(UIImage(named: "\(buttonimages[indexPath.row])"), for: .normal)
        print(buttonimages[indexPath.row])
        
        cell.nextButton.addTarget(self, action: #selector(buttonClick(sender:)), for: .touchUpInside)
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = introCollectionView.frame.size
        return CGSize(width: size.width, height: size.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}
