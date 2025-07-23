//
//  MoviesDBService.swift
//  MoviesApp
//
//  Created by Khalid Amr on 22/07/2025.
//
import Combine
import Foundation

class MoviesDBService {
    
    func getListOfMovies() -> AnyPublisher<MovieListResponse,Error> {
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/popular?api_key=1040d70be5bcb99e218d76c5d2137c83&language=en-US&page=1")!
        return URLSession.shared.dataTaskPublisher(for: url)
            .map{$0.data}
            .decode(type: MovieListResponse.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
        
    }
}
