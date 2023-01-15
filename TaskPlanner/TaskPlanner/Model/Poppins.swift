//
//  File.swift
//  TaskPlanner
//
//  Created by Dervis YILMAZ on 9.01.2023.
//

import SwiftUI

enum Poppins{
    case regular
    case medium
    case bold
    
    var weight: Font.Weight{
        switch self {
        case .regular:
            return .regular
        case .medium:
            return .medium
        case .bold:
            return .bold
        }
    }
    
}

extension View {
    
    func poppins(_ size: CGFloat,_ weight: Poppins)-> some View{
        self
            .font(.custom("Poppins", size: size))
            .fontWeight(weight.weight)
    }
}
