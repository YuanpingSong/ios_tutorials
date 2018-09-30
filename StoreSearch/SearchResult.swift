//
//  SearchResult.swift
//  StoreSearch
//
//  Created by imac on 2017/7/17.
//  Copyright © 2017年 songyp. All rights reserved.
//

class SearchResult {
    var name = ""
    var artistName = ""
    var artworkSmallURL = ""
    var artworkLargeURL = ""
    var storeURL = ""
    var kind = ""
    var currency = ""
    var price = 0.0
    var genre = ""
    
    func kindForDisplay() -> String {
        switch kind {
        case "album": return "Album"
        case "audiobook": return "Audio Book"
        case "book" : return "Book"
        case "ebook" : return "E-book"
        case "feature-movie" : return "Movie"
        case "music-video" : return "Music Video"
        case "podcast" : return "Podcast"
        case "software" : return "App"
        case "song" : return "Song"
        case "tv-episode" : return "TV Episode"
        default: return kind
            
        }
    }
}

func < (lhs: SearchResult, rhs: SearchResult) -> Bool {
    return lhs.name.localizedStandardCompare(rhs.name) == .orderedAscending
}
