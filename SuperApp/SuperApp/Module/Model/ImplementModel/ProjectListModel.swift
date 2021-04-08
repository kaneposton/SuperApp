// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import Foundation

class ProjectListModel: ProjectModel {
    var address: String?
    var total_area_square: Int?
    var latitude: Double?
    var longitude: Double?
    var date_opened: String?
    var rank_type: Int?
    var description: String?
    var province_id: Int?
    var province_name: String?
    var district_id: Int?
    var district_name: String?
    var location: String?
    var project_highlights: Bool?
    var project_setting_type: [ProjectSettingType]?

    required init(from decoder: Decoder) throws {
        let contrainer = try decoder.container(keyedBy: CodingKeys.self)
        self.address = try contrainer.decode(String.self, forKey: .address)
        self.total_area_square = try contrainer.decode(Int.self, forKey: .total_area_square)
        self.latitude = try contrainer.decode(Double.self, forKey: .latitude)
        self.longitude = try contrainer.decode(Double.self, forKey: .longitude)
        self.date_opened = try contrainer.decode(String.self, forKey: .date_opened)
        self.rank_type = try contrainer.decode(Int.self, forKey: .rank_type)
        self.description = try contrainer.decode(String.self, forKey: .description)
        self.province_id = try contrainer.decode(Int.self, forKey: .province_id)
        self.province_name = try contrainer.decode(String.self, forKey: .province_name)
        self.district_id = try contrainer.decode(Int.self, forKey: .district_id)
        self.district_name = try contrainer.decode(String.self, forKey: .district_name)
        self.location = try contrainer.decode(String.self, forKey: .location)
        self.project_highlights = try contrainer.decode(Bool.self, forKey: .project_highlights)
        self.project_setting_type = try contrainer.decode([ProjectSettingType].self, forKey: .project_setting_type)
        try super.init(from: decoder)
    }
    
    private enum CodingKeys: String, CodingKey {
        case address = "address"
        case total_area_square = "total_area_square"
        case latitude = "latitude"
        case longitude = "longitude"
        case date_opened = "date_opened"
        case rank_type = "rank_type"
        case description = "description"
        case province_id = "province_id"
        case province_name = "province_name"
        case district_id = "district_id"
        case district_name = "district_name"
        case location = "location"
        case project_highlights = "project_highlights"
        case project_setting_type = "project_setting_type"
    }
}
