// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import SwiftUI
import Combine

struct InitView: View {
    @State var isStartHome = false
    @State var isAlreadySplash = false
    @State var selectedTabBar = 0
    @State var isAppearItem = false
    @State var animation = false
    @State var isTabBarAppear = true
    @State var isShowPopupNoti = false
    @State var contentNoti = ""
    @State var selectedRowNoti = -1
    @State var deleteNotiID = -1
    @State var canUseArrNoti = true
    @State var imageNameNoti = ""
    @State var isOpenSideMenu = false
    @State var isSideMenuAppear = false
    @State var isMenuPurpleAppear = true
    @State var isNextSideMenu = false
    @State var animationSideMenu = [false, false, false, false, false, false, false, false, false]
    @State var selectedMenuPurple = 0
    @State var animationTime = 0.03
    @State var selectedCorlor = 0
    @State var isLogin = false
    @State var isInit = false
    @State var strUsernameTemp = ""
    @State var strPasswordTemp = ""
    @State var txtCheckUser = ""
    @State var txtCheckPass = ""
    @State var showPopUpLogin = false
    @State var userInfor = LoginModel(
        success: false,
        user_id: 0,
        full_name: "",
        token: "",
        avatar_url: "",
        username: "",
        mobile: "",
        rabbit_info: RabbitInfoModel(rABBIT_USER: "", rABBIT_PASS: "", rABBIT_HOST: "", rABBIT_PORT: 0, rABBIT_VHOT: "", cHATTING_QUEUE: "", cHATTING_EXCHANGE_TOPIC: "", cHATTING_EXCHANGE_DIRECT: ""),
        default_map_style: "",
        default_lat: 0.0,
        default_lon: 0.0,
        host_video_call: "")
    @ObservedObject var homeViewModel = HomeViewModel()
    @ObservedObject var loginViewModel = LoginViewModel()
    @State var disposables = Set<AnyCancellable>()

    var body: some View {
        ZStack (alignment: .top) {
            // MARK: HIỆU ỨNG SPLASH SCREEN KHI MỚI VÀO APP ========================================================================

            if isAlreadySplash {
                Text("").onAppear {
                    self.isAppearItem = true
                    self.animation = true
                }
            } else if isStartHome {
                Text("").onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        self.isAppearItem = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                            self.animation = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                                self.isAlreadySplash = true
                            }
                        }
                    }
                }
            }
            WelcomeView(isAlreadySplash: $isAlreadySplash, isStartHome: $isStartHome)

            // MARK: CÁC MÀN TRONG THẺ TAB ========================================================================
            buildInitView(
                selectedTabBar: selectedTabBar,
                strUsernameTemp: $strUsernameTemp,
                strPasswordTemp: $strPasswordTemp,
                txtCheckUser: $txtCheckUser,
                txtCheckPass: $txtCheckPass,
                userInfor: $userInfor
            ).opacity(isAppearItem ? 1 : 0)
                .animation(animation ? .none : .easeInOut(duration: 0.5))

            // MARK: THẺ TAB Ở DƯỚI BOTTOM
            TabBarCustom(selectedTabBar: $selectedTabBar)
                .opacity(!isTabBarAppear ? 0 : isAppearItem ? 1 : 0)
                .animation(animation ? .none : .easeInOut(duration: 0.5))

            // MARK: SIDE MENU TRƯỢT TỪ PHẢI QUA Ở TRONG MÀN HÌNH CHI TIẾT DỰ ÁN
            SideMenuPurple(
                closeSideMenu: { self.closeSideMenu() },
                openSideMenu: { self.openSideMenu() },
                isOpenSideMenu: $isOpenSideMenu,
                animationSideMenu: $animationSideMenu,
                isNextSideMenu: $isNextSideMenu,
                selectedMenuPurple: $selectedMenuPurple,
                selectedCorlor: $selectedCorlor,
                isMenuPurpleAppear: $isMenuPurpleAppear
            ).opacity(isSideMenuAppear ? 1 : 0)
                .animation(.easeInOut(duration: 0.1))
        }.onAppear {
            self.callSaveLogin()

            // MARK: KHÁM PHÁ
            self.homeViewModel.fetchDataDiscover()

            // MARK: DANH SÁCH DỰ ÁN
            self.homeViewModel.fetchDataProjectList(
                settingType: [0],
                provinceId: [],
                projectStatus: [0, 1],
                language: VIETNAM,
                districtId: []
            )

            // MARK: SẢN PHẨM NỔI BẬT
            self.homeViewModel.fetchDataProductSelling(language: VIETNAM)
        }
    }

    func callSaveLogin() {
        if KeychainManager.shared.getString(key: .savelogin) == "true" {
            self.strUsernameTemp = KeychainManager.shared.getString(key: .username) ?? ""
            self.strPasswordTemp = KeychainManager.shared.getString(key: .password) ?? ""
            self.fetchDataLogin()
        }
    }

    func fetchDataLogin() {
        if self.strUsernameTemp.isEmpty || self.strPasswordTemp.isEmpty {
            self.txtCheckUser = "1"
            self.txtCheckPass = "2"
        } else {
            self.loginViewModel.fetchDataLogin(userName: self.strUsernameTemp, passWord: self.strPasswordTemp)
            self.loginViewModel.vldLogin.sink { rs in
                self.userInfor = self.loginViewModel.userProfile ?? self.userInfor
                if self.userInfor.success ?? false {
                    self.isLogin = true
                } else {
                    self.showPopUpLogin = true
                }
            }.store(in: &self.disposables)
        }
    }

    // MARK: HÀM ĐÓNG SIDE MENU TRONG TRANG CHI TIẾT DỰ ÁN
    func closeSideMenu() {
        // MARK: HIỆU ỨNG TRƯỢT ĐÓNG CÁC LỰA CHỌN TRONG MENU RA THEO THỨ TỰ
        self.isOpenSideMenu = false
        DispatchQueue.main.asyncAfter(deadline: .now() + self.animationTime) {
            self.animationSideMenu[0] = false
            DispatchQueue.main.asyncAfter(deadline: .now() + self.animationTime) {
                self.animationSideMenu[1] = false
                DispatchQueue.main.asyncAfter(deadline: .now() + self.animationTime) {
                    self.animationSideMenu[2] = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + self.animationTime) {
                        self.animationSideMenu[3] = false
                        DispatchQueue.main.asyncAfter(deadline: .now() + self.animationTime) {
                            self.animationSideMenu[4] = false
                            DispatchQueue.main.asyncAfter(deadline: .now() + self.animationTime) {
                                self.animationSideMenu[5] = false
                                DispatchQueue.main.asyncAfter(deadline: .now() + self.animationTime) {
                                    self.animationSideMenu[6] = false
                                    DispatchQueue.main.asyncAfter(deadline: .now() + self.animationTime) {
                                        self.animationSideMenu[7] = false
                                        DispatchQueue.main.asyncAfter(deadline: .now() + self.animationTime) {
                                            self.animationSideMenu[8] = false
                                            DispatchQueue.main.asyncAfter(deadline: .now() + self.animationTime) {
                                                self.isMenuPurpleAppear = true
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    // MARK: HÀM MỞ SIDE MENU TRONG TRANG CHI TIẾT DỰ ÁN
    func openSideMenu() {
        // MARK: HIỆU ỨNG TRƯỢT MỞ CÁC LỰA CHỌN TRONG MENU RA THEO THỨ TỰ
        self.isMenuPurpleAppear = false
        self.isOpenSideMenu = true
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            self.animationSideMenu[0] = true
            DispatchQueue.main.asyncAfter(deadline: .now() + self.animationTime) {
                self.animationSideMenu[1] = true
                DispatchQueue.main.asyncAfter(deadline: .now() + self.animationTime) {
                    self.animationSideMenu[2] = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + self.animationTime) {
                        self.animationSideMenu[3] = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + self.animationTime) {
                            self.animationSideMenu[4] = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + self.animationTime) {
                                self.animationSideMenu[5] = true
                                DispatchQueue.main.asyncAfter(deadline: .now() + self.animationTime) {
                                    self.animationSideMenu[6] = true
                                    DispatchQueue.main.asyncAfter(deadline: .now() + self.animationTime) {
                                        self.animationSideMenu[7] = true
                                        DispatchQueue.main.asyncAfter(deadline: .now() + self.animationTime) {
                                            self.animationSideMenu[8] = true
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    // MARK: CÁC MÀN TRONG THẺ TAB
    func buildInitView(
        selectedTabBar: Int,
        strUsernameTemp: Binding<String>,
        strPasswordTemp: Binding<String>,
        txtCheckUser: Binding<String>,
        txtCheckPass: Binding<String>,
        userInfor: Binding<LoginModel>
    ) -> AnyView {
        switch selectedTabBar {
        case 0:
            return AnyView(
                // MARK: MÀN HÌNH KHÁM PHÁ
                HomeView(
                    isLogin: $isLogin,
                    isInit: $isInit,
                    isAlreadySplash: $isAlreadySplash,
                    closeSideMenu: { self.closeSideMenu() },
                    isAppearItem: $isAppearItem,
                    animation: $animation,
                    isTabBarAppear: $isTabBarAppear,
                    isOpenSideMenu: $isOpenSideMenu,
                    isSideMenuAppear: $isSideMenuAppear,
                    isNextSideMenu: $isNextSideMenu,
                    selectedMenuPurple: $selectedMenuPurple,
                    selectedCorlor: $selectedCorlor
                ).environmentObject(homeViewModel)
            )
        default:
            return AnyView(
                // MARK: MÀN HÌNH TÀI KHOẢN
                AccountView(
                    closeSideMenu: { self.closeSideMenu() },
                    callSaveLogin: { self.callSaveLogin() },
                    isOpenSideMenu: $isOpenSideMenu,
                    isSideMenuAppear: $isSideMenuAppear,
                    isNextSideMenu: $isNextSideMenu,
                    selectedMenuPurple: $selectedMenuPurple,
                    selectedCorlor: $selectedCorlor,
                    isTabBarAppear: $isTabBarAppear,
                    isLogin: $isLogin,
                    strUsernameTemp: $strUsernameTemp,
                    strPasswordTemp: $strPasswordTemp,
                    txtCheckUser: $txtCheckUser,
                    txtCheckPass: $txtCheckPass,
                    showPopUpLogin: $showPopUpLogin,
                    userInfor: $userInfor
                ).environmentObject(homeViewModel)
            )
        }
    }
}

struct sideMenuType: Identifiable, Hashable {
    var id = UUID()
    var imageName: String
    var title: String
    var index: Int
}

struct SideMenuPurple: View {
    let closeSideMenu: () -> Void
    let openSideMenu: () -> Void
    @Binding var isOpenSideMenu: Bool
    @Binding var animationSideMenu: [Bool]
    @Binding var isNextSideMenu: Bool
    @Binding var selectedMenuPurple: Int
    @Binding var selectedCorlor: Int
    @Binding var isMenuPurpleAppear: Bool

    var arrSideMenu = [
        sideMenuType(imageName: "home", title: "projectDetailHome_Home", index: 0),
        sideMenuType(imageName: "info", title: "projectDetailHome_Info", index: 1),
        sideMenuType(imageName: "plan", title: "projectDetailHome_Plan", index: 2),
        sideMenuType(imageName: "map", title: "projectDetailHome_Map", index: 3),
        sideMenuType(imageName: "ulities", title: "projectDetailHome_Ulities", index: 4),
        sideMenuType(imageName: "sale", title: "projectDetailHome_Sale", index: 5),
        sideMenuType(imageName: "library", title: "projectDetailHome_Library", index: 6),
        sideMenuType(imageName: "news", title: "projectDetailHome_News", index: 7),
        sideMenuType(imageName: "contact", title: "projectDetailHome_Contact", index: 8)
    ]

    var body: some View {
        HStack {
            Spacer()
            VStack (alignment: .trailing, spacing: 0) {
                ZStack (alignment: .trailing) {
                    ZStack {
                        Button(action: {
                            self.closeSideMenu()
                        }) {
                            ImageCustom(name: "closeSideMenu", w: 50, h: 50)
                                .scaleEffect(isOpenSideMenu ? 1 : 0.1)
                        }.buttonStyle(ButtonTapScale())
                            .animation(.easeInOut(duration: 0.2))
                            .offset(x: -25)
                    }.offset(x: isOpenSideMenu ? 0 : 100)
                    ZStack {
                        Button(action: {
                            self.openSideMenu()
                        }) {
                            ImageCustom(name: "SideMenuPurple", w: 46, h: 52)
                                .shadow(color: .init(#colorLiteral(red: 0.4281106591, green: 0.1894766092, blue: 0.6721540093, alpha: 1)), radius: 3)
                        }.buttonStyle(ButtonTapScale())
                            .animation(.easeInOut(duration: 0.2))
                            .offset(x: 2)
                    }.offset(x: !isOpenSideMenu && isMenuPurpleAppear ? 0 : 100)
                }.padding(.top, H(135))
                VStack (alignment: .trailing, spacing: 0) {
                    ForEach(arrSideMenu, id: \.self) { data in
                        SideMenuPurpleOptional(
                            isMenuPurpleAppear: self.$isMenuPurpleAppear,
                            isNextSideMenu: self.$isNextSideMenu,
                            animationSideMenu: self.$animationSideMenu,
                            selectedMenuPurple: self.$selectedMenuPurple,
                            isOpenSideMenu: self.$isOpenSideMenu,
                            selectedCorlor: self.$selectedCorlor,
                            imageName: data.imageName,
                            title: data.title,
                            index: data.index)
                    }
                }.padding(.top, H(24))
                Spacer()
            }
        }
    }
}

struct SideMenuPurpleOptional: View {
    @Binding var isMenuPurpleAppear: Bool
    @Binding var isNextSideMenu: Bool
    @Binding var animationSideMenu: [Bool]
    @Binding var selectedMenuPurple: Int
    @Binding var isOpenSideMenu: Bool
    @Binding var selectedCorlor: Int
    @State var imageName = ""
    @State var title = ""
    @State var index = 0
    @State var animationTime = 0.03

    var body: some View {
        Button(action: {
            self.selectedCorlor = self.index
            if self.index != 0 {
                self.selectedMenuPurple = self.index
                self.isNextSideMenu = true
            } else {
                self.isNextSideMenu = false
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                    self.selectedMenuPurple = 0
                }
            }
            self.isOpenSideMenu = false
            DispatchQueue.main.asyncAfter(deadline: .now() + self.animationTime) {
                self.animationSideMenu[0] = false
                DispatchQueue.main.asyncAfter(deadline: .now() + self.animationTime) {
                    self.animationSideMenu[1] = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + self.animationTime) {
                        self.animationSideMenu[2] = false
                        DispatchQueue.main.asyncAfter(deadline: .now() + self.animationTime) {
                            self.animationSideMenu[3] = false
                            DispatchQueue.main.asyncAfter(deadline: .now() + self.animationTime) {
                                self.animationSideMenu[4] = false
                                DispatchQueue.main.asyncAfter(deadline: .now() + self.animationTime) {
                                    self.animationSideMenu[5] = false
                                    DispatchQueue.main.asyncAfter(deadline: .now() + self.animationTime) {
                                        self.animationSideMenu[6] = false
                                        DispatchQueue.main.asyncAfter(deadline: .now() + self.animationTime) {
                                            self.animationSideMenu[7] = false
                                            DispatchQueue.main.asyncAfter(deadline: .now() + self.animationTime) {
                                                self.animationSideMenu[8] = false
                                                DispatchQueue.main.asyncAfter(deadline: .now() + self.animationTime) {
                                                    self.isMenuPurpleAppear = true
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }) {
            VStack (spacing: 0) {
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 146, height: H(11))
                HStack (spacing: 0) {
                    ImageCustom(name: selectedCorlor == index ? "\(imageName)Purple" : "\(imageName)White", w: 36, h: 36)
                        .background(Color.white)
                        .cornerRadius(7)
                        .scaleEffect(animationSideMenu[index] ? 1 : 0)
                    TextCustom(text: NSLocalizedString(title, comment: ""), font: MEDIUM, size: 16, lineLimit: 1, color: .white)
                        .scaleEffect(animationSideMenu[index] ? 1 : 0.1)
                        .padding(.leading, 19)
                        .frame(width: 110, alignment: .leading)
                }
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 146, height: H(11))
            }.background(Image("EmptyPicture").resizable())
        }.buttonStyle(ButtonTapScale())
            .opacity(animationSideMenu[index] ? 1 : 0)
            .offset(x: animationSideMenu[index] ? 0 : 100)
            .animation(.easeInOut(duration: 0.2))
    }
}
