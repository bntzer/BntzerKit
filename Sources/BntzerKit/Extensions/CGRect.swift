//
//  File.swift
//  
//
//  Created by Steve Bentz on 8/31/21.
//
#if os(iOS)
import Foundation
import UIKit

extension CGRect {
    
    public func bounds() -> CGRect {
        return CGRect(x: 0, y: 0, width: width, height: height)
    }
    
    static func fromCenter(_ center: CGPoint, width: CGFloat, height: CGFloat) -> CGRect {
        let rect = CGRect(x: center.x - (width / 2), y: center.y - (height / 2), width: width, height: height)
    
        return rect
    }
}
#endif
