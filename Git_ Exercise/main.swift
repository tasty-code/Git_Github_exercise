//
//  main.swift
//  Git_ Exercise
//
//  Created by 박재우 on 2022/12/18.
//

import Foundation

var manager = Management().students
main: while true {
    print(Questions.main.rawValue)
    guard let input = readLine() else { break main }
    switch Commands(rawValue: input) {
    case .addStudent:
        addStudent()
    case .deleteStudent:
        deleteStudent()
    case .updateGrade:
        updateGrade()
    case .removeGrade:
        removeGrade()
    case .reportCard:
        reportCard()
    case .exit:
        exit()
        break main
    default:
        print(Errors.main.rawValue)
    }
}
