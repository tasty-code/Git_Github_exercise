//
//  CreditManager.swift
//  Git_ Exercise
//
//  Created by sei_dev on 12/19/22.
//

import Foundation

/// creditManager의 DataFile 관련 정보들
enum DataFile {
    /// 데이터가 저장되고 로드하는 json 파일 이름
    static let name = "data.json"
    /// 파일이 저장될 Directory
    static let directory: String = FileManager.default.currentDirectoryPath
    static let pathString = DataFile.directory.appending(DataFile.name)
    static var pathUrl: URL {
        if #available(macOS 13.0, *) {
            return URL(filePath: DataFile.directory.appending(DataFile.name))
        } else {
            return URL(fileURLWithPath: DataFile.directory.appending(DataFile.name))
        }
    }
}

final class CreditManager {
    /// CreditManager - singleton
    static let shared = CreditManager()
    private init() { }
    
    /// CreditManager의 현재 status
    private var status: Status = .start
    /// CreditManager에 등록된 Student의 List
    private var students = [Student]()
    
    func run() {
    }
    
    /// status 별 input parse
    private func parse(input: String) throws -> ParsedInput {
        guard let parsedInput = status.parse(input: input) else {
            throw status == .start ? CMError.invalidStartInput : IOError.wrongInput
        }
        return parsedInput
    }
}

//MARK: - Start

extension CreditManager {
    /// 입력에 따라 credit manager의 status 변경
    private func start(_ input: ParsedInput) throws {
        guard let nextStatus = input[0] as? Status else {
            throw CMError.invalidStartInput
        }
        guard nextStatus != .exit else {
            throw CMError.quitProgram
        }
        guard [Status.start, Status.addStudent].contains(nextStatus) || false == students.isEmpty else {
            throw CMError.emptyStudents
        }
        self.status = nextStatus
    }
}
