// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import SwiftUI

struct SalePolicyContactBuy: View {
    @Binding var isNextOld: Bool
    @Binding var isRoot: Bool

    @State var strSearch = ""
    @State var strName = ""
    @State var strPhone = ""
    @State var isNextFinishBuy = false
    @State var isClear = false
    @State var isStrNameEmptyConfirm = false
    @State var isStrPhoneEmptyConfirm = false
    @State var isStrPhoneWrongConfirm = false
    @State var isEnableEdit = true

    var body: some View {
        NavigationView {
            ZStack (alignment: .top) {
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
                Rectangle()
                    .foregroundColor(.white)
                    .edgesIgnoringSafeArea(.all)
                VStack(spacing: 0) {
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.init(#colorLiteral(red: 0.6533299685, green: 0.6326879859, blue: 0.6321712136, alpha: 1)))
                        .padding(.top, H(64))
                    VStack(spacing: 0) {
                        TextCustom(text: NSLocalizedString("sale_policy_contact_buy_text", comment: ""), font: ITALIC, size: 14, color: #colorLiteral(red: 0.1422221363, green: 0.1236664429, blue: 0.1232500449, alpha: 1))
                            .padding(.top, H(81))
                            .padding(.bottom, H(20))
                            .padding(.horizontal, 59)
                            .multilineTextAlignment(.center)
                        TextCustom(text: "\(NSLocalizedString("sale_policy_contact_buy_call", comment: "")) 0909 123 456", size: 24, color: #colorLiteral(red: 0.4263509512, green: 0.1872772872, blue: 0.6715394855, alpha: 1))
                            .padding(.bottom, H(40.5))
                        VStack(alignment: .leading, spacing: 0) {
                            HStack (spacing: 17) {
                                TextCustom(text: NSLocalizedString("sale_policy_contact_buy_name", comment: ""), font: MEDIUM, size: 16, color: #colorLiteral(red: 0.1415808201, green: 0.1235596463, blue: 0.1233097687, alpha: 1))
                                ZStack (alignment: .leading) {
                                    TextCustom(text: NSLocalizedString("sale_policy_contact_buy_input_name", comment: ""), font: ITALIC, size: 16, color: #colorLiteral(red: 0.665820241, green: 0.6659018993, blue: 0.6657924652, alpha: 1))
                                        .opacity(strName.isEmpty ? 1 : 0)
                                    TextField("", text: $strName)
                                        .foregroundColor(.init(#colorLiteral(red: 0.1415808201, green: 0.1235596463, blue: 0.1233097687, alpha: 1)))
                                        .font(.custom(MEDIUM, size: H(16)))
                                        .padding(.trailing, 23)
                                        .frame(height: H(16))
                                    HStack {
                                        Spacer()
                                        Button(action: {
                                            self.strName = ""
                                        }) {
                                            ZStack (alignment: .trailing) {
                                                ImageCustom(name: "EmptyPicture", w: 19, h: 13)
                                                ImageCustom(name: "deleteAll", w: 14, h: 14)
                                            }
                                        }.buttonStyle(ButtonTapScale())
                                            .animation(.easeInOut(duration: 0.1))
                                            .offset(x: W(-3.5))
                                            .opacity(strName.isEmpty ? 0 : 1)
                                    }
                                }
                            }.padding(.horizontal, 36.5)
                                .padding(.bottom, H(15))
                            Rectangle()
                                .frame(width: FULL_W - 73, height: 1)
                                .foregroundColor(.init(!isStrNameEmptyConfirm ? #colorLiteral(red: 0.66581285, green: 0.6659106016, blue: 0.6657914519, alpha: 1): #colorLiteral(red: 0.8844479918, green: 0.2379874587, blue: 0.2341234982, alpha: 1)))
                                .padding(.bottom, H(isStrNameEmptyConfirm ? 0 : 31))
                                .padding(.leading, 36.5)
                            if isStrNameEmptyConfirm {
                                TextCustom(text: NSLocalizedString("sale_policy_contact_buy_input_nameUpper", comment: ""), font: REGULAR, size: 14, color: #colorLiteral(red: 0.8844479918, green: 0.2379874587, blue: 0.2341234982, alpha: 1))
                                    .fixedSize(horizontal: true, vertical: false)
                                    .padding(.top, H(10))
                                    .padding(.bottom, H(31))
                                    .padding(.leading, 36.5)
                            }
                            HStack (spacing: 17) {
                                TextCustom(text: NSLocalizedString("sale_policy_contact_buy_numberphone", comment: ""), font: MEDIUM, size: 16, color: #colorLiteral(red: 0.1415808201, green: 0.1235596463, blue: 0.1233097687, alpha: 1))
                                ZStack (alignment: .leading) {
                                    TextCustom(text: NSLocalizedString("sale_policy_contact_buy_input_number", comment: ""), font: ITALIC, size: 16, color: #colorLiteral(red: 0.665820241, green: 0.6659018993, blue: 0.6657924652, alpha: 1))
                                        .opacity(strPhone.isEmpty ? 1 : 0)
                                    TFPhoneNumner(font: MEDIUM, size: 16, color: #colorLiteral(red: 0.1415808201, green: 0.1235596463, blue: 0.1233097687, alpha: 1), changeHandler: { rs in
                                            self.strPhone = rs
                                        }, didBeginEditing: { _ in }, didEndEditing: { _ in }, isClear: $isClear, value: self.$strPhone, isEnableEdit: self.$isEnableEdit)
                                        .padding(.trailing, 23)
                                        .frame(height: H(16))
                                    HStack {
                                        Spacer()
                                        Button(action: {
                                            self.isClear = true
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                                self.isClear = false
                                            }
                                            self.strPhone = ""
                                        }) {
                                            ZStack (alignment: .trailing) {
                                                ImageCustom(name: "EmptyPicture", w: 19, h: 13)
                                                ImageCustom(name: "deleteAll", w: 14, h: 14)
                                            }
                                        }.buttonStyle(ButtonTapScale())
                                            .animation(.easeInOut(duration: 0.1))
                                            .offset(x: W(-3.5))
                                            .opacity(strPhone.isEmpty ? 0 : 1)
                                    }
                                }
                            }.padding(.horizontal, 36.5)
                                .padding(.bottom, H(15))
                            Rectangle()
                                .frame(width: FULL_W - 73, height: 1)
                                .foregroundColor(.init(!isStrPhoneEmptyConfirm && !isStrPhoneWrongConfirm ? #colorLiteral(red: 0.66581285, green: 0.6659106016, blue: 0.6657914519, alpha: 1): #colorLiteral(red: 0.8844479918, green: 0.2379874587, blue: 0.2341234982, alpha: 1)))
                                .padding(.leading, 36.5)
                            if isStrPhoneEmptyConfirm || isStrPhoneWrongConfirm {
                                TextCustom(text: NSLocalizedString(isStrPhoneEmptyConfirm ? "signup_warning_phone" : "signup_checkWrong_phone", comment: ""), font: REGULAR, size: 14, color: #colorLiteral(red: 0.8844479918, green: 0.2379874587, blue: 0.2341234982, alpha: 1))
                                    .fixedSize(horizontal: true, vertical: false)
                                    .padding(.top, H(10))
                                    .padding(.leading, 36.5)
                            }
                        }.padding(.bottom, H(40.5))
                        Button(action: {
                            UIApplication.shared.endEditing()
                            if self.strName.isEmpty {
                                self.isStrNameEmptyConfirm = true
                            }
                            if self.strPhone.isEmpty {
                                self.isStrPhoneEmptyConfirm = true
                            } else if formattedNumberPhone(number: self.strPhone).count < 12 {
                                self.isStrPhoneWrongConfirm = true
                            }
                            if !self.isStrNameEmptyConfirm && !self.isStrPhoneEmptyConfirm && !self.isStrPhoneWrongConfirm {
                                self.isNextFinishBuy = true
                            }
                        }) {
                            ZStack {
                                Rectangle()
                                    .foregroundColor(.init(#colorLiteral(red: 0.4263509512, green: 0.1872772872, blue: 0.6715394855, alpha: 1)))
                                    .frame(width: FULL_W - 72, height: H(40))
                                    .cornerRadius(4)
                                    .shadow(color: Color.init(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2018942637)), radius: 6, x: 3, y: 3)
                                TextCustom(text: NSLocalizedString("sale_policy_contact_buy_regist", comment: ""), font: MEDIUM, size: 18, color: #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0))
                            }
                        }.buttonStyle(ButtonTapScale())
                            .animation(.easeInOut(duration: 0.1))
                    }
                    Spacer()
                }

                //MARK: NAVIGATION BAR
                NavigationWhite(
                    isTapSearch: Binding.constant(false),
                    isLogin: Binding.constant(false),
                    isChangeColor: Binding.constant(false),
                    isOpenSideMenu: Binding.constant(false),
                    strSearch: Binding.constant(""),
                    isShowCalendar: Binding.constant(false),
                    isChooseValueDate: Binding.constant(false),
                    title: "sale_policy_contact_buy",
                    backFunc: {
                        self.isNextOld = false
                        UIApplication.shared.endEditing()
                    },
                    mapFunc: { },
                    filterFunc: { },
                    optionFunc: { },
                    callFunc: { },
                    textFunc: { },
                    isCallAndTextBlack: true,
                    noCallAndText: true
                )
                NavigationLink(destination:
                        SalePolicyContactBuyFinish(isNextOld: $isNextFinishBuy, isRoot: $isRoot), isActive: $isNextFinishBuy) {
                    EmptyView()
                }
            }.onTapGesture {
                UIApplication.shared.endEditing()
            }.navigationBarHidden(true)
                .navigationBarTitle("")
                .navigationBarBackButtonHidden(true)
                .edgesIgnoringSafeArea(.bottom)
        }.navigationBarHidden(true)
            .navigationBarTitle("")
            .navigationBarBackButtonHidden(true)
    }
}
