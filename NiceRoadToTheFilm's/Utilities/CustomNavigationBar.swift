//
//  CustomNavigationBar.swift
//  NiceRoadToTheFilm's
//
//  Created by Ivan Solohub on 12.02.2026.
//

import SwiftUI

struct AppTopBar: View {

    let title: String
    let titleFont: Font
    let height: CGFloat
    let backgroundColor: Color

    // Left (Back)
    let showsBackButton: Bool
    let backIconName: String
    let backAction: (() -> Void)?

    // Right (Favorite)
    let showsRightButton: Bool
    let rightIconName: String
    let rightSelectedIconName: String
    @Binding var isRightSelected: Bool
    let rightAction: (() -> Void)?

    let horizontalPadding: CGFloat
    let iconSize: CGFloat
    let bottomPadding: CGFloat

    init(
        title: String,
        titleFont: Font = .system(size: 18, weight: .semibold),
        height: CGFloat = 110,
        backgroundColor: Color = .mainTabBG,

        showsBackButton: Bool = false,
        backIconName: String = "backBtn",
        backAction: (() -> Void)? = nil,

        showsRightButton: Bool = false,
        rightIconName: String = "favorite",
        rightSelectedIconName: String = "selectedFavorite",
        isRightSelected: Binding<Bool> = .constant(false),
        rightAction: (() -> Void)? = nil,

        horizontalPadding: CGFloat = 20,
        iconSize: CGFloat = 46,
        bottomPadding: CGFloat = 5
    ) {
        self.title = title
        self.titleFont = titleFont
        self.height = height
        self.backgroundColor = backgroundColor

        self.showsBackButton = showsBackButton
        self.backIconName = backIconName
        self.backAction = backAction

        self.showsRightButton = showsRightButton
        self.rightIconName = rightIconName
        self.rightSelectedIconName = rightSelectedIconName
        self._isRightSelected = isRightSelected
        self.rightAction = rightAction

        self.horizontalPadding = horizontalPadding
        self.iconSize = iconSize
        self.bottomPadding = bottomPadding
    }

    var body: some View {
        ZStack {
            backgroundColor

            VStack {
                Spacer()

                HStack {
                    leftButtonOrPlaceholder

                    Spacer()

                    Text(title)
                        .font(titleFont)
                        .foregroundColor(.white)
                        .lineLimit(2)
                        .multilineTextAlignment(.center)

                    Spacer()

                    rightButtonOrPlaceholder
                }
                .padding(.horizontal, horizontalPadding)
                .padding(.bottom, bottomPadding)
            }
        }
        .frame(height: height)
        .frame(maxWidth: .infinity)
    }

    // MARK: - Left
    @ViewBuilder
    private var leftButtonOrPlaceholder: some View {
        if showsBackButton {
            Button {
                backAction?()
            } label: {
                Image(backIconName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: iconSize, height: iconSize)
                    .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
        } else {
            Color.clear
                .frame(width: iconSize, height: iconSize)
        }
    }

    // MARK: - Right
    @ViewBuilder
    private var rightButtonOrPlaceholder: some View {
        if showsRightButton {
            Button {
                isRightSelected.toggle()
                rightAction?()
            } label: {
                Image(isRightSelected ? rightSelectedIconName : rightIconName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: iconSize, height: iconSize)
                    .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
        } else {
            Color.clear
                .frame(width: iconSize, height: iconSize)
        }
    }
}
