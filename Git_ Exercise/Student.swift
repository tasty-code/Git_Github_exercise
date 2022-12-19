//
//  Student.swift
//  Git_ Exercise
//
//  Created by sei_dev on 12/19/22.
//

import Foundation

final class Student: Codable {
    let name: String
    private(set) var scores = [String:Score]()
    
    var isCourseEmpty: Bool {
        return scores.isEmpty
    }
    
    var averageScore: Float {
        let total = scores.values.reduce(0) { $0 + $1.rawValue }
        return total/Float(scores.values.count)
    }
    
    init(name: String) {
        self.name = name
    }
}
