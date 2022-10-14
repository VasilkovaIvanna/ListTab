//
//  ListViewModel.swift
//  ListTap
//
//  Created by Ivy on 13.09.2022.
//

import Foundation

enum ElementColor {
    case blue
    case orange
}

struct ElementModel {
    var color : ElementColor
    var number : Int
}

class ListViewModel {
    var elementsList : [ElementModel] = []
    
}
