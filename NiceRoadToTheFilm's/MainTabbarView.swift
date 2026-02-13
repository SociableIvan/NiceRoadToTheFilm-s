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
            
            if let activeOverlay {
                switch activeOverlay {
                    case .userPhotoMenu:
                    Color.white.opacity(0.25)
                        .ignoresSafeArea()
                        .onTapGesture {
                            withAnimation(.easeInOut(duration: 0.25)) {
                                self.activeOverlay = nil
                            }
                        }
                        .transition(.opacity)
                        .zIndex(50)

                    UserPhotoBottomSheet(
                        onClose: {
                            withAnimation(.easeInOut(duration: 0.25)) {
                                self.activeOverlay = nil
                            }
                        },
                        onFirst: {
                            withAnimation(.easeInOut(duration: 0.25)) { self.activeOverlay = nil }
//                            showAvatarPicker = true
                        },
                        onSecond: {
                            withAnimation(.easeInOut(duration: 0.25)) { self.activeOverlay = nil }
                            if UIImagePickerController.isSourceTypeAvailable(.camera) {
//                                showCameraPicker = true
                            } else {
//                                showNoCameraAlert = true
                            }
                        }
                    )
                    .transition(.move(edge: .bottom))
                    .zIndex(60)

                    case .privacyPolicy:
                        PrivacyPolicyView(onBack: { self.activeOverlay = nil })
                        .transition(.opacity)
                        .zIndex(80)

                    case .terms:
                        TermsOfUseView(onBack: { self.activeOverlay = nil })
                            .transition(.opacity)
                            .zIndex(80)
                    }
                }
        }
//        .contentShape(Rectangle())
//            .simultaneousGesture(
//                TapGesture().onEnded {
//                    AppSounds.playTapIfAllowed(soundEnabled)
//                }
//            )
//        .sheet(isPresented: $showAvatarPicker) {
//            AvatarPickerSheet { image in
//                session.updateAvatar(image)
//            }
//        }
//        .sheet(isPresented: $showCameraPicker) {
//            CameraPicker { image in
//                session.updateAvatar(image)
//            }
//        }
//        .alert("Camera is not available", isPresented: $showNoCameraAlert) {
//            Button("OK", role: .cancel) { }
//        
//        }
    }

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
        .environmentObject(UserSession())
}
