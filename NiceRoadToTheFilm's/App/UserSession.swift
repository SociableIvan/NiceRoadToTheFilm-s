//
//  UserSession.swift
//  NiceRoadToTheFilm's
//
//  Created by Ivan Solohub on 13.02.2026.
//

import Foundation
import Combine

final class UserSession: ObservableObject {

    // MARK: - Keys
    private let favoritesKey = "favoriteFilmIDs"
    private let userKey = "userProfile"

    // MARK: - Published
    @Published private(set) var favoriteFilmIDs: Set<String> = []
    @Published var user: User

    // MARK: - Init
    init() {
        // user
        if let data = UserDefaults.standard.data(forKey: userKey),
           let savedUser = try? JSONDecoder().decode(User.self, from: data) {
            self.user = savedUser
        } else {
            self.user = User(
                name: "",
                imageName: "",
                soundEnable: true,
                musicEnable: false
            )
        }

        // favorites
        loadFavorites()
    }

    // MARK: - Favorites API
    func isFavorite(_ film: Film) -> Bool {
        favoriteFilmIDs.contains(film.id)
    }

    func toggleFavorite(_ film: Film) {
        if favoriteFilmIDs.contains(film.id) {
            favoriteFilmIDs.remove(film.id)
        } else {
            favoriteFilmIDs.insert(film.id)
        }
        saveFavorites()
    }

    func removeFavorite(_ film: Film) {
        favoriteFilmIDs.remove(film.id)
        saveFavorites()
    }

    // MARK: - User API
    func setUserName(_ name: String) {
        user.name = name
        saveUser()
    }

    func setSoundEnabled(_ value: Bool) {
        user.soundEnable = value
        saveUser()
    }

    func setMusicEnabled(_ value: Bool) {
        user.musicEnable = value
        saveUser()
    }

    // MARK: - Persistence
    private func saveFavorites() {
        UserDefaults.standard.set(Array(favoriteFilmIDs), forKey: favoritesKey)
    }

    private func loadFavorites() {
        let array = UserDefaults.standard.stringArray(forKey: favoritesKey) ?? []
        favoriteFilmIDs = Set(array)
    }

    private func saveUser() {
        if let data = try? JSONEncoder().encode(user) {
            UserDefaults.standard.set(data, forKey: userKey)
        }
    }
}
