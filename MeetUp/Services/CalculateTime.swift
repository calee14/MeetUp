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
    static func calculate(superDict: [[Int : Bool]], pickedDuration: Int, pickedNumberOfPeople: Int) {
//        var user1 = [Int: Bool]()
//        var user2 = [Int: Bool]()
//        var user3 = [Int: Bool]()
//
//        for i in 0...23 {
//            user1[i] = false
//            user2[i] = false
//            user3[i] = false
//        }
        
        var pickedDuration = pickedDuration
        var pickedNumberOfPeople = pickedNumberOfPeople
        var superDict: [[Int: Bool]] = superDict // [user1, user2, user3]
        
       
        var startingTimes=[[Int]]()
        var tempArray=[Int]()
        var checkArray = [String]()
        var oneLessHour=pickedDuration-1
        var oneLessPeople=pickedNumberOfPeople-1
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
                        
                    }
                }
                
                
                if checkArray.count == oneLessHour{
                    tempArray.append(cell)
                    checkArray=[]
                    
                } else{
                    checkArray=[]
                }
            }
            
            startingTimes.append(tempArray)
            tempArray=[]
            individualWorkingValues=[]
        }
        
        //Compares all starting values and finds a common one
        
        var finalCheckArray = [String]()
        var finalSolution = [Int]()
        for value in startingTimes[0]{
            for thirdIndex in  1...oneLessPeople{
                for eachCell in startingTimes[thirdIndex]{
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
        
        
        if finalSolution.count>0{
            print("The following meeting times work for your group:")
            for finalTime in finalSolution{
                var endingTime=finalTime+pickedDuration
                if finalTime==0{
                    var new=finalTime+12
                    if endingTime<12{
                        print("\(String(new)):00 AM to \(String(endingTime)):00 AM")
                    }
                    else if endingTime==12{
                        print("\(String(new)):00 AM to \(String(endingTime)):00 PM")
                    }
                    else if endingTime==24{
                        endingTime-=12
                        print("\(String(new)):00 AM to \(String(endingTime)):00 AM")
                    }
                    else{
                        endingTime-=12
                        print("\(String(new)):00 AM to \(String(endingTime)):00 PM")
                    }
                }
                    
                else if finalTime<12{
                    if endingTime<12{
                        print("\(String(finalTime)):00 AM to \(String(endingTime)):00 AM")
                    }
                    else if endingTime==12{
                        print("\(String(finalTime)):00 AM to \(String(endingTime)):00 PM")
                    }
                    else if endingTime==24{
                        endingTime-=12
                        print("\(String(finalTime)):00 AM to \(String(endingTime)):00 AM")
                    }
                    else{
                        endingTime-=12
                        print("\(String(finalTime)):00 AM to \(String(endingTime)):00 PM")
                    }
                    
                }
                    
                else if finalTime==12{
                    if endingTime==24{
                        endingTime-=12
                        print("\(String(finalTime)):00 PM to \(String(endingTime)):00 AM")
                    } else{
                        endingTime-=12
                        print("\(String(finalTime)):00 PM to \(String(endingTime)):00 PM")
                    }
                }
                    
                else if finalTime>12{
                    var newFinalTime=finalTime-12
                    if endingTime==24{
                        endingTime-=12
                        print("\(String(newFinalTime)):00 PM to \(String(endingTime)):00 AM")
                    }
                    else{
                        endingTime-=12
                        print("\(String(newFinalTime)):00 PM to \(String(endingTime)):00 PM")
                    }
                }
                
            }
        }
            
        else{
            print("No meeting times work for your group")
        }
    }
}
