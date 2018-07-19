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
    static func calculate(superDict: [[Int : Bool]], pickedDuration: Int, pickedNumberOfPeople: Int) -> String {
//        var user1 = [Int: Bool]()
//        var user2 = [Int: Bool]()
//        var user3 = [Int: Bool]()
//
//        for i in 0...23 {
//            user1[i] = false
//            user2[i] = false
//            user3[i] = false
//        }
        
        var pickedDuration = CalendarViewController.testFromDatePage.NewTime
        var pickedNumberOfPeople = CalendarViewController.testFromDatePage.NewMember
        var superDict: [[Int: Bool]] = superDict // [user1, user2, user3]
        
       
        var startingTimes=[[Int]]()
        var tempArray=[Int]()
        var checkArray = [String]()
        var oneLessHour=pickedDuration!-1
        var oneLessPeople=pickedNumberOfPeople!-1
        var individualWorkingValues=[Int]()
        var workingValues=[[Int]]()
        
        
        for index in 0...oneLessPeople /*for each of the people*/{
            for i in 0...23{
                if superDict[index][i]!{
                    individualWorkingValues.append(i)
                }
            }
            workingValues.append(individualWorkingValues)
            for cell in individualWorkingValues{
                if pickedDuration == 1{
                    tempArray.append(cell)
                    print(tempArray)
                } else{
                    //for now it will run twice cause it's one through two
                    for firstIndex in 1...oneLessHour /* runs 2 times, onelesshour is 2 */ {
                        var nextValue=cell+firstIndex
                        
                        if individualWorkingValues.contains(nextValue){
                            checkArray.append("yes")
                            
                        } else{
                            checkArray=[]
                            break
                        }
                        
                        if checkArray.count == oneLessHour{
                            tempArray.append(cell)
                            checkArray=[]
                            
                        } else{
                            checkArray=[]
                        }
                        
                    }
                }
            }
            
            startingTimes.append(tempArray)
            tempArray=[]
            individualWorkingValues=[]
        }
        
        print("Starting times: \(startingTimes)")
        //Compares all starting values and finds a common one
        
        var finalCheckArray = [String]()
        var finalSolution = [Int]()
        for value in startingTimes[0]{
            if pickedNumberOfPeople! == 1{
                finalSolution.append(value)
            } else{
                for index in  1...oneLessPeople{
                    for eachCell in startingTimes[index]{
                        if eachCell == value{
                            finalCheckArray.append("yes")
                        } else{
                            continue
                        }
                    }
                    
                }
                
                if finalCheckArray.count == oneLessPeople{
                    finalSolution.append(value)
                    finalCheckArray=[]
                } else{
                    finalCheckArray=[]
                }
            }
            
        }
        
        print("Final solution array: \(finalSolution)")
        
        var solutionArray = [String]()
        
        if finalSolution.count>0{
            print("The following meeting times work for your group:")
            for finalTime in finalSolution{
                var endingTime=finalTime+pickedDuration!
                if finalTime==0{
                    var new=finalTime+12
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
                    var newFinalTime=finalTime-12
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
