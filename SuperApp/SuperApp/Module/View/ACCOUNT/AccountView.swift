// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import SwiftUI
import Combine
import SDWebImageSwiftUI

struct AccountLineData: Identifiable, Hashable {
    var id = UUID()
    var state: String
    var imageName: String
    var menuName: String
    var notify: Int
    var isEnd: Bool
}

struct AccountView: View {
    let closeSideMenu: () -> Void
    let callSaveLogin: () -> Void
    @Binding var isOpenSideMenu: Bool
    @Binding var isSideMenuAppear: Bool
    @Binding var isNextSideMenu: Bool
    @Binding var selectedMenuPurple: Int
    @Binding var selectedCorlor: Int
    @Binding var isTabBarAppear: Bool
    @Binding var isLogin: Bool
    @Binding var strUsernameTemp: String
    @Binding var strPasswordTemp: String
    @Binding var txtCheckUser: String
    @Binding var txtCheckPass: String
    @Binding var showPopUpLogin: Bool
    @Binding var userInfor: LoginModel

    @State var isNextLogin = false
    @State var isNextProject = false
    @State var isAnimation = false
    @State var isNextInfo = false
    @State var isNextResponse = false
    @State var tempNext = false

    @State var disposables = Set<AnyCancellable>()

    @State var arrLogin = [
        AccountLineData(state: "info", imageName: "informationLine", menuName: "account_information", notify: 0, isEnd: false),
        AccountLineData(state: "project", imageName: "projectLine", menuName: "account_project_list", notify: 0, isEnd: false),
        AccountLineData(state: "payment", imageName: "paymentLine", menuName: "account_manage_payment", notify: 0, isEnd: false),
        AccountLineData(state: "response", imageName: "responseLine", menuName: "account_response", notify: 0, isEnd: true),
    ]

    @State var arr = [
        AccountLineData(state: "liked", imageName: "heartLine", menuName: "account_favorite_apartment", notify: 2, isEnd: false),
        AccountLineData(state: "support", imageName: "supportLine", menuName: "Hỗ trợ", notify: 0, isEnd: false),
        AccountLineData(state: "setting", imageName: "settingsLine", menuName: "account_setting", notify: 0, isEnd: true),
    ]

    @State var isHasDataLogin = false

    @EnvironmentObject private var homeViewModel: HomeViewModel
    @ObservedObject var loginViewModel = LoginViewModel()

    var body: some View {
        NavigationView {
            ZStack (alignment: .top) {
                if tempNext {
                    Text("").onAppear {
                        self.isTabBarAppear = true
                        self.tempNext = false
                    }
                }
                VStack (spacing: 0) {
                    // MARK: NAVIGATION BAR
                    NavigationWhite(
                        isTapSearch: Binding.constant(false),
                        isLogin: $isLogin,
                        isChangeColor: Binding.constant(false),
                        isOpenSideMenu: Binding.constant(false),
                        strSearch: Binding.constant(""),
                        isShowCalendar: Binding.constant(false),
                        isChooseValueDate: Binding.constant(false),
                        title: "account_title",
                        backFunc: { },
                        mapFunc: { },
                        filterFunc: { },
                        optionFunc: { },
                        callFunc: { },
                        textFunc: { },
                        isHaveOption: true)

                    // MARK: BODY
                    ScrollView(showsIndicators: false) {
                        VStack (spacing: 0) {
                            AccountInfoView(
                                isLogin: $isLogin,
                                isNextLogin: $isNextLogin,
                                isTabBarAppear: $isTabBarAppear,
                                image: userInfor.avatar_url ?? "",
                                userName: userInfor.username ?? ""
                            )
                            if isLogin {
                                HStack {
                                    TextCustom(text: NSLocalizedString("account_manage_tk", comment: ""), font: MEDIUM, size: 16, color: #colorLiteral(red: 0.4282599092, green: 0.1879977882, blue: 0.6717798114, alpha: 1))
                                        .padding(.leading, 20)
                                    Spacer()
                                }.padding(.bottom, H(8))
                                ForEach(arrLogin, id: \.self) { data in
                                    AccountMenuList(
                                        isTabBarAppear: self.$isTabBarAppear,
                                        isNext:
                                            data.state == "info" ? self.$isNextInfo:
                                            data.state == "project" ? self.$isNextProject:
                                            data.state == "response" ? self.$isNextResponse: self.$tempNext,
                                        isAnimation: self.$isAnimation,
                                        data: data
                                    )
                                }
                            }
                            if isLogin {
                                Rectangle()
                                    .frame(height: H(10))
                                    .foregroundColor(.init(#colorLiteral(red: 0.9636391997, green: 0.9496440291, blue: 0.9981387258, alpha: 1)))
                                    .padding(.bottom, H(16))
                            }
                            HStack {
                                TextCustom(text: NSLocalizedString("account_function", comment: ""), font: MEDIUM, size: 16, color: #colorLiteral(red: 0.4282599092, green: 0.1879977882, blue: 0.6717798114, alpha: 1))
                                    .padding(.leading, 20)
                                Spacer()
                            }.padding(.bottom, H(8))
                            ForEach(arr, id: \.self) { data in
                                AccountMenuList(
                                    isTabBarAppear: self.$isTabBarAppear,
                                    isNext:
                                        data.state == "info" ? self.$isNextInfo:
                                        data.state == "project" ? self.$isNextProject: self.$tempNext,
                                    isAnimation: self.$isAnimation,
                                    data: data
                                )
                            }
                            if isLogin {
                                Button(action: {
                                    self.isLogin = false
                                    KeychainManager.shared.saveString(value: "false", forkey: .savelogin)
                                }) {
                                    TextCustom(text: NSLocalizedString("account_logout", comment: ""), font: MEDIUM, size: 18, color: #colorLiteral(red: 0.4281106591, green: 0.1894766092, blue: 0.6721540093, alpha: 1))
                                        .frame(width: W(374), height: H(50)).background(Color.white)
                                        .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.init(#colorLiteral(red: 0.4281106591, green: 0.1894766092, blue: 0.6721540093, alpha: 1)), lineWidth: 1.5))
                                }.buttonStyle(ButtonTapScale()).animation(.easeInOut(duration: 0.1))
                                    .padding(.top, H(18))
                                    .padding(.bottom, H(40))
                            }
                        }.padding(.bottom, H(
                            FULL_H == H_SE && FULL_W == W_SE ? 110: // iPhone SE 1st generation
                            FULL_H == H_8 && FULL_W == W_8 ? 95: // iPhone 8 && iPhone SE 2nd generation
                            FULL_H == H_8Plus && FULL_W == W_8Plus ? 85: // iPhone 8 Plus
                            FULL_H == H_11 && FULL_W == W_11 ? 45: // iPhone 11 && iPhone 11 Pro Max
                            FULL_H == H_11Pro && FULL_W == W_11Pro ? 45 : 0 // iPhone 11 Pro
                            ))
                    }
                }.background(Color.white)
                ZStack (alignment: .top) {
                    NavigationLink(destination:
                            LoginView(
                                isNextOld: $isNextLogin,
                                isTabBarAppear: $isTabBarAppear,
                                isLogin: $isLogin,
                                userInfor: $userInfor,
                                txtCheckUser: isLogin ? txtCheckUser : "",
                                txtCheckPass: isLogin ? txtCheckPass : "",
                                showPopUpLogin: isLogin ? showPopUpLogin : false
                            ), isActive: $isNextLogin) {
                        EmptyView()
                    }
                    NavigationLink(destination: InfoView(isNextOld: $isNextInfo), isActive: $isNextInfo) {
                        EmptyView()
                    }
                    NavigationLink(destination: ParticipatedProjectView(isNextOld: $isNextProject), isActive: $isNextProject) {
                        EmptyView()
                    }
                    NavigationLink(destination: ResponseListView(isNextOld: $isNextResponse), isActive: $isNextResponse) {
                        EmptyView()
                    }
                }
            }.onAppear {
                self.isTabBarAppear = true
                self.callSaveLogin()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    self.isAnimation = true
                }
            }.navigationBarBackButtonHidden(true)
                .navigationBarTitle("")
                .navigationBarHidden(true)
        }.navigationBarBackButtonHidden(true)
            .navigationBarTitle("")
            .navigationBarHidden(true)
    }
}

struct AccountInfoView: View {
    @Binding var isLogin: Bool
    @Binding var isNextLogin: Bool
    @Binding var isTabBarAppear: Bool
    @State var image: String
    @State var userName: String

    var body: some View {
        VStack (spacing: 0) {
            if isLogin {
                ZStack {
                    if image.isEmpty {
                        ZStack (alignment: .bottom) {
                            Rectangle()
                                .frame(width: W(106), height: W(106))
                                .foregroundColor(.init(#colorLiteral(red: 0.7886190414, green: 0.8274392486, blue: 0.865532577, alpha: 1)))
                            ImageCustom(name: "user1", w: 80, h: 90)
                        }
                    } else {
                        ZStack {
                            Rectangle().foregroundColor(.init(#colorLiteral(red: 0.9756801724, green: 0.9647900462, blue: 0.9644319415, alpha: 1)))
                            WebImage(url: URL(string: "\(image)"))
                                .resizable()
                        }.scaledToFill()
                            .frame(width: W(106), height: W(106))
                            .clipped()
                    }
                }.cornerRadius(.infinity)
                    .padding(.top, H(29))
                HStack {
                    Text(NSLocalizedString("account_hello", comment: ""))
                        .font(.custom(REGULAR, size: 14))
                        .foregroundColor(.init(#colorLiteral(red: 0.1422221363, green: 0.1236664429, blue: 0.1232500449, alpha: 1)))
                        + Text(" ")
                        .font(.custom(REGULAR, size: 14))
                        .foregroundColor(.init(#colorLiteral(red: 0.1422221363, green: 0.1236664429, blue: 0.1232500449, alpha: 1)))
                        + Text(userName.isEmpty ? "-" : "\(userName)")
                        .font(.custom(BOLD, size: 14))
                        .foregroundColor(.init(#colorLiteral(red: 0.1422221363, green: 0.1236664429, blue: 0.1232500449, alpha: 1)))
                }.padding(.top, H(10))
                    .padding(.bottom, H(34))
            } else {
                ZStack (alignment: .bottom) {
                    Rectangle()
                        .frame(width: W(72), height: W(72))
                        .foregroundColor(.init(#colorLiteral(red: 0.7886190414, green: 0.8274392486, blue: 0.865532577, alpha: 1)))
                    ImageCustom(name: "user1", w: 50, h: 56)
                }.cornerRadius(.infinity)
                    .padding(.top, H(29))
                Button(action: {
                    self.isNextLogin = true
                    self.isTabBarAppear = false
                }) {
                    TextCustom(text: NSLocalizedString("account_inout", comment: ""), font: MEDIUM, size: 18, color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
                        .frame(width: FULL_W - 182, height: H(40))
                        .background(LinearGradient(gradient: Gradient(colors: [.init(#colorLiteral(red: 0.5176470588, green: 0.3098039216, blue: 0.7254901961, alpha: 1)), .init(#colorLiteral(red: 0.4274509804, green: 0.1882352941, blue: 0.6705882353, alpha: 1)), .init(#colorLiteral(red: 0.4274509804, green: 0.1882352941, blue: 0.6705882353, alpha: 1))]), startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(5)
                        .shadow(color: Color.init(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2018942637)), radius: 6, x: 3, y: 3)
                }.buttonStyle(ButtonTapScale())
                    .animation(.easeInOut(duration: 0.1))
                    .padding(.top, H(20))
                    .padding(.bottom, H(34))
            }
        }
    }
}

struct AccountMenuList: View {
    @Binding var isTabBarAppear: Bool
    @Binding var isNext: Bool
    @Binding var isAnimation: Bool

    @State var data = AccountLineData(state: "", imageName: "", menuName: "", notify: 0, isEnd: false)

    var body: some View {
        VStack (spacing: 0) {
            Button(action: {
                self.isNext = true
                self.isTabBarAppear = false
            }) {
                HStack (spacing: 0) {
                    ImageCustom(name: data.imageName.isEmpty ? "EmptyPicture" : data.imageName, w: 20, h: 20)
                        .padding(.trailing, 19)
                    TextCustom(text: NSLocalizedString(data.menuName, comment: ""), font: MEDIUM, size: 16, color: #colorLiteral(red: 0.1422221363, green: 0.1215686275, blue: 0.1215686275, alpha: 1))
                    if data.notify != 0 {
                        ZStack {
                            Rectangle().frame(width: 24, height: 24).foregroundColor(.init(#colorLiteral(red: 0.4274509804, green: 0.1882352941, blue: 0.6705882353, alpha: 1))).cornerRadius(.infinity)
                            TextCustom(text: "\(data.notify)", font: MEDIUM, size: 14, color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
                        }.padding(.leading, 15)
                    }
                    Spacer()
                    ImageCustom(name: "iconNextAccount", w: 8, h: 14)
                }.frame(height: 24).background(Color.white)
            }.buttonStyle(ButtonTapScale()).animation(isAnimation ? .easeInOut(duration: 0.1) : .none)
                .padding(.bottom, 15)
            if !data.isEnd {
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.init(#colorLiteral(red: 0.9636391997, green: 0.9496440291, blue: 0.9981387258, alpha: 1)))
            }
        }.padding(.horizontal, 20)
            .padding(.top, 15)
    }
}
