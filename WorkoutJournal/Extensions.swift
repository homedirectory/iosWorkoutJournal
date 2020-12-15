//
//  Extensions.swift
//  WorkoutJournal
//
//  Created by Vlad Bilyk on 14.12.2020.
//  Copyright © 2020 Vlad Bilyk. All rights reserved.
//

import Foundation
import UIKit

extension UITableViewCell {
    static var id: String {
        String(describing: Self.self)
    }
}

extension UICollectionViewCell {
    static var id: String {
        String(describing: Self.self)
    }
}
