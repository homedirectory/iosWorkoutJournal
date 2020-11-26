//
//  DurationActivity.swift
//  WorkoutJournal
//
//  Created by Vlad Bilyk on 26.11.2020.
//  Copyright © 2020 Vlad Bilyk. All rights reserved.
//

import Foundation


protocol DurationActivity: Activity {
    
    var name: String {get set}
    var timeSpent: Int {get set}
    
}
