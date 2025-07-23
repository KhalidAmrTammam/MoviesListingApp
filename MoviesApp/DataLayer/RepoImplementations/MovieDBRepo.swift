//
//  MovieDBRepo.swift
//  MoviesApp
//
//  Created by Khalid Amr on 22/07/2025.
//
import Combine

class MovieDBRepo : MoviesDPRepoProtocols {
    let remoteDataSource : RemoteDataSource
    
    init(remoteDataSource: RemoteDataSource) {
        self.remoteDataSource = remoteDataSource
    }
    
    func getTheMovieList() -> AnyPublisher<MovieListResponse,Error> {
        return remoteDataSource.getMovieList()
    }
}
