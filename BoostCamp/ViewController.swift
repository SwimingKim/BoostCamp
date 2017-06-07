//
//  ViewController.swift
//  BoostCamp
//
//  Created by 김수영 on 2017. 6. 6..
//  Copyright © 2017년 김수영. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let manager = InoutManager()
        if manager.readFile() {
            let writeData : [Students] = parseJSON(manager.data!)!
            manager.writeFile(writeData)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // JSON Parsing
    func parseJSON(_ rawData : Data) -> [Students]? {
        
        do {
            var studentList = Array<Students>()
            
            // json 파일 불러오기
            let json = try JSONSerialization.jsonObject(with: rawData, options: []) as? [Any]
            
            for row in json! {
                let r = row as! [String:Any]
                
                let name = r["name"] as! String
                let grades = r["grade"] as! NSDictionary
                
                var scores = Array<Int>()
                for row in grades {
                    let score = row.value as! Int
                    scores.append(score)
                }
                
                let student = Students(name: name, scores: scores)
                studentList.append(student)
            }
            return studentList
            
        } catch let error {
            NSLog(error.localizedDescription)
        }
        
        return nil
    }
    
    
}

