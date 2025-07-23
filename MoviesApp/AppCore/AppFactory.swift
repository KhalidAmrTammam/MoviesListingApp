//
//  AppFactory.swift
//  MoviesApp
//
//  Created by Khalid Amr on 22/07/2025.
//
protocol UseCaseFactory {
    func makeMovieListUseCase() -> GetMovieListDBUseCase
}

struct AppFactory: UseCaseFactory {
    static let shared = AppFactory()
    private init() {}
    func makeMovieListUseCase() -> GetMovieListDBUseCase {
        let service = MoviesDBService()
        let repo = MovieDBRepo(remoteDataSource: RemoteDataSource(moviesDBService: service))
        return GetMovieListDBUseCase(movieListRepoProtocol: repo)
    }
}
