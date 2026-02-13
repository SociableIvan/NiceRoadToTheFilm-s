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
    
    @EnvironmentObject private var session: UserSession
    
    @FocusState private var isNameFocused: Bool
    @State private var isEditingName = false
    @State private var draftName: String = ""
    
    var body: some View {
        VStack {
            navigationView
            if session.isSmallScreen {
                ScrollView(showsIndicators: false) {
                    userPhotoButton
                    inputUserNameTF
                        .padding(.top, 10)
                    
                    settingsSwitchers
                        .padding(.top, 30)
                    
                    Spacer()
                    bottomButtons
                }
            } else {
                userPhotoButton
                inputUserNameTF
                    .padding(.top, 20)
                
                settingsSwitchers
                    .padding(.top, 30)
                
                Spacer()
                bottomButtons
            }
        }
    }
    
    private var navigationView: some View {
        AppTopBar(
            title: "Settings",
            titleFont: .patuaOne(.regular, size: 30)
            
        )
    }

    private var userPhotoButton: some View {
        Button {
            onOpenPhotoMenu()
        } label: {
            if let avatar = session.loadAvatarUIImage() {
                ZStack {
                    Image("UserImageFrame")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 134)
                    
                    Image(uiImage: avatar)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 130, height: 130)
                        .clipShape(RoundedRectangle(cornerRadius: 13, style: .continuous))
                }
            } else {
                ZStack {
                    Image("UserImageFrame")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 130)

                    Image("plusButtonImage")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 45)
                        .padding(.top, 110)

                    Image("gallerry")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 65)
                }
            }
        }
        .buttonStyle(.plain)
    }
    
    private var inputUserNameTF: some View {
        Group {
            if isEditingName {
                TextField("", text: $draftName)
                    .textInputAutocapitalization(.words)
                    .disableAutocorrection(false)
                    .submitLabel(.done)
                    .focused($isNameFocused)
                    .onChange(of: draftName) { newValue in
                        draftName = sanitizeNameInput(newValue)
                    }
                    .onSubmit {
                        isNameFocused = false
                        saveName()
                    }
                    .font(.inter(.semibold, size: 20))
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 12)
            } else {
                HStack {
                    Text(session.user.name.isEmpty ? "Username" : session.user.name)
                        .font(.inter(.semibold, size: 20))
                        .foregroundStyle(.white)
                        .onTapGesture {
                            startEditingName()
                        }
                    
                    Image("editIcon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 13)
                }
            }
        }
    }
    
    private var bottomButtons: some View {
        VStack(spacing: 16) {
            Button("Privacy Policy") {
                onOpenPrivacyPolicy()
            }
            .font(.patuaOne(.regular, size: 18))
            .buttonStyle(FullWidthButtonStyle())
            
            Button("Terms of Use") {
                onOpenTerms()
            }
            .font(.patuaOne(.regular, size: 18))
            .buttonStyle(FullWidthButtonStyle())
        }
        .padding(.bottom, 30)
        .padding(.horizontal, 50)
    }
    
    private var settingsSwitchers: some View {
        VStack(spacing: 20) {
            
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.peach)
                    .frame(height: 56)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.customViolet, lineWidth: 3)
                    )
                
                HStack {
                    Text("Sound")
                        .font(.inter(.semibold, size: 20))
                        .foregroundColor(.customViolet)
                    
                    Spacer()
                    
                    CircleSwitch(
                        isOn: Binding(
                            get: { session.user.soundEnable },
                            set: { session.setSoundEnabled($0) }
                        )
                    )
                    .shadow(color: .black.opacity(0.25), radius: 4, y: 4)
                }
                .padding(.horizontal, 10)
            }
            
            ZStack {
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.peach)
                    .frame(height: 56)
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.customViolet, lineWidth: 3)
                    )
                
                HStack {
                    Text("Music")
                        .font(.inter(.semibold, size: 20))
                        .foregroundColor(.customViolet)
                    
                    Spacer()
                    
                    CircleSwitch(
                        isOn: Binding(
                            get: { session.user.musicEnable },
                            set: { session.setMusicEnabled($0) }
                        )
                    )
                    .shadow(color: .black.opacity(0.25), radius: 4, y: 4)
                }
                .padding(.horizontal, 10)
            }
        }
        .padding(.horizontal, 50)
    }
    
    
    // MARK: - Private helper methods
    private func startEditingName() {
        draftName = session.user.name
        isEditingName = true
        isNameFocused = true
    }

    private func saveName() {
        let trimmed = draftName.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return }

        session.setUserName(trimmed)

        isNameFocused = false
        isEditingName = false
    }
    
    private func sanitizeNameInput(_ text: String) -> String {
        var result = ""
        var previousWasSpace = false

        for char in text {
            if char == " " {
                if previousWasSpace { continue }
                previousWasSpace = true
            } else {
                previousWasSpace = false
            }

            result.append(char)

            if result.count == 15 {
                break
            }
        }

        return result
    }
}
#Preview {
        MainTabbarView()
            .environmentObject(UserSession())
}
