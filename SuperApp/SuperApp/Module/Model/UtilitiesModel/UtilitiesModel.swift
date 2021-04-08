// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import SwiftUI
import Foundation

struct UtilitiesModel: Codable {
    let success: Bool?
    let detail: String?
    let list_area: [UtilitiesListAreaModel]?
    let list_utilities: [UtilitiesListUtilitiesModel]?

    enum CodingKeys: String, CodingKey {
        case success = "success"
        case detail = "detail"
        case list_area = "list_area"
        case list_utilities = "list_utilities"
    }
}

struct UtilitiesListAreaModel: Codable, Identifiable, Hashable {
    let id = UUID()
    var sale_product_id: Int?
    var sale_product_name: String?
    var sale_product_location: UtilitiesProductLocationModel?
    var sale_product_lat: Float?
    var sale_product_lon: Float?

    enum CodingKeys: String, CodingKey {
        case sale_product_id = "sale_product_id"
        case sale_product_name = "sale_product_name"
        case sale_product_location = "sale_product_location"
        case sale_product_lat = "sale_product_lat"
        case sale_product_lon = "sale_product_lon"
    }
}

struct UtilitiesListUtilitiesModel: Codable, Identifiable, Hashable {
    let id = UUID()
    var lon: Double?
    var lat: Double?
    var internal_utility_type: Int?
    var area_m2: Int?
    var utility_name: String?

    enum CodingKeys: String, CodingKey {
        case lon = "lon"
        case lat = "lat"
        case internal_utility_type = "internal_utility_type"
        case area_m2 = "area_m2"
        case utility_name = "utility_name"
    }
}

struct UtilitiesProductLocationModel: Codable, Identifiable, Hashable {
    let id = UUID()
    var type: String?
    var coordinates: [[[Double]]]?

    enum CodingKeys: String, CodingKey {
        case type = "type"
        case coordinates = "coordinates"
    }
}
