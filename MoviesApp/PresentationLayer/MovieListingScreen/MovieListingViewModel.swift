//
//  MovieListingViewModel.swift
//  MoviesApp
//
//  Created by Khalid Amr on 23/07/2025.
//

import Foundation
import Combine

class MovieListingViewModel {
    enum ViewState {
        case loading
        case loaded([Movies])
        case error(Error)
        case empty
    }

    @Published private(set) var state: ViewState = .loading

    private let useCase: GetMovieListDBUseCaseProtocol
    private var cancellables = Set<AnyCancellable>()

    init(useCase: GetMovieListDBUseCaseProtocol) {
        self.useCase = useCase
    }

    func fetchMovies() {
        state = .loading
        useCase.getMovieList()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                if case let .failure(error) = completion {
                    self?.state = .error(error)
                }
            } receiveValue: { [weak self] movies in
                if movies.isEmpty {
                    self?.state = .empty
                } else {
                    self?.state = .loaded(movies)
                }
            }.store(in: &cancellables)
    }
}
