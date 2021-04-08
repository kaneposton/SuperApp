// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import Foundation
import SwiftUI
import UIKit

extension String {
    var localized: String {
        if let _ = KeychainManager.shared.getLanguage(key: .language) {
            
        } else {
            // UserDefaults.standard.set("en", forKey: "i18n_language")
            KeychainManager.shared.setLanguage(value: "en", forkey: .language)
            // UserDefaults.standard.synchronize()
        }
        // let lang1 = UserDefaults.standard.string(forKey: "i18n_language")
        let lang = KeychainManager.shared.getLanguage(key: .language)

        let path = Bundle.main.path(forResource: lang, ofType: "lproj")
        guard let _path = path else { return "" }
        let bundle = Bundle(path: _path)
        guard let _bundle = bundle else { return "" }
        return NSLocalizedString(self, tableName: nil, bundle: _bundle, value: "", comment: "")
    }
    
    static func getLast2Charater(name: String?) -> String {
        guard let getArrayName = name?.components(separatedBy: " ") else { return "" }
        var result = ""
        
        if getArrayName.count >= 2 {
            for i in 0 ..< getArrayName.count {                
                if i == getArrayName.count - 1 {
                    result = String("\(getArrayName[i - 1].prefix(1))\(getArrayName[i].prefix(1))")
                }
            }
        } else if getArrayName.count == 1 {
            result = String(getArrayName[0].prefix(1))
        } else if getArrayName.count == 0 {
            result = ""
        }
        
        return result
    }

    var length: Int {
        return count
    }

    subscript (i: Int) -> String {
        return self[i ..< i + 1]
    }

    func substring(fromIndex: Int) -> String {
        return self[min(fromIndex, length) ..< length]
    }

    func substring(toIndex: Int) -> String {
        return self[0 ..< max(0, toIndex)]
    }

    subscript (r: Range<Int>) -> String {
        let range = Range(uncheckedBounds: (lower: max(0, min(length, r.lowerBound)),
            upper: min(length, max(0, r.upperBound))))
        let start = index(startIndex, offsetBy: range.lowerBound)
        let end = index(start, offsetBy: range.upperBound - range.lowerBound)
        return String(self[start ..< end])
    }

    func removingWhiteSpaces() -> String {
        return components(separatedBy: .whitespaces).joined()
    }

    static func parseStringToJson(string: String = "") -> [String: Any] {
        let data = string.data(using: .utf8)!
        do {
            if let jsonArray = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
                {
                print(jsonArray) // use the json here
                return jsonArray
            } else {
                print("bad json")
                return [:]
            }
        } catch let error as NSError {
            print(error)
            return [:]
        }
    }

    func formatDate(from: String, to: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .current
        dateFormatter.dateFormat = from
        guard let date = dateFormatter.date(from: self) else { return "-/-/-" }
        dateFormatter.dateFormat = to
        return dateFormatter.string(from: date)
    }
}
