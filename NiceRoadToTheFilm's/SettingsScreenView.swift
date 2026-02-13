//
//  SettingsScreenView.swift
//  NiceRoadToTheFilm's
//
//  Created by Ivan Solohub on 11.02.2026.
//

import SwiftUI

struct SettingsScreenView: View {
    
    let onOpenPrivacyPolicy: () -> Void
    let onOpenTerms: () -> Void
    let onOpenPhotoMenu: () -> Void
    
    var body: some View {
        VStack {
            userPhotoButton
        }
    }
    
    private var userPhotoButton: some View {
        Button {
            onOpenPhotoMenu()
        } label: {
            ZStack {
                Image("UserImageFrame")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 130)
                
                Image("gallerry")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 65)
                
                Image("plusButtonImage")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 45)
                    .padding(.top, 110)

//                if let uiImage = session.avatarUIImage {
//                    Image(uiImage: uiImage)
//                        .resizable()
//                        .scaledToFill()
//                        .frame(width: 74, height: 74)
//                        .clipShape(Circle())
//                        .offset(y: -5)
//                } else {
//                    Image("userProfileIcon")
//                        .resizable()
//                        .scaledToFit()
//                        .frame(width: 48)
//                        .offset(y: -5)
//                }
            }
        }
        .buttonStyle(.plain)
    }
}
#Preview {
    ZStack {
        Image("mainBGImage")
            .resizable()
            .ignoresSafeArea()
        
        SettingsScreenView(onOpenPrivacyPolicy: {}, onOpenTerms: {}, onOpenPhotoMenu: {})
    }
}
