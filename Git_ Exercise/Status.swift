//
//  Status.swift
//  Git_ Exercise
//
//  Created by sei_dev on 12/19/22.
//

import Foundation

typealias ParsedInput = [Codable]

/// status 정보
enum Status: String, Codable {
    case start = "0"
    case addStudent = "1"
    case deleteStudent = "2"
    case addScore = "3"
    case deleteScore = "4"
    case showScoreAverage = "5"
    case exit = "X"
}

//MARK: - Info Message

extension Status {
    var infoMessage: String {
        switch self {
        case .start:
            return Info.start
        case .addStudent:
            return Info.Student.forAdd
        case .deleteStudent:
            return Info.Student.forDelete
        case .addScore:
            return Info.Score.forAdd
        case .deleteScore:
            return Info.Score.forDelete
        case .showScoreAverage:
            return Info.Score.forAverage
        default:
            return ""
        }
    }
}
