// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import SwiftUI
import Foundation

struct ContactModel: Codable, Hashable {
    let success: Bool?
    let detail: String?
    let developer_project: ContactDeveloperModel?
    let trading: [ContactTradingModel]?

    enum CodingKeys: String, CodingKey {
        case success = "success"
        case detail = "detail"
        case developer_project = "developer_project"
        case trading = "trading"
    }
}

struct ContactDeveloperModel: Codable, Hashable {
    var logo_url: String?
    var project_address: String?
    var hotline: String?
    var fax: String?

    enum CodingKeys: String, CodingKey {
        case logo_url = "logo_url"
        case project_address = "project_address"
        case hotline = "hotline"
        case fax = "fax"
    }
}

struct ContactTradingModel: Codable, Hashable, Identifiable {
    let id = UUID()
    var name: String?
    var address: String?

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case address = "address"
    }
}
