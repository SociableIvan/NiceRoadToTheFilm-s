//
//  NiceRoadToTheFilm_sApp.swift
//  NiceRoadToTheFilm's
//
//  Created by Ivan Solohub on 11.02.2026.
//

import SwiftUI

@main
struct NiceRoadToTheFilm_sApp: App {

    @StateObject private var session = UserSession()

    @AppStorage("hasSeenOnboarding") private var hasSeenOnboarding: Bool = false
    @State private var flow: AppFlow = .loading

    enum AppFlow {
        case loading
        case onboarding
        case main
    }

    var body: some Scene {
        WindowGroup {
            ZStack {
                switch flow {
                case .loading:
                    LoadingScreenView(duration: 3.0) {
                        withAnimation(.easeInOut(duration: 0.3)) {
                            flow = hasSeenOnboarding ? .main : .onboarding
                        }
                    }

                case .onboarding:
                    OnboardingView(
                        onFinish: {
                            hasSeenOnboarding = true
                            withAnimation(.easeInOut(duration: 0.35)) {
                                flow = .main
                            }
                        }
                    )
                    .transition(.opacity)

                case .main:
                    MainTabbarView()
                        .environmentObject(session)
                        .transition(.opacity)
                }
            }
        }
    }
}
