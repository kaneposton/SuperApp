// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import Foundation

struct LibraryModel: Codable {
    let success: Bool?
    let list_image: [LibraryListImageModel]?
    let list_video: [LibraryListVideoModel]?
    let list_ar: [LibraryListARModel]?

    enum CodingKeys: String, CodingKey {
        case success = "success"
        case list_image = "list_image"
        case list_video = "list_video"
        case list_ar = "list_ar"
    }
}

struct LibraryListImageModel: Codable, Hashable, Identifiable {
    let id = UUID()
    var url: String?
    var info: LibraryInfoModel?

    enum CodingKeys: String, CodingKey {
        case url = "url"
        case info = "info"
    }
}

struct LibraryListVideoModel: Codable, Hashable, Identifiable {
    let id = UUID()
    var url: String?
    var info: LibraryInfoModel?

    enum CodingKeys: String, CodingKey {
        case url = "url"
        case info = "info"
    }
}

struct LibraryListARModel: Codable, Hashable, Identifiable {
    let id = UUID()
    var url: String?
    var info: LibraryInfoModel?

    enum CodingKeys: String, CodingKey {
        case url = "url"
        case info = "info"
    }
}

struct LibraryInfoModel: Codable, Hashable, Identifiable {
    let id = UUID()
    var info: String?

    enum CodingKeys: String, CodingKey {
        case info = "info"
    }
}
