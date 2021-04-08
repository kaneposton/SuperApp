// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import SwiftUI
import Foundation

struct LocationModel: Codable {
    let success: Bool?
    let list: [LocationListModel]?

    enum CodingKeys: String, CodingKey {
        case success = "success"
        case list = "list"
    }
}

struct LocationListModel: Codable, Identifiable, Hashable {
    var name: String?
    var id: Int?
    var latitude: Double?
    var longitude: Double?
    var address: String?
    var avatar_url: String?
    var distance_met: Int?
    var utility_type_id: Int?

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case id = "id"
        case latitude = "latitude"
        case longitude = "longitude"
        case address = "address"
        case avatar_url = "avatar_url"
        case distance_met = "distance_met"
        case utility_type_id = "utility_type_id"
    }
}
