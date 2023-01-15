//
//  TaskCategory.swift
//  TaskPlanner
//
//  Created by Dervis YILMAZ on 9.01.2023.
//

import SwiftUI
// MARK: Category Enum
enum Category: String, CaseIterable{
    case general = "General"
    case bug = "Bug"
    case idea = "Idea"
    case modifiers = "Modifiers"
    case challange = "Challange"
    case coding = "Coding"
    
    var color: Color{
        switch self{
            case .general:
                return Color("Gray")
        case .bug:
                return Color("Green")
        case .idea:
            return Color("Pink")
        case .modifiers:
            return Color("Blue")
        case .challange:
            return Color.red
        case .coding:
            return Color.brown
        }
        
    }
    
}
