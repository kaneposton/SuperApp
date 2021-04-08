// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import SwiftUI
import Foundation

struct IntroductionModel: Codable, Hashable {
    let success: Bool?
    let detail: String?
    let info: IntroductionListModel?

    enum CodingKeys: String, CodingKey {
        case success = "success"
        case detail = "detail"
        case info = "info"
    }
}

struct IntroductionListModel: Codable, Hashable, Identifiable {
    let id = UUID()
    var total_area_square: Int?
    var education_and_health: Int?
    var theme_parks: Int?
    var area_water_surface: Int?
    var area_river: Int?
    var common_utility: Int?

    enum CodingKeys: String, CodingKey {
        case total_area_square = "total_area_square"
        case education_and_health = "education_and_health"
        case theme_parks = "theme_parks"
        case area_water_surface = "area_water_surface"
        case area_river = "area_river"
        case common_utility = "common_utility"
    }
}
