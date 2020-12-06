//
//  Activity.swift
//  WorkoutJournal
//
//  Created by Vlad Bilyk on 01.12.2020.
//  Copyright © 2020 Vlad Bilyk. All rights reserved.
//

import Foundation
import CoreData


public class Activity {
    
    private static var _totalDuration = Stats<Double>(name: "Duration", value: 0)
    class var totalDuration: Stats<Double> {
        get {
            return Self._totalDuration
        }
    }
    
    private static var _totalDistance = Stats<Double>(name: "Distance", value: 0)
    class var totalDistance: Stats<Double> {
        get {
            return Self._totalDistance
        }
    }
    
    private static var _totalRepetitions = Stats<Int>(name: "Repetitions", value: 0)
    class var totalRepetitions: Stats<Int> {
        get {
            return Self._totalRepetitions
        }
    }
//
//    private static var _totalDuration: Double = 0
//    class var totalDuration: Double {
//           get {
//            return Self._totalDuration
//           }
//           set {
//            Self._totalDuration = max(newValue, 0)
//           }
//       }
//
//    private static var _totalDistance: Double = 0
//    class var totalDistance: Double {
//           get {
//            return Self._totalDistance
//           }
//           set {
//            Self._totalDistance = max(newValue, 0)
//           }
//       }
//
//    private static var _totalRepetitions: Int = 0
//    class var totalRepetitions: Int {
//           get {
//            return Self._totalRepetitions
//           }
//           set {
//            Self._totalRepetitions = max(newValue, 0)
//           }
//       }
    
    var name: String
    var duration: Double?
    {
        willSet {
            if let prevDuration = self.duration {
                Self.totalDuration.value! -= prevDuration
            }
        }
        didSet {
            Self.totalDuration.value! += self.duration!
        }
    }
    
    var distance: Double?
    {
        willSet {
            if let prevDistance = self.distance {
                Self.totalDistance.value! -= prevDistance
            }
        }
        didSet {
            Self.totalDistance.value! += self.distance!
        }
    }
    
    var repetitions: Int?
    {
        willSet {
            if let prevRepetitions = self.repetitions {
                Self.totalRepetitions.value! -= prevRepetitions
            }
        }
        didSet {
            Self.totalRepetitions.value! += self.repetitions!
        }
    }
    
    lazy var entityName: String = {
        let name = NSStringFromClass(type(of: self)) + "Model"
        return name.components(separatedBy: ".").last!
    }()
    
    init(name: String, duration: Double? = nil, distance: Double? = nil, repetitions: Int? = nil) {
        self.name = name
        self.duration = duration
        self.distance = distance
        self.repetitions = repetitions

        if let _ = duration {
            Self.totalDuration.value! += duration!
        }
        if let _ = distance {
            Self.totalDistance.value! += distance!
        }
        if let _ = repetitions {
            Self.totalRepetitions.value! += repetitions!
        }
    }
    
    func toManagedObject(context: NSManagedObjectContext) -> NSManagedObject {
        let entity = NSEntityDescription.entity(forEntityName: self.entityName, in: context)!
        let managedObject = NSManagedObject(entity: entity, insertInto: context)
        managedObject.setValue(self.name, forKey: "name")
        managedObject.setValue(self.duration, forKey: "duration")
        managedObject.setValue(self.distance, forKey: "distance")
        managedObject.setValue(self.repetitions, forKey: "repetitions")

        return managedObject
    }
    
    func toString() -> String {
        var str =  "[ name: \(name)"
        str += duration == nil ? "" : " | duration: \(String(self.duration! / 60)) min."
        str += distance == nil ? "" : " |  distance: \(String(self.distance! / 1000)) km"
        str += repetitions == nil ? "" : " | repetitions: \(String(self.repetitions!))"
        str += " ]"
        
        return str
    }
    
}
