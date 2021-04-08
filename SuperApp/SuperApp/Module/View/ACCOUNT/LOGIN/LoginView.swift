// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import SwiftUI
import Combine

struct LoginView: View {
    @Binding var isNextOld: Bool
    @Binding var isTabBarAppear: Bool
    @Binding var isLogin: Bool
    @Binding var userInfor: LoginModel

    @State var strUsername = ""
    @State var strPassword = ""
    @State var isHide = true
    @State var saveLogin = (KeychainManager.shared.getString(key: .savelogin) ?? "false") == "false" ? false : true
    @State var txtCheckUser = ""
    @State var txtCheckPass = ""
    @State var showPopUpForgot = false
    @State var showPopUpEmailResetPass = false
    @State var showPopUpLogin = false
    @State var isNext = false
    @State var strUsernameTemp = ""
    @State var strPasswordTemp = ""
    @State var isStrEmailEmptyConfirm = false
    @State var isStrEmailWrongConfirm = false
    @State var strEmail = ""
    @State var disposables = Set<AnyCancellable>()
    @ObservedObject var loginViewModel = LoginViewModel()

    var body: some View {
        NavigationView {
            ZStack (alignment: .top) {
                VStack (alignment: .leading, spacing: 0) {
                    HStack {
                        Spacer()
                        Image("maskGroup522")
                    }
                    Spacer()
                    Image("maskGroup523")
                }
                VStack (alignment: .leading, spacing: 0) {
                    HStack {
                        Button(action: {
                            self.isNextOld = false
                            self.isTabBarAppear = true
                        }) {
                            HStack (spacing: 15) {
                                ImageCustom(name: "backBlack", w: 20, h: 11)
                                TextCustom(text: NSLocalizedString("login_welcome", comment: ""), font: MEDIUM, size: 26, color: #colorLiteral(red: 0.1401897073, green: 0.1228597537, blue: 0.1228597537, alpha: 1))
                            }
                        }.buttonStyle(ButtonTapScale())
                            .animation(.easeInOut(duration: 0.1))
                        Spacer()
                    }.padding(.bottom, H(8))
                    TextCustom(text: NSLocalizedString("login_system", comment: ""), font: REGULAR, size: 16, color: #colorLiteral(red: 0.2495550513, green: 0.2954892516, blue: 0.4120893478, alpha: 1))
                    VStack (alignment: .leading, spacing: 0) {
                        //MARK: Nhập tên đăng nhập
                        ZStack (alignment: .leading) {
                            HStack {
                                ZStack {
                                    ImageCustom(name: "011User", w: 11.6, h: 16)
                                }.frame(width: W(18), height: W(18))
                                Spacer()
                            }
                            ZStack(alignment: .leading) {
                                TextCustom(text: NSLocalizedString("login_username", comment: ""), font: REGULAR, size: 16, color: #colorLiteral(red: 0.6532951593, green: 0.6316769719, blue: 0.6316769719, alpha: 1))
                                    .opacity(strUsername.isEmpty ? 1 : 0)
                                TextField("", text: $strUsername)
                                    .font(.custom(BOLD, size: H(16)))
                                    .foregroundColor(.init(#colorLiteral(red: 0.2495550513, green: 0.2954892516, blue: 0.4120893478, alpha: 1)))
                                    .frame(height: H(16))
                            }.padding(.leading, 32)
                                .padding(.trailing, 27)
                            HStack {
                                Spacer()
                                Button(action: {
                                    self.strUsername = ""
                                }) {
                                    ImageCustom(name: "iconIonicMdCloseCircleOutline", w: 13, h: 13)
                                }.buttonStyle(ButtonTapScale())
                                    .animation(.easeInOut(duration: 0.1))
                            }.opacity(strUsername.isEmpty ? 0 : 1)
                        }
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.init(txtCheckUser.isEmpty || !strUsername.isEmpty ? #colorLiteral(red: 0.2418473065, green: 0.2878687382, blue: 0.3971883059, alpha: 1): #colorLiteral(red: 0.9020258188, green: 0.2418473065, blue: 0.2379874587, alpha: 1)))
                            .padding(.top, H(8))
                        if !txtCheckUser.isEmpty && strUsername.isEmpty {
                            TextCustom(text: NSLocalizedString("login_input_username", comment: ""), font: REGULAR, size: 14, color: #colorLiteral(red: 0.8844479918, green: 0.2379874587, blue: 0.2341234982, alpha: 1))
                                .padding(.top, H(10))
                        }
                        //MARK: Nhập password
                        ZStack (alignment: .leading) {
                            HStack {
                                ZStack {
                                    ImageCustom(name: "085Padlock", w: 13.1, h: 16)
                                }.frame(width: W(18), height: W(18))
                                Spacer()
                            }
                            ZStack (alignment: .leading) {
                                TextCustom(text: NSLocalizedString("login_password", comment: ""), font: REGULAR, size: 16, color: #colorLiteral(red: 0.6532951593, green: 0.6316769719, blue: 0.6316769719, alpha: 1))
                                    .opacity(strPassword.isEmpty ? 1 : 0)
                                ZStack (alignment: .leading) {
                                    SecureField("", text: $strPassword, onCommit: {
                                        self.fetchDataLogin()
                                    }).font(.custom(BOLD, size: H(16)))
                                        .foregroundColor(.init(#colorLiteral(red: 0.2495550513, green: 0.2954892516, blue: 0.4120893478, alpha: 1)))
                                        .opacity(isHide ? 1 : 0)
                                    TextField("", text: $strPassword, onCommit: {
                                        self.fetchDataLogin()
                                    }).font(.custom(BOLD, size: H(16)))
                                        .foregroundColor(.init(#colorLiteral(red: 0.2495550513, green: 0.2954892516, blue: 0.4120893478, alpha: 1)))
                                        .opacity(isHide ? 0 : 1)
                                } .frame(height: H(16))
                            }.padding(.leading, 32)
                                .padding(.trailing, 69)
                            HStack(spacing: 26) {
                                Spacer()
                                Button(action: {
                                    self.strPassword = ""
                                }) {
                                    ImageCustom(name: "iconIonicMdCloseCircleOutline", w: 13, h: 13)
                                }.buttonStyle(ButtonTapScale())
                                    .opacity(strPassword.isEmpty ? 0 : 1)
                                Button(action: {
                                    self.isHide.toggle()
                                }) {
                                    ImageCustom(name: isHide ? "014Vision1" : "015Vision", w: 16, h: isHide ? 14.3 : 10)
                                }.buttonStyle(ButtonTapScale())
                            }.animation(.easeInOut(duration: 0.1))
                        }.padding(.top, H(!txtCheckUser.isEmpty ? 27 : 31))
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.init(txtCheckPass.isEmpty || !strPassword.isEmpty ? #colorLiteral(red: 0.2495550513, green: 0.2954892516, blue: 0.4120893478, alpha: 1): #colorLiteral(red: 0.8844479918, green: 0.2379874587, blue: 0.2341234982, alpha: 1)))
                            .padding(.top, H(8))
                        if !txtCheckPass.isEmpty && strPassword.isEmpty {
                            TextCustom(text: NSLocalizedString("login_input_password", comment: ""), font: REGULAR, size: 14, color: #colorLiteral(red: 0.8844479918, green: 0.2379874587, blue: 0.2341234982, alpha: 1))
                                .padding(.top, H(10))
                        }
                    }.padding(.top, H(83))
                    VStack(alignment: .leading, spacing: 0) {
                        HStack (spacing: 10) {
                            ZStack (alignment: saveLogin ? .trailing : .leading) {
                                Rectangle()
                                    .frame(width: W(51), height: W(28))
                                    .cornerRadius(.infinity)
                                    .foregroundColor(.init(saveLogin ?#colorLiteral(red: 0.5179212689, green: 0.3108788133, blue: 0.726385951, alpha: 1): #colorLiteral(red: 0.6533299685, green: 0.6326879859, blue: 0.6321712136, alpha: 1)))
                                Rectangle()
                                    .frame(width: W(22), height: W(22))
                                    .cornerRadius(.infinity)
                                    .shadow(color: .init(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.3541577483)), radius: 3)
                                    .foregroundColor(.white)
                                    .padding(saveLogin ? .trailing : .leading, W(3))
                            }.animation(.easeInOut(duration: 0.1))
                                .onTapGesture {
                                    self.saveLogin.toggle()
                            }
                            Button(action: {
                                self.saveLogin.toggle()
                            }) {
                                TextCustom(text: NSLocalizedString("login_remember", comment: ""), font: REGULAR, size: 16, color: #colorLiteral(red: 0.519064784, green: 0.3106909394, blue: 0.7249851823, alpha: 1))
                            }.buttonStyle(ButtonTapScale())
                                .animation(.easeInOut(duration: 0.1))
                        }.padding(.top, H(!txtCheckPass.isEmpty ? 25 : 29))
                        Button(action: {
                            UIApplication.shared.endEditing()

                            //MARK: check user login
                            self.fetchDataLogin()
                        }) {
                            ZStack {
                                Rectangle()
                                    .frame(width: FULL_W - 36, height: H(49))
                                    .foregroundColor(.init(#colorLiteral(red: 0.4454799891, green: 0.214740485, blue: 0.6820377707, alpha: 1)))
                                    .cornerRadius(4)
                                    .shadow(color: Color.init(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2018942637)), radius: 6, x: 3, y: 3)
                                TextCustom(text: NSLocalizedString("login_signin", comment: ""), font: MEDIUM, size: 18, color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
                            }
                        }.buttonStyle(ButtonTapScale())
                            .animation(.easeInOut(duration: 0.1))
                            .padding(.top, H(30))
                        HStack {
                            Spacer()
                            Button(action: {
                                self.showPopUpForgot = true
                            }) {
                                TextCustom(text: NSLocalizedString("login_forgot_password", comment: ""), font: ITALIC, size: 14, color: #colorLiteral(red: 0.4269524217, green: 0.1874135733, blue: 0.6712699533, alpha: 1))
                            }.buttonStyle(ButtonTapScale())
                                .animation(.easeInOut(duration: 0.1))
                                .padding(.top, H(18))
                        }
                        HStack (spacing: 3) {
                            Spacer()
                            TextCustom(text: NSLocalizedString("login_member", comment: ""), font: REGULAR, size: 16, color: #colorLiteral(red: 0.2495550513, green: 0.2954892516, blue: 0.4120893478, alpha: 1))
                            Button(action: {
                                self.isNext = true
                            }) {
                                TextCustom(text: NSLocalizedString("login_signup_now", comment: ""), size: 16, color: #colorLiteral(red: 0.4454799891, green: 0.214740485, blue: 0.6820377707, alpha: 1))
                            }.buttonStyle(ButtonTapScale())
                                .animation(.easeInOut(duration: 0.1))
                            Spacer()
                        }.padding(.top, H(83))
                    }
                }.padding(.horizontal, 21)
                    .padding(.top, H(180))
                Rectangle()
                    .opacity(showPopUpForgot || showPopUpEmailResetPass || showPopUpLogin ? 0.65 : 0)
                    .onTapGesture {
                        self.strEmail = ""
                        UIApplication.shared.endEditing()
                        self.showPopUpForgot = false
                        self.isStrEmailEmptyConfirm = false
                        self.isStrEmailWrongConfirm = false
                        self.showPopUpEmailResetPass = false
                        self.showPopUpLogin = false
                }.animation(.easeInOut(duration: 0.2))
                PopUpForgotUsernameOrPassword(
                    showPopUpForgot: $showPopUpForgot,
                    showPopUpEmailResetPass: $showPopUpEmailResetPass,
                    isStrEmailEmptyConfirm: $isStrEmailEmptyConfirm,
                    isStrEmailWrongConfirm: $isStrEmailWrongConfirm,
                    strEmail: $strEmail
                )
                PopUpSendEmailReset(showPopUpEmailResetPass: $showPopUpEmailResetPass)
                PopUploginFailed(showPopUpLogin: $showPopUpLogin)
                NavigationLink(destination: SignupView(isNextOld: $isNext), isActive: $isNext) {
                    EmptyView()
                }
            }.background(Color.white).onTapGesture {
                UIApplication.shared.endEditing() }
                .navigationBarTitle("")
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
                .edgesIgnoringSafeArea(.all)

        }.navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
    }

    func fetchDataLogin() {
        if self.strUsername.isEmpty || self.strPassword.isEmpty {
            self.txtCheckUser = "1"
            self.txtCheckPass = "2"
        } else {
            self.loginViewModel.fetchDataLogin(userName: self.strUsername, passWord: self.strPassword)
            self.loginViewModel.vldLogin.sink { rs in
                if rs {
                    self.userInfor = self.loginViewModel.userProfile ?? self.userInfor
                    if self.userInfor.success ?? false {
                        KeychainManager.shared.saveString(value: self.saveLogin ? "true" : "false", forkey: .savelogin)
                        self.isLogin = true
                        self.isNextOld = false
                    } else {
                        self.showPopUpLogin = true
                    }
                }
            }.store(in: &self.disposables)
        }
    }
}

struct PopUpForgotUsernameOrPassword: View {
    @Binding var showPopUpForgot: Bool
    @Binding var showPopUpEmailResetPass: Bool
    @Binding var isStrEmailEmptyConfirm: Bool
    @Binding var isStrEmailWrongConfirm: Bool
    @Binding var strEmail: String
    
    @State var keyboardHeight: CGFloat = 0
    
    var body: some View {
        VStack {
            Spacer()
            ZStack (alignment: .topTrailing) {
                if !strEmail.isEmpty {
                    Text("").onAppear {
                        self.isStrEmailEmptyConfirm = false
                    }
                }
                if Utils.isValidEmail(email: strEmail) {
                    Text("").onAppear {
                        self.isStrEmailWrongConfirm = false
                    }
                }
                VStack(spacing: 0) {
                    VStack(spacing: 0) {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 1, height: H(
                                FULL_H == H_SE && FULL_W == W_SE ? 13: // iPhone SE 1st generation
                                FULL_H == H_8 && FULL_W == W_8 ? 13: // iPhone 8 && iPhone SE 2nd generation
                                FULL_H == H_8Plus && FULL_W == W_8Plus ? 14: // iPhone 8 Plus
                                FULL_H == H_11 && FULL_W == W_11 ? 11: // iPhone 11 && iPhone 11 Pro Max
                                FULL_H == H_11Pro && FULL_W == W_11Pro ? 11 : 0)// iPhone 11 Pro
                            )
                        ImageCustom(name: "iconAwesomeQuestionCircle", w: 65, h: 65)
                            .padding(.bottom, H(9))
                            .offset(x:
                                    FULL_H == H_SE && FULL_W == W_SE ? -0.4: // iPhone SE 1st generation
                                FULL_H == H_8 && FULL_W == W_8 ? -0.6: // iPhone 8 && iPhone SE 2nd generation
                                FULL_H == H_8Plus && FULL_W == W_8Plus ? -0.5: // iPhone 8 Plus
                                FULL_H == H_11 && FULL_W == W_11 ? -1: // iPhone 11 && iPhone 11 Pro Max
                                FULL_H == H_11Pro && FULL_W == W_11Pro ? -0.75 : 0// iPhone 11 Pro
                            )
                        TextCustom(text: NSLocalizedString("login_forgot_password", comment: ""), size: 18, color: #colorLiteral(red: 0.4281106591, green: 0.1894766092, blue: 0.6721540093, alpha: 1))
                            .padding(.bottom, H(16))
                        HStack {
                            Text("\(NSLocalizedString("login_please", comment: "")) ")
                                .font(.custom(REGULAR, size: H(14)))
                                .foregroundColor(.init(#colorLiteral(red: 0.3842699528, green: 0.384339571, blue: 0.3842601776, alpha: 1)))
                                + Text("\(NSLocalizedString("login_please_input_mail", comment: "")) ")
                                .font(.custom(BOLD, size: H(14)))
                                .foregroundColor(.init(#colorLiteral(red: 0.4053176045, green: 0.179061532, blue: 0.6358116269, alpha: 1)))
                                + Text(NSLocalizedString("login_please_input_mail_system", comment: ""))
                                .font(.custom(REGULAR, size: H(14)))
                                .foregroundColor(.init(#colorLiteral(red: 0.3842699528, green: 0.384339571, blue: 0.3842601776, alpha: 1)))
                        }.lineSpacing(5)
                            .multilineTextAlignment(.center)
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.horizontal, 33)
                            .padding(.bottom, H(24))
                        ZStack (alignment: .leading) {
                            ImageCustom(name: "iconEmail", w: 18, h: 18)
                            ZStack (alignment: .leading) {
                                TextCustom(text: "Email (*)", font: REGULAR, size: 16, color: #colorLiteral(red: 0.6534755826, green: 0.6314619184, blue: 0.6309846044, alpha: 1)).opacity(strEmail.isEmpty ? 1 : 0)
                                TextField("", text: $strEmail)
                                    .font(.custom(BOLD, size: H(16)))
                                    .foregroundColor(.init(#colorLiteral(red: 0.2495550513, green: 0.2954892516, blue: 0.4120893478, alpha: 1)))
                                    .keyboardType(.emailAddress)
                                    .frame(height: W(16))
                            }.padding(.leading, 32)
                                .padding(.trailing, 27)
                            HStack {
                                Spacer()
                                Button(action: {
                                    self.strEmail = ""
                                }) {
                                    ImageCustom(name: "iconIonicMdCloseCircleOutline", w: 13, h: 13)
                                }.buttonStyle(ButtonTapScale())
                                    .animation(.easeInOut(duration: 0.1))
                            }.opacity(strEmail.isEmpty ? 0 : 1)
                        }.frame(width: FULL_W - 72)
                        VStack (alignment: .leading, spacing: 0) {
                            Rectangle()
                                .frame(width: FULL_W - 72, height: 1)
                                .foregroundColor(.init(!isStrEmailEmptyConfirm && !isStrEmailWrongConfirm ? #colorLiteral(red: 0.2499063611, green: 0.2955911756, blue: 0.4130570292, alpha: 1): #colorLiteral(red: 0.8844479918, green: 0.2379874587, blue: 0.2341234982, alpha: 1)))
                                .padding(.top, H(8))
                                .padding(.bottom, H(isStrEmailWrongConfirm || isStrEmailEmptyConfirm ? 0 : 23))
                            if isStrEmailWrongConfirm || isStrEmailEmptyConfirm {
                                TextCustom(text: NSLocalizedString(isStrEmailWrongConfirm ? "signup_checkWrong_email" : "signup_warning_email", comment: ""), font: REGULAR, size: 14, color: #colorLiteral(red: 0.8844479918, green: 0.2379874587, blue: 0.2341234982, alpha: 1))
                                    .padding(.top, H(10))
                                    .padding(.bottom, H(23))
                            }
                        }
                    }
                    Button(action: {
                        if self.strEmail.isEmpty {
                            self.isStrEmailEmptyConfirm = true
                        } else {
                            self.isStrEmailEmptyConfirm = false
                            if !Utils.isValidEmail(email: self.strEmail) {
                                self.isStrEmailWrongConfirm = true
                            } else {
                                UIApplication.shared.endEditing()
                                self.isStrEmailWrongConfirm = false
                                self.showPopUpForgot = false
                                self.showPopUpEmailResetPass = true
                            }
                        }
                    }) {
                        ZStack {
                            Rectangle()
                                .cornerRadius(4)
                                .foregroundColor(.init(#colorLiteral(red: 0.4282599092, green: 0.1879977882, blue: 0.6717798114, alpha: 1)))
                                .frame(width: FULL_W - 72, height: H(40))
                                .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.init(#colorLiteral(red: 0.4282599092, green: 0.1879977882, blue: 0.6717798114, alpha: 1)), lineWidth: 1))
                            TextCustom(text: NSLocalizedString("login_send", comment: ""), font: MEDIUM, size: 16, color: .white)
                        }
                    }.buttonStyle(ButtonTapScale())
                        .animation(.easeInOut(duration: 0.2))
                }.padding(.bottom, H(26))
                    .background(
                        Image("union154")
                            .resizable()
                            .frame(width: FULL_W - 42)
                            .shadow(color: .init(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2016802226)), radius: 6)
                    )
                Button(action: {
                    self.strEmail = ""
                    UIApplication.shared.endEditing()
                    self.showPopUpForgot = false
                    self.isStrEmailEmptyConfirm = false
                    self.isStrEmailWrongConfirm = false
                }) {
                    ImageCustom(name: "iconIonicMdCloseCircleOutline", w: 20, h: 20)
                }.buttonStyle(ButtonTapScale())
                    .animation(.easeInOut(duration: 0.2))
                    .offset(x: W(
                        FULL_H == H_SE && FULL_W == W_SE ? 8 : 6
                            ), y: H(
                            FULL_H == H_SE && FULL_W == W_SE ? 48: // iPhone SE 1st generation
                            FULL_H == H_8 && FULL_W == W_8 ? 46: // iPhone 8 && iPhone SE 2nd generation
                            FULL_H == H_8Plus && FULL_W == W_8Plus ? 45: // iPhone 8 Plus
                            FULL_H == H_11 && FULL_W == W_11 ? 42: // iPhone 11 && iPhone 11 Pro Max
                            FULL_H == H_11Pro && FULL_W == W_11Pro ? 42 : 0// iPhone 11 Pro
                            ))
            }.offset(y: keyboardHeight > 0 ?
                FULL_H == H_SE && FULL_W == W_SE ? -75: // iPhone SE 1st generation
                FULL_H == H_8 && FULL_W == W_8 ? -60: // iPhone 8 && iPhone SE 2nd generation
                FULL_H == H_8Plus && FULL_W == W_8Plus ? -65: // iPhone 8 Plus
                FULL_H == H_11 && FULL_W == W_11 ? -70: // iPhone 11 && iPhone 11 Pro Max
                FULL_H == H_11Pro && FULL_W == W_11Pro ? -80 : 0// iPhone 11 Pro
                : 0)
            Spacer()
        }.keyboardAppear(keyboardHeight: $keyboardHeight)
            .opacity(showPopUpForgot ? 1 : 0)
            .scaleEffect(showPopUpForgot ? 1 : 0.1)
            .animation(.easeInOut(duration: 0.2))
    }
}

struct PopUpSendEmailReset: View {
    @Binding var showPopUpEmailResetPass: Bool

    var body: some View {
        VStack {
            Spacer()
            ZStack (alignment: .topTrailing) {
                VStack(spacing: 0) {
                    VStack(spacing: 0) {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(width: 1, height: H(
                                FULL_H == H_SE && FULL_W == W_SE ? 13: // iPhone SE 1st generation
                                FULL_H == H_8 && FULL_W == W_8 ? 13: // iPhone 8 && iPhone SE 2nd generation
                                FULL_H == H_8Plus && FULL_W == W_8Plus ? 14: // iPhone 8 Plus
                                FULL_H == H_11 && FULL_W == W_11 ? 11: // iPhone 11 && iPhone 11 Pro Max
                                FULL_H == H_11Pro && FULL_W == W_11Pro ? 11 : 0)// iPhone 11 Pro
                            )
                        ImageCustom(name: "group14825", w: 65, h: 65)
                            .padding(.bottom, H(9))
                            .offset(x: -0.5)
                        TextCustom(text: NSLocalizedString("login_email_send", comment: ""), size: 18, color: #colorLiteral(red: 0.4281106591, green: 0.1894766092, blue: 0.6721540093, alpha: 1))
                            .padding(.bottom, H(16))
                        TextCustom(text: NSLocalizedString("login_email_check", comment: ""), font: REGULAR, size: 14, color: #colorLiteral(red: 0.3842699528, green: 0.384339571, blue: 0.3842601776, alpha: 1))
                            .lineSpacing(5)
                            .multilineTextAlignment(.center)
                            .fixedSize(horizontal: false, vertical: true)
                            .padding(.horizontal, 33)
                    }
                }.padding(.bottom, H(26))
                    .background(
                        Image("union150")
                            .resizable()
                            .frame(width: FULL_W - 42)
                            .shadow(color: .init(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2016802226)), radius: 6)
                    )
                Button(action: {
                    self.showPopUpEmailResetPass = false
                }) {
                    ImageCustom(name: "iconIonicMdCloseCircleOutline", w: 20, h: 20)
                }.buttonStyle(ButtonTapScale())
                    .animation(.easeInOut(duration: 0.1))
                    .offset(x: W(
                        FULL_H == H_SE && FULL_W == W_SE ? -36: // iPhone SE 1st generation
                        FULL_H == H_8 && FULL_W == W_8 ? -36: // iPhone 8 && iPhone SE 2nd generation
                        FULL_H == H_8Plus && FULL_W == W_8Plus ? -29: // iPhone 8 Plus
                        FULL_H == H_11 && FULL_W == W_11 ? -29: // iPhone 11 && iPhone 11 Pro Max
                        FULL_H == H_11Pro && FULL_W == W_11Pro ? -34 : 0// iPhone 11 Pro
                            ), y: H(
                            FULL_H == H_SE && FULL_W == W_SE ? 39: // iPhone SE 1st generation
                            FULL_H == H_8 && FULL_W == W_8 ? 40: // iPhone 8 && iPhone SE 2nd generation
                            FULL_H == H_8Plus && FULL_W == W_8Plus ? 39: // iPhone 8 Plus
                            FULL_H == H_11 && FULL_W == W_11 ? 39: // iPhone 11 && iPhone 11 Pro Max
                            FULL_H == H_11Pro && FULL_W == W_11Pro ? 39 : 0// iPhone 11 Pro
                            ))
            }
            Spacer()
        }.opacity(showPopUpEmailResetPass ? 1 : 0)
            .scaleEffect(showPopUpEmailResetPass ? 1 : 0.1)
            .animation(.easeInOut(duration: 0.2))
    }
}

struct PopUploginFailed: View {
    @Binding var showPopUpLogin: Bool

    var body: some View {
        VStack {
            Spacer()
            ZStack (alignment: .topTrailing) {
                VStack(spacing: 0) {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 1, height: H(
                            FULL_H == H_SE && FULL_W == W_SE ? 13: // iPhone SE 1st generation
                            FULL_H == H_8 && FULL_W == W_8 ? 13: // iPhone 8 && iPhone SE 2nd generation
                            FULL_H == H_8Plus && FULL_W == W_8Plus ? 14: // iPhone 8 Plus
                            FULL_H == H_11 && FULL_W == W_11 ? 11: // iPhone 11 && iPhone 11 Pro Max
                            FULL_H == H_11Pro && FULL_W == W_11Pro ? 11 : 0)// iPhone 11 Pro
                        )
                    ImageCustom(name: "iconIonicIosCloseCircle", w: 65, h: 65)
                        .padding(.bottom, H(9))
                        .offset(x: -0.5)
                    TextCustom(text: NSLocalizedString("login_wrong", comment: ""), font: REGULAR, size: 14, color: #colorLiteral(red: 0.3842699528, green: 0.384339571, blue: 0.3842601776, alpha: 1))
                        .lineSpacing(5)
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.horizontal, 33)
                        .padding(.bottom, H(24))
                    Button(action: {
                        self.showPopUpLogin = false
                    }) {
                        ZStack {
                            Rectangle()
                                .cornerRadius(4)
                                .foregroundColor(.init(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                                .frame(width: FULL_W - 72, height: H(40))
                                .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.init(#colorLiteral(red: 0.4282599092, green: 0.1879977882, blue: 0.6717798114, alpha: 1)), lineWidth: 1))
                            TextCustom(text: NSLocalizedString("login_close", comment: ""), font: MEDIUM, size: 16, color: #colorLiteral(red: 0.4282599092, green: 0.1879977882, blue: 0.6717798114, alpha: 1))
                        }
                    }.buttonStyle(ButtonTapScale())
                        .animation(.easeInOut(duration: 0.1))
                }.padding(.bottom, H(26))
                    .background(
                        Image("union150")
                            .resizable()
                            .frame(width: FULL_W - 42)
                            .shadow(color: .init(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2016802226)), radius: 6)
                    )
            }
            Spacer()
        }.opacity(showPopUpLogin ? 1 : 0)
            .scaleEffect(showPopUpLogin ? 1 : 0.1)
            .animation(.easeInOut(duration: 0.2))
    }
}
