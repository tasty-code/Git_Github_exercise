//
//  main.swift
//  Git_ Exercise
//
//  Created by 잼킹 on 2022/12/18.
//

import Foundation

var runValue: Bool = true

class MyCreditManager {
    
    func showMenu() {
        print(StringLiterals.Menu.startProgram)
    }
    
    func getUserInput() {
        guard let input = readLine() else { return }
        selectMenu(input: input)
    }
    
    private func printWrongMenuError() {
        print(StringLiterals.Menu.wrongMenu)
    }
    
    private func selectMenu(input: String) {
        let menu = Menu(rawValue: input)
        switch menu {
        case .addStudent:
            addStudentProgram()
        case .deleteStudent:
            deleteStudentProgram()
        case .addOrChangeGrades:
            addOrChangeGradesProgram()
        case .deleteGrades:
            deleteGradesProgram()
        case .showGrades:
            showGradesProgram()
        case .exitProgram:
            exitProgram()
        default:
            printWrongMenuError()
        }
    }
    
    private func addStudentProgram() {
        print(StringLiterals.Student.addStudentMessage)
    }
    
    private func deleteStudentProgram() {
        print(StringLiterals.Student.deleteStudentMessage)
    }
    
    private func addOrChangeGradesProgram() {
        print(StringLiterals.Grades.addOrChangeGradesMessage)
    }
    
    private func deleteGradesProgram() {
        print(StringLiterals.Grades.deleteGradesMessage)
    }
    
    private func showGradesProgram() {
        print(StringLiterals.Grades.showGradesMessage)
    }
    
    private func exitProgram() {
        print(StringLiterals.Menu.exitProgram)
        runValue = false
    }
}

func main() {
    
    let myCreditManager = MyCreditManager()
    
    while runValue {
        myCreditManager.showMenu()
        myCreditManager.getUserInput()
    }
}

main()
