//
//  MovieListR.swift
//  MoviesApp
//
//  Created by Khalid Amr on 22/07/2025.
//

struct MovieListResponse : Codable {
    
    let page : Int
    let results : [Movies]
    var total_pages : Int = 0
    var total_results : Int = 0
    
}

struct Movies : Codable {
    
    var adult : Bool = true
    let backdrop_path : String
    let genre_ids : [Int]
    var id : Int = 0
    let original_language : String
    let original_title : String
    let overview : String
    var popularity : Double = 0
    let poster_path : String
    let release_date : String
    let title : String
    var video : Bool = true
    var vote_average : Double = 0
    var vote_count : Int = 0

}
