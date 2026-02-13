//
//  FilmsScreenView.swift
//  NiceRoadToTheFilm's
//
//  Created by Ivan Solohub on 11.02.2026.
//

import SwiftUI

struct FilmsScreenView: View {
    
    @EnvironmentObject private var session: UserSession
    
    @State private var showDetails: Bool = false
    @State private var selectedFilm: Film? = nil
    @State private var isFavoriteSelected = false
    
    private let films = FilmsData.all

    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]
    
    var body: some View {
        VStack(spacing: 0) {
            navigationView

            if showDetails, let film = selectedFilm {
                FilmDetailScreenView(film: film)
                    .transition(.opacity.combined(with: .move(edge: .trailing)))
            } else {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(films) { film in
                            filmCell(film)
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 10)
                    .padding(.bottom, 40)
                }
                .transition(.opacity.combined(with: .move(edge: .leading)))
            }
        }
        .animation(.easeInOut(duration: 0.25), value: showDetails)
        .onChange(of: selectedFilm?.id) { _ in
            guard let film = selectedFilm else { return }
            isFavoriteSelected = session.isFavorite(film)
        }
        .onChange(of: session.favoriteFilmIDs) { _ in
            guard let film = selectedFilm else { return }
            isFavoriteSelected = session.isFavorite(film)
        }
    }

    private var navigationView: some View {
        AppTopBar(
            title: showDetails ? (selectedFilm?.filmName ?? "Films") : "Films",
            titleFont: showDetails ? .seymourOne(.regular, size: 20) : .patuaOne(.regular, size: 30),
            showsBackButton: showDetails,
            backAction: {
                withAnimation(.easeInOut(duration: 0.25)) {
                    showDetails = false
                    selectedFilm = nil
                }
            },
            showsRightButton: showDetails,
            rightIconName: "favorite",
            rightSelectedIconName: "selectedFavorite",
            isRightSelected: $isFavoriteSelected,
            rightAction: {
                guard let film = selectedFilm else { return }
                session.toggleFavorite(film)
                isFavoriteSelected = session.isFavorite(film)
            }
        )
    }

    private func filmCell(_ film: Film) -> some View {
        Image(film.previewPicture)
            .resizable()
            .scaledToFit()
            .frame(width: 167, height: 267)
            .contentShape(Rectangle())
            .onTapGesture {
                withAnimation(.easeInOut(duration: 0.25)) {
                    selectedFilm = film
                    showDetails = true
                    isFavoriteSelected = session.isFavorite(film)
                }
            }
    }
}

#Preview {
    MainTabbarView()
}

