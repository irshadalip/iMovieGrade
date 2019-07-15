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
    var movieURL : String? //now["r9-DM9uBtVI", "coOKvrsmQiI","vJz5l5ru7ws","rF5viX42K3s","39udgGPyYMg","ue80QwXMRHg","n6ihJIjVGLo","Ku52zNnft8k"]
    var index: Int?
    //populer[====1arrival=ZLO4X6UI8OY===2the dark knight=EXeTwQWrcwY=====3the expanse=kQuTAPWJxNo=====4high castle=zzayf9GpXCI=======5 mother=XpICoc65uh0=======6a ghost story=c_3NMtxeyfk========7tomb raider=8ndhidEmUbI=========8 10 cloverfield lane=M9cTqkXTl7s=======9iron man=Ke1Y3P9D0Bc========10salvation=A34OV9uYZWg=====11the hunger games=EAzGXqJSDJ8]
}
//struct Movies {
//
//    var movieURL = ["r9-DM9uBtVI", "coOKvrsmQiI","vJz5l5ru7ws","rF5viX42K3s","39udgGPyYMg","ue80QwXMRHg","n6ihJIjVGLo","Ku52zNnft8k"]
//}
class PopulerModel {
    var name : String?
    var image : UIImage?
    var movieURL : String?
    var index: Int?
}

class MovieModel {
    var name : String?
    var image : UIImage?
    var movieURL : String?
    var index: Int?
}
class CharacterModel {
    var name : String?
    var image : UIImage?
    var movieURL : String?
    var index: Int?
    var character: Array<String>?
}
class ReviewModel {
    var discription : String?
    //var image : UIImage?
    var movieURL : String?
    //var index: Int?
}
