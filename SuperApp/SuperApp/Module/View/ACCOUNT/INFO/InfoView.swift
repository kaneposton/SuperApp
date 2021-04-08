// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import SwiftUI
import SDWebImageSwiftUI

struct InfoView: View {
    @Binding var isNextOld: Bool

    @State var URLAvatar = ""
    @State var strEmail = ""
    @State var strPass = ""
    @State var strName = ""
    @State var dateBirth = Date()
    @State var strAddress = ""
    @State var strPhone = ""
    @State var gender = -1
    @State var strJob = ""

    @State var temp_URLAvatar = ""
    @State var temp_strEmail = ""
    @State var temp_strPass = ""
    @State var temp_strName = ""
    @State var temp_dateBirth = Date()
    @State var temp_strAddress = ""
    @State var temp_strPhone = ""
    @State var temp_gender = -1
    @State var temp_strJob = ""

    @State var isEnableEdit = false
    @State var isNextEditPass = false
    @State var isShowPopUp = false

    @State var image: Image? = nil
    @State var uiImg: UIImage?
    @State var isOpenPopupChoosePhoto = false
    @State var isShowLibrary = false
    @State var sourceType = 0
    @State var isShowDatePicker = false
    @State var selectedIndex = -1
    @State var isShowPopUpBackConfirm = false
    @State var isEmailEmpty = false
    @State var isEmailWrong = false
    @State var isNameEmpty = false
    @State var isPhoneWrong = false
    @State var isShowPopupSaveSuccess = false

    @State var initValue = 1
    @State var pushKeyboard = ""
    @State var isDifferent = false
    @State var isAlreadyChangePass = false

    @State var keyboardHeight: CGFloat = 0

    var body: some View {
        NavigationView {
            ZStack (alignment: .top) {
                ZStack {
                    // MARK: STR EMAIL
                    if !temp_strEmail.isEmpty {
                        Text("").onAppear {
                            self.isEmailEmpty = false
                        }
                    }
                    if temp_strEmail.isEmpty || Utils.isValidEmail(email: temp_strEmail) {
                        Text("").onAppear {
                            self.isEmailWrong = false
                        }
                    }

                    // MARK: STR NAME
                    if !temp_strName.isEmpty {
                        Text("").onAppear {
                            self.isNameEmpty = false
                        }
                    }

                    // MARK: STR PHONE
                    if temp_strPhone.isEmpty || formattedNumberPhone(number: temp_strPhone).count == 12 {
                        Text("").onAppear {
                            self.isPhoneWrong = false
                        }
                    }

                    if temp_strEmail != strEmail || temp_strPass != strPass || temp_strName != strName || initValue != 1 || temp_strAddress != strAddress || temp_strPhone != strPhone || temp_gender != gender || temp_strJob != strJob || image != nil || isAlreadyChangePass {
                        Text("").onAppear {
                            self.isDifferent = true
                        }
                    }

                    if temp_strEmail == strEmail && temp_strPass == strPass && temp_strName == strName && initValue == 1 && temp_strAddress == strAddress && temp_strPhone == strPhone && temp_gender == gender && temp_strJob == strJob && image == nil && !isAlreadyChangePass {
                        Text("").onAppear {
                            self.isDifferent = false
                        }
                    }
                }
                VStack (alignment: .leading, spacing: 0) {
                    HStack {
                        Button(action: {
                            UIApplication.shared.endEditing()
                            if self.isEnableEdit {
                                if self.isDifferent {
                                    self.isShowPopUpBackConfirm = true
                                } else {
                                    self.isNextOld = false
                                }
                            } else {
                                self.isNextOld = false
                            }
                        }) {
                            HStack (spacing: 14) {
                                ImageCustom(name: "backBlack", w: 20, h: 11)
                                TextCustom(text: NSLocalizedString("account_information", comment: ""), size: 24, lineLimit: 1, color: #colorLiteral(red: 0.1422221363, green: 0.1236664429, blue: 0.1232500449, alpha: 1))
                            }
                        }.buttonStyle(ButtonTapScale())
                        Spacer()
                        ZStack (alignment: .trailing) {
                            Button(action: {
                                self.isEnableEdit = true
                            }) {
                                TextCustom(text: NSLocalizedString("info_editing", comment: ""), font: MEDIUM, size: 18, lineLimit: 1, color: #colorLiteral(red: 0.1422221363, green: 0.1236664429, blue: 0.1232500449, alpha: 1))
                            }.buttonStyle(ButtonTapScale())
                                .opacity(isEnableEdit ? 0 : 1)
                            Button(action: {
                                self.saveInfo()
                            }) {
                                TextCustom(text: NSLocalizedString("info_save", comment: ""), font: MEDIUM, size: 18, lineLimit: 1, color: isDifferent ? #colorLiteral(red: 0.4282599092, green: 0.1879977882, blue: 0.6717798114, alpha: 1): #colorLiteral(red: 0.6534755826, green: 0.6314619184, blue: 0.6309846044, alpha: 1))
                            }.buttonStyle(ButtonTapScale())
                                .disabled(isDifferent ? false : true)
                                .opacity(isEnableEdit ? 1 : 0)
                        }
                    }.animation(.easeInOut(duration: 0.1))
                        .padding(.horizontal, 20)
                        .background(Color.white)
                        .padding(.top, H(16))
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.init(#colorLiteral(red: 0.6534755826, green: 0.6314619184, blue: 0.6309846044, alpha: 1)))
                        .padding(.top, H(12))
                    ScrollView(showsIndicators: false) {
                        VStack (alignment: .leading, spacing: 0) {
                            HStack {
                                Spacer()
                                if image == nil {
                                    if URLAvatar.isEmpty {
                                        ZStack {
                                            Button(action: {
                                                self.isShowPopUp = true
                                            }) {
                                                ImageCustom(name: "photo_info", w: 144, h: 144)
                                            }.buttonStyle(ButtonTapScale())
                                                .opacity(isEnableEdit ? 1 : 0)
                                                .animation(.easeInOut(duration: 0.1))
                                            ImageCustom(name: "grayImage", w: 144, h: 144)
                                                .opacity(isEnableEdit ? 0 : 1)
                                                .animation(.easeInOut(duration: 0.5))
                                        }
                                    } else {
                                        ZStack (alignment: .bottomTrailing) {
                                            ZStack {
                                                Rectangle().foregroundColor(.init(#colorLiteral(red: 0.9756801724, green: 0.9647900462, blue: 0.9644319415, alpha: 1)))
                                                WebImage(url: URL(string: URLAvatar))
                                                    .resizable()
                                            }.scaledToFill()
                                                .frame(width: W(144), height: W(144))
                                                .clipped()
                                                .cornerRadius(.infinity)
                                                .background(Rectangle().foregroundColor(.init(#colorLiteral(red: 0.9039022021, green: 0.9039022021, blue: 0.9039022021, alpha: 1))).cornerRadius(.infinity))
                                            Button(action: {
                                                self.isShowPopUp = true
                                            }) {
                                                ZStack {
                                                    Rectangle()
                                                        .foregroundColor(.init(isEnableEdit ? #colorLiteral(red: 0.2833439708, green: 0.1511963606, blue: 0.5081686378, alpha: 1): #colorLiteral(red: 0.6665948629, green: 0.6667092443, blue: 0.6665788293, alpha: 1)))
                                                        .frame(width: W(35), height: W(35))
                                                        .cornerRadius(.infinity)
                                                    ImageCustom(name: "cameraMini", w: 19, h: 14)
                                                }
                                            }.buttonStyle(ButtonTapScale())
                                                .disabled(isEnableEdit ? false : true)
                                                .offset(x: W(35) / 2 - W(144) / 4)
                                        }.animation(.easeInOut(duration: 0.1))
                                    }
                                } else {
                                    ZStack (alignment: .bottomTrailing) {
                                        image?
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: W(144), height: W(144))
                                            .clipped()
                                            .cornerRadius(.infinity)
                                        Button(action: {
                                            self.isShowPopUp = true
                                        }) {
                                            ZStack {
                                                Rectangle()
                                                    .foregroundColor(.init(isEnableEdit ? #colorLiteral(red: 0.2833439708, green: 0.1511963606, blue: 0.5081686378, alpha: 1): #colorLiteral(red: 0.6665948629, green: 0.6667092443, blue: 0.6665788293, alpha: 1)))
                                                    .frame(width: W(35), height: W(35))
                                                    .cornerRadius(.infinity)
                                                ImageCustom(name: "cameraMini", w: 19, h: 14)
                                            }
                                        }.buttonStyle(ButtonTapScale())
                                            .disabled(isEnableEdit ? false : true)
                                            .offset(x: W(35) / 2 - W(144) / 4)
                                    }.animation(.easeInOut(duration: 0.1))
                                }
                                Spacer()
                            }.padding(.bottom, H(22))
                                .animation(.easeInOut(duration: 0.1))
                            TextCustom(text: NSLocalizedString("account_title", comment: "").uppercased(), font: MEDIUM, size: 16, color: #colorLiteral(red: 0.4282599092, green: 0.1879977882, blue: 0.6717798114, alpha: 1))
                                .padding(.leading, 20)
                                .padding(.bottom, H(16))
                                .animation(.easeInOut(duration: 0.1))
                            VStack (alignment: .leading, spacing: H(18)) {
                                VStack (alignment: .leading, spacing: H(10)) {
                                    // MARK: EMAIL
                                    TextFieldInfo(
                                        pushKeyboard: $pushKeyboard,
                                        isEmpty: $isEmailEmpty,
                                        isWrong: $isEmailWrong,
                                        selectedIndex: $selectedIndex,
                                        value: $temp_strEmail,
                                        isEnableEdit: $isEnableEdit,
                                        isNextEditPass: $isNextEditPass,
                                        iconName: "infoEmail",
                                        label: "Email",
                                        holder: "example@gmail.com",
                                        isEmail: true,
                                        index: 0
                                    ).padding(.bottom, isEmailEmpty || isEmailWrong ? 0 : H(2))
                                    if isEmailEmpty || isEmailWrong {
                                        TextCustom(text: NSLocalizedString(isEmailEmpty ? "signup_warning_email" : "signup_checkWrong_email", comment: ""), font: REGULAR, size: 14, color: #colorLiteral(red: 0.9144201279, green: 0.29770872, blue: 0.2992521822, alpha: 1))
                                            .padding(.leading, 20)
                                    }
                                }
                                TextFieldInfo(
                                    pushKeyboard: $pushKeyboard,
                                    isEmpty: Binding.constant(false),
                                    isWrong: Binding.constant(false),
                                    selectedIndex: $selectedIndex,
                                    value: $temp_strPass,
                                    isEnableEdit: $isEnableEdit,
                                    isNextEditPass: $isNextEditPass,
                                    iconName: "infoLock",
                                    label: "info_pass",
                                    index: 1
                                ).padding(.bottom, H(2))
                                Rectangle()
                                    .frame(height: H(10))
                                    .foregroundColor(.init(#colorLiteral(red: 0.9636391997, green: 0.9496440291, blue: 0.9981387258, alpha: 1)))
                                    .padding(.bottom, H(2))
                                TextCustom(text: NSLocalizedString("info_sheets", comment: ""), font: MEDIUM, size: 16, color: #colorLiteral(red: 0.4282599092, green: 0.1879977882, blue: 0.6717798114, alpha: 1))
                                    .padding(.leading, 20)
                                    .padding(.bottom, H(2))
                                VStack (alignment: .leading, spacing: H(10)) {
                                    TextFieldInfo(
                                        pushKeyboard: $pushKeyboard,
                                        isEmpty: $isNameEmpty,
                                        isWrong: Binding.constant(false),
                                        selectedIndex: $selectedIndex,
                                        value: $temp_strName,
                                        isEnableEdit: $isEnableEdit,
                                        isNextEditPass: $isNextEditPass,
                                        iconName: "namePurple",
                                        label: "projectDetailHome_FullName",
                                        holder: "info_holderName",
                                        index: 2
                                    ).padding(.bottom, isNameEmpty ? 0 : H(2))
                                    if isNameEmpty {
                                        TextCustom(text: NSLocalizedString("sale_policy_contact_buy_input_nameUpper", comment: ""), font: REGULAR, size: 14, color: #colorLiteral(red: 0.9144201279, green: 0.29770872, blue: 0.2992521822, alpha: 1))
                                            .padding(.leading, 20)
                                    }
                                }
                                DatePickerInfo(
                                    selectedIndex: $selectedIndex,
                                    isShowDatePicker: $isShowDatePicker,
                                    date: $temp_dateBirth,
                                    isEnableEdit: $isEnableEdit,
                                    initValue: $initValue,
                                    index: 3
                                ).padding(.bottom, H(2))
                                TextFieldInfo(
                                    pushKeyboard: $pushKeyboard,
                                    isEmpty: Binding.constant(false),
                                    isWrong: Binding.constant(false),
                                    selectedIndex: $selectedIndex,
                                    value: $temp_strAddress,
                                    isEnableEdit: $isEnableEdit,
                                    isNextEditPass: $isNextEditPass,
                                    iconName: "addressPurple",
                                    label: "projectDetailHome_Address",
                                    holder: "info_holderAddress",
                                    index: 4
                                ).padding(.bottom, H(2))
                                VStack (alignment: .leading, spacing: H(10)) {
                                    TextFieldInfo(
                                        pushKeyboard: $pushKeyboard,
                                        isEmpty: Binding.constant(false),
                                        isWrong: $isPhoneWrong,
                                        selectedIndex: $selectedIndex,
                                        value: $temp_strPhone,
                                        isEnableEdit: $isEnableEdit,
                                        isNextEditPass: $isNextEditPass,
                                        iconName: "phonePurple",
                                        label: "info_phone",
                                        holder: "info_holderPhone",
                                        index: 5
                                    ).padding(.bottom, isPhoneWrong ? 0 : H(2))
                                    if isPhoneWrong {
                                        TextCustom(text: NSLocalizedString("signup_checkWrong_phone", comment: ""), font: REGULAR, size: 14, color: #colorLiteral(red: 0.9144201279, green: 0.29770872, blue: 0.2992521822, alpha: 1))
                                            .padding(.leading, 20)
                                    }
                                }
                                RadioInfo(gender: $temp_gender, isEnableEdit: $isEnableEdit)
                                    .padding(.bottom, H(2))
                                TextFieldInfo(
                                    pushKeyboard: $pushKeyboard,
                                    isEmpty: Binding.constant(false),
                                    isWrong: Binding.constant(false),
                                    selectedIndex: $selectedIndex,
                                    value: $temp_strJob,
                                    isEnableEdit: $isEnableEdit,
                                    isNextEditPass: $isNextEditPass,
                                    iconName: "jobPurple",
                                    label: "info_job",
                                    holder: "info_holderJob",
                                    index: 6
                                )
                            }.animation(.easeInOut(duration: 0.1))
                        }.padding(.top, H(14))
                            .padding(.bottom, H(
                                FULL_H == H_SE && FULL_W == W_SE ? 40: // iPhone SE 1st generation
                                FULL_H == H_8 && FULL_W == W_8 ? 40: // iPhone 8 && iPhone SE 2nd generation
                                FULL_H == H_8Plus && FULL_W == W_8Plus ? 40: // iPhone 8 Plus
                                FULL_H == H_11 && FULL_W == W_11 ? 20: // iPhone 11 && iPhone 11 Pro Max
                                FULL_H == H_11Pro && FULL_W == W_11Pro ? 20 : 0 // iPhone 11 Pro
                                    )
                            ).offset(y: keyboardHeight > 0 && !pushKeyboard.isEmpty ?
                                pushKeyboard == "projectDetailHome_FullName" ?
                                H(
                                    FULL_H == H_SE && FULL_W == W_SE ? -200: // iPhone SE 1st generation
                                    FULL_H == H_8 && FULL_W == W_8 ? -150: // iPhone 8 && iPhone SE 2nd generation
                                    FULL_H == H_8Plus && FULL_W == W_8Plus ? -110: // iPhone 8 Plus
                                    FULL_H == H_11 && FULL_W == W_11 ? -110: // iPhone 11 && iPhone 11 Pro Max
                                    FULL_H == H_11Pro && FULL_W == W_11Pro ? -130 : 0 // iPhone 11 Pro
                                ):
                                    pushKeyboard == "projectDetailHome_Address" ?
                                H(
                                    FULL_H == H_SE && FULL_W == W_SE ? -380: // iPhone SE 1st generation
                                    FULL_H == H_8 && FULL_W == W_8 ? -330: // iPhone 8 && iPhone SE 2nd generation
                                    FULL_H == H_8Plus && FULL_W == W_8Plus ? -290: // iPhone 8 Plus
                                    FULL_H == H_11 && FULL_W == W_11 ? -290: // iPhone 11 && iPhone 11 Pro Max
                                    FULL_H == H_11Pro && FULL_W == W_11Pro ? -310 : 0 // iPhone 11 Pro
                                ):
                                    pushKeyboard == "info_phone" ?
                                H(
                                    FULL_H == H_SE && FULL_W == W_SE ? -410: // iPhone SE 1st generation
                                    FULL_H == H_8 && FULL_W == W_8 ? -360: // iPhone 8 && iPhone SE 2nd generation
                                    FULL_H == H_8Plus && FULL_W == W_8Plus ? -320: // iPhone 8 Plus
                                    FULL_H == H_11 && FULL_W == W_11 ? -320: // iPhone 11 && iPhone 11 Pro Max
                                    FULL_H == H_11Pro && FULL_W == W_11Pro ? -340 : 0 // iPhone 11 Pro
                                ):
                                    pushKeyboard == "info_job" ?
                                H(
                                    FULL_H == H_SE && FULL_W == W_SE ? -420: // iPhone SE 1st generation
                                    FULL_H == H_8 && FULL_W == W_8 ? -370: // iPhone 8 && iPhone SE 2nd generation
                                    FULL_H == H_8Plus && FULL_W == W_8Plus ? -330: // iPhone 8 Plus
                                    FULL_H == H_11 && FULL_W == W_11 ? -330: // iPhone 11 && iPhone 11 Pro Max
                                    FULL_H == H_11Pro && FULL_W == W_11Pro ? -350 : 0 // iPhone 11 Pro
                                ): 0: 0)
                    }.resignKeyboardOnDragGesture()
                }
                Rectangle()
                    .edgesIgnoringSafeArea(.all)
                    .opacity(isShowPopupSaveSuccess || isShowPopUpBackConfirm || isShowDatePicker || isShowPopUp ? 0.5 : 0)
                    .animation(.easeInOut(duration: 0.2))
                    .onTapGesture {
                        self.isShowDatePicker = false
                        self.isShowPopUp = false
                        self.isShowPopUpBackConfirm = false
                }
                InfoPicturePick(isShowPopUp: $isShowPopUp, isShowLibrary: $isShowLibrary, sourceType: $sourceType)
                    .sheet(isPresented: self.$isShowLibrary) {
                        ImagePicker(isVisible: self.$isShowLibrary, image: self.$image, uiImg: self.$uiImg, sourceType: self.sourceType)
                }
                // MARK: POPUP BACK CONFIRM
                ShowBackPopup(isShowPopUpBackConfirm: $isShowPopUpBackConfirm, isNextOld: $isNextOld)

                // MARK: DATE PICKER
                ShowDatePickerInfo(date: $temp_dateBirth, isShowDatePicker: $isShowDatePicker, initValue: $initValue)
                NavigationLink(destination:
                        ChangePassView(
                            isNextOld: $isNextEditPass,
                            isAlreadyChangePass: $isAlreadyChangePass
                        ), isActive: $isNextEditPass) {
                    EmptyView()
                }
            }.keyboardAppear(keyboardHeight: $keyboardHeight)
                .onAppear {
                    self.temp_strEmail = self.strEmail
                    self.temp_strPass = self.strPass
                    self.temp_strName = self.strName
                    self.temp_dateBirth = self.dateBirth
                    self.temp_strAddress = self.strAddress
                    self.temp_strPhone = self.strPhone
                    self.temp_gender = self.gender
                    self.temp_strJob = self.strJob
                }.onTapGesture {
                    self.selectedIndex = -1
                    UIApplication.shared.endEditing()
                }.navigationBarBackButtonHidden(true)
                .navigationBarTitle("")
                .navigationBarHidden(true)
        }.navigationBarBackButtonHidden(true)
            .navigationBarTitle("")
            .navigationBarHidden(true)
    }

    func saveInfo() {
        UIApplication.shared.endEditing()
        // MARK: EMAIL
        if self.temp_strEmail.isEmpty {
            self.isEmailEmpty = true
        } else {
            self.isEmailEmpty = false
            if Utils.isValidEmail(email: self.temp_strEmail) {
                self.isEmailWrong = false
            } else {
                self.isEmailWrong = true
            }
        }

        // MARK: NAME
        if self.temp_strName.isEmpty {
            self.isNameEmpty = true
        } else {
            self.isNameEmpty = false
        }

        // MARK: PHONE
        if !self.temp_strPhone.isEmpty {
            if formattedNumberPhone(number: temp_strPhone).count == 12 {
                self.isPhoneWrong = false
            } else {
                self.isPhoneWrong = true
            }
        }

        // MARK: RESULT
        if !self.isEmailEmpty && !self.isEmailWrong && !self.isNameEmpty && !self.isPhoneWrong {
            self.isEnableEdit = false

            self.strEmail = self.temp_strEmail
            self.strPass = self.temp_strPass
            self.strName = self.temp_strName
            self.dateBirth = self.temp_dateBirth
            self.strAddress = self.temp_strAddress
            self.strPhone = self.temp_strPhone
            self.gender = self.temp_gender
            self.strJob = self.temp_strJob
        }
    }
}

struct TextFieldInfo: View {
    @Binding var pushKeyboard: String
    @Binding var isEmpty: Bool
    @Binding var isWrong: Bool
    @Binding var selectedIndex: Int
    @Binding var value: String
    @Binding var isEnableEdit: Bool
    @Binding var isNextEditPass: Bool

    @State var iconName = ""
    @State var label = ""
    @State var holder = ""
    @State var isEmail = false
    @State var index = 0
    @State var isClear = false
    @State var fakePass = "123456"

    var body: some View {
        VStack (alignment: .leading, spacing: H(10)) {
            HStack (spacing: 8) {
                ImageCustom(name: iconName, w: 18, h: 18)
                TextCustom(text: NSLocalizedString(label, comment: ""), font: MEDIUM, size: 16, lineLimit: 1, color: #colorLiteral(red: 0.1400775909, green: 0.1216219291, blue: 0.1212796792, alpha: 1))
                if label == "info_pass" {
                    Spacer()
                    Button(action: {
                        self.isNextEditPass = true
                    }) {
                        TextCustomUnderLine(text: NSLocalizedString("info_changePass", comment: ""), font: REGULAR, size: 14, color: isEnableEdit ? #colorLiteral(red: 0.3190362453, green: 0.7693782449, blue: 0.442176193, alpha: 1): #colorLiteral(red: 0.4117182493, green: 0.4117922187, blue: 0.4117078185, alpha: 1))
                    }.buttonStyle(ButtonTapScale())
                        .padding(.trailing, 20)
                        .disabled(isEnableEdit ? false : true)
                }
            }
            ZStack (alignment: .leading) {
                if label != "info_pass" {
                    TextCustom(text: "---", font: REGULAR, size: 16, color: #colorLiteral(red: 0.3450582027, green: 0.3451215923, blue: 0.3450492918, alpha: 1))
                        .opacity(value.isEmpty && !isEnableEdit ? 1 : 0)
                        .padding(.leading, 16)
                }
                TextCustom(text: NSLocalizedString(holder, comment: ""), font: REGULAR, size: 16, color: #colorLiteral(red: 0.3450582027, green: 0.3451215923, blue: 0.3450492918, alpha: 1))
                    .opacity(value.isEmpty && isEnableEdit ? 1 : 0)
                    .padding(.leading, 16)
                if label == "info_phone" {
                    TFPhoneNumner(font: MEDIUM, size: 16, color: #colorLiteral(red: 0.1400775909, green: 0.1216219291, blue: 0.1212796792, alpha: 1), changeHandler: { rs in
                            self.value = rs
                        }, didBeginEditing: { _ in
                            self.pushKeyboard = self.label
                            self.selectedIndex = self.index
                        }, didEndEditing: { _ in
                            self.pushKeyboard = ""
                            self.selectedIndex = -1
                        }, isClear: $isClear, value: $value, isEnableEdit: $isEnableEdit)
                        .padding(.trailing, 39)
                        .padding(.leading, 16)
                        .frame(height: H(40))
                } else {
                    if label == "info_pass" {
                        SecureField("", text: $fakePass)
                            .disabled(true)
                            .font(.custom(MEDIUM, size: H(16)))
                            .foregroundColor(.init(#colorLiteral(red: 0.1400775909, green: 0.1216219291, blue: 0.1212796792, alpha: 1)))
                            .padding(.leading, 16)
                            .padding(.trailing, 39)
                    } else {
                        TextField("", text: $value, onEditingChanged: { rs in
                            if rs {
                                if self.label != "Email" {
                                    self.pushKeyboard = self.label
                                } else {
                                    self.pushKeyboard = ""
                                }
                                self.selectedIndex = self.index
                            } else {
                                self.pushKeyboard = ""
                                self.selectedIndex = -1
                            }
                        }).disabled(isEnableEdit && label != "info_pass" ? false : true)
                            .keyboardType(isEmail ? .emailAddress : .default)
                            .font(.custom(MEDIUM, size: H(16)))
                            .foregroundColor(.init(#colorLiteral(red: 0.1400775909, green: 0.1216219291, blue: 0.1212796792, alpha: 1)))
                            .padding(.leading, 16)
                            .padding(.trailing, 39)
                    }
                }
                if isEnableEdit {
                    HStack(spacing: 16) {
                        Spacer()
                        Button(action: {
                            if self.label == "info_phone" {
                                self.isClear = true
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                    self.isClear = false
                                }
                            }
                            self.value = ""
                        }) {
                            ImageCustom(name: "iconIonicMdCloseCircleOutline", w: 13, h: 13)
                        }.buttonStyle(ButtonTapScale())
                            .opacity(value.isEmpty ? 0 : 1)
                            .animation(.easeInOut(duration: 0.1))
                    }.padding(.trailing, 16)
                }
            }.frame(width: FULL_W - 40, height: H(40))
                .background(Color.init(isEnableEdit && label != "info_pass" ? #colorLiteral(red: 0.999894917, green: 1, blue: 0.999871552, alpha: 1): #colorLiteral(red: 0.9756801724, green: 0.9647900462, blue: 0.9644319415, alpha: 1)))
                .overlay(
                    RoundedRectangle(cornerRadius: 4).stroke(Color.init(
                        isEmpty || isWrong ? #colorLiteral(red: 0.9328963161, green: 0.2516918182, blue: 0.2457951307, alpha: 1):
                            isEnableEdit && label != "info_pass" ? selectedIndex == index ? #colorLiteral(red: 0.4281106591, green: 0.1894766092, blue: 0.6721540093, alpha: 1): #colorLiteral(red: 0.8469690681, green: 0.847112, blue: 0.8469489217, alpha: 1): #colorLiteral(red: 0.8469690681, green: 0.847112, blue: 0.8469489217, alpha: 1)), lineWidth: 1)
                )
        }.padding(.leading, 20)
            .animation(.easeInOut(duration: 0.1))
    }
}
