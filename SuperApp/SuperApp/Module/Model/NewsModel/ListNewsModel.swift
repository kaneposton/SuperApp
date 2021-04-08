// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import SwiftUI

struct ListNewsModel: Codable, Hashable {
    var list: [NewsListModel]?
    var page: Int?
    var success: Bool?
    var total_pages: Int?
    var total_records: Int?

    enum CodingKeys: String, CodingKey {
        case success = "success"
        case list = "list"
        case page = "page"
        case total_pages = "total_pages"
        case total_records = "total_records"
    }
}

struct NewsListModel: Codable, Hashable {
    var avatar_url: String?
    var created_at: String?
    var news_id: Int?
    var news_title: String?

    enum CodingKeys: String, CodingKey {
        case avatar_url = "avatar_url"
        case created_at = "created_at"
        case news_id = "news_id"
        case news_title = "news_title"
    }
}

extension NewsListModel {
    func formatTime() -> String {
        let time = DateFormatter()
        time.locale = Locale(identifier: "vi_VN")
        time.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        guard let date = time.date(from: self.created_at ?? "") else { return "-/-/-" }
        time.dateFormat = "HH:mm dd/MM/yyyy"
        return time.string(from: date)

    }
}
