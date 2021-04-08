// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import Foundation

struct FilterCityModel: Codable {
    let success: Bool?
    let data: [FilterCityListModel]?

    enum CodingKeys: String, CodingKey {
        case success = "success"
        case data = "data"
    }
}

struct FilterCityListModel: Codable, Hashable, Identifiable {
    let id = UUID()
    var province_id: Int?
    var name: String?
    var code: String?
    var avatar: String?
    var lon: Double?
    var lat: Double?

    enum CodingKeys: String, CodingKey {
        case province_id = "province_id"
        case name = "name"
        case code = "code"
        case avatar = "avatar"
        case lon = "lon"
        case lat = "lat"
    }
}
