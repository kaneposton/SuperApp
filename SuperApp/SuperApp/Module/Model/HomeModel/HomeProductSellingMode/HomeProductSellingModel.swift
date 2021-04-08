// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import Foundation

struct HomeProductSellingModel: Codable {
    let success: Bool?
    let list: [HomeProductSellListModel]?

    enum CodingKeys: String, CodingKey {
        case success = "success"
        case list = "list"
    }
}

struct HomeProductSellListModel: Codable, Hashable, Identifiable {
    let id = UUID()
    var project_id: Int?
    var project_name: String?
    var project_avatar_url: String?
    var date_opened: String?
    var project_property: String?
    var address: String?
    var province_id: Int?
    var province_name: String?
    var district_id: Int?
    var district_name: String?
    var estimate_price: Int?
    var area_m2_total: Int?

    enum CodingKeys: String, CodingKey {
        case project_id = "project_id"
        case project_name = "project_name"
        case project_avatar_url = "project_avatar_url"
        case date_opened = "date_opened"
        case project_property = "project_property"
        case address = "address"
        case province_id = "province_id"
        case province_name = "province_name"
        case district_id = "district_id"
        case district_name = "district_name"
        case area_m2_total = "area_m2_total"
        case estimate_price = "estimate_price"
    }
}
