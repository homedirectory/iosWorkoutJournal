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
    
    var name: String
    var duration: Double?
    var distance: Double?
    var repetitions: Int?
    
    lazy var entityName: String = {
        let name = NSStringFromClass(type(of: self)) + "Model"
        return name.components(separatedBy: ".").last!
    }()
    
    init(name: String, duration: Double? = nil, distance: Double? = nil, repetitions: Int? = nil) {
        self.name = name
        self.duration = duration
        self.distance = distance
        self.repetitions = repetitions
    }
    
//    init(_ managedObject: ActivityModel) {
//        self.name = managedObject.value(forKey: "name") as! String
//        self.duration = managedObject.value(forKey: "duration") as? Double
//        self.distance = managedObject.value(forKey: "distance") as? Double
//        self.repetitions = managedObject.value(forKey: "repetitions") as? Int
//    }
//
//    func toManagedObject(context: NSManagedObjectContext) -> NSManagedObject {
//        let entity = NSEntityDescription.entity(forEntityName: "ActivityModel", in: context)!
//        let managedObject = NSManagedObject(entity: entity, insertInto: context)
//        managedObject.setValue(self.name, forKey: "name")
//        managedObject.setValue(self.duration, forKey: "duration")
//        managedObject.setValue(self.distance, forKey: "distance")
//        managedObject.setValue(self.repetitions, forKey: "repetitions")
//
//        return managedObject
//    }
    
    func toString() -> String {
        var str =  "[ name: \(name)"
        str += duration == nil ? "" : " | duration: \(String(self.duration! / 60)) min."
        str += distance == nil ? "" : " |  distance: \(String(self.distance! / 1000)) km"
        str += repetitions == nil ? "" : " | repetitions: \(String(self.repetitions!))"
        str += " ]"
        
        return str
    }
    
}
