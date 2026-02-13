//
//  TermsOfUseView.swift
//  NiceRoadToTheFilm's
//
//  Created by Ivan Solohub on 13.02.2026.
//

import SwiftUI

struct TermsOfUseView: View {
    
    let onBack: () -> Void
    
    private let termsOfUseText: String = """
 Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.
 """
    
    var body: some View {
        ZStack {
            Image("mainBGImage")
                .resizable()
                .ignoresSafeArea()
            
            VStack {
                navigationView
                
                ScrollView {
                    Text(termsOfUseText)
                        .font(.patuaOne(.regular, size: 16))
                        .foregroundColor(.white)
                        .padding(.horizontal, 30)
                        .padding(.top, 60)
                }
            }
            
            
        }
        .ignoresSafeArea()
    }
    
    private var navigationView: some View {
        AppTopBar(
            title: "Terms of use",
            titleFont: .patuaOne(.regular, size: 20),
            showsBackButton: true,
            backAction: {
                onBack()
            }
        )
    }
}

#Preview {
    TermsOfUseView() {}
}
