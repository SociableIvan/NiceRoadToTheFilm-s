//
//  UserPhotoBottomSheet.swift
//  NiceRoadToTheFilm's
//
//  Created by Ivan Solohub on 13.02.2026.
//

import SwiftUI

struct UserPhotoBottomSheet: View {

    let onClose: () -> Void
    let onFirst: () -> Void
    let onSecond: () -> Void

    var body: some View {
        VStack {
            Spacer()

            buttons
            .frame(maxWidth: .infinity)
            .background(
                Color.white
                    .clipShape(TopRoundedShape(radius: 14))
            )
            .padding(.horizontal, 31)
        }
        .ignoresSafeArea(edges: .bottom)
    }
    
    private var buttons: some View {
        VStack(spacing: 12) {
            actionButton(
                title: "choose from gallery",
                action: onFirst
            )

            actionButton(
                title: "take a picture",
                action: onSecond
            )
        }
        .padding(.horizontal, 18)
        .padding(.vertical, 60)
    }

    private func actionButton(
        title: String,
        action: @escaping () -> Void
    ) -> some View {
        Button(action: action) {
            Text(title)
                .foregroundColor(.white)
                .frame(maxWidth: .infinity, minHeight: 50)
                .background(Color.black)
                .clipShape(RoundedRectangle(cornerRadius: 35, style: .continuous))
        }
        .buttonStyle(.plain)
    }
}

// MARK: - helper
 fileprivate struct TopRoundedShape: Shape {
    var radius: CGFloat = 35

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: [.topLeft, .topRight],
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}

#Preview {
    MainTabbarView()
        .environmentObject(UserSession())
}
