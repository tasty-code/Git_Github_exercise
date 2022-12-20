//
//  CreditManager.swift
//  MyCreditManager_targ2t
//
//  Created by 김보미 on 2022/12/06.
//

import Foundation

/// 메뉴의 타입을 정해주는 열거형 enum
enum OptionType: String {
    case addStudent = "1"
    case deleteStudent = "2"
    case addGrade = "3"
    case deleteGrade = "4"
    case average = "5"
    case quit = "X"
    case unknown
    
    /// enum의 value에 따라서 실행해야 할 기능등을 매칭해주는 초기화함수 init
    init(value: String) {
        switch value {
        case "1": self = .addStudent
        case "2": self = .deleteStudent
        case "3": self = .addGrade
        case "4": self = .deleteGrade
        case "5": self = .average
        case "X": self = .quit
        default: self = .unknown
        }
    }
}

// MARK: - 전체적으로 사용될 배열과 상수들의 집합을 모아두었다.
/// 성적, 점수를 각각 Array로 구현 후 Dictionary로 Key-Value를 매칭시킨다. `평점에 활용 예정`
/// CaseIterable 프로토콜, CustomStringConvertible을 사용하는 경우 case로 처리 가능함! - Jason
let grade: [String] = ["A+", "A0", "B+", "B0", "C+", "C0", "D+", "D0", "F"]
let credit: [Double] = [4.5, 4, 3.5, 3, 2.5, 2, 1.5, 1, 0]
let creditByGrade = Dictionary(uniqueKeysWithValues: zip(grade, credit))

/// 학생 성적 목록의 저장형식으로 선언된 구조체이다.
struct StudentCreditList {
    var name: String
    var subject: [String]
    var credit: [String]
}

/// StudentCreditList 구조체를 따르는 배열을 선언한다.
var studentCreditList: [StudentCreditList] = []

// MARK: - CreditManager Class
class CreditManager {
    
    /// 콘솔의 모든 입력 및 출력 요소를 관리하는 클래스(ConsoleIO)를 상수로 선언하여 사용한다.
    let consoleIO = ConsoleIO()
    
    /// 입력받은 옵션 타입을 value로 전환하는 과정을 함수로 선언하여 사용하였다.
    func getOption(_ option: String) -> OptionType {
        return (OptionType(value: option))
    }
    
    /// 실제 프로그램이 실행되는 동안 수행되는 함수이다.
    func creditManager() {
        
        /// 콘솔 프로그램 종료 여부를 판단하기 위해 선언된 변수이다.
        var isRun: Bool = true
        
        /// shouldQuit이 false일 동안 수행될 while 반복문이다.
        /// while true가 되는 무한반복문 사용은 지양하는 것이 좋다 - Jason
        while isRun {
            /// while 반복문 시작과 동시에 사용할 수 있는 메뉴를 모두 print해준다.
            consoleIO.printAllMenu()
            
            /// 메뉴에 대한 입력을 받는 상수를 선언하고 입력받은 내용을 할당한다.
            let inputMenu = getOption(consoleIO.getInput())
            
            /// 입력받은 메뉴를 기점으로 switch문으로 메뉴를 분기처리한다.
            switch inputMenu {
                
                // MARK: - 학생 추가 기능
            case .addStudent:
                /// 학생 추가 안내 문구를 출력한다.
                consoleIO.printAddStudentGuid()
                
                /// 사용자에게 추가할 학생의 이름을 입력받는 상수를 선언하고 입력받은 내용을 할당한다.
                let addStudentName: String = consoleIO.getInput()
                
                /// 학생 이름의 중복여부를 체크할 변수를 선언하고 기본값으로 false를 할당한다.
                var checkDuplicateName: Bool = false
                
                ///  studentCreditList의 요소 중 이름을 하나씩 꺼내서 입력된 이름과 같은지 확인하고 중복여부를 true로 바꾼다.
                for studentCell in studentCreditList {
                    if addStudentName == studentCell.name {
                        checkDuplicateName = true
                        break
                    }
                }
                
                /// 이름이 알파벳으로만 이루어졌는지 확인하기 위한 변수를 선언하고 기본값으로 true를 할당한다.
                var isOnlyAlphabet: Bool = true
                
                /// 이름이 알파벳으로만 이루어져있는지 확인하는 예외처리 함수를 선언한다.
                func checkNameIsOnlyAlphabet(_ name: String) {
                    
                    /// 정규식으로 이름이 알파벳으로만 이루어졌는지 확인하기 위한 조건 pattern을 선언하고 정규식을 할당한다.
                    let pattern = "^[a-zA-Z]*$"
                    
                    /// range를 통하여 pattern으로만 이루어져 있으면 해당 문자를 반환하고
                    /// 알파벳이 아닌 숫자, 특수문자가 들어간 경우 nil을 반환한다.
                    let range = name.range(of: pattern, options: .regularExpression)
                    
                    /// 숫자, 특수문자가 들어간 경우에는 isOnlyAlphabet의 값을 false로 변환한다.
                    if range == nil {
                        isOnlyAlphabet = false
                    }
                }
                
                /// 이름이 알파벳으로만 이루어져있는지 확인하는 예외처리 함수를 실행한다.
                checkNameIsOnlyAlphabet(addStudentName)
                
                /// 예외처리 및 출력을 실행하는 구간이다.
                if addStudentName == "" || !isOnlyAlphabet {
                    /// 1. 잘못된 입력(공백, 숫자)인 경우 에러 메세지를 출력한다.
                    consoleIO.printFuncInputError()
                } else if checkDuplicateName == true {
                    /// 2. 이미 존재하는 학생을 추가하는 경우 에러 메세지를 출력한다.
                    consoleIO.printAddStudentDuplicateError(name: addStudentName)
                } else {
                    /// 정상적으로 추가된 경우 배열에 추가하고 추가 안내 텍스트 출력한다.
                    let addNewStudent = StudentCreditList(name: "\(addStudentName)", subject: [], credit: [])
                    studentCreditList.append(addNewStudent)
                    consoleIO.printAddStudentSuccess(name: addStudentName)
                }
                /// 학생이 잘 추가되었는지 확인하기 위해 print문을 사용한다.
//                print(studentCreditList)
                
                // MARK: - 학생 삭제 기능
            case .deleteStudent:
                /// 학생 삭제 안내 문구를 출력한다.
                consoleIO.printDeleteStudentGuid()
                
                /// 사용자에게 삭제할 학생의 이름을 입력받는 상수를 선언하고 입력받은 내용을 할당한다.
                let deleteStudentName: String = consoleIO.getInput()
                
                /// 삭제할 곳의 Index 값을 가지고 있는 변수를 선언한다.
                var deleteIndex: Int = 0
                
                /// 예외처리 및 출력을 실행하는 if문을 선언한다.
                if  deleteStudentName == "" {
                    /// 1. 잘못된 입력(공백, 저장된 학생 이름이 없는 경우)인 경우 오류 메세지를 출력한다.
                    consoleIO.printFuncInputError()
                } else if studentCreditList.count == 0 {
                    /// 배열이 비어있는 경우 학생이 없으므로 오류 메세지를 출력한다.
                    consoleIO.printStudentMissingError(name: deleteStudentName)
                } else {
                    /// 정상적으로 삭제된 경우 배열에서 삭제하고 삭제 안내 텍스트 출력한다.
                    for studentCell in studentCreditList {
                        if studentCell.name == deleteStudentName {
                            studentCreditList.remove(at: deleteIndex)
                            consoleIO.printDeleteStudentSuccess(name: deleteStudentName)
                            
                            break
                        } else {
                            deleteIndex += 1
                            if deleteIndex == studentCreditList.count {
                                /// 2. 없는 학생을 삭제하는 경우 오류 메세지를 출력한다.
                                consoleIO.printStudentMissingError(name: deleteStudentName)
                            }
                        }
                    }
                    
                }
                /// 학생이 잘 삭제되었는지 확인하기 위해 print문을 사용한다.
//                print(studentCreditList)
                
                
            }
        }
    }
}
