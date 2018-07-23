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
    
    static func findNames(time: Int, names: [String]) -> (canMakeIt: String, cantMakeIt: String) {
        // get the data of all the users and their times in an array
        let dict = CalculateTime.changeTimeDataType()
        // initialize variables to store names
        var canMakeIt = ""
        var cantMakeIt = ""
        // loop through all the members
        for i in 0...CalendarViewController.testFromDatePage.NewMember!-1 {
            // if the member is available at time
            if dict[i][time]! {
                // add them to the can make it list
                canMakeIt = canMakeIt + names[i] + "\n"
            }
            else {
                // add them to the can't make it list
                cantMakeIt = cantMakeIt + names[i] + "\n"
            }
        }
        return (canMakeIt, cantMakeIt)
    }
    
    static func preprocessing() -> [Int: Int] {
        // store how long the meeting is going to last integer
        let pickedDuration = CalendarViewController.testFromDatePage.NewTime!
        // store how many people are in the meeting
        let pickedNumberOfPeople = CalendarViewController.testFromDatePage.NewMember!
        // the data of the available times each user selected
        let superDict: [[Int: Bool]] = CalculateTime.changeTimeDataType()
        
        // show how many people are available for each time from 0-23
        var availableTimesCount = [Int: Int]()
        
        for i in 0...23 {
            // make 23 elements to store the available times
            // currently they're all set to 0
            availableTimesCount[i] = 0
        }
        
        // loop through all the people
        for index in 0...pickedNumberOfPeople - 1 {
            // loop through all the times from 0-23
            for i in 0...23{
                // if the user at index at time is available/true
                if superDict[index][i]!{
                    // add one person to the availablilty at i time
                    availableTimesCount[i] = availableTimesCount[i]! + 1
                }
            }
        }
        return availableTimesCount
    }
    
    
    static func calculate() -> String {
        // get the duration of the meeting as a integer
        let pickedDuration = CalendarViewController.testFromDatePage.NewTime!
        // get the amount of people going to the meeting as a integer
        let pickedNumberOfPeople = CalendarViewController.testFromDatePage.NewMember!
        // get the amount of data each user and the times they're going
        let superDict: [[Int: Bool]] = CalculateTime.changeTimeDataType()
        
        // instead of superDict we're using the available times array which store the amount of people available at each time
        
        // array to store the amount of people available at each time
        let availableTimesCount = CalculateTime.preprocessing()
        
        // variables for the result
        var startingTimesTotalCount = [Int: Int]()
        var finalAnswer = [Int]()
        
        // initialize 23 elements containing 0
        for i in 0...23 {
            startingTimesTotalCount[i] = 0
        }
        
        // loop through all 23 times
        for i in 0...23 {
            // loop through all the possible durations from 0 - the amount of the duration the user chose
            for j in 0...pickedDuration-1 {
                // if the i time plus the duration of the time is within 24 hours
                if i+j < 24 {
                    print("Times \(startingTimesTotalCount[i]! + availableTimesCount[i+j]!) starting \(startingTimesTotalCount[i])  available \(availableTimesCount[i])")
                    // add number of points for the specific time
                    // the number of points coresponds to the amount of people who are available at i + j
                    startingTimesTotalCount[i] = startingTimesTotalCount[i]! + availableTimesCount[i+j]!
                }
            }
        }
        
        // order the values so the highest is first
        var sortedKeys = startingTimesTotalCount.sorted(by: { $0.value > $1.value })
        print("Sorted keys: \(sortedKeys)")
        // get the highest value of the sorted array which is the first one
        let maxVal = sortedKeys[0].value
        // loop through all the sorted keys
        for tuple in sortedKeys {
            // if the key's value matches the highest value
            if tuple.value == maxVal {
                // add it to the final answer
                finalAnswer.append(tuple.key)
            }
        }
        
        
        // Everything beyond here seems to be formatting
        
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
        
        if maxVal == pickedDuration * pickedNumberOfPeople {
            return solutionArray[Int(arc4random_uniform(UInt32(solutionArray.count)))]
        }
        else {
            return (solutionArray[Int(arc4random_uniform(UInt32(solutionArray.count)))] + ". WARNING: Not everyone can make this time.")
        }
    }
    
    static func changeTimeDataType() -> [[Int: Bool]] {
        // change the data type so that times go from 0 - 23
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
