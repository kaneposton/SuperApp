// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import Foundation

struct FilterDistrictModel: Codable {
    let success: Bool?
    let data: [FilterDistrictListModel]?

    enum CodingKeys: String, CodingKey {
        case success = "success"
        case data = "data"
    }
}

struct FilterDistrictListModel: Codable, Hashable, Identifiable {
    let id = UUID()
    var province_id: Int?
    var province_avatar: String?
    var district_id: Int?
    var name: String?
    var code: String?
    var lon: Double?
    var lat: Double?

    enum CodingKeys: String, CodingKey {
        case province_id = "province_id"
        case province_avatar = "province_avatar"
        case district_id = "district_id"
        case name = "name"
        case code = "code"
        case lon = "lon"
        case lat = "lat"
    }
}
