// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import Foundation

struct RegisterModel: Codable {
    var success: Bool?
    var detail: String?
    var customer_id: Int?

    enum CodingKeys: String, CodingKey {
        case success = "success"
        case detail = "detail"
        case customer_id = "customer_id"
    }
}
