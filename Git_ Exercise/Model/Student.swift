//
//  Student.swift
//  Git_ Exercise
//
//  Created by Mason Kim on 2022/12/19.
//

import Foundation

class Student {
    let name: String
    private var subjects = [Subject]()

    init(name: String) {
        self.name = name
    }

    func updateScore(subject: Subject) {
        if let index = subjects.firstIndex(where: { $0.name == name }) {
            subjects[index] = subject
        } else {
            subjects.append(subject)
        }
    }

    func removeScore(subjectName: String) -> Bool {
        if let index = subjects.firstIndex(where: { $0.name == subjectName }) {
            subjects.remove(at: index)
            return true
        } else {
            ConsoleView.printSubjectNotFound(subjectName: subjectName)
            return false
        }
    }


}
