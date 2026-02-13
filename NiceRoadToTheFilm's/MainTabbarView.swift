//
//  MainTabbarView.swift
//  NiceRoadToTheFilm's
//
//  Created by Ivan Solohub on 11.02.2026.
//

import SwiftUI

struct MainTabbarView: View {
    
    @State private var selectedTab = 0
    
    private let tabBarHeight: CGFloat = 104
    
    @AppStorage("soundEnabled") private var soundEnabled: Bool = false
    @State private var activeOverlay: ActiveOverlay? = nil
    
    private enum ActiveOverlay {
        case userPhotoMenu
        case privacyPolicy
        case terms
    }
    
    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                contentView
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    
                CustomTabBarView(selectedTab: $selectedTab)
                    .frame(height: tabBarHeight)
                    .background(Color.mainTabBG)
                    
            }
            .ignoresSafeArea(edges: .vertical)
            .background(Image("mainBGImage")
                .resizable()
                .ignoresSafeArea()
            )
        }
    }
//    var body: some View {
////        NavigationView {
//            ZStack {
//                VStack(spacing: 0) {
//                    contentView
//                        .frame(maxWidth: .infinity, maxHeight: .infinity)
//
//                    CustomTabBarView(selectedTab: $selectedTab)
//                        .frame(height: tabBarHeight)
//                        .background(Color.mainTabBG)
//                }
//                .ignoresSafeArea(edges: .vertical)
//                .background(
//                    Image("mainBGImage")
//                        .resizable()
//                        .ignoresSafeArea()
//                )
//            }
////            .navigationTitle(navTitle)
////            .navigationBarTitleDisplayMode(.inline)
////            .navigationBarBackButtonHidden(true)
////        }
////        .navigationViewStyle(.stack)
////        .onAppear {
////            NavigationBarStyle.apply()
////        }
//    }
    
//    private var navTitle: String {
//            switch selectedTab {
//            case 0: return "Home"
//            case 1: return "Films"
//            case 2: return "Favorites"
//            case 3: return "Settings"
//            default: return ""
//            }
//        }
    
    
    
    @ViewBuilder
    private var contentView: some View {
        switch selectedTab {
        case 0:
            HomeScreenView()
        case 1:
            FilmsScreenView()
        case 2:
            FavoritesScreenView()
        case 3:
            SettingsScreenView(
                onOpenPrivacyPolicy: { activeOverlay = .privacyPolicy },
                    onOpenTerms: { activeOverlay = .terms },
                    onOpenPhotoMenu: {
                        withAnimation(.easeInOut(duration: 0.25)) {
                            activeOverlay = .userPhotoMenu
                        }
                    }
            )
        default:
            Color.clear
        }
    }
    
    private struct CustomTabBarView: View {
        @Binding var selectedTab: Int

        var body: some View {
            HStack {
                tabButton(imageName: "home", selectedImageName: "selectedHome", index: 0)
                Spacer()
                tabButton(imageName: "gallerry", selectedImageName: "selectedFilms", index: 1)
                Spacer()
                tabButton(imageName: "favorite", selectedImageName: "selectedFavorites", index: 2)
                Spacer()
                tabButton(imageName: "settings", selectedImageName: "selectedSettings", index: 3)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .padding(.horizontal, 19)
        }
        
        private func tabButton(
            imageName: String,
            selectedImageName: String,
            index: Int
        ) -> some View {
            let isSelected = selectedTab == index

            return Button {
                withAnimation(.easeInOut(duration: 0.25)) {
                    selectedTab = index
                }
            } label: {
                Image(isSelected ? selectedImageName : imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(height: 47)
            }
            .buttonStyle(.plain)
        }
    }
}


#Preview {
    MainTabbarView()
}




//import UIKit
//
//enum NavigationBarStyle {
//
//    static func apply() {
//        let appearance = UINavigationBarAppearance()
//        appearance.configureWithTransparentBackground()
//        appearance.backgroundColor = UIColor.mainTabBG
//
////        let titleFont = UIFont(name: "SeymourOne-Regular", size: 20) ?? .systemFont(ofSize: 20, weight: .semibold)
//        let titleFont = UIFont(name: "PatuaOne-Regular", size: 30) ?? .systemFont(ofSize: 20, weight: .semibold)
//
//        appearance.titleTextAttributes = [
//            .font: titleFont,
//            .foregroundColor: UIColor.white
//        ]
//
//        UINavigationBar.appearance().standardAppearance = appearance
//        UINavigationBar.appearance().scrollEdgeAppearance = appearance
//        UINavigationBar.appearance().compactAppearance = appearance
//
//        UINavigationBar.appearance().tintColor = .white
//    }
//}
