import Foundation

var list: [Dictionary<String, String>] = []
var isExecute = true

MAIN: while isExecute {
    print("원하는 기능을 입력해주세요")
    print("1: 학생 추가, 2: 학생 삭제, 3: 성적 추가(변경), 4: 성적 삭제, 5: 평점보기, X: 종료 ")
    let menu = readLine()!

    switch menu {
    case "1": // 학생 추가 기능
        print("_")

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
