// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import SwiftUI

struct DatePickerInfo: View {
    @Binding var selectedIndex: Int
    @Binding var isShowDatePicker: Bool
    @Binding var date: Date
    @Binding var isEnableEdit: Bool
    @Binding var initValue: Int
    @State var index = 0

    var dateFormatter: DateFormatter {
        let df = DateFormatter()
        df.dateFormat = "dd/MM/yyyy"
        return df
    }

    var body: some View {
        VStack (alignment: .leading, spacing: H(10)) {
            HStack (spacing: 8) {
                ImageCustom(name: "dobPurple", w: 18, h: 18)
                TextCustom(text: NSLocalizedString("info_birth", comment: ""), font: MEDIUM, size: 16, lineLimit: 1, color: #colorLiteral(red: 0.1400775909, green: 0.1216219291, blue: 0.1212796792, alpha: 1))
            }
            Button(action: {
                self.selectedIndex = self.index
                UIApplication.shared.endEditing()
                self.isShowDatePicker = true
            }) {
                ZStack (alignment: .leading) {
                    HStack {
                        Spacer()
                        ImageCustom(name: "calendar", w: 14.7, h: 16)
                            .padding(.trailing, 16)
                    }
                    TextCustom(text: "---", font: REGULAR, size: 16, color: #colorLiteral(red: 0.3450582027, green: 0.3451215923, blue: 0.3450492918, alpha: 1))
                        .opacity(initValue == 1 && !isEnableEdit ? 1 : 0)
                        .padding(.leading, 16)
                    TextCustom(text: NSLocalizedString("info_holderBirth", comment: ""), font: REGULAR, size: 16, color: #colorLiteral(red: 0.3450582027, green: 0.3451215923, blue: 0.3450492918, alpha: 1))
                        .opacity(initValue == 1 && isEnableEdit ? 1 : 0)
                        .padding(.leading, 16)
                    Text("\(date, formatter: dateFormatter)")
                        .foregroundColor(.init(#colorLiteral(red: 0.1422221363, green: 0.1236664429, blue: 0.1232500449, alpha: 1)))
                        .font(.custom(MEDIUM, size: H(14)))
                        .opacity(initValue != 1 ? 1 : 0)
                        .padding(.leading, 16)
                }.frame(width: FULL_W - 40, height: H(40), alignment: .leading)
                    .background(Color.init(isEnableEdit ? #colorLiteral(red: 0.999894917, green: 1, blue: 0.999871552, alpha: 1): #colorLiteral(red: 0.9756801724, green: 0.9647900462, blue: 0.9644319415, alpha: 1)))
                    .overlay(
                        RoundedRectangle(cornerRadius: 4).stroke(Color.init(isEnableEdit ? selectedIndex == index ? #colorLiteral(red: 0.4281106591, green: 0.1894766092, blue: 0.6721540093, alpha: 1): #colorLiteral(red: 0.8469690681, green: 0.847112, blue: 0.8469489217, alpha: 1): #colorLiteral(red: 0.8469690681, green: 0.847112, blue: 0.8469489217, alpha: 1)), lineWidth: 1)
                    )
            }.buttonStyle(ButtonTapScale())
                .animation(.easeInOut(duration: 0.1))
                .disabled(isEnableEdit ? false : true)
        }.padding(.leading, 20)
            .animation(.easeInOut(duration: 0.1))
    }
}

struct RadioInfo: View {
    @Binding var gender: Int
    @Binding var isEnableEdit: Bool

    var body: some View {
        VStack (alignment: .leading, spacing: H(10)) {
            HStack (spacing: 8) {
                ImageCustom(name: "genderPurple", w: 18, h: 18)
                TextCustom(text: NSLocalizedString("info_gender", comment: ""), font: MEDIUM, size: 16, lineLimit: 1, color: #colorLiteral(red: 0.1400775909, green: 0.1216219291, blue: 0.1212796792, alpha: 1))
            }.animation(.easeInOut(duration: 0.1))
            ZStack {
                HStack {
                    Button(action: {
                        if self.gender == 0 {
                            self.gender = -1
                        } else {
                            self.gender = 0
                        }
                    }) {
                        HStack (spacing: 7) {
                            ZStack {
                                Rectangle()
                                    .foregroundColor(.init(gender == 0 ? #colorLiteral(red: 0.4282599092, green: 0.1879977882, blue: 0.6717798114, alpha: 1): isEnableEdit ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1): #colorLiteral(red: 0.9756801724, green: 0.9647900462, blue: 0.9644319415, alpha: 1)))
                                    .frame(width: W(15), height: W(15))
                                    .cornerRadius(.infinity)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: .infinity).stroke(Color.init(gender == 0 ? #colorLiteral(red: 0.4282599092, green: 0.1879977882, blue: 0.6717798114, alpha: 1): isEnableEdit ? #colorLiteral(red: 0.8469690681, green: 0.847112, blue: 0.8469489217, alpha: 1): #colorLiteral(red: 0.8469690681, green: 0.847112, blue: 0.8469489217, alpha: 1)), lineWidth: 1)
                                    )
                                ImageCustom(name: "checkRadio", w: 9, h: 7)
                                    .opacity(gender == 0 ? 1 : 0)
                            }
                            TextCustom(text: NSLocalizedString("info_male", comment: ""), font: MEDIUM, size: 16, color: #colorLiteral(red: 0.05096982419, green: 0.0509866029, blue: 0.05096747726, alpha: 1))
                        }
                    }.buttonStyle(ButtonTapScale())
                        .animation(.easeInOut(duration: 0.1))
                        .disabled(isEnableEdit ? false : true)
                    Spacer()
                }

                Button(action: {
                    if self.gender == 1 {
                        self.gender = -1
                    } else {
                        self.gender = 1
                    }
                }) {
                    HStack (spacing: 7) {
                        ZStack {
                            Rectangle()
                                .foregroundColor(.init(gender == 1 ? #colorLiteral(red: 0.4282599092, green: 0.1879977882, blue: 0.6717798114, alpha: 1): isEnableEdit ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1): #colorLiteral(red: 0.9756801724, green: 0.9647900462, blue: 0.9644319415, alpha: 1)))
                                .frame(width: W(15), height: W(15))
                                .cornerRadius(.infinity)
                                .overlay(
                                    RoundedRectangle(cornerRadius: .infinity).stroke(Color.init(gender == 1 ? #colorLiteral(red: 0.4282599092, green: 0.1879977882, blue: 0.6717798114, alpha: 1): isEnableEdit ? #colorLiteral(red: 0.8469690681, green: 0.847112, blue: 0.8469489217, alpha: 1): #colorLiteral(red: 0.8469690681, green: 0.847112, blue: 0.8469489217, alpha: 1)), lineWidth: 1)
                                )
                            ImageCustom(name: "checkRadio", w: 9, h: 7)
                                .opacity(gender == 1 ? 1 : 0)
                        }
                        TextCustom(text: NSLocalizedString("info_female", comment: ""), font: MEDIUM, size: 16, color: #colorLiteral(red: 0.05096982419, green: 0.0509866029, blue: 0.05096747726, alpha: 1))
                    }
                }.buttonStyle(ButtonTapScale())
                    .animation(.easeInOut(duration: 0.1))
                    .disabled(isEnableEdit ? false : true)

                HStack {
                    Spacer()
                    Button(action: {
                        if self.gender == 2 {
                            self.gender = -1
                        } else {
                            self.gender = 2
                        }
                    }) {
                        HStack (spacing: 7) {
                            ZStack {
                                Rectangle()
                                    .foregroundColor(.init(gender == 2 ? #colorLiteral(red: 0.4282599092, green: 0.1879977882, blue: 0.6717798114, alpha: 1): isEnableEdit ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1): #colorLiteral(red: 0.9756801724, green: 0.9647900462, blue: 0.9644319415, alpha: 1)))
                                    .frame(width: W(15), height: W(15))
                                    .cornerRadius(.infinity)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: .infinity).stroke(Color.init(gender == 2 ? #colorLiteral(red: 0.4282599092, green: 0.1879977882, blue: 0.6717798114, alpha: 1): isEnableEdit ? #colorLiteral(red: 0.8469690681, green: 0.847112, blue: 0.8469489217, alpha: 1): #colorLiteral(red: 0.8469690681, green: 0.847112, blue: 0.8469489217, alpha: 1)), lineWidth: 1)
                                    )
                                ImageCustom(name: "checkRadio", w: 9, h: 7)
                                    .opacity(gender == 2 ? 1 : 0)
                            }
                            TextCustom(text: NSLocalizedString("info_other", comment: ""), font: MEDIUM, size: 16, color: #colorLiteral(red: 0.05096982419, green: 0.0509866029, blue: 0.05096747726, alpha: 1))
                        }
                    }.buttonStyle(ButtonTapScale())
                        .animation(.easeInOut(duration: 0.1))
                        .disabled(isEnableEdit ? false : true)
                }
            }
        }.padding(.horizontal, 20)
            .frame(width: FULL_W)
    }
}

struct InfoPicturePick: View {
    @Binding var isShowPopUp: Bool
    @Binding var isShowLibrary: Bool
    @Binding var sourceType: Int

    var body: some View {
        VStack (spacing: H(20)) {
            Spacer()
            VStack (spacing: 0) {
                ZStack {
                    TextCustom(text: NSLocalizedString("info_avatar", comment: ""), font: MEDIUM, size: 20, color: #colorLiteral(red: 0.1999745965, green: 0.2000149786, blue: 0.1999689341, alpha: 1))
                }.frame(height: H(54))
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.init(#colorLiteral(red: 0.8384397626, green: 0.8275271058, blue: 0.8271935582, alpha: 1)))
                Button(action: {
                    self.isShowLibrary = true
                    self.sourceType = 1
                    self.isShowPopUp = false
                }) {
                    ZStack {
                        HStack (spacing: 13) {
                            ImageCustom(name: "selectPurple", w: 20, h: 20)
                            TextCustom(text: NSLocalizedString("info_pickImage", comment: ""), font: REGULAR, size: 18, color: #colorLiteral(red: 0.2499063611, green: 0.2955911756, blue: 0.4130570292, alpha: 1))
                        }
                    }.frame(width: FULL_W - 40, height: H(54))
                        .background(Image("EmptyPicture").resizable())
                }.buttonStyle(ButtonTapScale())
                Rectangle()
                    .frame(height: 1)
                    .foregroundColor(.init(#colorLiteral(red: 0.8384397626, green: 0.8275271058, blue: 0.8271935582, alpha: 1)))
                Button(action: {
                    self.isShowLibrary = true
                    self.sourceType = 2
                    self.isShowPopUp = false
                }) {
                    ZStack {
                        HStack (spacing: 13) {
                            ImageCustom(name: "cameraPurple", w: 20, h: 20)
                            TextCustom(text: NSLocalizedString("info_takeImage", comment: ""), font: REGULAR, size: 18, color: #colorLiteral(red: 0.2499063611, green: 0.2955911756, blue: 0.4130570292, alpha: 1))
                        }
                    }.frame(width: FULL_W - 40, height: H(54))
                        .background(Image("EmptyPicture").resizable())
                }.buttonStyle(ButtonTapScale())
            }.frame(width: FULL_W - 40)
                .background(Color.white)
                .cornerRadius(4)
                .shadow(color: .init(#colorLiteral(red: 0.4142806155, green: 0.4142806155, blue: 0.4142806155, alpha: 0.6977766104)), radius: 6)
            Button(action: {
                self.isShowPopUp = false
            }) {
                ZStack {
                    Rectangle()
                        .foregroundColor(.white)
                        .cornerRadius(4)
                        .frame(width: FULL_W - 40, height: H(45))
                        .shadow(color: .init(#colorLiteral(red: 0.4142806155, green: 0.4142806155, blue: 0.4142806155, alpha: 0.6977766104)), radius: 6)
                    TextCustom(text: NSLocalizedString("login_close", comment: ""), font: MEDIUM, size: 16, color: #colorLiteral(red: 0.1400775909, green: 0.1216219291, blue: 0.1212796792, alpha: 1))
                }
            }.buttonStyle(ButtonTapScale())
                .padding(.bottom, H(
                    FULL_H == H_SE && FULL_W == W_SE ? 40: // iPhone SE 1st generation
                    FULL_H == H_8 && FULL_W == W_8 ? 40: // iPhone 8 && iPhone SE 2nd generation
                    FULL_H == H_8Plus && FULL_W == W_8Plus ? 40: // iPhone 8 Plus
                    FULL_H == H_11 && FULL_W == W_11 ? 20: // iPhone 11 && iPhone 11 Pro Max
                    FULL_H == H_11Pro && FULL_W == W_11Pro ? 20 : 0 // iPhone 11 Pro
                        ))
        }.offset(y: isShowPopUp ? 0 : 300)
            .animation(.easeInOut(duration: 0.2))
    }
}

struct ShowBackPopup: View {
    @Binding var isShowPopUpBackConfirm: Bool
    @Binding var isNextOld: Bool

    var body: some View {
        VStack {
            Spacer()
            VStack(spacing: 0) {
                VStack(spacing: 0) {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 1, height: H(
                            FULL_H == H_SE && FULL_W == W_SE ? 13: // iPhone SE 1st generation
                            FULL_H == H_8 && FULL_W == W_8 ? 13: // iPhone 8 && iPhone SE 2nd generation
                            FULL_H == H_8Plus && FULL_W == W_8Plus ? 14: // iPhone 8 Plus
                            FULL_H == H_11 && FULL_W == W_11 ? 11: // iPhone 11 && iPhone 11 Pro Max
                            FULL_H == H_11Pro && FULL_W == W_11Pro ? 11 : 0) // iPhone 11 Pro
                        )
                    ImageCustom(name: "resultFail", w: 65, h: 65)
                        .padding(.bottom, H(9))
                        .offset(x: -0.5)
                    TextCustom(text: NSLocalizedString("info_saveTitle", comment: ""), size: 18, color: #colorLiteral(red: 0.4281106591, green: 0.1894766092, blue: 0.6721540093, alpha: 1))
                        .padding(.bottom, H(17))
                    // MARK: CHƯA BIẾT CÁCH LOCALIZE TEXT CÓ ""
                    TextCustom(text: NSLocalizedString("info_saveConfirmText", comment: ""), font: REGULAR, size: 16, color: #colorLiteral(red: 0.2495550513, green: 0.2954892516, blue: 0.4120893478, alpha: 1))
                        .lineSpacing(5)
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.horizontal, 45)
                        .padding(.bottom, H(23))
                }
                HStack (spacing: 10) {
                    Button(action: {
                        self.isShowPopUpBackConfirm = false
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            self.isNextOld = false
                        }
                    }) {
                        ZStack {
                            Rectangle()
                                .cornerRadius(4)
                                .foregroundColor(.white)
                                .frame(width: (FULL_W - 72) / 2 - 5, height: H(40))
                                .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.init(#colorLiteral(red: 0.4282599092, green: 0.1879977882, blue: 0.6717798114, alpha: 1)), lineWidth: 1))
                            TextCustom(text: NSLocalizedString("info_no", comment: ""), font: MEDIUM, size: 16, color: #colorLiteral(red: 0.4269524217, green: 0.1874135733, blue: 0.6712699533, alpha: 1))
                        }
                    }.buttonStyle(ButtonTapScale())
                    Button(action: {
                        self.isShowPopUpBackConfirm = false
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            self.isNextOld = false
                        }
                    }) {
                        ZStack {
                            Rectangle()
                                .cornerRadius(4)
                                .foregroundColor(.init(#colorLiteral(red: 0.4282599092, green: 0.1879977882, blue: 0.6717798114, alpha: 1)))
                                .frame(width: (FULL_W - 72) / 2 - 5, height: H(40))
                                .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.init(#colorLiteral(red: 0.4282599092, green: 0.1879977882, blue: 0.6717798114, alpha: 1)), lineWidth: 1))
                            TextCustom(text: NSLocalizedString("info_save", comment: ""), font: MEDIUM, size: 16, color: .white)
                        }
                    }.buttonStyle(ButtonTapScale())
                }.animation(.easeInOut(duration: 0.1))
            }.padding(.bottom, H(17))
                .background(
                    Image("union150")
                        .resizable()
                        .frame(width: FULL_W - 42)
                        .shadow(color: .init(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2016802226)), radius: 6)
                ).scaleEffect(isShowPopUpBackConfirm ? 1 : 0.1)
                .opacity(isShowPopUpBackConfirm ? 1 : 0)
                .animation(.easeInOut(duration: 0.2))
            Spacer()
        }
    }
}

struct ShowDatePickerInfo: View {
    @Binding var date: Date
    @Binding var isShowDatePicker: Bool
    @Binding var initValue: Int

    @State var temp_date = Date()

    var body: some View {
        ZStack {
            if isShowDatePicker {
                Text("").onAppear {
                    self.temp_date = self.date
                }
            } else {
                Text("").onAppear {
                    self.temp_date = Date()
                }
            }
            VStack {
                Spacer()
                ZStack (alignment: .top) {
                    DatePicker(selection: $temp_date, displayedComponents: .date) {
                        EmptyView()
                    }.environment(\.locale, Locale.init(identifier: "vi_VN"))
                        .frame(width: W(110), height: H(110))
                        .background(Color.white)
                        .scaleEffect(
                            FULL_H == H_SE && FULL_W == W_SE ? 0.8: // iPhone SE 1st generation
                            FULL_H == H_8 && FULL_W == W_8 ? 1: // iPhone 8 && iPhone SE 2nd generation
                            FULL_H == H_8Plus && FULL_W == W_8Plus ? 1: // iPhone 8 Plus
                            FULL_H == H_11 && FULL_W == W_11 ? 1.2: // iPhone 11 && iPhone 11 Pro Max
                            FULL_H == H_11Pro && FULL_W == W_11Pro ? 1 : 0 // iPhone 11 Pro
                        ).offset(y: H(
                            FULL_H == H_SE && FULL_W == W_SE ? 145: // iPhone SE 1st generation
                            FULL_H == H_8 && FULL_W == W_8 ? 145: // iPhone 8 && iPhone SE 2nd generation
                            FULL_H == H_8Plus && FULL_W == W_8Plus ? 145: // iPhone 8 Plus
                            FULL_H == H_11 && FULL_W == W_11 ? 145: // iPhone 11 && iPhone 11 Pro Max
                            FULL_H == H_11Pro && FULL_W == W_11Pro ? 145 : 0 // iPhone 11 Pro
                                ))
                    VStack(spacing: 0) {
                        Rectangle()
                            .frame(width: W(74), height: W(4))
                            .foregroundColor(.init(#colorLiteral(red: 0.5111798048, green: 0.3070217371, blue: 0.7141162753, alpha: 1)))
                            .padding(.top, H(8))
                        ZStack {
                            HStack {
                                Button(action: {
                                    self.isShowDatePicker = false
                                }) {
                                    TextCustom(text: NSLocalizedString("project_ground_plan_popup_cancel", comment: ""), font: REGULAR, size: 18, color: #colorLiteral(red: 0.4038758278, green: 0.4039486051, blue: 0.403865695, alpha: 1))
                                }.buttonStyle(ButtonTapScale())
                                Spacer()
                            }
                            TextCustom(text: NSLocalizedString("info_birth", comment: ""), font: MEDIUM, size: 22, lineLimit: 1, color: #colorLiteral(red: 0.1363612413, green: 0.1216128543, blue: 0.1213363782, alpha: 1))
                                .frame(width: FULL_W - 60 - 30 - 60)
                            HStack {
                                Spacer()
                                Button(action: {
                                    self.date = self.temp_date
                                    self.isShowDatePicker = false
                                    self.initValue += 1
                                }) {
                                    TextCustom(text: NSLocalizedString("project_ground_plan_popup_done", comment: ""), font: REGULAR, size: 18, color: #colorLiteral(red: 0.4205850065, green: 0.1838403046, blue: 0.6598007083, alpha: 1))
                                }.buttonStyle(ButtonTapScale())
                            }
                        }.padding(.top, H(12))
                            .padding(.horizontal, 30)
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.init(#colorLiteral(red: 0.8077571988, green: 0.8078939915, blue: 0.8077381253, alpha: 1)))
                            .padding(.top, H(14))
                        Spacer()
                    }
                }.frame(width: FULL_W, height: H(344))
                    .background(Color.white.cornerRadius(5))
            }.edgesIgnoringSafeArea(.bottom)
                .offset(y: isShowDatePicker ? 0 : H(500))
                .animation(.easeInOut(duration: 0.2))
        }
    }
}
