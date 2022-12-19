//
//  Controller.swift
//  Git_ Exercise
//
//  Created by Mason Kim on 2022/12/19.
//

import Foundation

class Controller {
    private let studentList = StudentList()
    
    func userSelectMenu() -> Bool {
        ConsoleView.printUserSelectMenu()
        let input = ConsoleView.userInput()

        if input.lowercased() == "x" {
            ConsoleView.printTerminateProgram()
            return false
        }

        guard InputChecker.checkUserSelectMenuInput(input: input) else {
            ConsoleView.printUserSelectMenuError()
            return true
        }

        switch input {
        case "1":
            addStudent()
        default:
            break
        }

        return true
    }

    func addStudent() {
        ConsoleView.printAddStudentInform()
        let input = ConsoleView.userInput()
        guard input.isEmpty == false else { return ConsoleView.printInputError() }
        studentList.addStudent(name: input)
    }
}
