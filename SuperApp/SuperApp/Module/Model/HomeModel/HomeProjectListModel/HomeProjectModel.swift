// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import Foundation

struct HomeProjectModel: ResponseProtocol, Codable {
    var detail: String?
    var success: Bool?
    var total_records: Int?
    var list: [HomeProjectListModel]? = []

    enum CodingKeys: String, CodingKey {
        case detail = "detail"
        case success = "success"
        case total_records = "total_records"
        case list = "list"
    }
}

struct HomeProjectListModel: Codable, Hashable, Identifiable {
    let id = UUID()
    var project_id: Int?
    var project_name: String?
    var project_status: Int?
    var address: String?
    var total_area_square: Double?
    var latitude: Double?
    var longitude: Double?
    var date_opened: String?
    var rank_type: Int?
    var description: String?
    var project_avatar_url: String?
    var province_id: Int?
    var province_name: String?
    var district_id: Int?
    var district_name: String?
    var location: HomeProjectLocationModel?
    var project_highlights: Bool?
    var project_setting_type: [HomeProjectSettingTypeModel]?
    var is_sell: Bool?
    var sale_open_name: String?

    enum CodingKeys: String, CodingKey {
        case project_id = "project_id"
        case project_name = "project_name"
        case project_status = "project_status"
        case address = "address"
        case total_area_square = "total_area_square"
        case latitude = "latitude"
        case longitude = "longitude"
        case date_opened = "date_opened"
        case rank_type = "rank_type"
        case description = "description"
        case project_avatar_url = "project_avatar_url"
        case province_id = "province_id"
        case province_name = "province_name"
        case district_id = "district_id"
        case district_name = "district_name"
        case location = "location"
        case project_highlights = "project_highlights"
        case project_setting_type = "project_setting_type"
        case sale_open_name = "sale_open_name"
        case is_sell = "is_sell"
    }
}

struct HomeProjectLocationModel: Codable, Hashable {
    var type: String?
    var coordinates: [[[Double]]]?

    enum CodingKeys: String, CodingKey {
        case type = "type"
        case coordinates = "coordinates"
    }
}

struct HomeProjectSettingTypeModel: Codable, Hashable {
    var name: String?
    var type_id: Int?

    enum CodingKeys: String, CodingKey {
        case name = "name"
        case type_id = "type_id"
    }
}
