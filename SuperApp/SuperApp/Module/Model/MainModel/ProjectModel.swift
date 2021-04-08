// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import Foundation

class ProjectModel: Codable {
    var project_id: Int?
    var project_name: String?
    var project_status: Int?
    var project_avatar_url: String?

    private enum CodingKeys: String, CodingKey {
        case project_id = "project_id"
        case project_name = "project_name"
        case project_status = "project_status"
        case project_avatar_url = "project_avatar_url"
    }
}
