//
//  File.swift
//  iMovieGrade
//
//  Created by Irshadali Palsaniya on 26/07/19.
//  Copyright © 2019 Anitaa. All rights reserved.
//
import UIKit
import ImageIO

class ReusebaleMethods: UIView{

    static let sharedInstance  = ReusebaleMethods()

    lazy var transparantView : UIView = {
        let transparantView = UIView(frame: UIScreen.main.bounds)
        transparantView.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        transparantView.isUserInteractionEnabled = false
        return transparantView
    }()

    lazy var gifImage: UIImageView = {
        let gifImage = UIImageView(frame: CGRect(x: 0, y: 0, width: 200, height: 60))
        gifImage.contentMode = .scaleAspectFit
        gifImage.center = transparantView.center
        gifImage.isUserInteractionEnabled = false
        gifImage.loadGif(name: "demo")
        return gifImage
    }()

    func showLoader() {
        self.addSubview(transparantView)
        self.transparantView.addSubview(gifImage)
        self.transparantView.bringSubview(toFront: self.gifImage)
        UIApplication.shared.keyWindow?.addSubview(transparantView)
    }
    func hideLoader() {
        self.transparantView.removeFromSuperview()
    }
    func Shadow(Component : UIImageView) {
        Component.clipsToBounds = false
        Component.layer.shadowColor = UIColor.black.cgColor
        Component.layer.shadowOpacity = 0.5
        Component.layer.shadowOffset = CGSize.init(width: 5, height: 15)
        Component.layer.shadowRadius = 10
        Component.layer.shadowPath = UIBezierPath(roundedRect: Component.bounds, cornerRadius: 10).cgPath
    }
   
}
