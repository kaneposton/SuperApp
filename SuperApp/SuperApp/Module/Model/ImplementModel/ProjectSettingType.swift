// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import Foundation

class ProjectSettingType: Decodable {
    var name: String?
    var type_id: Int?

    private enum codingKeys: String, CodingKey {
        case name = "name"
        case type_id = "type_id"
    }
}
