//
//  FavoriteMoviesStorage.swift
//  MoviesApp
//
//  Created by Khalid Amr on 23/07/2025.
//

import Foundation

struct FavoriteMoviesStorage {
    private static let key = "favoriteMovies"

    static func isFavorite(movieId: Int) -> Bool {
        return favoriteMovieIds().contains(movieId)
    }

    static func toggleFavorite(movieId: Int) {
        var current = favoriteMovieIds()
        if current.contains(movieId) {
            current.removeAll { $0 == movieId }
        } else {
            current.append(movieId)
        }
        UserDefaults.standard.set(current, forKey: key)
    }

    static func favoriteMovieIds() -> [Int] {
        return UserDefaults.standard.array(forKey: key) as? [Int] ?? []
    }
}
