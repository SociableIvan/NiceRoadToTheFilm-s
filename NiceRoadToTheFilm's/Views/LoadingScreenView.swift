//
//  LoadingScreenView.swift
//  NiceRoadToTheFilm's
//
//  Created by Ivan Solohub on 11.02.2026.
//

import SwiftUI

struct LoadingScreenView: View {

    let duration: Double
    let onFinished: () -> Void

    @State private var isAnimating = false
    @State private var progress: Int = 0

    var body: some View {
        ZStack {
            Image("mainBGImage")
                .resizable()
                .ignoresSafeArea()

            loadingAnimation
                .frame(width: 165, height: 165)
        }
        .onAppear {
            isAnimating = true
            startProgress()
        }
        .onDisappear {
            isAnimating = false
        }
    }

    private var loadingAnimation: some View {
        ZStack {
            Image("loadingImage")
                .resizable()
                .scaledToFit()
                .rotationEffect(.degrees(isAnimating ? 360 : 0))
                .animation(
                    .linear(duration: duration).repeatForever(autoreverses: false),
                    value: isAnimating
                )

            Text("Loading \(progress)%")
                .font(.patuaOne(.regular, size: 15))
                .foregroundColor(.white)
                .shadow(color: .black, radius: 4, x: 3, y: 1)
        }
    }

    private func startProgress() {
        let steps = 100
        let stepTime = duration / Double(steps)

        Timer.scheduledTimer(withTimeInterval: stepTime, repeats: true) { timer in
            if progress >= 100 {
                timer.invalidate()
                onFinished()
            } else {
                progress += 1
            }
        }
    }
}

#Preview {
    LoadingScreenView(duration: 3.0, onFinished: {})
}
