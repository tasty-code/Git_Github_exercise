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
    func makeFolder() {
        // FileManager 인스턴스 생성
        let fileManager: FileManager = FileManager.default
        // 사용자의 문서 경로
        let documentPath: URL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        // 파일을 저장할 디렉토리 경로(URL) 반환 (경로 추가)
        let directoryPath: URL = documentPath.appendingPathComponent("MyCreditManagerSave")
        // 디렉토리에 만들 '파일이름.확장자' 설정 (경로에 'hi.txt'의 새 경로 추가)
        
        
        // 파일매니저로 디렉토리 생성하기
        do {
            // 아까 만든 디렉토리 경로에 디렉토리 생성 (폴더가 만들어진다.)
            try fileManager.createDirectory(at: directoryPath, withIntermediateDirectories: false, attributes: nil)
        } catch _ {
           // print(e.localizedDescription)
        }
    }
   
    func save() {
        // FileManager 인스턴스 생성
        let fileManager: FileManager = FileManager.default
        // 사용자의 문서 경로
        let documentPath: URL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        // 파일을 저장할 디렉토리 경로(URL) 반환 (경로 추가)
        let directoryPath: URL = documentPath.appendingPathComponent("MyCreditManagerSave")
        // 디렉토리에 만들 '파일이름.확장자' 설정 (경로에 'hi.txt'의 새 경로 추가)
        let textPath: URL = directoryPath.appendingPathComponent("save.txt")
        
        // 1. encoder instance 생성
        var result = ""
        do{
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted // 출력용 설정
            
            // 2. encode method 로 Codable 준수하는 타입의 instance 넘기기
            let data = try encoder.encode(database.students)
            
            result = (String(data: data, encoding: .utf8)!)
            //optional forced unwrapping
        }catch _ {
            print("")
        }
        
        if let data: Data = result.data(using: String.Encoding.utf8) { // String to Data
            do {
                try data.write(to: textPath) // 위 data를 "hi.txt"에 쓰기
            } catch _ {
//                print(e.localizedDescription)
            }
        }
    }
    func load() {
        let fileManager: FileManager = FileManager.default
        // 사용자의 문서 경로
        let documentPath: URL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        // 파일을 저장할 디렉토리 경로(URL) 반환 (경로 추가)
        let directoryPath: URL = documentPath.appendingPathComponent("MyCreditManagerSave")
        // 디렉토리에 만들 '파일이름.확장자' 설정 (경로에 'hi.txt'의 새 경로 추가)
        let textPath: URL = directoryPath.appendingPathComponent("save.txt")
        
        do {
            let dataFromPath: Data = try Data(contentsOf: textPath) // URL을 불러와서 Data타입으로 초기화
            let text: String = String(data: dataFromPath, encoding: .utf8) ?? "문서없음" // Data to String
            
            // 1. JSON 데이터를 담은 Data 인스턴스 생성
            let jsonData = text.data(using: .utf8)!
              
            // 2. decoder 인스턴스 생성
            let decoder = JSONDecoder()
              
            // 3. 타입과 json data 를 decode method 에 넘기면 Point 인스턴스 반환
            let result = try decoder.decode([String:Student].self, from: jsonData)
              students = result
              
//            print([String:Student])
            
//            print(text) // 출력
        } catch _ {
//            print(e.localizedDescription)
        }
    }
    func saves() {
        // FileManager 인스턴스 생성
        let fileManager: FileManager = FileManager.default
        // 사용자의 문서 경로
        let documentPath: URL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
        // 파일을 저장할 디렉토리 경로(URL) 반환 (경로 추가)
        let directoryPath: URL = documentPath.appendingPathComponent("MyCreditManagerSave")
        // 디렉토리에 만들 '파일이름.확장자' 설정 (경로에 'hi.txt'의 새 경로 추가)
        let textPath: URL = directoryPath.appendingPathComponent("save.txt")
        
        // 1. encoder instance 생성
        var result = ""
        do{
            let encoder = JSONEncoder()
            encoder.outputFormatting = .prettyPrinted // 출력용 설정
            
            // 2. encode method 로 Codable 준수하는 타입의 instance 넘기기
            let data = try encoder.encode(database.students)
            
            result = (String(data: data, encoding: .utf8)!)
            //optional forced unwrapping
        }catch _ {
            print("")
        }
        
        if let data: Data = result.data(using: String.Encoding.utf8) { // String to Data
            do {
                try data.write(to: textPath) // 위 data를 "hi.txt"에 쓰기
            } catch _ {
//                print(e.localizedDescription)
            }
        }
    }
    
}

var database = DataBase()
database.makeFolder()
database.load()

var running = true
    // while true 구문에 사용하기 위한 변수. false로 바꿔주면 프로그램이 종료되게(프로그램 종료 메뉴에 활용)
while running
{
    print("원하는 기능을 입력해주세요\n1: 학생추가, 2: 학생삭제, 3: 성적추가(변경), 4: 성적삭제, 5: 평점보기, X: 종료")
    /*input을 받기 위해 readLine() 사용. readLine()은 입력을 모두 optional String으로 처리함.
     콘솔창에서 입력받기 때문에 nil값이 들어오는것을 고려하지 않음*/
    let inputMenu = readLine() ?? ""
    /*
     switch case 구문을 활용해 input값에 해당하는 함수를 실행시켜줄것. 메뉴 이름에 매칭되게 함수 이름을 설정해준다.
     1: addStudent(), 2: deleteStudent(), 3: addCourse(), 4: deleteCourse(), 5:checkGrade(), X:endProgram()
     */
    switch inputMenu
    {
    case "1": addStudent()
    case "2": deleteStudent()
    case "3": addCourse()
    case "4": deleteCourse()
    case "5": checkGrade()
    case "X": endProgram()
    default: print("뭔가 입력이 잘못되었습니다. 1~5 사이의 숫자 혹은 X를 입력해주세요.")
        continue
        /*swich case는 비교값이 확실하지 않은경우(ex: 총 요소 :5개 와 같이 확실한 경우가 아니면) default 써줘야함.
         continue는 case 이외의 입력값이 들어오면 while running 첫부분으로 돌아가도록.*/
        
    }
}
