// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import SwiftUI
import Combine

struct signupInput: Identifiable, Hashable {
    var id = UUID()
    var state: String
    var holder: String
    var icon: String
    var checkEmpty: String
    var checkWrong: String
}

struct SignupView: View {
    @Binding var isNextOld: Bool

    @State var strName = ""
    @State var strPass = ""
    @State var strRePass = ""
    @State var strEmail = ""
    @State var isShowPopUpRegister = false
    @State var userEmptyConfirm = false
    @State var passEmptyConfirm = false
    @State var repassEmptyConfirm = false
    @State var emailEmptyConfirm = false
    @State var phoneEmptyConfirm = false
    @State var userWrongConfirm = false
    @State var passWrongConfirm = false
    @State var repassWrongConfirm = false
    @State var emailWrongConfirm = false
    @State var emailDuplicatedConfirm = false
    @State var phoneWrongConfirm = false
    @State var countWarning = 0
    @State var disposables = Set<AnyCancellable>()
    @State var signupResult = false
    @State var duplicatedEmail = ""
    @State var duplicatedUser = ""
    @ObservedObject var registerViewModel = RegisterViewModel()

    @State var keyboardHeight: CGFloat = 0

    let arrSignUp = [
        signupInput(state: "user", holder: "signup_holder_user", icon: "iconAccount", checkEmpty: "signup_warning_user", checkWrong: "signup_checkWrong_user"),
        signupInput(state: "email", holder: "Email (*)", icon: "iconEmail", checkEmpty: "signup_warning_email", checkWrong: "signup_checkWrong_email"),
        signupInput(state: "pass", holder: "signup_holder_pass", icon: "iconLock", checkEmpty: "signup_warning_pass", checkWrong: ""),
        signupInput(state: "repass", holder: "signup_holder_repass", icon: "iconLock", checkEmpty: "signup_warning_repass", checkWrong: "signup_checkWrong_pass")
    ]

    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                if self.signupResult {
                    Text("").onAppear {
                        self.isShowPopUpRegister = true
                        UIApplication.shared.endEditing()
                    }
                }
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
                        }) {
                            HStack (spacing: 15) {
                                ImageCustom(name: "backBlack", w: 20, h: 11)
                                TextCustom(text: NSLocalizedString("signup_title_regist", comment: ""), font: MEDIUM, size: 26, color: #colorLiteral(red: 0.1401897073, green: 0.1228597537, blue: 0.1228597537, alpha: 1))
                            }
                        }.buttonStyle(ButtonTapScale())
                            .animation(.easeInOut(duration: 0.1))
                        Spacer()
                    }.padding(.bottom, H(8))
                        .opacity(keyboardHeight > 0 ? 0 : 1)
                    TextCustom(text: NSLocalizedString("signup_welcome_minerva", comment: ""), font: REGULAR, size: 16, color: #colorLiteral(red: 0.2495550513, green: 0.2954892516, blue: 0.4120893478, alpha: 1))
                        .opacity(keyboardHeight > 0 ? 0 : 1)
                    VStack (alignment: .leading, spacing: H(30)) {
                        ForEach(arrSignUp, id: \.self) { item in
                            SignUpTextField(
                                signUp: { self.signUp() },
                                countWarning: self.$countWarning,
                                value:
                                    item.state == "user" ? self.$strName:
                                    item.state == "pass" ? self.$strPass:
                                    item.state == "repass" ? self.$strRePass: self.$strEmail,
                                valueEmptyConfirm:
                                    item.state == "user" ? self.$userEmptyConfirm:
                                    item.state == "pass" ? self.$passEmptyConfirm:
                                    item.state == "repass" ? self.$repassEmptyConfirm: self.$emailEmptyConfirm,
                                valueWrongConfirm:
                                    item.state == "user" ? self.$userWrongConfirm:
                                    item.state == "pass" ? self.$passWrongConfirm:
                                    item.state == "repass" ? self.$repassWrongConfirm: self.$emailWrongConfirm,
                                repassWrongConfirm: self.$repassWrongConfirm,
                                emailDuplicatedConfirm: self.$emailDuplicatedConfirm,
                                duplicatedEmail: self.$duplicatedEmail,
                                duplicatedUser: self.$duplicatedUser,
                                item: item
                            )
                        }
                    }.padding(.top, H(45))
                    Button(action: {
                        self.signUp()
                    }) {
                        ZStack {
                            Rectangle()
                                .frame(width: FULL_W - 36, height: H(49))
                                .foregroundColor(.init(#colorLiteral(red: 0.4454799891, green: 0.214740485, blue: 0.6820377707, alpha: 1)))
                                .cornerRadius(4)
                                .shadow(color: Color.init(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2018942637)), radius: 6, x: 3, y: 3)
                            TextCustom(text: NSLocalizedString("signup_signup", comment: ""), font: MEDIUM, size: 18, color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
                        }
                    }.buttonStyle(ButtonTapScale())
                        .animation(.easeInOut(duration: 0.1))
                        .padding(.top, H(30))
                    HStack {
                        Spacer()
                        Button(action: {
                            self.isNextOld = false
                        }) {
                            HStack (spacing: 4) {
                                TextCustom(text: NSLocalizedString("login_signin", comment: ""), size: 16, color:
                                        FULL_H == H_SE && FULL_W == W_SE ? // iPhone SE 1st generation
                                    countWarning > 2 ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1): #colorLiteral(red: 0.4454799891, green: 0.214740485, blue: 0.6820377707, alpha: 1):
                                        FULL_H == H_8 && FULL_W == W_8 ? #colorLiteral(red: 0.4454799891, green: 0.214740485, blue: 0.6820377707, alpha: 1): // iPhone 8 && iPhone SE 2nd generation
                                    FULL_H == H_8Plus && FULL_W == W_8Plus ? #colorLiteral(red: 0.4454799891, green: 0.214740485, blue: 0.6820377707, alpha: 1): // iPhone 8 Plus
                                    FULL_H == H_11 && FULL_W == W_11 ? #colorLiteral(red: 0.4454799891, green: 0.214740485, blue: 0.6820377707, alpha: 1): // iPhone 11 && iPhone 11 Pro Max
                                    FULL_H == H_11Pro && FULL_W == W_11Pro ? #colorLiteral(red: 0.4454799891, green: 0.214740485, blue: 0.6820377707, alpha: 1): #colorLiteral(red: 0.4454799891, green: 0.214740485, blue: 0.6820377707, alpha: 1) // iPhone 11 Pro
                                )
                                ZStack {
                                    ImageCustom(name: "EmptyPicture", w: 20, h: 20)
                                    ImageCustom(name:
                                            FULL_H == H_SE && FULL_W == W_SE ? // iPhone SE 1st generation
                                            countWarning > 2 ? "nextWhite" : "group14910":
                                                FULL_H == H_8 && FULL_W == W_8 ? "group14910": // iPhone 8 && iPhone SE 2nd generation
                                            FULL_H == H_8Plus && FULL_W == W_8Plus ? "group14910": // iPhone 8 Plus
                                            FULL_H == H_11 && FULL_W == W_11 ? "group14910": // iPhone 11 && iPhone 11 Pro Max
                                            FULL_H == H_11Pro && FULL_W == W_11Pro ? "group14910" : "group14910" // iPhone 11 Pro
                                        , w:
                                            FULL_H == H_SE && FULL_W == W_SE ? // iPhone SE 1st generation
                                            countWarning > 2 ? 8 : 20:
                                                FULL_H == H_8 && FULL_W == W_8 ? 20: // iPhone 8 && iPhone SE 2nd generation
                                            FULL_H == H_8Plus && FULL_W == W_8Plus ? 20: // iPhone 8 Plus
                                            FULL_H == H_11 && FULL_W == W_11 ? 20: // iPhone 11 && iPhone 11 Pro Max
                                            FULL_H == H_11Pro && FULL_W == W_11Pro ? 20 : 20 // iPhone 11 Pro
                                        , h:
                                            FULL_H == H_SE && FULL_W == W_SE ? // iPhone SE 1st generation
                                            countWarning > 2 ? 13 : 20:
                                                FULL_H == H_8 && FULL_W == W_8 ? 20: // iPhone 8 && iPhone SE 2nd generation
                                            FULL_H == H_8Plus && FULL_W == W_8Plus ? 20: // iPhone 8 Plus
                                            FULL_H == H_11 && FULL_W == W_11 ? 20: // iPhone 11 && iPhone 11 Pro Max
                                            FULL_H == H_11Pro && FULL_W == W_11Pro ? 20 : 20 // iPhone 11 Pro
                                    )
                                }
                            }.shadow(color: .init(
                                FULL_H == H_SE && FULL_W == W_SE ? // iPhone SE 1st generation
                                countWarning > 2 ? #colorLiteral(red: 0.4454799891, green: 0.214740485, blue: 0.6820377707, alpha: 1): #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0):
                                    FULL_H == H_8 && FULL_W == W_8 ? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0): // iPhone 8 && iPhone SE 2nd generation
                                FULL_H == H_8Plus && FULL_W == W_8Plus ? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0): // iPhone 8 Plus
                                FULL_H == H_11 && FULL_W == W_11 ? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0): // iPhone 11 && iPhone 11 Pro Max
                                FULL_H == H_11Pro && FULL_W == W_11Pro ? #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0): #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0) // iPhone 11 Pro
                                ), radius: 3)
                        }.buttonStyle(ButtonTapScale())
                            .animation(.easeInOut(duration: 0.1))
                        Spacer()
                    }.padding(.top, H(
                        FULL_H == H_SE && FULL_W == W_SE ? // iPhone SE 1st generation
                        countWarning < 4 ? 95 : 73:
                            FULL_H == H_8 && FULL_W == W_8 ? // iPhone 8 && iPhone SE 2nd generation
                        countWarning < 4 ? 95 : 73:
                            FULL_H == H_8Plus && FULL_W == W_8Plus ? // iPhone 8 Plus
                        countWarning < 4 ? 95 : 73:
                            FULL_H == H_11 && FULL_W == W_11 ? // iPhone 11 && iPhone 11 Pro Max
                        countWarning < 4 ? 95 : countWarning == 4 ? 73 : 0:
                            FULL_H == H_11Pro && FULL_W == W_11Pro ? // iPhone 11 Pro
                        countWarning < 4 ? 95 : countWarning == 4 ? 73 : 0: 0
                        ))
                }.padding(.horizontal, 21)
                    .padding(.top, H(180))
                Rectangle()
                    .foregroundColor(.black)
                    .opacity(isShowPopUpRegister ? 0.65 : 0)
                    .animation(.easeInOut(duration: 0.2))
                    .onTapGesture {
                        self.isShowPopUpRegister = false
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            self.isNextOld = false
                        }
                }
                PopUpRegisterView(isNextOld: $isNextOld, isShowPopUpRegister: $isShowPopUpRegister)
            }.keyboardAppear(keyboardHeight: $keyboardHeight)
                .animation(.easeInOut(duration: 0.1))
                .offset(y: keyboardHeight > 0 ?
                    FULL_H == H_SE && FULL_W == W_SE ? -147: // iPhone SE 1st generation
                    FULL_H == H_8 && FULL_W == W_8 ? -147: // iPhone 8 && iPhone SE 2nd generation
                    FULL_H == H_8Plus && FULL_W == W_8Plus ? -147: // iPhone 8 Plus
                    FULL_H == H_11 && FULL_W == W_11 ? -177: // iPhone 11 && iPhone 11 Pro Max
                    FULL_H == H_11Pro && FULL_W == W_11Pro ? -177 : 0: 0 // iPhone 11 Pro
                ).background(Color.white).onTapGesture {
                    UIApplication.shared.endEditing()
                }.edgesIgnoringSafeArea(.all)
                .navigationBarTitle("")
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
        }.navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
    }

    func signUp() {
        self.repassWrongConfirm = false
        self.emailWrongConfirm = false
        if self.strName.isEmpty {
            self.userEmptyConfirm = true
            self.userWrongConfirm = false
        }
        if self.strPass.isEmpty {
            self.passEmptyConfirm = true
            self.passWrongConfirm = false
        }
        if self.strRePass.isEmpty {
            self.repassEmptyConfirm = true
            self.repassWrongConfirm = false
        }
        if self.strEmail.isEmpty {
            self.emailEmptyConfirm = true
            self.emailWrongConfirm = false
        } else {
            if !Utils.isValidEmail(email: strEmail) {
                self.emailWrongConfirm = true
            }
        }
        if self.strPass != self.strRePass && !self.strPass.isEmpty && !self.strRePass.isEmpty {
            self.repassWrongConfirm = true
        }
        if !self.strName.isEmpty && !self.strPass.isEmpty && !self.strRePass.isEmpty && !self.strEmail.isEmpty && (self.strPass == self.strRePass) {
            self.registerViewModel.registerViewModel(email: self.strEmail, username: self.strName, password: self.strPass)
            self.registerViewModel.registerResult.sink { rs in
                if self.registerViewModel.registerModel?.success ?? false {
                    self.signupResult = true
                } else {
                    if self.registerViewModel.registerModel?.detail ?? "" == "Username is exist" {
                        self.userWrongConfirm = true
                        self.duplicatedUser = self.strName
                    }
                    if self.registerViewModel.registerModel?.detail ?? "" == "Email is not valid" {
                        self.emailWrongConfirm = true
                    }
                    if self.registerViewModel.registerModel?.detail ?? "" == "Email is exist" {
                        self.emailDuplicatedConfirm = true
                        self.duplicatedEmail = self.strEmail
                    }
                }
            }.store(in: &self.disposables)
        }
    }
}

struct SignUpTextField: View {
    let signUp: () -> Void
    @Binding var countWarning: Int
    @Binding var value: String
    @Binding var valueEmptyConfirm: Bool
    @Binding var valueWrongConfirm: Bool
    @Binding var repassWrongConfirm: Bool
    @Binding var emailDuplicatedConfirm: Bool
    @Binding var duplicatedEmail: String
    @Binding var duplicatedUser: String
    @State var item = signupInput(state: "", holder: "", icon: "", checkEmpty: "", checkWrong: "")
    @State var checkEmpty = ""
    @State var checkWrong = ""

    @State var isShowPassWord = false
    @State var isClear = false
    @State var isEnableEdit = true

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            ZStack (alignment: .leading) {
                if !value.isEmpty {
                    Text("").onAppear {
                        self.valueEmptyConfirm = false
                    }
                }
                if item.state == "email" && Utils.isValidEmail(email: value) {
                    Text("").onAppear {
                        self.valueWrongConfirm = false
                    }
                }
                if item.state == "email" && value != duplicatedEmail {
                    Text("").onAppear {
                        self.emailDuplicatedConfirm = false
                    }
                }
                if item.state == "user" && value != duplicatedUser {
                    Text("").onAppear {
                        self.valueWrongConfirm = false
                    }
                }
                HStack {
                    ZStack {
                        ImageCustom(name: item.icon.isEmpty ? "EmptyPicture" : item.icon, w: 18, h: 18)
                    }.frame(width: W(18), height: W(18))
                    Spacer()
                }
                ZStack (alignment: .leading) {
                    TextCustom(text: NSLocalizedString(item.holder, comment: ""), font: REGULAR, size: 16, color: #colorLiteral(red: 0.6532951593, green: 0.6316769719, blue: 0.6316769719, alpha: 1))
                        .opacity(value.isEmpty ? 1 : 0)
                    ZStack (alignment: .leading) {
                        SecureField("", text: $value)
                            .foregroundColor(.init(#colorLiteral(red: 0.2521458864, green: 0.2940720916, blue: 0.4103593528, alpha: 1)))
                            .font(.custom(BOLD, size: H(16)))
                            .keyboardType(item.state == "email" ? .emailAddress : .default)
                            .opacity(item.state == "pass" || item.state == "repass" ? !isShowPassWord ? 1 : 0: 0)
                        TextField("", text: $value)
                            .foregroundColor(.init(#colorLiteral(red: 0.2521458864, green: 0.2940720916, blue: 0.4103593528, alpha: 1)))
                            .font(.custom(BOLD, size: H(16)))
                            .opacity(item.state == "pass" || item.state == "repass" ? isShowPassWord ? 1 : 0: 1)
                            .keyboardType(item.state == "email" ? .emailAddress : .default)
                    }.frame(height: H(16))
                }.padding(.leading, 32)
                    .padding(.trailing, 69)
                HStack(spacing: 0) {
                    Spacer()
                    Button(action: {
                        self.value = ""
                    }) {
                        ImageCustom(name: "iconIonicMdCloseCircleOutline", w: 13, h: 13)
                    }.buttonStyle(ButtonTapScale())
                        .opacity(value.isEmpty ? 0 : 1)
                    if item.state == "pass" || item.state == "repass" {
                        Button(action: {
                            self.isShowPassWord.toggle()
                        }) {
                            ImageCustom(name: isShowPassWord ? "015Vision" : "014Vision1", w: 16, h: isShowPassWord ? 10 : 14.3)
                        }.buttonStyle(ButtonTapScale())
                            .padding(.leading, 26)
                    }
                }.animation(.easeInOut(duration: 0.1))
            }
            Rectangle()
                .frame(height: 1)
                .foregroundColor(.init(
                    (valueEmptyConfirm && value.isEmpty)
                        || valueWrongConfirm
                        || (item.state == "email" && emailDuplicatedConfirm)
                        || (item.state == "pass" && repassWrongConfirm) ?
                    #colorLiteral(red: 0.932536602, green: 0.2507158816, blue: 0.2460758984, alpha: 1): #colorLiteral(red: 0.2495550513, green: 0.2954892516, blue: 0.4120893478, alpha: 1)
                        ))
                .padding(.top, H(8))
            if (valueEmptyConfirm && value.isEmpty)
                || valueWrongConfirm
                || (emailDuplicatedConfirm && item.state == "email")
                {
                TextCustom(text: NSLocalizedString(emailDuplicatedConfirm && item.state == "email" ? "signup_warning_email_exist" : valueWrongConfirm ? item.checkWrong : item.checkEmpty, comment: ""), font: REGULAR, size: 14, lineLimit: 1, color: #colorLiteral(red: 0.932536602, green: 0.2507158816, blue: 0.2460758984, alpha: 1))
                    .padding(.top, H(8))
                    .onAppear { self.countWarning += 1 }
                    .onDisappear { self.countWarning -= 1 }
            }
        }
    }
}

struct PopUpRegisterView: View {
    @Binding var isNextOld: Bool
    @Binding var isShowPopUpRegister: Bool

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
                        TextCustom(text: NSLocalizedString("signup_email_send_confirm", comment: ""), size: 18, color: #colorLiteral(red: 0.4281106591, green: 0.1894766092, blue: 0.6721540093, alpha: 1))
                            .padding(.bottom, H(16))
                        TextCustom(text: NSLocalizedString("signup_email_send_descripe", comment: ""), font: REGULAR, size: 14, color: #colorLiteral(red: 0.3842699528, green: 0.384339571, blue: 0.3842601776, alpha: 1))
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
                    self.isShowPopUpRegister = false
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        self.isNextOld = false
                    }
                }) {
                    ImageCustom(name: "iconIonicMdCloseCircleOutline", w: 20, h: 20)
                }.buttonStyle(ButtonTapScale())
                    .animation(.easeInOut(duration: 0.1))
                    .offset(x: W(
                        FULL_H == H_SE && FULL_W == W_SE ? -33: // iPhone SE 1st generation
                        FULL_H == H_8 && FULL_W == W_8 ? -36: // iPhone 8 && iPhone SE 2nd generation
                        FULL_H == H_8Plus && FULL_W == W_8Plus ? -29: // iPhone 8 Plus
                        FULL_H == H_11 && FULL_W == W_11 ? -33: // iPhone 11 && iPhone 11 Pro Max
                        FULL_H == H_11Pro && FULL_W == W_11Pro ? -34 : 0// iPhone 11 Pro
                            ), y: H(
                            FULL_H == H_SE && FULL_W == W_SE ? 40: // iPhone SE 1st generation
                            FULL_H == H_8 && FULL_W == W_8 ? 40: // iPhone 8 && iPhone SE 2nd generation
                            FULL_H == H_8Plus && FULL_W == W_8Plus ? 39: // iPhone 8 Plus
                            FULL_H == H_11 && FULL_W == W_11 ? 39: // iPhone 11 && iPhone 11 Pro Max
                            FULL_H == H_11Pro && FULL_W == W_11Pro ? 39 : 0// iPhone 11 Pro
                            ))
            }
            Spacer()
        }.opacity(isShowPopUpRegister ? 1 : 0)
            .scaleEffect(isShowPopUpRegister ? 1 : 0.1)
            .animation(.easeInOut(duration: 0.2))
    }
}
