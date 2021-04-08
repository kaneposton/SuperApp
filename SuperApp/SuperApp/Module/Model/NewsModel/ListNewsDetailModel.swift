//
//  ListNewsDetailModel.swift
//  SuperApp
//
//  Created by hoanglinh on 4/21/20.
//  Copyright © 2020 Tran Thien Phu. All rights reserved.
//

import SwiftUI

struct ListNewsDetailModel: Codable, Hashable {
         var created_at : String?
         var new_content : String?
         var new_description : String?
         var new_title : String?
         var news_id : Int?
         var thumbnail_url : String?
    
    enum CodingKeys: String, CodingKey {
        case news_id = "news_id"
        case new_title = "new_title"
        case new_description = "new_description"
        case new_content = "new_content"
        case thumbnail_url = "thumbnail_url"
        case created_at = "created_at"
    }
}

