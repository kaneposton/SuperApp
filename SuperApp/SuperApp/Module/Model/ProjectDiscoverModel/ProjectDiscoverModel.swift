// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import SwiftUI
import Foundation

struct ProjectDiscoverModel: Codable {
    let success: Bool?
    let total_records: Int?
    let list: [DiscoverProvinceModel]?

    enum CodingKeys: String, CodingKey {
        case success = "success"
        case total_records = "total_records"
        case list = "list"
    }
}
struct DiscoverProvinceModel: Codable {
    let province_id: Int?
    let total_project: Int?
    let province_name: String?
    let province_avatar: String?

    enum CodingKeys: String, CodingKey {
        case province_id = "province_id"
        case total_project = "total_project"
        case province_name = "province_name"
        case province_avatar = "province_avatar"
    }
}
