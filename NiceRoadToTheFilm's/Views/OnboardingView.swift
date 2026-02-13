//
//  OnboardingView.swift
//  NiceRoadToTheFilm's
//
//  Created by Ivan Solohub on 11.02.2026.
//

import SwiftUI

struct OnboardingView: View {
    
    @State private var pageIndex = 0
    @State private var showPrestart = false
    
    private let pages: [DescribePage] = [
        .init(
            imageName: "onboarding1",
            titleText: "Discover Bold Cinema",
            bodyText: "Discover a carefully curated collection of stylish realism stories, dialogue-rich films, and unforgettable characters—all in one place."
        ),
        .init(
            imageName: "onboarding2",
            titleText: "Save What Hits Hard",
            bodyText: "Add films to your favorites, build your personal collection, and return anytim to the stories that left a mark."
        ),
        .init(
            imageName: "onboarding3",
            titleText: "Stay Focused.\nStay Connected.",
            bodyText: "No noise. No distractions. Just atmosphere, stories, and a clean cinematic experience designed for true film lovers."
        )
    ]
    
    private var currentPage: DescribePage { pages[pageIndex] }
    
    var body: some View {
        ZStack {
            Image("mainBGImage")
                .resizable()
                .ignoresSafeArea()

            VStack {
                
                VStack(spacing: 50) {
                    titleText
                    bodyText
                }
                .id(pageIndex)
                .transition(.asymmetric(
                    insertion: .move(edge: .trailing).combined(with: .opacity),
                    removal: .move(edge: .leading).combined(with: .opacity)
                ))

                Spacer()
                mainImage
                Spacer()
                nextButton
            }
        }
        .animation(.easeInOut(duration: 0.35), value: pageIndex)
        .animation(.easeInOut(duration: 0.5), value: showPrestart)
    }
    
    private var titleText: some View {
        Text(currentPage.titleText)
            .font(.seymourOne(.regular, size: 20))
            .foregroundColor(.white)
            .multilineTextAlignment(.center)
            .padding(.horizontal, 20)
    }
    
    private var bodyText: some View {
        Text(currentPage.bodyText)
            .font(.pathwayGothicOne(.regular, size: 20))
            .foregroundColor(.white)
            .multilineTextAlignment(.center)
            .padding(.horizontal, 35)
    }
    
    private var mainImage: some View {
        Image(currentPage.imageName)
            .resizable()
            .scaledToFit()
            .id("image-\(pageIndex)")
            .transition(.asymmetric(
                insertion: .move(edge: .trailing).combined(with: .opacity),
                removal: .move(edge: .leading).combined(with: .opacity)
            ))
            .padding(.horizontal, 20)
        
    }
    
    private var nextButton: some View {
        Button(pageIndex == pages.count - 1 ? "Start" : "Next") {
            onNextTap()
        }
        .font(.patuaOne(.regular, size: 18))
        .buttonStyle(FullWidthButtonStyle())
        .padding(.horizontal, 50)
        .padding(.bottom, 30)
    }

    private func onNextTap() {
        if pageIndex < pages.count - 1 {
            pageIndex += 1
        } else {
            showPrestart = true
            
        }
    }
}

private struct DescribePage {
    let imageName: String
    let titleText: String
    let bodyText: String
}



#Preview {
    OnboardingView()
}
