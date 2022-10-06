//
//  UIKit extensions.swift
//  Jokes App
//
//  Created by Aibek on 06.10.2022.
//

import UIKit

extension NSObject {
    var stringFromClass : String { return NSStringFromClass(type(of: self)) }
    var className : String { return self.stringFromClass.components(separatedBy: ".").last! }
    
    static var stringFromClass : String { return NSStringFromClass(self) }
    static var className : String { return self.stringFromClass.components(separatedBy: ".").last! }
}

extension UITableViewCell {
    @objc func fill(with item: Any?){}
}

extension String {
    static var empty: String { return String() }
}
