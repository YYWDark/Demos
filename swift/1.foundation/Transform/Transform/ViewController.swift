//
//  ViewController.swift
//  Transform
//
//  Created by wyy on 2017/6/1.
//  Copyright © 2017年 wyy. All rights reserved.
//

import UIKit

class MediaItem {
    var name:String
    init(name:String) {
        self.name = name
    }
}

class Movie:MediaItem {
    var director:String
    init(name: String, director:String) {
        self.director = director
        super.init(name:name)
    }
}

class Song:MediaItem {
    var artist:String
    init(name: String,artist:String) {
        self.artist = artist
        super.init(name: name)
    }
}

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let library = [
            Movie(name: "Casablanca", director: "Michael Curtiz"),
            Song(name: "Blue Suede Shoes", artist: "Elvis Presley"),
            Movie(name: "Citizen Kane", director: "Orson Welles"),
            Song(name: "The One And Only", artist: "Chesney Hawkes"),
            Song(name: "Never Gonna Give You Up", artist: "Rick Astley")
        ]
        
        var movieCount = 0
        var songCount = 0
        
        for value in library {
            if value is Movie {
                movieCount += 1
            }else {
                songCount += 1
            }
        }
        print("movieCount is \(movieCount), songCount is \(songCount)")
        
     //向下转型
        for item in library {
            if let movie = item as? Movie {
                print("Movie: '\(movie.name)', dir. \(movie.director)")
            }else if let song = item as? Song {
                print("Song: '\(song.name)', by \(song.artist)")
            }
        }
    }
    //Any和AnyObject的类型转换
    var things = [Any]()
    
//    things.append(0)
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

