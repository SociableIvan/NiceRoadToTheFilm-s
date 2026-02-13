//
//  HomeScreenView.swift
//  NiceRoadToTheFilm's
//
//  Created by Ivan Solohub on 11.02.2026.
//

import SwiftUI

struct HomeScreenView: View {

    @State private var showInfo: Bool = false
    
    var body: some View {
        VStack {
            AppTopBar(
                title: showInfo ? "Aelita Worth" : "Home",
                titleFont: showInfo ? .seymourOne(.regular, size: 20) : .patuaOne(.regular, size: 30),
                backgroundColor: .mainTabBG,
                showsBackButton: showInfo
            ) {
                withAnimation(.easeInOut(duration: 0.25)) {
                    showInfo = false
                }
            }
            
            if showInfo {
                VStack {
                    Image("directorImage")
                        .resizable()
                        .scaledToFit()
                    
                    name
                    directorsInfo
                    
                }
                .padding(.top, 10)
            } else {
                Image("directorImage")
                    .resizable()
                    .scaledToFit()
                    .overlay(
                        HStack {
                            name
                            Spacer()
                            infoButton
                        }
                            .padding(.horizontal, 20)
                            .padding(.vertical, 20),
                        alignment: .bottom
                    )
                    .padding(.horizontal, 13)
                    .padding(.vertical, 20)
            }
        }
        .ignoresSafeArea(edges: .top)
    }

    private var name: some View {
        Text("Aelita Worth")
            .font(.seymourOne(.regular, size: 20))
            .foregroundColor(.white)
    }
    
    private var directorsInfo: some View {
        Text("An Icelandic visionary known for incorporating actual black hole sounds and minimalist future architecture into her films.")
            .font(.seymourOne(.regular, size: 15))
            .foregroundColor(.white)
            .multilineTextAlignment(.center)
            .padding(.top, 10)
            .padding(.bottom, 20)
            .padding(.horizontal, 30)
    }

    private var infoButton: some View {
        Button {
            showInfo = true
        } label: {
            Image("infoIcon")
                .resizable()
                .scaledToFit()
                .frame(width: 30)
        }
        .buttonStyle(.plain)
    }
}



#Preview {
    MainTabbarView()
}
