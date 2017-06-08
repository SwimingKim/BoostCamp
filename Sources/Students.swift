//
//  Students.swift
//  BoostCamp
//
//  Created by 김수영 on 2017. 6. 6..
//  Copyright © 2017년 김수영. All rights reserved.
//
import Foundation

class Students {
    
    var name : String
    var scores : Array<Int>
    
    var total : Int {
        get {
            var sum = 0
            for row in self.scores {
                sum += row
            }
            
            return sum
        }
    }
    var average : Double {
        get {
            let length = Double(self.scores.count)
            return Double(self.total) / Double(length)
        }
    }
    var isPass : Bool {
        get {
            if self.average >= 70 {
                return true
            }
            return false
        }
    }
    
    init(name : String, scores : Array<Int>) {
        self.name = name
        self.scores = scores
    }

}
