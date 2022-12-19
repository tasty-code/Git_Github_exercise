//
//  InputChecker.swift
//  Git_ Exercise
//
//  Created by Mason Kim on 2022/12/19.
//

import Foundation

struct InputChecker {

    static func checkUserSelectMenuInput(input: String) -> Bool {
        if input.lowercased() == "x" {
            return true
        }
        guard let num = Int(input), 1...5 ~= num else {
            return false
        }
        return true
    }
    
    static func checkUpdateScoreInput(input: String) -> Bool {
        let inputArray = input.split(separator: " ")
        guard inputArray.count == 3,
            Grade(string: String(inputArray.last ?? "")) != nil else {
            return false
        }
        return true
    }

}
