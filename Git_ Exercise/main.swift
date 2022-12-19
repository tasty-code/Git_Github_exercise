import Foundation

let gradeDict: [String:Float] =
[
    "A+":4.5,
    "A0":4.0,
    "B+":3.5,
    "B0":3.0,
    "C+":2.5,
    "C0":2.0,
    "D+":1.5,
    "D0":1.0,
    "F":0.0
]

struct Course: Codable // 성적(Course)은 과목이름과 점수로 이루어져있다. (ex. Swift, A+)
{
    var name: String //Swift
    var grade: String //A+
}

// 학생 이름과 성적을 묶을 구조체를 하나 만든다.
struct Student: Codable
{
    var name: String
    var courses: [String:Course] = [:]
}

