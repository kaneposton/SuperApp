// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import Foundation

struct ProjectListResponeModel: Codable, ResponseProtocol {
    var success: Bool?
    var detail: String?
    var total_records: Int?
    var list: [ProjectListModel]? = []

    private enum CodingKeys: String, CodingKey {
        case list = "list"
        case success = "success"
        case detail = "detail"
        case total_records = "total_records"
    }
}
