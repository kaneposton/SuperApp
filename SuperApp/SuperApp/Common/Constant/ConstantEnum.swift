// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import Foundation
import UIKit
import SwiftUI

enum Status: String {
    case done = "Hoàn thành"
    case undeveloped = "Chưa triển khai"
    case deployment = "Đang triển khai"
    case stop = "Dừng"
    case delay = "Trễ hạn"
    var description: String {
        return self.rawValue
    }
    static func getStatus(_ value: Int) -> Status {
        switch value {
        case 1:
            return .undeveloped
        case 2:
            return .deployment
        case 3:
            return .stop
        case 4:
            return .delay
        default:
            return .done
        }
    }
    static func getIdStatus(_ value: Status) -> Int {
        switch value {
        case .undeveloped:
            return 1
        case .deployment:
            return 2
        case .stop:
            return 3
        case .delay:
            return 4
        default:
            return 5
        }
    }
    static func getColorBlur(_ value: Int) -> UIColor {
        switch value {
        case 1:
            return GENERAL_GRAY
        case 2:
            return GENERAL_BLUE_BLUR
        case 3:
            return GENERAL_RANGE
        case 4:
            return GENERAL_RED_TASK
        default:
            return GENERAL_GREEN
        }
    }
    static func getColor(_ value: Int) -> UIColor {
        switch value {
        case 1:
            return GENERAL_GRAY
        case 2:
            return GENERAL_BLUE_BLUR
        case 3:
            return GENERAL_RANGE
        case 4:
            return GENERAL_RED
        default:
            return GENERAL_GREEN_TEXT
        }
    }
}

enum RequestPrice: String {
    case send = "Đã cập nhật báo giá"
    case unsend = "Chưa gửi yêu cầu"
    var desc: String {
        return self.rawValue
    }
}

enum StatusLegal {
    case done
    case progress
    case onHold
    static func getStatus(_ value: Int) -> String {
        switch value {
        case 1:
            return "Mới"
        case 2:
            return "In Progress"
        case 3:
            return "Stop"
        case 4:
            return "Delay"
        default:
            return "Hoàn Thành"
        }
    }
}

enum ProjectStatus: String {
    case new = "Mới"
    case inprogress = "In Progress"
    case stop = "Stop"
    case delay = "Delay"
    case done = "Hoàn Thành"
    
    var description: String {
        return self.rawValue
    }
    
    static func SearchStatus(_ value: Int) -> ProjectStatus {
        switch value {
        case 1:
            return .new
        case 2:
            return .inprogress
        case 3:
            return .stop
        case 4:
            return .delay
        default:
            return .done
        }
    }
    
    static func getColorFromServer(_ value: Int) -> UIColor {
        switch value {
        case 1:
            return txtNew
        case 2:
            return txtBeing
        case 3:
            return txtStop
        case 4:
            return txtWaiting
        default:
            return txtComplete
        }
    }
    static func getColorTask(_ value: Int) -> UIColor {
        switch value {
        case 1:
            return complete
        case 2:
            return Beingtxt
        case 3:
            return Stoptxt
        case 4:
            return duedate
        default:
            return Newcolor
        }
    }
}
