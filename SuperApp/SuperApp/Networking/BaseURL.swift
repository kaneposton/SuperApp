// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import Foundation
import SwiftUI

struct BaseURL {
    static let baseURL = "http://superappapi.minerva.vn:9222"
}

struct RegisterURL {
    static let RegisUrl = "\(BaseURL.baseURL)/api/v1/customer/register"
}

struct LoginUrl {
    static let LoginUrl = "\(BaseURL.baseURL)/api/v1/login"
    static let forgotPassWordURL = "\(BaseURL.baseURL)/api/v1/user/forgot"
}

//MARK: API News
struct NewsURL {
    static let categoriesURL = "\(BaseURL.baseURL)/api/v1/project/sale/news/category"
    static let listNewsURL = "\(BaseURL.baseURL)/api/v1/project/sale/news"
    static let NewsDetailURL = "\(BaseURL.baseURL)/api/v1/project/sale/news/detail"
}

//MARK: PROJECT
struct Project {
    static let projectList = "\(BaseURL.baseURL)/api/v1/project/list"
    static let discover = "\(BaseURL.baseURL)/api/v1/project/discover"
    static let Sale_Library = "\(BaseURL.baseURL)/api/v1/project/sale/library"
    static let Sales = "\(BaseURL.baseURL)/api/v1/project/sale/sales"
    static let introduction = "\(BaseURL.baseURL)/api/v1/project/introduction"
}

struct HomeUrl {
    static let homeDiscover = "\(BaseURL.baseURL)/api/v1/project/discover"
    static let homeProjectList = "\(BaseURL.baseURL)/api/v1/project/list"
    static let homeProductSelling = "\(BaseURL.baseURL)/api/v1/project/product/selling"
}

struct FilterUrl {
    static let filterStatus = "\(BaseURL.baseURL)/api/v1/project/status?language="
    static let filterProject = "\(BaseURL.baseURL)/api/v1/project/setting_type?language="
    static let filterCity = "\(BaseURL.baseURL)/api/v1/project/provinces"
    static let filterDistrict = "\(BaseURL.baseURL)/api/v1/project/districts"
}

//MARK: CONTACT
struct ContactUrl {
    static let contact = "\(BaseURL.baseURL)/api/v1/project/contact/info"
}

//MARK: SALE
struct SaleUrl {
    static let location = "\(BaseURL.baseURL)/api/v1/project/sale/location"
    static let library = "\(BaseURL.baseURL)/api/v1/project/sale/library"
}

//MARK: UTILITIES
struct UlitiesUrl {
    static let ulities = "\(BaseURL.baseURL)/api/v1/project/utilities/list"
}
