// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import Foundation

struct FilterStatusModel: Codable {
    let success: Bool?
    let detail: String?
    let list: [FilterStatusListModel]?

    enum CodingKeys: String, CodingKey {
        case success = "success"
        case detail = "detail"
        case list = "list"
    }
}

struct FilterStatusListModel: Codable, Hashable, Identifiable {
    let uuid = UUID()
    var id: Int?
    var name: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "name"
    }
}
