//
//  main.swift
//  Git_ Exercise
//
//  Created by 잼킹 on 2022/12/18.
//

import Foundation

final class DataManager {
    
    private let defaults = UserDefaults.standard
    
    /// students: [ name : [ subject : point ]
    var students : [String:[String:String]] = [:]
    private let grades: [String:Double] = [ "A+":4.5, "A0":4, "B+":3.5, "B0":3, "C+":2.5, "C0":2, "D+":1.5, "D0":1, "F":0]
    

    func setStoredData() {
        
        let storedData = defaults.dictionary(forKey: "studentsData")
        
        if storedData?.count != nil { students = storedData as! [String:[String:String]] }
        else { students = [:] }
    }
    
    func saveData() {
        defaults.set(students, forKey: "studentsData")
        UserDefaults.standard.synchronize()
    }
    
    func convertGradeToPoint(grade: String) -> Double?{
        
        if let point = grades[grade]{
            return point
        }
        print(#function)
        print("⚠️ Error: convert fail")
        return nil
    }
    
    
    ///이름 체크 -> 결과에 따라 함수분기 : readLine 입력 받은 후 사용할 것
    ///trueAction : 학생이름 있을때 액션     /  falseAction : 학생이름이 없을때 액션
    func nameCheckAndAction(name: String?, trueAction: (_ name: String) -> Void, falseAction: (_ name: String) -> Void) {
        
        guard let name else { print("⚠️ 입력이 잘못되었습니다. 다시 확인해주세요."); return }
        let studentName = name.trimmingCharacters(in: .whitespaces).firstUppercased
        
        if studentName.isEmpty {
            print("⚠️ 입력이 없습니다. 다시 확인해주세요.")
            return
        }
        if students.contains(where: { (key: String, value: [String:String]) in
            return key == studentName
        }){
            trueAction(studentName)
            return
        }else{
            falseAction(studentName)
            return
        }
    }
    
    //학생추가
    func addStudent(){
        print("추가할 학생의 이름을 입력해주세요.")
        let studentName: String? = readLine()
        
        nameCheckAndAction(name: studentName) { name in
            print("⚠️ \(name)은 이미 존재하는 학생입니다. 추가하지 않습니다.")
        } falseAction: { name in
            students[name] = .init([:])
            print("✅ \(name) 학생을 추가했습니다.")
        }
    }
    
    //학생삭제
    func deleteStudent(){
        print("삭제할 학생의 이름을 입력해주세요.")
        let studentName: String? = readLine()
        
        nameCheckAndAction(name: studentName) { name in
            students[name] = nil
            print("✅  \(name) 학생을 삭제하였습니다.")
        } falseAction: { name in
            print("⚠️ \(name) 학생을 찾지 못했습니다.")
        }
    }
    
    //성적추가(변경)
    func updateGrades(){
        print("성적을 추가할 학생의 이름, 과목 이름, 성적(A+, A, F 등)을 띄어쓰기로 구분하여 차례로 작성해 주세요.\n입력예) Mickey Swift A+")
        let inputData = readLine()
        guard let inputData else { print("⚠️ 입력이 잘못되었습니다. 다시 확인해주세요."); return }
        let studentData = inputData.split(separator: " ")
        if studentData.count < 3 {
            print("⚠️ 입력이 잘못되었습니다. 다시 확인해주세요.")
            return
        }
        
        let name = String(studentData[0])
        let subject = String(studentData[1]).firstUppercased
        let grade = String(studentData[2]).firstUppercased
        
        if !grades.keys.contains(grade){
            print("⚠️ 잘못된 점수를 입력했습니다. 다시 확인해주세요.")
            return
        }
        
        print("[✅  \(name) 학생의 \(subject) 과목이 \(grade)로 추가(변경) 되었습니다. ]")
        nameCheckAndAction(name: name) { name in
            students[name]?.updateValue(grade, forKey: subject)
        } falseAction: { name in
            print("⚠️ \(name) 학생을 찾지 못했습니다.")
        }
    }
    
    //성적삭제
    func deleteGrade(){
        print("성적을 삭제할 학생의 이름, 과목 이름을 띄어쓰기로 구분하여 차례로 작성해주세요.\n입력예) Mickey Swift")
        let inputData = readLine()
        guard let inputData else { print("⚠️ 입력이 잘못되었습니다. 다시 확인해주세요."); return }
        let studentData = inputData.split(separator: " ")
        if studentData.count < 2 { print("⚠️ 입력이 잘못되었습니다. 다시 확인해주세요."); return }
        
        let name = String(studentData[0]).firstUppercased
        let subject = String(studentData[1]).firstUppercased
        
        print("✅ \(name) 학생의 \(subject) 과목의 성적이 삭제되었습니다.")
        nameCheckAndAction(name: name) { name in
            students[name]?.removeValue(forKey: subject)
        } falseAction: { name in
            print("⚠️ \(name) 학생을 찾지 못했습니다.")
        }
    }
    
    //평점보기
    func getCredit(){
        print("평점을 알고싶은 학생의 이름을 입력해주세요.")
        let inputData = readLine()
        nameCheckAndAction(name: inputData) { name in
            let datas = students[name]?.compactMap({ (key: String, value: String) in
                return (key, value)
            })
            var totalPoint = 0.0
            if datas?.count != 0 {
                datas?.forEach{ data in
                    print("\(data.0): \(data.1)")
                    if let point = convertGradeToPoint(grade: data.1){
                        totalPoint += point
                    }
                }
                
                totalPoint = totalPoint/Double(datas!.count)
                let credit = String(format: "%.2f", totalPoint).trimmingCharacters(in: ["0","."])
                print("✅ 평점: \(credit)")
            } else {
                print("⚠️ 학생의 성적이 없습니다.")
            }
            
        } falseAction: { name in
            print("⚠️ \(name) 학생을 찾지 못했습니다.")
        }
    }
}


extension StringProtocol {
    var firstUppercased: String { return prefix(1).uppercased() + dropFirst() }
    var firstCapitalized: String { return prefix(1).capitalized + dropFirst() }
}




let dataManager = DataManager()
dataManager.setStoredData()
runProgram()

func runProgram() {

    print("\n\n원하는 기능을 입력해주세요.\n| 1: 학생추가 | 2: 학생삭제 | 3: 성적추가(변경) | 4: 성적삭제 | 5: 평점보기 | X: 종료 |")
    
    let userInput: String? = readLine()?.lowercased()
    
    switch userInput {
    case "1":
        print("[ 학생추가 ]")
        dataManager.addStudent()
        runProgram()
        
    case "2":
        print("[ 학생삭제 ]")
        dataManager.deleteStudent()
        runProgram()
        
    case "3":
        print("[ 성적추가(변경) ]")
        dataManager.updateGrades()
        runProgram()
        
    case "4":
        print("[ 성적삭제 ]")
        dataManager.deleteGrade()
        runProgram()
        
    case "5":
        print("[ 평점보기 ]")
        dataManager.getCredit()
        runProgram()
        
    case "x":
        dataManager.saveData()
        print("🍕 프로그램을 종료합니다..")
   
    default:
        print("⚠️ 뭔가 입력이 잘못되었습니다. 1~5 사이의 숫자 혹은 X를 입력해주세요.")
        runProgram()
    }
}
