// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import Foundation

protocol ResponseProtocol {
    var success: Bool? { get }
    var detail: String? { get }
    var total_records: Int? { get }
}

struct ResponseModel: ResponseProtocol, Codable {
    var success: Bool?
    var detail: String?
    var total_records: Int?

    private enum CodingKeys: String, CodingKey {
        case success = "success"
        case detail = "detail"
        case total_records = "total_records"
    }
}
