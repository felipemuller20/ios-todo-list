//
//  File.swift
//  todolist
//
//  Created by Felipe Muller on 05/08/23.
//

import Foundation

struct Task {
    var id = UUID()
    var date: Date = Date()
    var task: String = ""
    var category: Category = Category(name: "Marketing", color: .black)
}
