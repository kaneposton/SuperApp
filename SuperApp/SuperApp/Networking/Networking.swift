// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import Foundation
import RxCocoa
import ObjectMapper
import KeychainSwift
import AeroGearOTP
import MBProgressHUD
import Combine
import SwiftyJSON
import Alamofire
import UIKit

enum METHOD: String {
    case POST = "POST"
    case GET = "GET"
    case PUT = "PUT"
    case DELETE = "DELETE"
}

class Networking {
    static let shared: Networking = {
        let instance = Networking()
        return instance
    }()

    let session: URLSession
    init(session: URLSession = .shared) {
        self.session = session
    }

    func getHeader() -> [String: String] {
        let accessToken = KeychainManager.shared.getToken() ?? ""
        let otp = genOTP()
        if(!accessToken.isEmpty) {
            return ["Content-Type": "application/json",
                "Authorization": "Bearer \(String(describing: accessToken))",
                "MNV-Device": otp!]
        } else {
            return ["Content-Type": "application/json",
                "MNV-Device": otp!]
        }
    }

    func aut_basic(_ username: String?, password: String?) -> String? {
        // Forming string with credentials 'myusername:mypassword'
        let authStr = "\(username ?? ""):\(password ?? "")"
        // Getting data from it
        let authData: Data? = authStr.data(using: .ascii)
        // Encoding data with base64 and converting back to NSString
        var authStrData: String? = nil
        if let base64 = authData?.base64EncodedData(options: .endLineWithLineFeed) {
            authStrData = String(data: base64, encoding: .ascii)
        }
        // Set your user login credentials
        return "Basic \(authStrData ?? "")"
    }

    func genOTP() -> String? {
        let seconds: TimeInterval = Date().timeIntervalSince1970
        let s = UInt64(seconds)
        var current_time_no_second: UInt64 = (s / 60) * 60
        let current_second = Int(s % 60)
        if current_second < 30 {
            current_time_no_second += 29
        } else {
            current_time_no_second += 59
        }
        let generator = AGTotp(secret: AGBase32.base32Decode("najvj5u2sd5svty"))
        if let strOTP = generator?.generate(forCounter: current_time_no_second) {
            return strOTP
        }
        return ""
    }

    func parse_data_output(_ params: [AnyHashable: Any]?) -> Data? {
        var _: Error?
        var data: NSData? = nil
        if let params = params {
            data = try? JSONSerialization.data(withJSONObject: params, options: []) as NSData
        }
        return data?.zlibDeflate()
    }

    func parse_data_input(_ data: Data?) -> Data? {
        let res: Data? = (data as NSData?)?.zlibInflate()
        return res
    }

    //MARK: Respone JSON with Image
    func getHeaderWithImage(param: Int) -> [String: String] {
        let accessToken = KeychainManager.shared.getToken() ?? ""
        let otp = genOTP()
        return ["Content-Type": "image/png",
            "CONTENT-DISPOSITION": "name=\"file\"; filename=\"image.png\"",
            "Minerva": "Bearer \(String(describing: accessToken))",
            "MNV-Device": otp!,
            "TOURIST-STORY-ID": "\(param)"]
    }

    func upLoadFile(url: String, parameters: [String: Any], onCompletion: ((JSON?) -> Void)? = nil, onError: ((Error?) -> Void)? = nil) {
        let accessToken = KeychainManager.shared.getToken() ?? ""
        let otp = genOTP()

        let headers: HTTPHeaders = [
            "Content-type": "multipart/form-data",
            "Authorization": "Bearer \(String(describing: accessToken))",
            "MNV-Device": otp!
        ]

        Alamofire.upload(multipartFormData: { (multipartFormData) in
            for (key, value) in parameters {
                if let _value = value as? [URL] {
                    _value.forEach({ rs in
                        do {
                            let dataUrl = try Data(contentsOf: rs.absoluteURL)
                            multipartFormData.append(dataUrl, withName: "document", fileName: "\(rs.lastPathComponent)", mimeType: "application/pdf")
                        } catch {
                            Utils.showAlert("Upload thất bại")
                        }
                    })
                } else {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
            }
        }, usingThreshold: UInt64.init(), to: url, method: .post, headers: headers)
        { (result) in
            switch result {
            case .success(let upload, _, _):
                upload.uploadProgress(closure: { (progress) in
                    print("uploading: \(progress.fractionCompleted)")
                })

                upload.responseString { response in
                    guard let httpResponse = response.response, 200..<300 ~= httpResponse.statusCode else {
                        if let errorCode = response.response {
                            let localizedResponse = HTTPURLResponse.localizedString(forStatusCode: errorCode.statusCode)
                            DispatchQueue.main.async {
                                Utils.showAlert("\(localizedResponse.description) : \(errorCode.statusCode)")
                                print("ERRORS: \(localizedResponse.description) : \(errorCode.statusCode)")
                            }
                        }
                        return
                    }
                    guard let dataDecrypt: Data = self.parse_data_input(response.data) else { return }
                    let str = dataDecrypt.prettyPrintedJSONString
                    debugPrint("====================================================================================================================")
                    debugPrint(self)
                    debugPrint()
                    debugPrint("URL: \(url)")
                    debugPrint()
                    print("PARAMS: \(JSON(parameters))")
                    debugPrint()
                    debugPrint(str ?? "")
                    debugPrint("====================================================================================================================")
                    do {
                        let data = try JSON(data: dataDecrypt)
                        onCompletion!(data)
                    } catch {

                    }
                    if let err = response.error {
                        print(err)
                        return
                    }
                }
            case .failure(let error):
                print("Error in upload: \(error.localizedDescription)")
                onError?(error)
            }
        }
    }

    func upLoadImage(url: String, parameters: [String: Any], onCompletion: ((JSON?) -> Void)? = nil, onError: ((Error?) -> Void)? = nil) {
        let accessToken = KeychainManager.shared.getToken() ?? ""
        let otp = genOTP()

        let headers: HTTPHeaders = [
            "Content-type": "multipart/form-data",
            "Authorization": "Bearer \(String(describing: accessToken))",
            "MNV-Device": otp!
        ]

        Alamofire.upload(multipartFormData: { (multipartFormData) in
            for (key, value) in parameters {
                if let _value = value as? UIImage {
                    let dataImage = _value.pngData()
                    multipartFormData.append(dataImage!, withName: "avatar", fileName: "quecbeo", mimeType: "image/jpg")
                } else {
                    multipartFormData.append("\(value)".data(using: String.Encoding.utf8)!, withName: key as String)
                }
            }
        }, usingThreshold: UInt64.init(), to: url, method: .post, headers: headers)
        { (result) in
            switch result {
            case .success(let upload, _, _):
                upload.uploadProgress(closure: { (progress) in
                    print("uploading: \(progress.fractionCompleted)")
                })

                upload.responseString { response in
                    guard let httpResponse = response.response, 200..<300 ~= httpResponse.statusCode else {
                        if let errorCode = response.response {
                            let localizedResponse = HTTPURLResponse.localizedString(forStatusCode: errorCode.statusCode)
                            DispatchQueue.main.async {
                                Utils.showAlert("\(localizedResponse.description) : \(errorCode.statusCode)")
                                print("ERRORS: \(localizedResponse.description) : \(errorCode.statusCode)")
                            }
                        }
                        return
                    }
                    guard let dataDecrypt: Data = self.parse_data_input(response.data) else { return }
                    let str = dataDecrypt.prettyPrintedJSONString
                    debugPrint("====================================================================================================================")
                    debugPrint(self)
                    debugPrint()
                    debugPrint("URL: \(url)")
                    debugPrint()
                    print("PARAMS: \(JSON(parameters))")
                    debugPrint()
                    debugPrint(str ?? "")
                    debugPrint("====================================================================================================================")
                    do {
                        let data = try JSON(data: dataDecrypt)
                        onCompletion!(data)
                    } catch { }
                    if let err = response.error {
                        print(err)
                        return
                    }
                }
            case .failure(let error):
                print("Error in upload: \(error.localizedDescription)")
                onError?(error)
            }
        }
    }

    func fetchData<T>(isShowHUB: Bool = false, url: String?, params: [String: Any] = [:], method: METHOD = .POST, header: [String: Any] = [:], isLogin: Bool = false) -> AnyPublisher<T, ErrorStatus> where T: Decodable {
        // show hubs
        var hubs: MBProgressHUD?

        DispatchQueue.main.async {
            if isShowHUB {
                if let topVC = UIApplication.getTopViewController() {
                    hubs = MBProgressHUD.showAdded(to: topVC.view, animated: true)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                        (hubs ?? MBProgressHUD()).hide(animated: true)
                    }
                }
            }
        }

        // check nil url
        guard let url = url else {
            let error = ErrorStatus.network(description: "Couldn't create Url")
            return Fail(error: error).eraseToAnyPublisher()
        }

        // create URLRequest
        var request: URLRequest?
        if let url = URL(string: url) {
            request = URLRequest(url: url)
        }
        request?.httpMethod = method.rawValue

        // Header
        let header = header
        for key in (header.keys) {
            request!.addValue(header[key] as! String, forHTTPHeaderField: key)
        }

        // encode param
        if params.count == 0 && !isLogin {

        } else {
            request?.httpBody = self.parse_data_output(params)
        }

        return session.dataTaskPublisher(for: request!)
            .tryMap { data, response in
                guard let httpResponse = response as? HTTPURLResponse,
                    200..<300 ~= httpResponse.statusCode else {
                        // show alert error code and description
                        if let errorCode = response as? HTTPURLResponse {
                            let localizedResponse = HTTPURLResponse.localizedString(forStatusCode: errorCode.statusCode)
                            DispatchQueue.main.async {
                                hubs?.hide(animated: true)
                                Utils.showAlert("\(localizedResponse.description) : \(errorCode.statusCode) + \(url)")
                                print("ERRORS: \(localizedResponse.description) : \(errorCode.statusCode)")
                            }

                        }
                        throw ErrorStatus.unknow
                }
                DispatchQueue.main.async {
                    hubs?.hide(animated: true)
                }
                guard let dataDecrypt: Data = self.parse_data_input(data) else { return data }
                let str = dataDecrypt.prettyPrintedJSONString
                debugPrint("====================================================================================================================")
                debugPrint(T.self)
                debugPrint()
                debugPrint("URL: \(url)")
                debugPrint()
                debugPrint("METHOD: \(method.rawValue)")
                debugPrint()
                print("HEADER: \(JSON(header))")
                debugPrint()
                print("PARAMS: \(JSON(params))")
                debugPrint()
                debugPrint(str ?? "")
                debugPrint("====================================================================================================================")
                return dataDecrypt
            }.mapError { error in
                    .network(description: error.localizedDescription)
            }.flatMap() { data in
                decode(data)
            }.eraseToAnyPublisher()
    }
}

extension Data {
    var prettyPrintedJSONString: NSString? { /// NSString gives us a nice sanitized debugDescription
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
            let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
            let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }

        return prettyPrintedString
    }
}
