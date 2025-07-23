//
//  GetMovieListDB.swift
//  MoviesApp
//
//  Created by Khalid Amr on 22/07/2025.
//
import Combine

protocol GetMovieListDBUseCaseProtocol {
    func getMovieList()->AnyPublisher<[Movies],Error>
}

class GetMovieListDBUseCase : GetMovieListDBUseCaseProtocol {
    
    let movieListRepoProtocol : MoviesDPRepoProtocols
    
    init(movieListRepoProtocol: MoviesDPRepoProtocols) {
        self.movieListRepoProtocol = movieListRepoProtocol
    }
    
    func getMovieList()->AnyPublisher<[Movies],Error> {
        return movieListRepoProtocol.getTheMovieList()
            .map{
            $0.results
            }.eraseToAnyPublisher()
    }
}
