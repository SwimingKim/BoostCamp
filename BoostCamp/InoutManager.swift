//
//  FileManager.swift
//  BoostCamp
//
//  Created by 김수영 on 2017. 6. 6..
//  Copyright © 2017년 김수영. All rights reserved.
//

import Foundation

class InoutManager {
    
    // Users/사용자계정
    var path : NSString {
        get {
            let tempDirectory : [String] = NSTemporaryDirectory().characters.split(separator: "/").map(String.init)
            return ("/" + tempDirectory[0] + "/" + tempDirectory[1]) as NSString
        }
    }
    var data : Data?
    
    func readFile() -> Bool {
        // Users/사용자계정/students.json
        let readFile = "students.json"
        let readPath = self.path.appendingPathComponent(readFile)
        
        // 파일 읽기
        if FileManager.default.fileExists(atPath: readPath) {
            do {
                let file = try NSString(contentsOfFile: readPath, encoding: String.Encoding.utf8.rawValue) as String
                self.data = file.data(using: .utf8)
                NSLog(readPath + " 파일 읽기")
                
                return true
                
            } catch let error {
                NSLog(error.localizedDescription)
            }
        }
        else {
            NSLog("파일이 경로에 없습니다")
        }
        
        return false
    }
    
    
    func writeFile(_ writeData : [Students]) {
        let writeFile = "result.txt"
        let writePath = self.path.appendingPathComponent(writeFile)

        // 결과 출력에 필요한 데이터
        var sum : Double = 0
        var personalGrade : String = ""
        var passStudents = Array<String>()
        
        for row in writeData.sorted(by: { $0.name < $1.name }) {
            sum += row.average
            
            personalGrade += "\n\(showName(row.name)) : \(evaluateGrade(row.average))"
            
            if row.isPass {
                passStudents.append(row.name)
            }
        }
        let average = sum / Double(writeData.count)
        
        var ss : String = "steve      "
        NSLog("\(ss.characters.count)")
        
        // 결과 출력을 위한 텍스트
        var contents = "성적결과표"
        contents += "\n\n전체 평균 : \(showNum(average))"
        contents += "\n\n개인별 학점"
        contents += personalGrade
        contents += "\n\n수료생\n"
        for row in 0..<passStudents.count {
            contents += passStudents[row]
            if (row != passStudents.count-1) { contents += ", " }
        }

        NSLog(contents)

        do {
            try contents.write(toFile: writePath, atomically: false, encoding: .utf8)
            NSLog("\(writePath)₩ 파일 쓰기 완료")
        } catch let error {
            NSLog(error.localizedDescription)
        }
    }
    
    func evaluateGrade(_ average : Double) -> String {
        switch Int(average/10) {
        case 10, 9 :
            return "A"
        case 8 :
            return "B"
        case 7 :
            return "C"
        case 6 :
            return "D"
        default :
            return "F"
        }
    }
    
    // 소수점 2자리 표시 함수
    func showNum(_ num : Double) -> Double {
        let numberOfPlaces = 2.0
        let multiplier = pow(10.0, numberOfPlaces)
        
        return round(num * multiplier) / multiplier
    }
    
    // 문자열 칸 지정하는 함수
    func showName(_ value : String) -> String {
        var newValue = value
        
        while newValue.characters.count != 10 {
            newValue += " "
        }
        
        return newValue
    }
    
    
    
}
