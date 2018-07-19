//
//  CalculateTime.swift
//  MeetUp
//
//  Created by Cappillen on 7/18/18.
//  Copyright © 2018 Cappillen. All rights reserved.
//

import Foundation
import UIKit

struct CalculateTime {
    static func calculate() -> String {
        
        let pickedDuration = CalendarViewController.testFromDatePage.NewTime!
        let pickedNumberOfPeople = CalendarViewController.testFromDatePage.NewMember!
        let superDict: [[Int: Bool]] = CalculateTime.changeTimeDataType()
        
        var availableTimesCount = [Int: Int]()
        
        for i in 0...23 {
            availableTimesCount[i] = 0
        }
        
        for index in 0...pickedNumberOfPeople - 1 {
            for i in 0...23{
                if superDict[index][i]!{
                    availableTimesCount[i] = availableTimesCount[i]! + 1
                }
            }
        }
        
        print("Starting times: \(availableTimesCount)")
        //Compares all starting values and finds a common one
        
        var startingTimesTotalCount = [Int: Int]()
        var finalAnswer = [Int]()
        
        for i in 0...23 {
            startingTimesTotalCount[i] = 0
        }
        
        for i in 0...23{
            for j in 0...pickedDuration-1 {
                if i+j < 24 {
                    startingTimesTotalCount[i] = startingTimesTotalCount[i]! + availableTimesCount[i+j]!
                }
            }
        }
        
        var sortedKeys = startingTimesTotalCount.sorted(by: { $0.value > $1.value })
        print("Sorted keys: \(sortedKeys)")
        let maxVal = sortedKeys[0].value
        for tuple in sortedKeys {
            if tuple.value == maxVal {
                finalAnswer.append(tuple.key)
            }
        }
        
        
        //Everything beyond here seems to be formatting
        
        print("Final solution array: \(finalAnswer)")
        
        var solutionArray = [String]()
        
        if finalAnswer.count>0{
            print("The following meeting times work for your group:")
            for finalTime in finalAnswer{
                var endingTime=finalTime+pickedDuration
                if finalTime==0{
                    let new=finalTime+12
                    if endingTime<12{
                        print("\(String(new)):00 AM to \(String(endingTime)):00 AM")
                        solutionArray.append("\(String(new)):00 AM to \(String(endingTime)):00 AM")
                    }
                    else if endingTime==12{
                        print("\(String(new)):00 AM to \(String(endingTime)):00 PM")
                        solutionArray.append("\(String(new)):00 AM to \(String(endingTime)):00 PM")
                    }
                    else if endingTime==24{
                        endingTime-=12
                        print("\(String(new)):00 AM to \(String(endingTime)):00 AM")
                        solutionArray.append("\(String(new)):00 AM to \(String(endingTime)):00 AM")
                    }
                    else{
                        endingTime-=12
                        print("\(String(new)):00 AM to \(String(endingTime)):00 PM")
                        solutionArray.append("\(String(new)):00 AM to \(String(endingTime)):00 PM")
                    }
                }
                    
                else if finalTime<12{
                    if endingTime<12{
                        print("\(String(finalTime)):00 AM to \(String(endingTime)):00 AM")
                        solutionArray.append("\(String(finalTime)):00 AM to \(String(endingTime)):00 AM")
                    }
                    else if endingTime==12{
                        print("\(String(finalTime)):00 AM to \(String(endingTime)):00 PM")
                        solutionArray.append("\(String(finalTime)):00 AM to \(String(endingTime)):00 PM")
                    }
                    else if endingTime==24{
                        endingTime-=12
                        print("\(String(finalTime)):00 AM to \(String(endingTime)):00 AM")
                        solutionArray.append("\(String(finalTime)):00 AM to \(String(endingTime)):00 AM")
                    }
                    else{
                        endingTime-=12
                        print("\(String(finalTime)):00 AM to \(String(endingTime)):00 PM")
                        solutionArray.append("\(String(finalTime)):00 AM to \(String(endingTime)):00 PM")
                    }
                    
                }
                    
                else if finalTime==12{
                    if endingTime==24{
                        endingTime-=12
                        print("\(String(finalTime)):00 PM to \(String(endingTime)):00 AM")
                        solutionArray.append("\(String(finalTime)):00 PM to \(String(endingTime)):00 AM")
                    } else{
                        endingTime-=12
                        print("\(String(finalTime)):00 PM to \(String(endingTime)):00 PM")
                        solutionArray.append("\(String(finalTime)):00 PM to \(String(endingTime)):00 PM")
                    }
                }
                    
                else if finalTime>12{
                    let newFinalTime=finalTime-12
                    if endingTime==24{
                        endingTime-=12
                        print("\(String(newFinalTime)):00 PM to \(String(endingTime)):00 AM")
                        solutionArray.append("\(String(newFinalTime)):00 PM to \(String(endingTime)):00 AM")
                    }
                    else{
                        endingTime-=12
                        print("\(String(newFinalTime)):00 PM to \(String(endingTime)):00 PM")
                        solutionArray.append("\(String(newFinalTime)):00 PM to \(String(endingTime)):00 PM")
                    }
                }
                
            }
        }
            
        else{
            print("No meeting times work for your group")
            solutionArray.append("No meeting times work for your group")
        }
        
        return solutionArray[Int(arc4random_uniform(UInt32(solutionArray.count)))]
        
    }
    
    static func changeTimeDataType() -> [[Int: Bool]] {
        var result = [[Int : Bool]]()
        let data = UIViewController.userTimeData
        for users in data {
            var user = [Int: Bool]()
            for amUser in users[0] {
                user[amUser.key] = amUser.value
            }
            for pmUser in users[1] {
                user[pmUser.key + 12] = pmUser.value
            }
            result.append(user)
        }
        return result
    }
}
