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
}
