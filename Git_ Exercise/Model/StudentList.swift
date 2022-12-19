//
//  StudentList.swift
//  Git_ Exercise
//
//  Created by Mason Kim on 2022/12/19.
//

import Foundation

class StudentList {
    private var students = [Student]()

    func addStudent(name: String) {
        guard students.contains(where: { $0.name == name }) == false else { return ConsoleView.printStudentAlreadyExists(name: name) }

        students.append(Student(name: name))
        ConsoleView.printAddStudentComplete(name: name)
    }

}
