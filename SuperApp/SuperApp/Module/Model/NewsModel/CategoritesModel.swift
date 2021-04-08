// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import SwiftUI
import Foundation
import Combine

struct NewsCatesModel: Codable, Hashable {
    var list: [NewsCategoriesModel] = []
    var success: Bool?

    enum CodingKeys: String, CodingKey {
        case list = "list"
        case success = "success"
    }
}

struct NewsCategoriesModel: Codable, Hashable {
    var category_id: Int?
    var category_name: String?

    enum CodingKeys: String, CodingKey {
        case category_id = "category_id"
        case category_name = "category_name"
    }
}
