//
//  QuizModel.swift
//  CGTrivia
//
//  Created by Sain-R Edwards Jr. on 10/22/17.
//  Copyright © 2017 Appybuildmore Apps. All rights reserved.
//

import UIKit

class QuizModel: NSObject {

    func getQuestions() -> [Question] {
        
        var questions = [Question]()
        
        // Get array of dictionaries from JSON File
        let array = getLocalJsonFile()
        
        // Parse dictionary into Question objects
        for dict in array {
            
            // Create question object
            let q = Question()
            
            // Assign question properties
            q.questionText = dict["question"] as! String
            q.answers = dict["answers"] as! [String]
            q.correctAnswerIndex = dict["correctAnswerIndex"] as! Int
            q.feedback = dict["feedback"] as! String
            
            // Add the question object into the array
            questions += [q]
            
        }
        
        // Return list of question objects
        return questions
    }
    
    func getLocalJsonFile() -> [[String:Any]] {
        
        do {
        
            // Get path to json file in bundle
            let bundlePath = Bundle.main.path(forResource: "QuestionData", ofType: "json")
            
            if let actualBundlePath = bundlePath {
                
                // Create url object
                let url = URL(fileURLWithPath: actualBundlePath)
                
                // Create data object
                let data = try Data(contentsOf: url)
                
                // Use JsonSerialization to turn data into array of dictionaries
                let array = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as! [[String:Any]]
                
                return array
            }
        }
        catch {
            // Something wrong happened
        }
        return [[String:Any]]()
    }
    
}
