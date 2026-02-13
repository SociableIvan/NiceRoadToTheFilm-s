//
//  UserSession.swift
//  NiceRoadToTheFilm's
//
//  Created by Ivan Solohub on 13.02.2026.
//

import UIKit
import Foundation
import Combine
import SwiftUI

final class UserSession: ObservableObject {

    @AppStorage("soundEnabled") private var soundEnabled: Bool = false
    
    // MARK: - Keys
    private let favoritesKey = "favoriteFilmIDs"
    private let userKey = "userProfile"

    // MARK: - Published
    @Published private(set) var favoriteFilmIDs: Set<String> = []
    @Published var user: User
    @Published private(set) var isSmallScreen: Bool = false

    // MARK: - Init
    init() {
       
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

        loadFavorites()
        BackgroundMusicPlayer.shared.apply(isEnabled: user.musicEnable)
    }
    
    func updateScreenMetricsIfNeeded() {
        let size = UIScreen.main.bounds.size
        let minSide = min(size.width, size.height)
        let maxSide = max(size.width, size.height)

        isSmallScreen = (minSide <= 375 && maxSide <= 667)
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
        BackgroundMusicPlayer.shared.apply(isEnabled: value)
    }
    
    // MARK: - Avatar
        func updateAvatar(_ image: UIImage) {
            guard let fileName = saveAvatarToDisk(image) else { return }
            user.imageName = fileName
            saveUser()
        }

        func removeAvatar() {
            deleteAvatarFromDiskIfNeeded()
            user.imageName = ""
            saveUser()
        }

        func loadAvatarUIImage() -> UIImage? {
            guard !user.imageName.isEmpty else { return nil }
            let url = avatarFileURL(fileName: user.imageName)
            guard let data = try? Data(contentsOf: url) else { return nil }
            return UIImage(data: data)
        }

        private func saveAvatarToDisk(_ image: UIImage) -> String? {
            deleteAvatarFromDiskIfNeeded()

            let fileName = "avatar.jpg"
            let url = avatarFileURL(fileName: fileName)

            guard let data = image.jpegData(compressionQuality: 0.85) else { return nil }

            do {
                try data.write(to: url, options: [.atomic])
                return fileName
            } catch {
                return nil
            }
        }

        private func deleteAvatarFromDiskIfNeeded() {
            guard !user.imageName.isEmpty else { return }
            let url = avatarFileURL(fileName: user.imageName)
            try? FileManager.default.removeItem(at: url)
        }

        private func avatarFileURL(fileName: String) -> URL {
            let docs = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            return docs.appendingPathComponent(fileName)
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
