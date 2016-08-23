//
//  data.swift
//  BoutTime
//
//  Created by ahmed seddek on 8/21/16.
//  Copyright © 2016 ahmed seddek. All rights reserved.
//

import Foundation
import GameKit

class Events {
    let historiEvents: [[String: AnyObject]] = [
        ["Title": "Wright Brothers perform first controller heavier-than air flight", "Year": 1903],
        ["Title": "Major earthquake in San Francisco killing about 3000 people", "Year": 1906],
        ["Title": "Ford Model T created", "Year": 1908],
        ["Title": "Mexican revolution begins", "Year": 1910],
        ["Title": "Lusitania is torpedoed by German U-Boat", "Year": 1915],
        ["Title": "World War I ends", "Year": 1918],
        ["Title": "Prohibition of alcohol in the United States begins", "Year": 1920],
        ["Title": "Hitler becomes Führer of the Nazi party", "Year": 1921],
        ["Title": "FBI is founded", "Year": 1924],
        ["Title": "Mussolini comes into power in Italy", "Year": 1925],
        ["Title": "Penicillin is discovered", "Year": 1928],
        ["Title": "The Great Depression begins after Wall Street crash", "Year": 1929],
        ["Title": "South Africa gains its independence", "Year": 1931],
        ["Title": "Franklin D. Roosevelt is elected to become President of the United States", "Year": 1932],
        ["Title": "Spanish Civil War begins", "Year": 1936],
        ["Title": "The Hindenberg crashes", "Year": 1937],
        ["Title": "Invasion of France, the Netherlands, Denmark, and Norway by the Nazis", "Year": 1940],
        ["Title": "The Holocaust begins with Operation Reinhard and the attacks on Peal Harbor cause the United States to join World War II", "Year": 1941],
        ["Title": "Japanese-American citizens put into internment camps", "Year": 1942],
        ["Title": "D-Day", "Year": 1944],
        ["Title": "World War II ends in Europe and United Nations is founded", "Year": 1945],
        ["Title": "The CIA is formed in the United States", "Year": 1945],
        ["Title": "The state of Israel is formed officially by United Nations", "Year": 1948],
        ["Title": "NATO is formed", "Year": 1949],
        ["Title": "The Treaty of San Francisco or the Treaty of Peace with Japan is signed", "Year": 1951],
        ["Title": "First jet airplane enters service", "Year": 1952],
        ["Title": "Three-dimensional structure of DNA discovered", "Year": 1953],
        ["Title": "Brown v. Board of Education ends segregation in public schools", "Year": 1954],
        ["Title": "First jet airplane enters service", "Year": 1952],
        ["Title": "Nikita Krushchev gains control of the Soviet Union", "Year": 1955],
        ["Title": "Sputnik 1 launched", "Year": 1957],
        ["Title": "NASA founded, cassette tape and optical disc are invented", "Year": 1958],
        ["Title": "Cuban revolution ends, Alaska and Hawaii are admitted to the United States", "Year": 1959],
        ["Title": "The Beatles form", "Year": 1960],
        ["Title": "The Berlin Wall is built", "Year": 1961],
        ["Title": "The Cuban missile crisis", "Year": 1962],
        ["Title": "MLK delivers 'I Have a Dream' speech and JFK is assassinated", "Year": 1963],
        ["Title": "The Civil Rights Act is signed into law", "Year": 1964],
        ["Title": "Winston Churchill dies", "Year": 1965],
        ["Title": "Martin Luther King, Jr. and Robert F. Kennedy are assassinated", "Year": 1968],
        ["Title": "The first moon landing", "Year": 1969],
        ["Title": "First flight of the Boeing 747, Jimi Hendrix and Janis Joplin die", "Year": 1970],
        ["Title": "Microchip invented", "Year": 1971],
        ["Title": "First space station is launched, Roe v. Wade passes through Supreme Court", "Year": 1973],
        ["Title": "World population surpasses 4 billion, first nearby images of Mercury", "Year": 1974],
        ["Title": "Vietnam War ends", "Year": 1975],
        ["Title": "Apple Computer is formed", "Year": 1976],
        ["Title": "Voyager spacecraft is launched", "Year": 1977],
        ["Title": "War in Afghanistan begins", "Year": 1978],
        ["Title": "Smallpox is eradicated", "Year": 1979],
        ["Title": "Ronald Reagan is elected President of the United States", "Year": 1980],
        ["Title": "MTV launches", "Year": 1981],
        ["Title": "First commercial CD player sold", "Year": 1982],
        ["Title": "Chernobyl and Challenger tragedies", "Year": 1986],
        ["Title": "George HW Bush is elected to become President of the United States", "Year": 1988],
        ["Title": "The Berlin Wall is destroyed", "Year": 1989],
        ["Title": "The Hubble Space Telecsope is launched", "Year": 1990],
        ["Title": "The Gulf War ends", "Year": 1991],
        ["Title": "The European Union is formed", "Year": 1992],
        ["Title": "End of apartheid and Nelson Mandela elected first President of South Africa", "Year": 1994],
        ["Title": "The World Trade Organization is formed", "Year": 1995],
        ["Title": "Dolly the sheep is cloned successfully", "Year": 1996],
        ["Title": "Tony Blair becomes Prime Minister of the UK", "Year": 1997],
        ["Title": "Google is founded", "Year": 1998],
        ["Title": "The Euro is introduced as a new currency", "Year": 1999]
    ]
    
    var questions: [[String: AnyObject]] = []
    let numOfFacts = 4
    
    init() {
        // Copy all events to an array within the init method.
        var tempHistoriEvents = historiEvents
        // Loop through and randomly pick the number of facts as defined with numberOfFacts
        for _ in 0...numOfFacts {
        
            let randomNum = GKRandomSource.sharedRandom().nextIntWithUpperBound(tempHistoriEvents.count)
            // Append the event to the questions array
            self.questions.append(tempHistoriEvents[randomNum])
            // Remove the picked event so that it is not chosen again
            tempHistoriEvents.removeAtIndex(randomNum)
            
        }
    
    }
    // Use this to swap elements when the user reorders the elements.
    func swapElements(fromIndex: Int , toIndex: Int)
    {
        swap(&questions[fromIndex], &questions[toIndex])
    }
    
    func orderIsCorrect() -> Bool {
    
        var arrOfYears: [Int] = []
        
        for i in 0...numOfFacts - 1 {
        
        arrOfYears.append(questions[i]["Year"] as! Int)
        }
        
        let sortedArrOfYears = arrOfYears.sort()
        
        if sortedArrOfYears == arrOfYears {
        
        return true
        } else {
        return false
        }
    
    }
}


