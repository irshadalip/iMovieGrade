//
//  MovieNameUrl.swift
//  iMovieGrade
//
//  Created by Irshadali Palsaniya on 11/07/19.
//  Copyright © 2019 Anitaa. All rights reserved.
//
//Now Movie Url
//    var movieURL = ["r9-DM9uBtVI", "coOKvrsmQiI","vJz5l5ru7ws","rF5viX42K3s","39udgGPyYMg","ue80QwXMRHg","n6ihJIjVGLo","Ku52zNnft8k"]
//populer====>
//1.  arrival=
//        ZLO4X6UI8OY===
//2.  the dark knight=
//        EXeTwQWrcwY
//3.  the expanse
//        kQuTAPWJxNo
//4.      high castle
//        zzayf9GpXCI
//5.      mother
//        XpICoc65uh0
//6.      a ghost story
//        c_3NMtxeyfk
//7.      tomb raider
//        8ndhidEmUbI
//8.      10 cloverfield lane
//        M9cTqkXTl7s
//9.      iron man
//        Ke1Y3P9D0Bc
//10.     salvation
//        A34OV9uYZWg
//11.     the hunger games
//        EAzGXqJSDJ8]

import UIKit


class NowModel {
    
    var name : String?
    var image : UIImage?
    var description : String?
    var movieURL : String?
    var index: Int?
    
}


class PopulerModel {
    var name : String?
    var image : UIImage?
    var description : String?
    var movieURL : String?
    var index: Int?
    var category: String?
}


class MovieModel {
    var name : String?
    var image : UIImage?
    var movieURL : String?
    var description : String?
    var index: Int?
}


class CharacterModel {
    var name : String?
    var image : UIImage?
    var movieURL : String?
    var index: Int?
    var nameArray : Array<String>?
    var character: String?
    var imageArray : Array<String>?
}


class ReviewModel {
    var discription : String?
    //var image : UIImage?
    var movieURL : String?
    var userimage : String?
    var profilename : String?
}


class commentModel {
    var likes : String?
    var name : String?
}


class watchModel {
    var count : String?
    var like : String?
    var url : String?
    var state : String?
}


class CharMovieModel {
    var name : String?
    var moviearray = [String]()
    
    var image : UIImage?
    var description : String?
    var movieURL : String?
    var index: Int?
}

class FavoriteModel {
    var name : String?
    var movieArray : Array<String>?
    
    var count : String?
    var like : String?
    var url : String?
    var state : String?
    var dic : Dictionary<String, String>?
}
