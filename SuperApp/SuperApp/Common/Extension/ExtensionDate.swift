// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import Foundation

extension Date {
    static func getCurrentDate(format: String) -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "vi_VN")
        formatter.dateFormat = format
        let result = formatter.string(from: date)
        return result
    }
    static func parseDuration(timeString: String) -> Double {
        let dfmatter = DateFormatter()
        dfmatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = dfmatter.date(from: timeString)
        if let dateStamp: TimeInterval = date!.timeIntervalSince1970 {
            let dateSt: Double = Double(dateStamp)
            return dateSt
        }
        return 0
    }
    static func convertStringToDate (_date: String) -> Date {
        let isoDate = _date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = Locale.current // set locale to reliable US_POSIX
        if let date = dateFormatter.date(from: isoDate) {
            return date
        }
        return Date()
    }
}
