//
//  ActivityStatsView.swift
//  WorkoutJournal
//
//  Created by Vlad Bilyk on 15.12.2020.
//  Copyright © 2020 Vlad Bilyk. All rights reserved.
//

import UIKit

public class ActivityStatsView: UIView {
    
//    override public func draw(_ rect: CGRect) {
//        super.draw(rect)
//        self.backgroundColor = .yellow
//    }
        
    static let LABEL_HEIGHT = 60
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .lightGray
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(stats: [Stats]) {
        let lblWidth = self.frame.width
        let lblX = CGFloat(self.frame.origin.x)
        var lblY = self.frame.height / 4
        
        for stat in stats {
            let lbl = UILabel(frame: CGRect(x: lblX, y: lblY, width: lblWidth, height: CGFloat(Self.LABEL_HEIGHT)))
            lbl.text = "    " + stat.toString()
            lbl.backgroundColor = .white
            lbl.layer.borderWidth = 1
            lbl.layer.borderColor = UIColor.gray.cgColor
            self.addSubview(lbl)
            
            lblY += CGFloat(Self.LABEL_HEIGHT)
        }
    }
    
}
