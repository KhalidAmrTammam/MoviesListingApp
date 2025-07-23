//
//  MoviesDPRepoProtocols.swift
//  MoviesApp
//
//  Created by Khalid Amr on 22/07/2025.
//

import Combine

protocol MoviesDPRepoProtocols {
    
    func getTheMovieList() -> AnyPublisher<MovieListResponse,Error>
    
}
