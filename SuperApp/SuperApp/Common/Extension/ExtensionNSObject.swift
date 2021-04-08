//  Created by thuy on 5/28/20.

import Foundation

extension NSObject {
    // Static Class using
    static var string: String {
        return String.init(describing: self)
    }
    
    var className: String {
        return type(of: self).description().components(separatedBy: ".").last!
    }
}
