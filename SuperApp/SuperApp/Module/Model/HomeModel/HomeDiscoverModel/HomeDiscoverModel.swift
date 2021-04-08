// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import Foundation

struct HomeDiscoverModel: ResponseProtocol, Codable {
    var success: Bool?
    var detail: String?
    var total_records: Int?
    var list: [HomeDiscoverListModel]? = []

    enum CodingKeys: String, CodingKey {
        case success = "success"
        case detail = "detail"
        case total_records = "total_records"
        case list = "list"
    }
}

struct HomeDiscoverListModel: Codable, Hashable, Identifiable {
    let id = UUID()
    var province_id: Int?
    var total_project: Int?
    var province_name: String?
    var province_avatar: String?

    private enum CodingKeys: String, CodingKey {
        case province_id = "province_id"
        case total_project = "total_project"
        case province_name = "province_name"
        case province_avatar = "province_avatar"
    }
}
