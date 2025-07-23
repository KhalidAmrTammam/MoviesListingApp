//
//  RemoteDataSource.swift
//  MoviesApp
//
//  Created by Khalid Amr on 22/07/2025.
//
import Combine
class RemoteDataSource {
    
    let moviesDBService : MoviesDBService
    
    init(moviesDBService: MoviesDBService) {
        self.moviesDBService = moviesDBService
    }
    
    func getMovieList() -> AnyPublisher<MovieListResponse,Error> {
        
        return moviesDBService.getListOfMovies()
        
    }
}
