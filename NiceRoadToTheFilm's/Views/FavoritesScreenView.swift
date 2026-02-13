//
//  FavoritesScreenView.swift
//  NiceRoadToTheFilm's
//
//  Created by Ivan Solohub on 11.02.2026.
//

import SwiftUI

struct FavoritesScreenView: View {

    @EnvironmentObject private var session: UserSession

    @State private var showDetails = false
    @State private var selectedFilm: Film? = nil
    @State private var isFavoriteSelected = false

    private let allFilms = FilmsData.all

    private let columns = [
        GridItem(.flexible(), spacing: 16),
        GridItem(.flexible(), spacing: 16)
    ]

    private var favoriteFilms: [Film] {
        allFilms.filter { session.favoriteFilmIDs.contains($0.id) }
    }

    var body: some View {
        VStack(spacing: 0) {
            navigationView

            if showDetails, let film = selectedFilm {
                FilmDetailScreenView(film: film)
                    .transition(.opacity.combined(with: .move(edge: .trailing)))
            } else {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(favoriteFilms) { film in
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
        .onChange(of: session.favoriteFilmIDs) { _ in
            
            if let film = selectedFilm, !session.isFavorite(film) {
                withAnimation(.easeInOut(duration: 0.25)) {
                    showDetails = false
                    selectedFilm = nil
                }
            }
        }
    }

    private var navigationView: some View {
        AppTopBar(
            title: showDetails ? (selectedFilm?.filmName ?? "Favorites") : "Favorites",
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
            }
        )
    }

    private func filmCell(_ film: Film) -> some View {
        ZStack(alignment: .topTrailing) {
            Image(film.previewPicture)
                .resizable()
                .scaledToFit()
                .frame(width: 167, height: 267)
                .contentShape(Rectangle())
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.25)) {
                        selectedFilm = film
                        showDetails = true
                        isFavoriteSelected = true
                    }
                }

            Button {
                session.removeFavorite(film)
            } label: {
                Image("selectedFavorite")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 30, height: 30)
                    .padding(.trailing, 10)
                    .padding(.top, 10)
            }
            .buttonStyle(.plain)
        }
    }
}
