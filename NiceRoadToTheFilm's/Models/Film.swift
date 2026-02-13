//
//  Film.swift
//  NiceRoadToTheFilm's
//
//  Created by Ivan Solohub on 12.02.2026.
//

import Foundation

struct Film: Identifiable, Hashable {
//    let id = UUID()
    let id: String
    let filmName: String
    let previewPicture: String
    let detailPictureString: String
    var isFavorite: Bool
}
