// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import SwiftUI
import SDWebImageSwiftUI

struct ProjectHomeView: View {
    let closeSideMenu: () -> Void
    @Binding var projectURL: String
    @Binding var projectName: String
    @Binding var isNextOld: Bool
    @Binding var isOpenSideMenu: Bool
    @Binding var isSideMenuAppear: Bool
    @Binding var isNextSideMenu: Bool
    @Binding var selectedMenuPurple: Int
    @Binding var selectedCorlor: Int

    @State var animation_intro = false
    @State var isRegistJoin = false
    @State var RegistAppear = false
    @State var completeHideRegist = true
    @State var isSlowAnimation = false
    @State var isNextChat = false

    @Binding var project_id: Int

    @State var arrChatData = [
        chatData(isMe: false, message: NSLocalizedString("chat_pleaseWait", comment: ""), time: "\(Date())")
    ]

    var body: some View {
        NavigationView {
            ZStack (alignment: .top) {
                ZStack {
                    if projectURL.isEmpty {
                        Image("default_large")
                            .resizable()
                    } else {
                        WebImage(url: URL(string: projectURL))
                            .resizable()
                    }
                }.scaledToFill()
                    .frame(width: FULL_W)
                    .clipped()
                    .edgesIgnoringSafeArea([.top, .bottom])
                Rectangle()
                    .foregroundColor(.clear)
                    .background(LinearGradient(gradient: Gradient(colors: [.init(#colorLiteral(red: 0.4281106591, green: 0.1894766092, blue: 0.6721540093, alpha: 0.5599047517)), .init(#colorLiteral(red: 0.4281106591, green: 0.1894766092, blue: 0.6721540093, alpha: 0.3159246575)), .init(#colorLiteral(red: 0.5268814247, green: 0.2303050755, blue: 0.8391709827, alpha: 0))]), startPoint: .bottom, endPoint: .top))
                    .edgesIgnoringSafeArea(.all)
                    .opacity(!isRegistJoin ? animation_intro ? 1 : 0: 0)
                    .animation(.easeInOut(duration: 0.6))
                Rectangle()
                    .foregroundColor(.clear)
                    .background(LinearGradient(gradient: Gradient(colors: [.init(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)), .init(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0))]), startPoint: .top, endPoint: .bottom))
                    .edgesIgnoringSafeArea(.top)
                    .frame(height: H(100))
                LandingPage(
                    isSideMenuAppear: $isSideMenuAppear,
                    animation_intro: $animation_intro,
                    projectName: $projectName,
                    isRegistJoin: $isRegistJoin,
                    RegistAppear: $RegistAppear,
                    completeHideRegist: $completeHideRegist,
                    isSlowAnimation: $isSlowAnimation
                )
                Rectangle()
                    .opacity(isOpenSideMenu ? 0.5 : 0)
                    .edgesIgnoringSafeArea(.all)
                    .animation(.easeInOut(duration: 0.2))
                    .onTapGesture {
                        self.closeSideMenu()
                }
                NavigationWhite(
                    isTapSearch: Binding.constant(false),
                    isLogin: Binding.constant(false),
                    isChangeColor: Binding.constant(false),
                    isOpenSideMenu: Binding.constant(false),
                    strSearch: Binding.constant(""),
                    isShowCalendar: Binding.constant(false),
                    isChooseValueDate: Binding.constant(false),
                    title: "projectDetailHome_Home",
                    title_2: "\(NSLocalizedString("projectDetailHome_Project", comment: "")) \(projectName)",
                    backFunc: {
                        self.isNextOld = false
                        UIApplication.shared.endEditing()
                        self.closeSideMenu()
                        self.isSideMenuAppear = false
                    },
                    mapFunc: { },
                    filterFunc: { },
                    optionFunc: { },
                    callFunc: {
                        callPhone()
                        UIApplication.shared.endEditing()
                    },
                    textFunc: {
                        UIApplication.shared.endEditing()
                        self.closeSideMenu()
                        self.isNextChat = true
                        self.isSideMenuAppear = false
                    },
                    isCallAndTextWhite: true
                )
                ZStack (alignment: .top) {
                    ZStack {
                        if projectURL.isEmpty {
                            Image("default_large")
                                .resizable()
                        } else {
                            WebImage(url: URL(string: projectURL))
                                .resizable()
                        }
                    }.scaledToFill()
                        .frame(width: FULL_W)
                        .clipped().edgesIgnoringSafeArea([.top, .bottom])
                    Rectangle()
                        .foregroundColor(.clear)
                        .background(Color.init(#colorLiteral(red: 0.5358567198, green: 0.2342282656, blue: 0.8534660533, alpha: 0.4522153253)))
                        .edgesIgnoringSafeArea(.all)
                }.opacity(isRegistJoin ? 1 : 0)
                    .animation(.easeInOut(duration: 0.6))
                RegisterJoin(
                    isSideMenuAppear: $isSideMenuAppear,
                    isRegistJoin: $isRegistJoin,
                    RegistAppear: $RegistAppear,
                    completeHideRegist: $completeHideRegist,
                    isSlowAnimation: $isSlowAnimation
                )
                ZStack (alignment: .top) {
                    NavigationLink(destination:
                            ChatView(
                                isNextOld: $isNextChat,
                                isSideMenuAppear: $isSideMenuAppear,
                                projectURL: $projectURL,
                                arrChatData: $arrChatData
                            ), isActive: $isNextChat) {
                        EmptyView()
                    }
                    NavigationLink(destination:
                            SideMenuMainView(
                                closeSideMenu: { self.closeSideMenu() },
                                isNextOld: $isNextSideMenu,
                                isOpenSideMenu: $isOpenSideMenu,
                                isSideMenuAppear: $isSideMenuAppear,
                                projectName: $projectName,
                                selectedMenuPurple: $selectedMenuPurple,
                                project_id: $project_id,
                                projectURL: $projectURL,
                                arrChatData: $arrChatData
                            ), isActive: $isNextSideMenu) {
                        EmptyView()
                    }
                }
            }.onAppear {
                self.isSideMenuAppear = true
                self.selectedCorlor = 0
            }.onTapGesture {
                UIApplication.shared.endEditing()
            }.navigationBarBackButtonHidden(true)
                .navigationBarTitle("")
                .navigationBarHidden(true)
        }.navigationBarBackButtonHidden(true)
            .navigationBarTitle("")
            .navigationBarHidden(true)
    }
}

struct RegisterJoin: View {
    @Binding var isSideMenuAppear: Bool
    @Binding var isRegistJoin: Bool
    @Binding var RegistAppear: Bool
    @Binding var completeHideRegist: Bool
    @Binding var isSlowAnimation: Bool
    @State var isShowRegisterPopUp = false
    @State var strName = ""
    @State var strPhone = ""
    @State var strEmail = ""
    @State var strAddress = ""
    @State var isStrNameEmptyConfirm = false
    @State var isStrPhoneEmptyConfirm = false
    @State var isStrPhoneWrongConfirm = false
    @State var isStrEmailEmptyConfirm = false
    @State var isStrEmailWrongConfirm = false
    @State var isStrAddressEmptyConfirm = false
    @State var isClear = false

    @State var keyboardHeight: CGFloat = 0

    var body: some View {
        ZStack {
            if !strName.isEmpty {
                Text("").onAppear {
                    self.isStrNameEmptyConfirm = false
                }
            }
            if !strPhone.isEmpty {
                Text("").onAppear {
                    self.isStrPhoneEmptyConfirm = false
                }
            }
            if formattedNumberPhone(number: strPhone).count == 12 {
                Text("").onAppear {
                    self.isStrPhoneWrongConfirm = false
                }
            }
            if !strEmail.isEmpty {
                Text("").onAppear {
                    self.isStrEmailEmptyConfirm = false
                }
            } else {
                Text("").onAppear {
                    self.isStrEmailWrongConfirm = false
                }
            }
            if Utils.isValidEmail(email: strEmail) {
                Text("").onAppear {
                    self.isStrEmailWrongConfirm = false
                }
            }
            if !strAddress.isEmpty {
                Text("").onAppear {
                    self.isStrAddressEmptyConfirm = false
                }
            }
            HStack {
                Spacer()
                VStack {
                    Button(action: {
                        self.isStrNameEmptyConfirm = false
                        self.isStrPhoneEmptyConfirm = false
                        self.isStrEmailEmptyConfirm = false
                        self.isStrAddressEmptyConfirm = false
                        UIApplication.shared.endEditing()
                        self.RegistAppear = false
                        self.isRegistJoin = false
                        self.completeHideRegist = true
                        self.isSlowAnimation = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                            self.isSideMenuAppear = true
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                            self.isSlowAnimation = false
                            self.strName = ""
                            self.isClear = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                self.isClear = false
                            }
                            self.strPhone = ""
                            self.strEmail = ""
                            self.strAddress = ""
                        }
                    }) {
                        ImageCustom(name: "closeSideMenu", w: 50, h: 50)
                    }.buttonStyle(ButtonTapScale())
                        .animation(.easeInOut(duration: RegistAppear ? 0.1 : 0.8))
                        .disabled(isSlowAnimation ? true : false)
                        .offset(x: -25)
                        .padding(.top, H(135))
                    Spacer()
                }.offset(y: keyboardHeight > 0 ?
                    H(
                        FULL_H == H_SE && FULL_W == W_SE ? 93: // iPhone SE 1st generation
                        FULL_H == H_8 && FULL_W == W_8 ? 93: // iPhone 8 && iPhone SE 2nd generation
                        FULL_H == H_8Plus && FULL_W == W_8Plus ? 93: // iPhone 8 Plus
                        FULL_H == H_11 && FULL_W == W_11 ? 160: // iPhone 11 && iPhone 11 Pro Max
                        FULL_H == H_11Pro && FULL_W == W_11Pro ? 145 : 0 // iPhone 11 Pro
                    ): 0
                )
            }
            VStack (spacing: 0) {
                Spacer()
                TextCustom(text: NSLocalizedString("projectDetailHome_RegisterToJoin", comment: ""), size: 26, color: .white)
                TextCustom(text: NSLocalizedString("projectDetailHome_LeaveInfo", comment: ""), font: LIGHT_ITALIC, size: 18, lineLimit: 2, color: .white)
                    .multilineTextAlignment(.center)
                    .padding(.top, H(9))
                    .padding(.horizontal, 55)
                    .opacity(0.75)
                    .padding(.bottom, H(40))
                VStack (spacing: H(20.5)) {
                    InputRegistJoin(
                        registConfirm: { self.registConfirm() },
                        index: 0,
                        value: $strName,
                        isSlowAnimation: $isSlowAnimation,
                        label: "\(NSLocalizedString("projectDetailHome_FullName", comment: "")) (*) :",
                        placeHolder: "projectDetailHome_input_FullName",
                        isWrongConfirm: Binding.constant(false),
                        isEmptyConfirm: $isStrNameEmptyConfirm,
                        isClear: $isClear
                    )
                    InputRegistJoin(
                        registConfirm: { self.registConfirm() },
                        index: 1,
                        value: $strPhone,
                        isSlowAnimation: $isSlowAnimation,
                        label: "\(NSLocalizedString("projectDetailHome_Phone", comment: "")) (*) :",
                        placeHolder: "projectDetailHome_input_Phone",
                        isWrongConfirm: $isStrPhoneWrongConfirm,
                        isEmptyConfirm: $isStrPhoneEmptyConfirm,
                        isClear: $isClear
                    )
                    InputRegistJoin(
                        registConfirm: { self.registConfirm() },
                        index: 2,
                        value: $strEmail,
                        isSlowAnimation: $isSlowAnimation,
                        label: "Email :",
                        placeHolder: "projectDetailHome_input_Email",
                        isWrongConfirm: $isStrEmailWrongConfirm,
                        isEmptyConfirm: $isStrEmailEmptyConfirm,
                        isClear: $isClear
                    )
                    InputRegistJoin(
                        registConfirm: { self.registConfirm() },
                        index: 3,
                        value: $strAddress,
                        isSlowAnimation: $isSlowAnimation,
                        label: "\(NSLocalizedString("projectDetailHome_Address", comment: "")) :",
                        placeHolder: "projectDetailHome_input_Address",
                        isWrongConfirm: Binding.constant(false),
                        isEmptyConfirm: $isStrAddressEmptyConfirm,
                        isClear: $isClear
                    )
                }
                Button(action: {
                    self.registConfirm()
                }) {
                    ZStack {
                        Rectangle()
                            .foregroundColor(.white)
                            .opacity(0.2)
                            .cornerRadius(5)
                            .frame(width: FULL_W - 144, height: H(46))
                            .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.init(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.7215592894)), lineWidth: 1))
                        TextCustom(text: NSLocalizedString("projectDetailHome_regist_regist", comment: ""), font: MEDIUM, size: 18, lineLimit: 1, color: .white)
                    }
                }.buttonStyle(ButtonTapScale())
                    .animation(.easeInOut(duration: isSlowAnimation ? 0.8 : RegistAppear ? 0.1 : 0.8))
                    .disabled(isSlowAnimation ? true : false)
                    .padding(.top, H(30))

            }.padding(.bottom, H(115))
                .animation(.easeInOut(duration: isSlowAnimation ? 0.8 : RegistAppear ? 0.1 : 0.8))
            Rectangle()
                .foregroundColor(.black)
                .opacity(isShowRegisterPopUp ? 0.5 : 0)
                .edgesIgnoringSafeArea(.all)
                .animation(.easeInOut(duration: 0.2))
            showRegisterPopUpView(
                isShowRegisterPopUp: $isShowRegisterPopUp,
                RegistAppear: $RegistAppear,
                isRegistJoin: $isRegistJoin,
                completeHideRegist: $completeHideRegist,
                isSlowAnimation: $isSlowAnimation,
                isSideMenuAppear: $isSideMenuAppear,
                strName: $strName,
                strPhone: $strPhone,
                strEmail: $strEmail,
                strAddress: $strAddress
            )
        }.keyboardAppear(keyboardHeight: $keyboardHeight)
            .offset(y: isRegistJoin ? keyboardHeight > 0 ? H(-230) : 0 : H(750))
    }

    func registConfirm() {
        if self.strName.isEmpty {
            self.isStrNameEmptyConfirm = true
        } else {
            self.isStrNameEmptyConfirm = false
        }
        if self.strPhone.isEmpty {
            self.isStrPhoneEmptyConfirm = true
        } else {
            self.isStrPhoneEmptyConfirm = false
            if formattedNumberPhone(number: strPhone).count == 12 {
                self.isStrPhoneWrongConfirm = false
            } else {
                self.isStrPhoneWrongConfirm = true
            }
        }
        if self.strAddress.isEmpty {
            self.isStrAddressEmptyConfirm = true
        } else {
            self.isStrAddressEmptyConfirm = false
        }
        if self.strEmail.isEmpty {
            self.isStrEmailEmptyConfirm = true
        } else {
            self.isStrEmailEmptyConfirm = false
            if Utils.isValidEmail(email: strEmail) {
                self.isStrEmailWrongConfirm = false
            } else {
                self.isStrEmailWrongConfirm = true
            }
        }

        if !self.isStrNameEmptyConfirm && !self.isStrPhoneEmptyConfirm && !self.isStrEmailWrongConfirm && !self.isStrAddressEmptyConfirm {
            UIApplication.shared.endEditing()
            self.isShowRegisterPopUp = true
        }
    }
}

struct showRegisterPopUpView: View {
    @Binding var isShowRegisterPopUp: Bool
    @Binding var RegistAppear: Bool
    @Binding var isRegistJoin: Bool
    @Binding var completeHideRegist: Bool
    @Binding var isSlowAnimation: Bool
    @Binding var isSideMenuAppear: Bool
    @Binding var strName: String
    @Binding var strPhone: String
    @Binding var strEmail: String
    @Binding var strAddress: String

    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 1, height: H(
                        FULL_H == H_SE && FULL_W == W_SE ? 13: // iPhone SE 1st generation
                        FULL_H == H_8 && FULL_W == W_8 ? 13: // iPhone 8 && iPhone 2nd generation
                        FULL_H == H_8Plus && FULL_W == W_8Plus ? 14: // iPhone 8 Plus
                        FULL_H == H_11 && FULL_W == W_11 ? 11: // iPhone 11 && iPhone 11 Pro Max
                        FULL_H == H_11Pro && FULL_W == W_11Pro ? 11 : 0) // iPhone 11 Pro
                    )
                ImageCustom(name: "greenChecked", w: 65, h: 65)
                    .padding(.bottom, H(9))
                    .offset(x: -0.5)
                TextCustom(text: NSLocalizedString("projectDetailHome_Thank", comment: ""), font: REGULAR, size: 16, color: #colorLiteral(red: 0.2495550513, green: 0.2954892516, blue: 0.4120893478, alpha: 1))
                    .lineSpacing(5)
                    .padding(.horizontal, 33)
                    .padding(.bottom, H(23))
            }
            Button(action: {
                self.isShowRegisterPopUp = false
                UIApplication.shared.endEditing()
                self.RegistAppear = false
                self.isRegistJoin = false
                self.completeHideRegist = true
                self.isSlowAnimation = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                    self.isSideMenuAppear = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                    self.isSlowAnimation = false
                    self.strName = ""
                    self.strPhone = ""
                    self.strEmail = ""
                    self.strAddress = ""
                }
            }) {
                ZStack {
                    Rectangle()
                        .foregroundColor(.white)
                        .frame(width: FULL_W - 72, height: H(40))
                        .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.init(#colorLiteral(red: 0.4282599092, green: 0.1879977882, blue: 0.6717798114, alpha: 1)), lineWidth: 1))
                    TextCustom(text: NSLocalizedString("projectDetailHome_BackToProject", comment: ""), font: MEDIUM, size: 16, color: #colorLiteral(red: 0.4269524217, green: 0.1874135733, blue: 0.6712699533, alpha: 1))
                }
            }.buttonStyle(ButtonTapScale())
                .animation(.easeInOut(duration: 0.1))
        }.padding(.bottom, H(26))
            .background(
                Image("union150")
                    .resizable()
                    .frame(width: FULL_W - 42)
                    .shadow(color: .init(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2016802226)), radius: 6)
            ).scaleEffect(isShowRegisterPopUp ? 1 : 0.1)
            .opacity(isShowRegisterPopUp ? 1 : 0)
            .animation(.easeInOut(duration: 0.2))
    }
}

struct InputRegistJoin: View {
    let registConfirm: () -> Void
    @State var index = 0
    @Binding var value: String
    @Binding var isSlowAnimation: Bool
    @State var label = ""
    @State var placeHolder = ""
    @Binding var isWrongConfirm: Bool
    @Binding var isEmptyConfirm: Bool
    @Binding var isClear: Bool
    @State var isEnableEdit = true

    var body: some View {
        VStack (spacing: 0) {
            HStack (spacing: 17) {
                TextCustom(text: label, font: MEDIUM, size: 16, color: .white)
                ZStack (alignment: .leading) {
                    TextCustom(text: NSLocalizedString(placeHolder, comment: ""), font: ITALIC, size: 16, color: .white)
                        .fixedSize(horizontal: true, vertical: false)
                        .opacity(value.isEmpty ? 0.45 : 0)
                    if index == 1 {
                        TFPhoneNumner(font: MEDIUM, size: 16, color: .white, changeHandler: { rs in
                            self.value = rs
                        }, didBeginEditing: { _ in }, didEndEditing: { _ in }, isClear: $isClear, value: self.$value, isEnableEdit: self.$isEnableEdit)
                            .disabled(isSlowAnimation ? true : false)
                            .padding(.trailing, 42)
                            .frame(height: H(16))
                    } else {
                        TextField("", text: $value, onCommit: {
                            if self.index == 3 {
                                self.registConfirm()
                            }
                        }).disabled(isSlowAnimation ? true : false)
                            .keyboardType(index == 1 ? .numberPad:
                                    index == 2 ? .emailAddress : .default)
                            .font(.custom(MEDIUM, size: H(16)))
                            .foregroundColor(.white)
                            .padding(.trailing, 42)
                            .frame(height: H(16))
                    }

                    HStack {
                        Spacer()
                        Button(action: {
                            if self.index == 1 {
                                self.isClear = true
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                    self.isClear = false
                                }
                            }
                            self.value = ""
                        }) {
                            ZStack (alignment: .trailing) {
                                ImageCustom(name: "EmptyPicture", w: 19, h: 14)
                                ImageCustom(name: "deleteAllWhite", w: 14, h: 14)
                            }
                        }.buttonStyle(ButtonTapScale())
                            .animation(.easeInOut(duration: 0.1))
                            .offset(x: W(-3.5))
                            .opacity(value.isEmpty ? 0 : 1)
                    }.padding(.trailing, 14)
                }
            }.padding(.horizontal, 55)
                .padding(.bottom, H(14))
            Rectangle()
                .foregroundColor(.white)
                .frame(height: 1)
                .padding(.horizontal, 55)
                .padding(.bottom, H(5))
            ZStack (alignment: .trailing) {
                HStack {
                    Spacer()
                    TextCustom(text: NSLocalizedString("projectDetailHome_PleaseFill", comment: ""), font: ITALIC, size: 12, color: #colorLiteral(red: 0.9721960425, green: 0.7968060374, blue: 0.796562016, alpha: 1))
                }.frame(width: FULL_W - 110)
                    .opacity(isEmptyConfirm ? 1 : 0)
                if index == 1 || index == 2 {
                    TextCustom(text: NSLocalizedString(index == 1 ? "signup_checkWrong_phone" : "projectDetailHome_EmailWrong", comment: ""), font: ITALIC, size: 12, color: #colorLiteral(red: 0.9721960425, green: 0.7968060374, blue: 0.796562016, alpha: 1))
                        .opacity(isWrongConfirm ? 1 : 0)
                }
            }.animation(.easeInOut(duration: 0.1))
        }
    }
}

struct LandingPage: View {
    @Binding var isSideMenuAppear: Bool
    @Binding var animation_intro: Bool
    @Binding var projectName: String
    @Binding var isRegistJoin: Bool
    @Binding var RegistAppear: Bool
    @Binding var completeHideRegist: Bool
    @Binding var isSlowAnimation: Bool
    @State var isAppearIntro = false

    var body: some View {
        VStack (spacing: 0) {
            Spacer()
            TextCustom(text: "\(NSLocalizedString("projectDetailHome_Project", comment: "")) \(projectName)", size: 36, lineLimit: 2, color: .white)
                .fixedSize(horizontal: false, vertical: true)
                .padding(.horizontal, 49)
                .multilineTextAlignment(.center)
            TextCustom(text: "Khu đô thị sinh thái thông minh mới nhất, hiện đại và xinh đẹp nhất nằm ở Tp Hồ Chi Minh", font: MEDIUM, size: 20, lineLimit: 3, color: .white)
                .fixedSize(horizontal: false, vertical: true)
                .multilineTextAlignment(.center)
                .padding(.horizontal, 49)
                .padding(.top, H(6))
                .padding(.bottom, H(34))
            Button(action: {
                self.isSideMenuAppear = false
                self.completeHideRegist = false
                self.isRegistJoin = true
                self.isSlowAnimation = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.8) {
                    self.RegistAppear = true
                    self.isSlowAnimation = false
                }
            }) {
                ZStack {
                    Rectangle()
                        .foregroundColor(.white)
                        .opacity(0.2)
                        .cornerRadius(5)
                        .frame(width: FULL_W - 144, height: H(46))
                        .overlay(RoundedRectangle(cornerRadius: 5).stroke(Color.init(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 0.7215592894)), lineWidth: 1))
                    TextCustom(text: NSLocalizedString("projectDetailHome_regist_join", comment: ""), font: MEDIUM, size: 18, lineLimit: 1, color: .white)
                }
            }.buttonStyle(ButtonTapScale())
                .animation(.easeInOut(duration: isAppearIntro ? 0.1 : 1.2))
                .disabled(isSlowAnimation ? true : false)
        }.opacity(isRegistJoin ? 0 : 1)
            .opacity(completeHideRegist ? 1 : 0)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                    self.animation_intro = true
                }
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.7) {
                    self.isAppearIntro = true
                }
            }.padding(.bottom, H(115))
            .offset(y: animation_intro ? 0 : H(380))
            .opacity(animation_intro ? 1 : 0)
            .animation(.easeInOut(duration: isAppearIntro ? isSlowAnimation ? 1.2 : 0.05: 1.2))
    }
}

func callPhone(_ phoneNumber: String = "0901018940") {
    if let phoneCallURL: NSURL = NSURL(string: "tel://\(phoneNumber)") {
        let application: UIApplication = UIApplication.shared
        if (application.canOpenURL(phoneCallURL as URL)) {
            application.openURL(phoneCallURL as URL);
        }
    }
}
