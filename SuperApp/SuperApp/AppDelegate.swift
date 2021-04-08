// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import UIKit
import Firebase
import UserNotifications

import FirebaseMessaging
import FirebaseInstanceID

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate, MessagingDelegate {
    var window: UIWindow?
    let gcmMessageIDKey = "gcm.message_id"

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        self.window = UIWindow(frame: UIScreen.main.bounds)

        FirebaseApp.configure()
        Messaging.messaging().delegate = self
        registerPushNotifications(application)

        //get application instance ID
        InstanceID.instanceID().instanceID { (result, error) in
            if let error = error {
                print("Error fetching remote instance ID: \(error)")
            } else if let result = result {
                print("Remote instance ID token: \(result.token)")
            }
        }
        return true
    }

    // MARK: UISceneSession Lifecycle
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    private func registerPushNotifications(_ application: UIApplication) {
        if #available(iOS 10.0, *) {
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().delegate = self
            UNUserNotificationCenter.current().requestAuthorization(options: authOptions, completionHandler: { granted, error in
                if granted {
                    DispatchQueue.main.async {
                        // application.registerForRemoteNotifications()
                        UIApplication.shared.registerForRemoteNotifications()
                    }
                } else {
                    // Unsuccessful...
                }
            })
        } else {
            let userNotificationTypes: UIUserNotificationType = [.alert, .badge, .sound]
            let settings = UIUserNotificationSettings(types: userNotificationTypes, categories: nil)
            application.registerUserNotificationSettings(settings)
            application.registerForRemoteNotifications()
        }
    }

    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        print("Firebase registration token: \(fcmToken)")
        let dataDict: [String: String] = ["token": fcmToken]
        KeychainManager.shared.saveString(value: fcmToken, forkey: .deviceToken)
        NotificationCenter.default.post(name: Notification.Name("FCMToken"), object: nil, userInfo: dataDict)

    }

    func userNotificationCenter(_ center: UNUserNotificationCenter,
        willPresent notification: UNNotification,
        withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {

        let userInfo = notification.request.content.userInfo
//        NotificationCenter.default.post(name: .receiveNotificationChat, object: false, userInfo: userInfo)
        let application = UIApplication.shared

        if(application.applicationState == .active) {
//            if Utils.topViewController() is WarehouseChatVC {
//                completionHandler([])
//
//            } else {
//                completionHandler([UNNotificationPresentationOptions.alert])
//            }
        }

        if(application.applicationState == .inactive) {
            completionHandler([UNNotificationPresentationOptions.alert])

        }
        if(application.applicationState == .background) {
            completionHandler([UNNotificationPresentationOptions.alert])

        }
    }
    func userNotificationCenter(_ center: UNUserNotificationCenter,
        didReceive response: UNNotificationResponse,
        withCompletionHandler completionHandler: @escaping () -> Void) {
        let application = UIApplication.shared

        if(application.applicationState == .active) {
            print("user tapped the notification bar when the app is in foreground")
        }

        if(application.applicationState == .inactive) {
            print("user tapped the notification bar when the app is in background")
        }
        if(application.applicationState == .background) {

        }
        let userInfo = response.notification.request.content.userInfo
        // Print message ID.
        print(userInfo)
//        let messageModel: WarehouseConversationSupperMarketModel? = WarehouseConversationSupperMarketModel()
        self.window = UIWindow(frame: UIScreen.main.bounds)
//        if let messageID = userInfo["data"] as? String{
//            let dic = String.parseStringToJson(string: messageID)
//            print(dic)
//            let vc = WarehouseChatVC(nibName: WarehouseChatVC.string, bundle: nil)
//            if let aps = userInfo["aps"] as? [String : Any] {
//                if let alert = aps["alert"] as? [String : Any] {
//                    if let title = alert["title"] as? String {
//                        vc.viewModel.name = title
//                    }
//                }
//            }
//            if let alert = dic["receiver"] as? String {
//                vc.viewModel.driverCode = alert
//            }
//            if let dtSender = dic["sender"] as? String {
//                messageModel?.name = dtSender
//                vc.name = dtSender
//            }
//            if let dtSender = dic["time"] as? String {
//                messageModel?.time = dtSender
//            }
//            if let dtSender = dic["message"] as? String {
//                messageModel?.message = [dtSender]
//            }
//
//            let navigationController = UINavigationController(rootViewController: vc)
//            navigationController.isNavigationBarHidden = false
//            navigationController.setNavigationBarHidden(false, animated: true)
//            GlobalQuick.tappedNotification = true
//            navigationController.modalPresentationStyle = UIModalPresentationStyle.fullScreen
//            Util.topViewController()?.present(navigationController, animated: true, completion: nil)
//
//        }
//        if let messageID = userInfo[gcmMessageIDKey] {
//            print("Message ID: \(messageID)")
//        }
        completionHandler()
    }
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) { }
}
