//
//  FilmDetailScreenView.swift
//  NiceRoadToTheFilm's
//
//  Created by Ivan Solohub on 12.02.2026.
//

import SwiftUI

struct FilmDetailScreenView: View {
    
    let film: Film
    
    @State private var showDetails: Bool = true
    
    var body: some View {
        VStack {
            Spacer()
            
            Image(film.detailPictureString)
                .resizable()
                .scaledToFit()
                .padding(.horizontal, 16)
            
            Spacer()
        }
    }
}
