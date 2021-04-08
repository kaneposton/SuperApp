// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import Foundation

struct FilterProjectModel: Codable {
    let success: Bool?
    let list: [FilterProjectListModel]?

    enum CodingKeys: String, CodingKey {
        case success = "success"
        case list = "list"
    }
}

struct FilterProjectListModel: Codable, Hashable, Identifiable {
    let id = UUID()
    var type_id: Int?
    var type_name: String?

    enum CodingKeys: String, CodingKey {
        case type_id = "id"
        case type_name = "name"
    }
}
