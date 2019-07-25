//
//  MovieNameUrl.swift
//  iMovieGrade
//
//  Created by Irshadali Palsaniya on 11/07/19.
//  Copyright © 2019 Anitaa. All rights reserved.
//

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
    var statedic : [String:Any]?
    var watch : String?
    
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


class AllUsersModel {
    var username : String?
}
