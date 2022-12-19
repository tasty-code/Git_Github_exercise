//
//  System.swift
//  Git_ Exercise
//
//  Created by jun on 2022/12/19.
//

import Foundation

final class System {
    private var students: [Student]

    init() {
        self.students = []
    }
    // 명렁어 - 학생추가 구현부
    func addStudent() -> State {
        // 설명 안내 문구 출력, 추가할 학생의 이름을 입력받음
        // EOF(Ctrl + D)는 프로그램 종료로 처리
        guard let studentName = getLine(messageType: .pleaseInputStudentNameToAdd) else {
            return .quit
        }
        // 이름 유효성 검사
        guard checkValidInput(studentName) else {
            printMessage(messageType: .inputError)
            return .continued
        }
        // 이미 존재하는 이름은 사용할 수 없음
        if let index = findStudentIndex(name: studentName) {
            print(self.students[index].name, terminator: "")
            printMessage(messageType: .cannotAddStudentAlreadyExistName)
            return .continued
        }
        self.students.append(Student(name: studentName))
        print(studentName, terminator: " ")
        printMessage(messageType: .addedStudent)
        return .continued
    }

    // 명렁어 - 학생삭제 구현부
    func deleteStudent() -> State {
        print("2. 학생삭제")
        return .continued
    }

    // 명렁어 - 성적추가(변경) 구현부
    func updateGrade() -> State {
        print("3. 성적추가(변경)")
        return .continued
    }

    // 명렁어 - 성적삭제 구현부
    func deleteGrade() -> State {
        print("4. 성적삭제")
        return .continued
    }

    // 명렁어 - 평점보기 구현부
    func showGPA() -> State {
        print("5. 성적삭제")
        return .continued
    }

    // 명렁어 - 종료 구현부
    func quit() -> State {
        return .quit
    }

    // 이름으로 학생이 존재하는지 확인 후 인덱스 반환
    func findStudentIndex(name: String) -> Int? {
        for (index, student) in students.enumerated() where student.name == name {
            return index
        }
        return nil
    }

    // 입력값 유효성 검사
    func checkValidInput(_ name: String) -> Bool {
        // ""은 유효하지 않은 입력
        guard !name.isEmpty else {
            return false
        }
        // 한글 및 다른 문자 체계는 이름으로 사용할 수 없음
        guard name.filter({$0.isASCII && $0 != "\0"}).count == name.count else {
            return false
        }
        return true
    }
}
