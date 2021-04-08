// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import Foundation
import UIKit
import MBProgressHUD

open class Utils {
    class func checkScreenIphone() -> CGFloat {
        switch UIDevice.current.screenType {
        case .iPhone_XR:
            return FULL_W / 2 + 95
        case .iPhone_XSMax:
            return FULL_W / 2 + 100
        case .iPhones_4_4S:
            return FULL_W
        case .iPhones_5_5s_5c_SE:
            return FULL_W
        case .iPhones_6_6s_7_8:
            return FULL_W / 2 + 5
        case .iPhones_6Plus_6sPlus_7Plus_8Plus:
            return FULL_W / 2 + 30
        case .iPhones_X_XS:
            return FULL_W / 2 + 80
        default:
            return FULL_W
        }
    }
    
    //Get text color
    class func getDateSelectColor(dataList: [String], index: Int, selected: Int) -> UIColor {
        //Get value index
        let value = dataList[index]
        //Get value select
        let day = dataList[selected]
        if value.elementsEqual(day) {
            return #colorLiteral(red: 0.4274509804, green: 0.1882352941, blue: 0.6705882353, alpha: 1)
        }
        return #colorLiteral(red: 0.5293536186, green: 0.5294462442, blue: 0.5293406844, alpha: 1)
    }
    
    //Get text font
    class func getDateSelectFont(dataList: [String], index: Int, selected: Int) -> String {
        //Get value index
        let value = dataList[index]
        //Get value select
        let day = dataList[selected]
        if value.elementsEqual(day) {
            return MEDIUM
        }
        return REGULAR
    }
    
    //Get text size
    class func getDateSelectSize(dataList: [String], index: Int, selected: Int) -> CGFloat {
        //Get value index
        let value = dataList[index]
        //Get value select
        let day = dataList[selected]
        if value.elementsEqual(day) {
            return 18
        }
        return 16
    }

    static var scaleScreenString = ["iPhone XR", "iPhone Xs Max", "iPhones 4", "iPhone 5", "iPhone 8", "iPhone 8 Plus", "iPhone Xs"]

    class func getDifferenceDate(fromDate: String, toDate: String) -> String {
        let dateFormatter = DateFormatter()
        let userCalendar = NSCalendar.current
        dateFormatter.locale = Locale(identifier: "vi_VN")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let startTime = dateFormatter.date(from: fromDate) else { return "" }
        guard let endTime = dateFormatter.date(from: toDate) else { return "" }
        let timeDifference = userCalendar.dateComponents([.day], from: startTime, to: endTime)
        return "\(timeDifference.day!)"
    }

    class func showAlert(alertMessage: String, completion: (() -> Void)?) {
        let alertVC = UIAlertController(title: "", message: alertMessage, preferredStyle: .alert)
        let buttonAlertOK = UIAlertAction(title: NSLocalizedString("OK", comment: ""), style: .cancel) { (handle) in
            completion?()
        }
        alertVC.addAction(buttonAlertOK)
        self.topViewController()?.present(alertVC, animated: true, completion: nil)
    }

    class func topViewController(controller: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }

    class func hideAllMBProgressHUD() {
        if #available(iOS 13.0.0, *) {
            if let appDelegate: AppDelegate = UIApplication.shared.delegate as? AppDelegate {
                if appDelegate.window != nil {
                    MBProgressHUD.hide(for: appDelegate.window!, animated: true)
                }
            }
        } else {
            // Fallback on earlier versions
        }
    }

    class func showAlert(_ alertMessage: String) {
        // Show alert
        Utils.showAlert(alertMessage: alertMessage, completion: nil)
    }

    class func getShowMBProgressHUD() -> MBProgressHUD? {
        if #available(iOS 13.0.0, *) {
            if let appDelegate: AppDelegate = UIApplication.shared.delegate as? AppDelegate {
                if appDelegate.window?.rootViewController != nil {
                    return MBProgressHUD.showAdded(to: appDelegate.window!.rootViewController!.view, animated: true)
                }
            }
        } else {
            // Fallback on earlier versions
        }
        return nil
    }

    class func loadImage(urlStr: String) -> UIImage {
        let url = URL(string: urlStr)
        let data = try? Data(contentsOf: url!)

        if let imageData = data {
            let image = UIImage(data: imageData)
            return image!
        }
        return UIImage()
    }

    class func getFormatterDate(format: String, identifier: String) -> DateFormatter {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: identifier)
        return dateFormatter
    }

    //MARK:Convert string to datetime
    class func convertStringToDate(str: String) -> NSDate {
        let formatter = self.getFormatterDate(format: "yyyy-MM-dd", identifier: "vi_VN")
        return formatter.date(from: str)! as NSDate
    }

    //MARK: Convert datetime to string
    class func convertDateToString(date: NSDate, formatter: String) -> String {
        let formatter = self.getFormatterDate(format: "dd/MM/yyyy", identifier: "vi_VN")
        return formatter.string(from: date as Date)
    }

    class func isValidUrl (urlString: String?) -> Bool {
        if let urlString = urlString {
            if let url = URL(string: urlString) {
                return UIApplication.shared.canOpenURL(url)
            }
        }
        return false
    }

    // save file  url --> document
    class func loadFileAsync(file: String, completion: @escaping (String?, Error?) -> Void) {
        let url = URL(string: file)!

        let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!

        let destinationUrl = documentsUrl.appendingPathComponent(url.lastPathComponent)
        if FileManager().fileExists(atPath: destinationUrl.path) {
            completion(destinationUrl.path, nil)
        } else {
            let session = URLSession(configuration: URLSessionConfiguration.default, delegate: nil, delegateQueue: nil)
            var request = URLRequest(url: url)
            request.httpMethod = "GET"
            let task = session.dataTask(with: request, completionHandler: {
                data, response, error in
                if error == nil {
                    if let response = response as? HTTPURLResponse {
                        if response.statusCode == 200 {
                            if let data = data {
                                if let _ = try? data.write(to: destinationUrl, options: Data.WritingOptions.atomic) {
                                    completion(destinationUrl.path, error)
                                } else {
                                    completion(destinationUrl.path, error)
                                }
                            } else {
                                completion(destinationUrl.path, error)
                            }
                        }
                    }
                } else {
                    completion(destinationUrl.path, error)
                }
            })
            task.resume()
        }
    }

    class func formatHighNumber(_ number: Double) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.groupingSeparator = ","
        numberFormatter.groupingSize = 3
        numberFormatter.usesGroupingSeparator = true
        numberFormatter.decimalSeparator = "."
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 2
        return numberFormatter.string(from: number as NSNumber)!
    }
    
    class func convertToDictionary(str: String) -> [String: Any]? {
        if let data = str.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
    class func formatIntNumber(_ number: Double) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 0
        return numberFormatter.string(from: number as NSNumber)!
    }

    class func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
