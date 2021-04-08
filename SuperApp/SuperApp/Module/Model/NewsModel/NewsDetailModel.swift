// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import SwiftUI

struct NewsDetailModel: Codable, Hashable {
    var success: Bool?
    var created_at: String?
    var new_content: String?
    var new_description: String?
    var new_title: String?
    var news_id: Int?
    var thumbnail_url: String?

    enum CodingKeys: String, CodingKey {
        case success = "success"
        case news_id = "news_id"
        case new_title = "new_title"
        case new_description = "new_description"
        case new_content = "new_content"
        case thumbnail_url = "thumbnail_url"
        case created_at = "created_at"
    }
}
