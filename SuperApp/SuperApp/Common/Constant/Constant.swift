// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import SwiftUI

// MARK: SCREEN SIZE
let FULL_W: CGFloat = UIScreen.main.bounds.width
let FULL_H: CGFloat = UIScreen.main.bounds.height

// MARK: DEVICE
let H_SE: CGFloat = 568
let W_SE: CGFloat = 320

let H_8: CGFloat = 667
let W_8: CGFloat = 375

let H_8Plus: CGFloat = 736
let W_8Plus: CGFloat = 414

let H_11: CGFloat = 896
let W_11: CGFloat = 414

let H_11Pro: CGFloat = 812
let W_11Pro: CGFloat = 375

// MARK: NAV SIZE
let H_NAV_CUSTOM: CGFloat = 100
let H_NAV_CUSTOM_SMALL: CGFloat = 60

// MARK: LANGUAGE
let VIETNAM = 1
let ENGLISH = 2

// MARK: HELVETICA FONT
let MEDIUM = "HelveticaNeue-Medium"
let BOLD = "HelveticaNeue-Bold"
let LIGHT = "HelveticaNeue-Light"
let ITALIC = "HelveticaNeue-Italic"
let LIGHT_ITALIC = "HelveticaNeue-LightItalic"
let REGULAR = "HelveticaNeue"

// MARK: INFO RABBIT
let RABBIT_USER = "uniprime"  //KeychainManager.shared.getString(key: .RABBIT_USER)
let RABBIT_PASS = "uniprim0mnv" //KeychainManager.shared.getString(key: .RABBIT_PASS)
let RABBIT_HOST = "222.255.238.29" //KeychainManager.shared.getString(key: .RABBIT_HOST)
let RABBIT_PORT = 3005 //KeychainManager.shared.getString(key: .RABBIT_PORT)
let RABBIT_VHOT = "chatting-uniprime" //KeychainManager.shared.getString(key: .RABBIT_VHOT)
let CHATTING_QUEUE = "json_messages" //KeychainManager.shared.getString(key: .CHATTING_QUEUE)
let CHATTING_EXCHANGE_SEND = "amq.topic" //KeychainManager.shared.getString(key: .CHATTING_EXCHANGE)
let APP_BASE_URL_CHATTING = "amqp://\(RABBIT_USER):\(RABBIT_PASS)@\(RABBIT_HOST):\(RABBIT_PORT)/\(RABBIT_VHOT)"
let CHATTING_EXCHANGE = "amq.direct"

// MARK: KEY_RABBIT
let KEY_MESSAGE = "message"
let KEY_CREATE_ROOM = "create_room"
let KEY_FIRST_LOG  = "first_log"
let KEY_LOG_MESSAGE = "get_log"

// MARK: FORMATTER
let LOCAL_IDENTIFIER_VN = "vi_VN"
let LOCAL_IDENTIFIER_US = "en_US_POSIX"
let FORMATTER_DATE = "EEEE, dd/MM/yyyy"
let FORMATTER_HOURS = "h:mm a"
let FORMATTER_DATE_SERVER = "yyyy-MM-dd HH:mm:ss"
let FORMATTER_DATE_SERVER_CHAT = "dd/MM/yyyy HH:mm:ss"
let FORMATTER_DATE_dd_MM_yyyy = "dd/MM/yyyy"
let FORAMTTER_DATE_YYYY_MM_DD = "yyyy-MM-dd"
let AVATAR_DEFAULT = "http://travelapidev.minerva.vn/static/img/default_avatar.png"

// MARK: ZOOM_LEVEL
let ZOOM_DEFAULT: CGFloat = CGFloat(13)
