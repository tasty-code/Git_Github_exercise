//
//  IOManager.swift
//  Git_ Exercise
//
//  Created by sei_dev on 12/19/22.
//

import Foundation

/// Console output type
enum OutputType {
    case information
    case reaction
    case error
}

enum IOManager {
    static let nameRegex = "^[A-Za-z0-9_]+$"
    
    /// 사용자 입력 받기
    static func getInput(isStartStatus: Bool) throws -> String {
        guard let input = readLine(),
              input != "" else {
            throw isStartStatus ? CMError.invalidStartInput : IOError.wrongInput
        }
        return input
    }
    
    static func checkValidity(of str: String) -> Bool {
        return str.range(of: Self.nameRegex, options: .regularExpression, range: nil, locale: nil) != nil
    }
    
}
