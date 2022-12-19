//
//  main.swift
//  Git_ Exercise
//
//  Created by 잼킹 on 2022/12/18.
//

import Foundation

var runValue: Bool = true

class MyCreditManager {
    
    var studentDictionary = [String : Student]()
    
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
    
    private func printInputError() {
        print(StringLiterals.Menu.wrongInput)
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
    
    private func isExistStudent(_ name: String) -> Bool {
        if let _ = studentDictionary[name] {
            return true
        } else {
            return false
        }
    }
    
    private func addStudentProgram() {
        print(StringLiterals.Student.addStudentMessage)
        guard let name = readLine() else {
            printInputError()
            return
        }
        
        if isExistStudent(name) {
            print("\(name)\(StringLiterals.Student.alredyExistError)")
        } else {
            studentDictionary[name] = Student(name: name)
            print(name, StringLiterals.Student.addStudentSuccess)
        }
    }
    
    private func deleteStudentProgram() {
        print(StringLiterals.Student.deleteStudentMessage)
        
        guard let name = readLine() else {
            printInputError()
            return
        }
        
        if isExistStudent(name) {
            studentDictionary.removeValue(forKey: name)
            print(name, StringLiterals.Student.deleteStudentSuccess)
        } else {
            print(name, StringLiterals.Student.nonExistError)
        }
    }
    
    private func addOrChangeGradesProgram() {
        print(StringLiterals.Grades.addOrChangeGradesMessage)
        
        let input = readLine()!.split(separator: " ").map { String($0) }
        
        if input.count != 3 || !isExistStudent(input[0]) {
            printInputError()
            return
        }
        
        let (name, subject, score) = (input[0], input[1], input[2])
        
        if let student = studentDictionary[name] {
            student.grades[subject] = score
            print(name, StringLiterals.Grades.studentSuccess,
                  subject, StringLiterals.Grades.subjectSuccess,
                  "\(score)\(StringLiterals.Grades.scoreSuccess)")
        } else {
            print(name,StringLiterals.Student.nonExistError)
        }
    }
    
    private func deleteGradesProgram() {
        print(StringLiterals.Grades.deleteGradesMessage)
        
        let input = readLine()!.split(separator: " ").map { String($0) }
        
        if input.count != 2 || !isExistStudent(input[0]) {
            printInputError()
            return
        }
        
        let (name, subject) = (input[0], input[1])
                
        if let student = studentDictionary[name] {
            student.grades.removeValue(forKey: subject)
            print(name, StringLiterals.Grades.studentSuccess,
                  subject, StringLiterals.Grades.deleteSuccess)
        } else {
            print(name,StringLiterals.Student.nonExistError)
        }
    }
    
    private func showGradesProgram() {
        print(StringLiterals.Grades.showGradesMessage)
        
        guard let name = readLine() else {
            printInputError()
            return
        }
        
        if isExistStudent(name) {
            if let student = studentDictionary[name] {
                for grade in student.grades {
                    print("\(grade.key): \(grade.value)")
                }
            }
        } else {
            print(name, StringLiterals.Student.nonExistError)
        }
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
