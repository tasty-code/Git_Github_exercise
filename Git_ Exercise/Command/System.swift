//
//  System.swift
//  Git_ Exercise
//
//  Created by jun on 2022/12/19.
//

import Foundation

final class System {

    init() {}

    // 명렁어 - 학생추가 구현부
    func addStudent() -> State {
        print("1. 학생추가")
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
}
