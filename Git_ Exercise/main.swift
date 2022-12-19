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

class DataBase: Codable
{
    private var students: [String:Student] = [:]
    
    //- 이미 존재하는 학생은 다시 추가하지 않습니다 -> stuents에 데이터가 있는지 없는지 확인하는게 필요함
    
    func checkExist(name: String) -> Bool //존재해?
    {
        return students[name] != nil //nil이 아니야?
    }
    
    func addStudent(name:String)
    {
        if !checkExist(name: name) {
            students[name] = Student(name:name)
        }
    }
    
    func deleteStudent(name: String)
    {
        students[name] = nil //students의 키값을 nil처리해서 삭제하기
    }
    
    func addCourse(name: String, course: Course)
    {
        students[name]?.courses[course.name] = course
    }
    
    func deleteCourse(name: String, courseName: String)
    {
        students[name]?.courses[courseName] = nil
    }
    
    func checkGrade(name: String) -> String
    {
        var result = "" //과목명 저장할 변수
        var score:Float = 0.0 //평점 계산 결과 저장할 변수 초기화
        let targetCourses = students[name]!.courses // 바깥 checkGrade함수에서 존재여부 확인해서 강제언래핑 사용
        
        // course에서 course만 사용하겠다. courses객체의 key값 사용 안함. course에 과목명, 성적 다 있기 때문에
        for(_, course) in targetCourses {
            result.append("\(course.name): \(course.grade)\n")
            score += gradeDict[course.grade] ?? 0.0 //gradeDict Key값에 없는게 들어오면 0.0으로 처리해줌
        }
        
        score /= Float(targetCourses.count) // 과목수 몇개인지 확인해서 나누고 평균 계산 (count 하면 Int라 Float 처리)
        result.append(String(format:"평점 : %.2f", score))
        return result
    }
    
