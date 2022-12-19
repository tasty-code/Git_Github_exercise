import Foundation

var list: [Dictionary<String, String>] = []
let scoreLevel: [String] = ["A+", "A0", "B+", "B0", "C+", "C0", "D+", "D0", "F"]
var isExecute = true

// 인풋값이 숫자, 문자인지 확인하는 함수
func validateInput(_ value: String) -> Bool{
    let pattern = "^[0-9a-zA-Z]*$"
    let predicate = NSPredicate(format: "SELF MATCHES %@", pattern)
    let isValid = predicate.evaluate(with: value)
    return isValid
}

MAIN: while isExecute {
    print("원하는 기능을 입력해주세요")
    print("1: 학생 추가, 2: 학생 삭제, 3: 성적 추가(변경), 4: 성적 삭제, 5: 평점보기, X: 종료 ")
    let menu = readLine()!

    switch menu {
    case "1": // 학생 추가 기능
        while true {
            print("추가할 학생의 이름을 입력해주세요")
            let studentName = readLine()!

            guard validateInput(studentName) else {
                print("입력이 잘못되었습니다. 다시 확인해주세요")
                continue MAIN
            }

            for item in list {
                if item["name"] == studentName {
                    print("\(studentName) 학생은 이미 존재합니다. 추가하지 않습니다")
                    continue MAIN
                }
            }

            list.append(["name": studentName])
            print("\(studentName) 학생을 추가하였습니다")
            continue MAIN
        }

    case "2": // 학생 삭제 기능
        print("_")
    case "3": // 성적 추가(변경) 기능
        print("_")

    case "4": // 성적 삭제 기능
        print("_")

    case "5": // 평점보기 기능
        print("_")
    case "X", "x": // 종료 기능
        print("_")
    default:
        print("잘못 입력하셨습니다. 1~5 사이의 숫자 또는 X를 입력해주세요")
    }
}
