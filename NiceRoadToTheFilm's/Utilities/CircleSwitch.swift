//
//  CircleSwitch.swift
//  NiceRoadToTheFilm's
//
//  Created by Ivan Solohub on 13.02.2026.
//

import SwiftUI

struct CircleSwitch: View {

    @Binding var isOn: Bool

    var height: CGFloat = 28
    var width: CGFloat = 45

    private var knobSize: CGFloat { height - 3 }
    private var padding: CGFloat { (height - knobSize) / 2 }

    var body: some View {
        Button {
            withAnimation(.spring(response: 0.22, dampingFraction: 0.85)) {
                isOn.toggle()
            }
        } label: {
            ZStack(alignment: isOn ? .trailing : .leading) {
                RoundedRectangle(cornerRadius: height / 2, style: .continuous)
                    .fill(isOn ? AnyShapeStyle(Color.switcherOn) : AnyShapeStyle(Color.switcherOff))
                    .frame(width: width, height: height)
                Circle()
                    .fill(Color.white)
                    .frame(width: knobSize, height: knobSize)
                    .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 1)
                    .padding(padding)
            }
        }
        .buttonStyle(.plain)
    }
}
