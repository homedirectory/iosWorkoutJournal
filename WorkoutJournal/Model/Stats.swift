//
//  Stats.swift
//  WorkoutJournal
//
//  Created by Vlad Bilyk on 06.12.2020.
//  Copyright © 2020 Vlad Bilyk. All rights reserved.
//

import Foundation
import UIKit


public class Stats<T> {
    
    var name: String?
    var value: T?
    var image: UIImage?
    
    init(name: String, value: T) {
        self.name = name
        self.value = value
    }
    
}
