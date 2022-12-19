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
    
    init(name: String) {
        self.name = name
    }
}
