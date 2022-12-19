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

// 성적 평점 구하는 함수
func calculateAverage(_ list: [String]) -> Double {
    var numberList: [Double] = []
    for score in list {
        switch score {
        case "A+":
            numberList.append(4.5)
        case "A0":
            numberList.append(4)
        case "B+":
            numberList.append(3.5)
        case "B0":
            numberList.append(3)
        case "C+":
            numberList.append(2.5)
        case "C0":
            numberList.append(2)
        case "D+":
            numberList.append(1.5)
        case "D0":
            numberList.append(1)
        case "F":
            numberList.append(0)
        default:
            break
        }
    }

    let sum = numberList.reduce(0){$0 + $1}
    let result = sum / Double(list.count)
    return result
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
        while true {
            print("삭제할 학생의 이름을 입력해주세요")
            let studentName = readLine()!

            guard validateInput(studentName) else {
                print("입력이 잘못되었습니다. 다시 확인해주세요")
                continue MAIN
            }

            for item in list {
                if studentName == item["name"] {
                    let findIndex = list.firstIndex(of: item)!
                    list.remove(at: findIndex)
                    print("\(studentName) 학생을 삭제하였습니다")
                    continue MAIN
                }
            }

            print("\(studentName) 학생을 찾기 못했습니다")
            continue MAIN
        }
        
    case "3": // 성적 추가(변경) 기능
        while true {
            print("성적을 추가할 학생의 이름, 과목명, 성적(예: A+, A0, F 등)을 띄어쓰기로 구분하여 차례대로 입력해주세요")
            print("입력 예) tom swift A+")
            print("만약 학생의 성적 중 해당 과목이 존재하면 기존 점수가 갱신됩니다")
            let score = readLine()!
            let scoreList = score.split(separator: " ")

            if scoreList.count != 3 {
                print("입력이 잘못되었습니다. 다시 확인해주세요")
                continue MAIN
            }

            let studentName = String(scoreList[0])
            let subjectName = String(scoreList[1])
            let scoreValue = String(scoreList[2])

            if validateInput(studentName) == false || validateInput(subjectName) == false  {
                print("입력이 잘못되었습니다. 다시 확인해주세요")
                continue MAIN
            }

            let isContain = scoreLevel.contains(scoreValue)
            guard isContain else {
                print("성적 입력이 잘못되었습니다. 다시 확인해주세요")
                continue MAIN
            }

            for item in list {
                if String(item["name"]!) == studentName {
                    // 성적 추가
                    let findIndex = list.firstIndex(of: item)!
                    var findData = list[findIndex]
                    findData[subjectName] = scoreValue
                    list.remove(at: findIndex)
                    list.append(findData)
                    print("\(studentName) 학생의 \(subjectName) 과목이 \(scoreValue)로 추가(변경)되었습니다")
                    continue MAIN
                }
            }

            print("\(studentName) 학생을 찾지 못했습니다. 다시 확인해주세요")
            continue MAIN
        }

    case "4": // 성적 삭제 기능
        print("성적을 삭제할 학생의 이름, 과목명을 띄어쓰기로 구분하여 차례대로 입력해주세요")
        let score = readLine()!
        let scoreList = score.split(separator: " ")

        if scoreList.count != 2 {
            print("입력이 잘못되었습니다. 다시 확인해주세요")
            continue MAIN
        }

        let studentName = String(scoreList[0])
        let subjectName = String(scoreList[1])

        guard validateInput(studentName) && validateInput(subjectName) else {
            print("입력이 잘못되었습니다. 다시 확인해주세요")
            continue MAIN
        }

        for item in list {
            if String(item["name"]!) == studentName {
                let findIndex = list.firstIndex(of: item)!
                var findData = list[findIndex]
                findData[subjectName] = nil
                list.remove(at: findIndex)
                list.append(findData)
                print("\(studentName) 학생의 \(subjectName) 과목의 성적이 삭제되었습니다")
                continue MAIN
            }
        }

        print("\(studentName) 학생을 찾지 못했습니다. 다시 확인해주세요")
        continue MAIN

    case "5": // 평점보기 기능
        while true {
            print("평점을 알고 싶은 학생의 이름을 입력해주세요")
            let studentName = readLine()!

            guard validateInput(studentName) else {
                print("입력이 잘못되었습니다. 다시 확인해주세요")
                continue MAIN
            }

            for item in list {
                if String(item["name"]!) == studentName {
                    var scoreList: [String] = []
                    let findIndex = list.firstIndex(of: item)!
                    let findData = list[findIndex]
                    for (key, value) in findData {
                        if key == "name" {
                            continue
                        }
                        scoreList.append(value)
                        print("\(key): \(value)")
                    }

                    let averageScore = String(format: "%.2f", calculateAverage(scoreList))
                    print("평점: \(averageScore)")
                    continue MAIN
                }
            }

            print("\(studentName) 학생을 찾지 못했습니다. 다시 확인해주세요")
            continue MAIN
        }
    case "X", "x": // 종료 기능
        print("종료")
        isExecute = false
        
    default:
        print("잘못 입력하셨습니다. 1~5 사이의 숫자 또는 X를 입력해주세요")
    }
}
