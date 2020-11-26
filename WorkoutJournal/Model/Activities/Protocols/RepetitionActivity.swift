//
//  RepetitionActivity.swift
//  WorkoutJournal
//
//  Created by Vlad Bilyk on 25.11.2020.
//  Copyright © 2020 Vlad Bilyk. All rights reserved.
//

import Foundation


protocol RepetitionActivity: Activity {
    
    var name: String {get set}
    var count: Int {get set}
    
}
