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

    func removeStudent(name: String) {
        guard let index = students.firstIndex(where: { $0.name == name }) else { return ConsoleView.printStudentNotFound(name: name) }

        students.remove(at: index)
        ConsoleView.printRemoveStudentComplete(name: name)
    }

    func updateScore(studentName: String, subject: Subject) {
        guard let student = students.first(where: { $0.name == studentName }) else { return ConsoleView.printStudentNotFound(name: studentName) }

        student.updateScore(subject: subject)
        ConsoleView.printUpdateScoreComplete(studentName: studentName, subjectName: subject.name, grade: subject.getGrade().description)
    }
}
