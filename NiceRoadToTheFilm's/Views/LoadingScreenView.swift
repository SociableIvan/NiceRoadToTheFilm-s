//
//  LoadingScreenView.swift
//  NiceRoadToTheFilm's
//
//  Created by Ivan Solohub on 11.02.2026.
//

import SwiftUI

struct LoadingScreenView: View {
    
    @State private var isAnimating = false
    
    var body: some View {
        ZStack {
            Image("mainBGImage")
                .resizable()
                .ignoresSafeArea()
            
            loadingAnimation
                .frame(width: 165, height: 165)
        }
        .onAppear { isAnimating = true }
        .onDisappear { isAnimating = false }
    }
    
    private var loadingAnimation: some View {
        ZStack {
            Image("loadingImage")
                .resizable()
                .scaledToFit()
                .rotationEffect(.degrees(isAnimating ? 360 : 0))
                .animation(
                    .linear(duration: 3).repeatForever(autoreverses: false),
                    value: isAnimating
                )
            
            Text("Loading 50%")
                .font(.patuaOne(.regular, size: 15))
                .foregroundColor(.white)
                .shadow(color: .black, radius: 4, x: 3, y: 1)
        }
    }
    
    private var titleText: some View {
        Text("No connection")
            .font(.patuaOne(.regular, size: 32))
            .foregroundColor(.black)
    }
}

#Preview {
    ZStack {
        Color.orange
        LoadingScreenView()
    }
}
