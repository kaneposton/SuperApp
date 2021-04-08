// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import SwiftUI

struct ChangePassView: View {
    @Binding var isNextOld: Bool
    @Binding var isAlreadyChangePass: Bool

    @State var isStartAnimation = false
    @State var strNewPass = ""
    @State var strNewPassRe = ""
    @State var isPassEmpty = true
    @State var isShowPopup = false
    @State var isHidePass = true
    @State var isHideRePass = true
    @State var isWrong = false
    @State var selectedIndex = -1

    @State var keyboardHeight: CGFloat = 0

    var body: some View {
        ZStack (alignment: .top) {
            if keyboardHeight <= 0 {
                Text("").onAppear {
                    self.selectedIndex = -1
                }
            }
            if !strNewPass.isEmpty && !strNewPassRe.isEmpty {
                Text("").onAppear {
                    self.isPassEmpty = false
                }
            }
            if strNewPass.isEmpty || strNewPassRe.isEmpty {
                Text("").onAppear {
                    self.isPassEmpty = true
                }
            }
            if !strNewPass.isEmpty && strNewPass == strNewPassRe {
                Text("").onAppear {
                    self.isWrong = false
                }
            }
            VStack (alignment: .leading, spacing: 0) {
                HStack {
                    Button(action: {
                        self.isNextOld = false
                    }) {
                        HStack (spacing: 14) {
                            ImageCustom(name: "backBlack", w: 20, h: 11)
                            TextCustom(text: NSLocalizedString("info_changePass", comment: ""), size: 24, lineLimit: 1, color: #colorLiteral(red: 0.1422221363, green: 0.1236664429, blue: 0.1232500449, alpha: 1))
                        }
                    }.buttonStyle(ButtonTapScale())
                    Spacer()
                    Button(action: {
                        self.checkPass()
                    }) {
                        TextCustom(text: NSLocalizedString("info_save", comment: ""), font: MEDIUM, size: 18, color: isPassEmpty ? #colorLiteral(red: 0.6534755826, green: 0.6314619184, blue: 0.6309846044, alpha: 1): #colorLiteral(red: 0.4282599092, green: 0.1879977882, blue: 0.6717798114, alpha: 1))
                    }.buttonStyle(ButtonTapScale())
                        .disabled(isPassEmpty ? true : false)
                }.animation(isStartAnimation ? .easeInOut(duration: 0.1) : .none)
                    .padding(.horizontal, 20)
                    .background(Color.white)
                    .padding(.top, H(16))
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.init(#colorLiteral(red: 0.6534755826, green: 0.6314619184, blue: 0.6309846044, alpha: 1)))
                    .padding(.top, H(12))
                    .padding(.bottom, H(24))
                HStack {
                    Spacer()
                    ImageCustom(name: "passwordPurple", w: 144, h: 144)
                    Spacer()
                }.padding(.bottom, H(28))
                TextCustom(text: NSLocalizedString("info_inputPassTwice", comment: ""), font: REGULAR, size: 16, color: #colorLiteral(red: 0.1400775909, green: 0.1216219291, blue: 0.1212796792, alpha: 1))
                    .padding(.horizontal, 20)
                    .padding(.bottom, H(16))
                ZStack (alignment: .leading) {
                    TextCustom(text: NSLocalizedString("info_inputPassNew", comment: ""), font: REGULAR, size: 16, color: #colorLiteral(red: 0.3450582027, green: 0.3451215923, blue: 0.3450492918, alpha: 1))
                        .opacity(strNewPass.isEmpty ? 1 : 0)
                        .padding(.leading, 16)
                    ZStack {
                        SecureField("", text: $strNewPass)
                            .font(.custom(BOLD, size: H(16)))
                            .foregroundColor(.init(#colorLiteral(red: 0.1400775909, green: 0.1216219291, blue: 0.1212796792, alpha: 1)))
                            .opacity(isHidePass ? 1 : 0)
                            .onTapGesture {
                                self.selectedIndex = 1
                        }
                        TextField("", text: $strNewPass, onEditingChanged: { rs in
                            if rs {
                                self.selectedIndex = 1
                            } else {
                                self.selectedIndex = -1
                            }
                        }).font(.custom(BOLD, size: H(16)))
                            .foregroundColor(.init(#colorLiteral(red: 0.1400775909, green: 0.1216219291, blue: 0.1212796792, alpha: 1)))
                            .opacity(isHidePass ? 0 : 1)
                    }.padding(.leading, 16)
                        .padding(.trailing, 67)
                    HStack(spacing: 12) {
                        Spacer()
                        Button(action: {
                            self.strNewPass = ""
                        }) {
                            ImageCustom(name: "iconIonicMdCloseCircleOutline", w: 13, h: 13)
                        }.buttonStyle(ButtonTapScale())
                            .opacity(strNewPass.isEmpty ? 0 : 1)
                        Button(action: {
                            self.isHidePass.toggle()
                        }) {
                            ImageCustom(name: isHidePass ? "014Vision1" : "015Vision", w: 16, h: isHidePass ? 14.3 : 10)
                        }.buttonStyle(ButtonTapScale())
                    }.animation(.easeInOut(duration: 0.1))
                        .padding(.trailing, 16)
                }.frame(width: FULL_W - 40, height: H(40))
                    .background(Color.init(#colorLiteral(red: 0.999894917, green: 1, blue: 0.999871552, alpha: 1)))
                    .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.init(isWrong ? #colorLiteral(red: 0.9328963161, green: 0.2516918182, blue: 0.2457951307, alpha: 1): selectedIndex == 1 ? #colorLiteral(red: 0.4282599092, green: 0.1879977882, blue: 0.6717798114, alpha: 1): #colorLiteral(red: 0.8469690681, green: 0.847112, blue: 0.8469489217, alpha: 1)), lineWidth: 1))
                    .padding(.bottom, H(16))
                    .padding(.leading, 20)
                ZStack (alignment: .leading) {
                    TextCustom(text: NSLocalizedString("info_inputPassNewRe", comment: ""), font: REGULAR, size: 16, color: #colorLiteral(red: 0.3450582027, green: 0.3451215923, blue: 0.3450492918, alpha: 1))
                        .opacity(strNewPassRe.isEmpty ? 1 : 0)
                        .padding(.leading, 16)
                    ZStack {
                        SecureField("", text: $strNewPassRe, onCommit: {
                            self.checkPass()
                        }).font(.custom(BOLD, size: H(16)))
                            .foregroundColor(.init(#colorLiteral(red: 0.1400775909, green: 0.1216219291, blue: 0.1212796792, alpha: 1)))
                            .opacity(isHideRePass ? 1 : 0)
                            .onTapGesture {
                                self.selectedIndex = 2
                        }
                        TextField("", text: $strNewPassRe, onEditingChanged: { rs in
                            if rs {
                                self.selectedIndex = 2
                            } else {
                                self.selectedIndex = -1
                            }
                        }, onCommit: {
                                self.checkPass()
                            }).font(.custom(BOLD, size: H(16)))
                            .foregroundColor(.init(#colorLiteral(red: 0.1400775909, green: 0.1216219291, blue: 0.1212796792, alpha: 1)))
                            .opacity(isHideRePass ? 0 : 1)
                    }.padding(.leading, 16)
                        .padding(.trailing, 67)
                    HStack(spacing: 12) {
                        Spacer()
                        Button(action: {
                            self.strNewPassRe = ""
                        }) {
                            ImageCustom(name: "iconIonicMdCloseCircleOutline", w: 13, h: 13)
                        }.buttonStyle(ButtonTapScale())
                            .opacity(strNewPassRe.isEmpty ? 0 : 1)
                        Button(action: {
                            self.isHideRePass.toggle()
                        }) {
                            ImageCustom(name: isHideRePass ? "014Vision1" : "015Vision", w: 16, h: isHideRePass ? 14.3 : 10)
                        }.buttonStyle(ButtonTapScale())
                    }.animation(.easeInOut(duration: 0.1))
                        .padding(.trailing, 16)
                }.frame(width: FULL_W - 40, height: H(40))
                    .background(Color.init(#colorLiteral(red: 0.999894917, green: 1, blue: 0.999871552, alpha: 1)))
                    .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.init(isWrong ? #colorLiteral(red: 0.9328963161, green: 0.2516918182, blue: 0.2457951307, alpha: 1): selectedIndex == 2 ? #colorLiteral(red: 0.4282599092, green: 0.1879977882, blue: 0.6717798114, alpha: 1): #colorLiteral(red: 0.8469690681, green: 0.847112, blue: 0.8469489217, alpha: 1)), lineWidth: 1))
                    .padding(.leading, 20)
                TextCustom(text: NSLocalizedString("info_wrong", comment: ""), font: REGULAR, size: 14, color: #colorLiteral(red: 0.9144201279, green: 0.29770872, blue: 0.2992521822, alpha: 1))
                    .opacity(isWrong ? 1 : 0)
                    .padding(.leading, 20)
                    .padding(.top, H(7))
                Spacer()
            }
            Rectangle()
                .edgesIgnoringSafeArea(.all)
                .opacity(isShowPopup ? 0.5 : 0)
                .animation(.easeInOut(duration: 0.2))
                .onTapGesture {
                    self.isShowPopup = false
                    self.isAlreadyChangePass = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        self.isNextOld = false
                    }
            }
            VStack {
                Spacer()
                showChangePassSuccess(isAlreadyChangePass: $isAlreadyChangePass, isShowPopup: $isShowPopup, isNextOld: $isNextOld)
                Spacer()
            }
        }.keyboardAppear(keyboardHeight: $keyboardHeight)
            .background(Color.white)
            .onTapGesture {
                self.selectedIndex = -1
                UIApplication.shared.endEditing()
            }.onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    self.isStartAnimation = true
                }
            }.navigationBarBackButtonHidden(true)
            .navigationBarTitle("")
            .navigationBarHidden(true)
    }

    func checkPass() {
        if self.strNewPass == self.strNewPassRe {
            UIApplication.shared.endEditing()
            self.isShowPopup = true
        } else {
            self.isWrong = true
        }
    }
}

struct showChangePassSuccess: View {
    @Binding var isAlreadyChangePass: Bool
    @Binding var isShowPopup: Bool
    @Binding var isNextOld: Bool

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
                    .padding(.bottom, H(10))
                    .offset(x: -0.5)
                TextCustom(text: NSLocalizedString("info_success", comment: ""), size: 18, color: #colorLiteral(red: 0.4282599092, green: 0.1879977882, blue: 0.6717798114, alpha: 1))
                TextCustom(text: NSLocalizedString("info_successSmall", comment: ""), font: REGULAR, size: 16, color: #colorLiteral(red: 0.1400775909, green: 0.1216219291, blue: 0.1212796792, alpha: 1))
                    .padding(.top, H(17))
                    .padding(.horizontal, 38)
                    .padding(.bottom, H(28))
            }
            Button(action: {
                self.isShowPopup = false
                self.isAlreadyChangePass = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    self.isNextOld = false
                }
            }) {
                ZStack {
                    Rectangle()
                        .foregroundColor(.init(#colorLiteral(red: 0.4282599092, green: 0.1879977882, blue: 0.6717798114, alpha: 1)))
                        .frame(width: FULL_W - 60, height: H(40))
                        .cornerRadius(4)
                    TextCustom(text: NSLocalizedString("login_close", comment: ""), font: MEDIUM, size: 16, color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
                }
            }.buttonStyle(ButtonTapScale())
                .animation(.easeInOut(duration: 0.1))
        }.padding(.bottom, H(16))
            .background(
                Image("union150")
                    .resizable()
                    .frame(width: FULL_W - 42)
                    .shadow(color: .init(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2016802226)), radius: 6)
            ).scaleEffect(isShowPopup ? 1 : 0.1)
            .opacity(isShowPopup ? 1 : 0)
            .animation(.easeInOut(duration: 0.2))
    }
}
