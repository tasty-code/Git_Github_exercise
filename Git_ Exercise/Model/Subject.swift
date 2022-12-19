//
//  Subject.swift
//  Git_ Exercise
//
//  Created by Mason Kim on 2022/12/19.
//

import Foundation

class Subject: Codable {
    let name: String
    let grade: Grade

    init(name: String, grade: Grade) {
        self.name = name
        self.grade = grade
    }

    func getGrade() -> Grade {
        return grade
    }


}
