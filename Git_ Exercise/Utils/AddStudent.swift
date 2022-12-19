//
//  AddStudent.swift
//  Git_ Exercise
//
//  Created by 박재우 on 2022/12/19.
//

import Foundation

func addStudent() {
    print(Questions.addStudent.rawValue)
    guard let student = readLine() else { return }
    guard let _ = student.range(of: Pattern.input.rawValue, options: .regularExpression),
          student.isEmpty == false else {
        print(Errors.input.rawValue)
        return
    }
    let isContain = manager.contains { $0.key == student }
    guard isContain == false else {
        print("\(student)\(Errors.containStudent.rawValue)")
        return
    }
    manager[student] = []
    Operations().addStudent(student)
}
