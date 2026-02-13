//
//  App+Font.swift
//  NiceRoadToTheFilm's
//
//  Created by Ivan Solohub on 11.02.2026.
//

import SwiftUI

extension Font {
    
    static func patuaOne(_ weight: PatuaOneWeight, size: CGFloat) -> Font {
        Font.custom(weight.rawValue, size: size)
    }
    
    enum PatuaOneWeight: String {
        case regular = "PatuaOne-Regular"
    }
    
    static func pathwayGothicOne(_ weight: PathwayGothicOneWeight, size: CGFloat) -> Font {
        Font.custom(weight.rawValue, size: size)
    }
    
    enum PathwayGothicOneWeight: String {
        case regular = "PathwayGothicOne-Regular"
    }
    
    static func seymourOne(_ weight: SeymourOneWeight, size: CGFloat) -> Font {
        Font.custom(weight.rawValue, size: size)
    }
    
    enum SeymourOneWeight: String {
        case regular = "SeymourOne"
    }
    
    static func inter(_ weight: InterOneWeight, size: CGFloat) -> Font {
        Font.custom(weight.rawValue, size: size)
    }
    
    enum InterOneWeight: String {
        case semibold = "Inter-SemiBold"
    }
}
