//
//  main.swift
//  Git_ Exercise
//
//  Created by 잼킹 on 2022/12/18.
//

import Foundation

// 이름, subject, 성적을 튜플을 넣어주는 리스트
var temp : [(String,String,String)] = [("","","")]

// 이름 추가 삭제용 리스트
var name: [String] = []

// 이름이 존재하는 지 확인해보는 함수
func checkIsIn(temp: [(String,String,String)], findingA: String, findingB: String) -> Bool {
    let count = temp.count
    var find = false
    for i in 0...(count-1){
        if temp[i].0 == findingA && temp[i].1 == findingB{
            find = true
        } else {
            continue
        }
    }
    return find
}

// 이름이 존재한다면, 리스트 중에서 몇번째 인지 index를 알려주는 함수
func checkTheIndex(temp: [(String,String,String)], findingA: String, findingB: String) -> Int{
    let count = temp.count
    var index = 0
    for i in 0...(count-1){
        if temp[i].0 == findingA && temp[i].1 == findingB {
            break
        } else {
            index += 1
        }
    }
    return index
}

// score과 subject를 던지는 함수
func calculateScore(temp: [(String,String,String)], who: String) -> ([String],[String]) {
    let count = temp.count
    var subject: [String] = []
    var score: [String] = []
    for i in 0...(count-1){
        if temp[i].0 == who{
            subject.append(temp[i].1)
            score.append(temp[i].2)
        } else {
            continue
        }
    }
    return (subject, score)
}

// 성적의 총합을 계산해주는 함수
func sumtheScore(scores:[String]) -> Double{
    var sum: Double = 0
    for i in 0...(scores.count-1){
        if scores[i] == "A+"{
            sum += 4.5
        } else if scores[i] == "A0"{
            sum += 4
        } else if scores[i] == "B+"{
            sum += 3.5
        } else if scores[i] == "B0"{
            sum += 3
        } else if scores[i] == "C+"{
            sum += 2.5
        } else if scores[i] == "C0"{
            sum += 2
        } else if scores[i] == "D+"{
            sum += 1.5
        } else if scores[i] == "D0"{
            sum += 1
        } else {
            sum += 0
        }
    }
    return sum
}

// 같은 말하는 함수 따로 빼주기
func macro(){
    print("원하는 기능을 입력해주세요")
    print("1: 학생추가, 2: 학생삭제, 3: 성적추가(변경), 4: 성적삭제, 5: 평점보기, X: 종료")
}
