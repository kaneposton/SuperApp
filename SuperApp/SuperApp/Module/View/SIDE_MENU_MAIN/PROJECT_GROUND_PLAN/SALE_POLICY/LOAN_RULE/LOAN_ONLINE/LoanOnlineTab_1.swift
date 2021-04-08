// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import SwiftUI

struct LoanOnlineTab_1: View {
    @Binding var dataRentOnline: ModalRentOnline
    @Binding var labelDatePicker: String
    @Binding var labelCombo: String
    @Binding var isShowCombobox: Bool
    @Binding var isChangeColor: Bool
    @Binding var selectedIndexTab_1: Int

    // MARK: VALUE TAB 1
    @Binding var isStartRed: Bool
    @Binding var isShowDatePicker: Bool

    @State var selectedTab = 0

    var body: some View {
        VStack (spacing: H(16)) {
            // MARK: THÔNG TIN KHÁCH HÀNG
            ZStack {
                VStack {
                    TabChangeLoanOnline(
                        currentSelectedFirstTab: Binding.constant(false),
                        selectedIndexPage: $dataRentOnline.selectedIndexPage,
                        index_1: 1,
                        label_1: "loan_online_1_customerInfo"
                    )
                    Spacer()
                }
                VStack (spacing: H(20)) {
                    VStack (spacing: H(20)) {
                        // MARK: HỌ VÀ TÊN
                        LoanOnlineTextField(
                            isStartRed: $isStartRed,
                            value: $dataRentOnline.tab_1_strName,
                            selectedIndex: $selectedIndexTab_1,
                            isTapComponent: Binding.constant(false),
                            isTapLoop: Binding.constant(false),
                            currentCombobox: Binding.constant(false),
                            label: "loan_online_1_name",
                            index: 0)

                        // MARK: NGÀY SINH
                        LoanOnlineDateField(
                            indexForEachBinding: Binding.constant(0),
                            labelDatePicker: $labelDatePicker,
                            isChangeColor: $isChangeColor,
                            isShowDatePicker: $isShowDatePicker,
                            initValue: $dataRentOnline.tab_1_initValueBirthday,
                            valueDate: $dataRentOnline.tab_1_dateBirthday,
                            isStartRed: $isStartRed,
                            valueIndex: Binding.constant(0),
                            value: Binding.constant(""),
                            selectedIndex: $selectedIndexTab_1,
                            isTapComponent: Binding.constant(false),
                            isTapLoop: Binding.constant(false),
                            currentCombobox: Binding.constant(false),
                            label: "loan_online_1_birth",
                            index: 1,
                            isTrueDate: true
                        )

                        // MARK: GIỚI TÍNH
                        LoanOnlineCombobox(
                            indexForEachBinding: Binding.constant(0),
                            moreComboIndex: Binding.constant(0),
                            labelCombo: $labelCombo,
                            isChangeColor: $isChangeColor,
                            isShowCombobox: $isShowCombobox,
                            isStartRed: $isStartRed,
                            value: $dataRentOnline.tab_1_strGender,
                            selectedIndex: $selectedIndexTab_1,
                            isTapComponent: Binding.constant(false),
                            isTapLoop: Binding.constant(false),
                            currentCombobox: Binding.constant(false),
                            label: "loan_online_1_gender",
                            index: 2
                        )

                        // MARK: CMND/HỘ CHIẾU
                        LoanOnlineTextField(
                            isStartRed: $isStartRed,
                            value: $dataRentOnline.tab_1_strCMND,
                            selectedIndex: $selectedIndexTab_1,
                            isTapComponent: Binding.constant(false),
                            isTapLoop: Binding.constant(false),
                            currentCombobox: Binding.constant(false),
                            label: "loan_online_1_cmnd",
                            isNumber: true,
                            index: 3
                        )

                        // MARK: NGÀY CẤP
                        LoanOnlineDateField(
                            indexForEachBinding: Binding.constant(0),
                            labelDatePicker: $labelDatePicker,
                            isChangeColor: $isChangeColor,
                            isShowDatePicker: $isShowDatePicker,
                            initValue: $dataRentOnline.tab_1_initValueGiveDate,
                            valueDate: $dataRentOnline.tab_1_dateGiveDate,
                            isStartRed: $isStartRed,
                            valueIndex: Binding.constant(0),
                            value: Binding.constant(""),
                            selectedIndex: $selectedIndexTab_1,
                            isTapComponent: Binding.constant(false),
                            isTapLoop: Binding.constant(false),
                            currentCombobox: Binding.constant(false),
                            label: "loan_online_1_dateGive",
                            isMustHave: false,
                            index: 4,
                            isTrueDate: true
                        )

                        // MARK: NƠI CẤP
                        LoanOnlineCombobox(
                            indexForEachBinding: Binding.constant(0),
                            moreComboIndex: Binding.constant(0),
                            labelCombo: $labelCombo,
                            isChangeColor: $isChangeColor,
                            isShowCombobox: $isShowCombobox,
                            isStartRed: $isStartRed,
                            value: $dataRentOnline.tab_1_strGivePlace,
                            selectedIndex: $selectedIndexTab_1,
                            isTapComponent: Binding.constant(false),
                            isTapLoop: Binding.constant(false),
                            currentCombobox: Binding.constant(false),
                            label: "loan_online_1_placeGive",
                            isMustHave: false,
                            index: 5
                        )
                    }
                    VStack (spacing: H(20)) {
                        // MARK: ĐIỆN THOẠI
                        LoanOnlineTextField(
                            isStartRed: $isStartRed,
                            value: $dataRentOnline.tab_1_strPhone,
                            selectedIndex: $selectedIndexTab_1,
                            isTapComponent: Binding.constant(false),
                            isTapLoop: Binding.constant(false),
                            currentCombobox: Binding.constant(false),
                            label: "loan_online_1_phone",
                            isNumber: true,
                            index: 6
                        )

                        // MARK: EMAIL
                        LoanOnlineTextField(
                            isStartRed: $isStartRed,
                            value: $dataRentOnline.tab_1_strEmail,
                            selectedIndex: $selectedIndexTab_1,
                            isTapComponent: Binding.constant(false),
                            isTapLoop: Binding.constant(false),
                            currentCombobox: Binding.constant(false),
                            label: "EMAIL",
                            isEmail: true,
                            index: 7
                        )

                        // MARK: TRÌNH ĐỘ HỌC VẤN
                        LoanOnlineCombobox(
                            indexForEachBinding: Binding.constant(0),
                            moreComboIndex: Binding.constant(0),
                            labelCombo: $labelCombo,
                            isChangeColor: $isChangeColor,
                            isShowCombobox: $isShowCombobox,
                            isStartRed: $isStartRed,
                            value: $dataRentOnline.tab_1_strEducation,
                            selectedIndex: $selectedIndexTab_1,
                            isTapComponent: Binding.constant(false),
                            isTapLoop: Binding.constant(false),
                            currentCombobox: Binding.constant(false),
                            label: "loan_online_1_edu",
                            isMustHave: false,
                            index: 8
                        )

                        // MARK: TÌNH TRẠNG HÔN NHÂN
                        LoanOnlineCombobox(
                            indexForEachBinding: Binding.constant(0),
                            moreComboIndex: Binding.constant(0),
                            labelCombo: $labelCombo,
                            isChangeColor: $isChangeColor,
                            isShowCombobox: $isShowCombobox,
                            isStartRed: $isStartRed,
                            value: $dataRentOnline.tab_1_strMarry,
                            selectedIndex: $selectedIndexTab_1,
                            isTapComponent: Binding.constant(false),
                            isTapLoop: Binding.constant(false),
                            currentCombobox: Binding.constant(false),
                            label: "loan_online_1_marry",
                            isMustHave: false,
                            index: 9
                        )

                        // MARK: TÌNH TRẠNG SỞ HỮU NHÀ Ở/BĐS
                        LoanOnlineCombobox(
                            indexForEachBinding: Binding.constant(0),
                            moreComboIndex: Binding.constant(0),
                            labelCombo: $labelCombo,
                            isChangeColor: $isChangeColor,
                            isShowCombobox: $isShowCombobox,
                            isStartRed: $isStartRed,
                            value: $dataRentOnline.tab_1_strHaveHouse,
                            selectedIndex: $selectedIndexTab_1,
                            isTapComponent: Binding.constant(false),
                            isTapLoop: Binding.constant(false),
                            currentCombobox: Binding.constant(false),
                            label: "loan_online_1_haveHouse",
                            isTooLong: true,
                            index: 10
                        )
                    }
                }.padding(.top, H(21))
                    .padding(.bottom, H(30))
                    .background(Color.white)
                    .padding(.top, H(56))
                    .padding(.horizontal, 16)
            }.cornerRadius(0)
                .shadow(color: Color.init(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.1574878961)), radius: 6, x: 0, y: 3)
                .padding(.top, H(30))

            // MARK: ĐỊA CHỈ
            VStack (alignment: .leading, spacing: H(20)) {
                TextCustom(text: NSLocalizedString("loan_online_1_address", comment: ""), font: MEDIUM, size: 16, color: #colorLiteral(red: 0.4281106591, green: 0.1894766092, blue: 0.6721540093, alpha: 1))
                    .padding(.bottom, H(6))
                    .padding(.leading, 14)

                // MARK: TỈNH/THÀNH PHỐ
                LoanOnlineCombobox(
                    indexForEachBinding: Binding.constant(0),
                    moreComboIndex: Binding.constant(0),
                    labelCombo: $labelCombo,
                    isChangeColor: $isChangeColor,
                    isShowCombobox: $isShowCombobox,
                    isStartRed: $isStartRed,
                    value: $dataRentOnline.tab_1_strCity,
                    selectedIndex: $selectedIndexTab_1,
                    isTapComponent: Binding.constant(false),
                    isTapLoop: Binding.constant(false),
                    currentCombobox: Binding.constant(false),
                    label: "loan_online_1_city",
                    isMustHave: false,
                    index: 11
                )

                // MARK: QUẬN/HUYỆN
                LoanOnlineCombobox(
                    indexForEachBinding: Binding.constant(0),
                    moreComboIndex: Binding.constant(0),
                    labelCombo: $labelCombo,
                    isChangeColor: $isChangeColor,
                    isShowCombobox: $isShowCombobox,
                    isStartRed: $isStartRed,
                    value: $dataRentOnline.tab_1_strDistrict,
                    selectedIndex: $selectedIndexTab_1,
                    isTapComponent: Binding.constant(false),
                    isTapLoop: Binding.constant(false),
                    currentCombobox: Binding.constant(false),
                    label: "loan_online_1_district",
                    isMustHave: false,
                    index: 12
                )

                //MARK: PHƯỜNG XÃ
                LoanOnlineCombobox(
                    indexForEachBinding: Binding.constant(0),
                    moreComboIndex: Binding.constant(0),
                    labelCombo: $labelCombo,
                    isChangeColor: $isChangeColor,
                    isShowCombobox: $isShowCombobox,
                    isStartRed: $isStartRed,
                    value: $dataRentOnline.tab_1_strVillage,
                    selectedIndex: $selectedIndexTab_1,
                    isTapComponent: Binding.constant(false),
                    isTapLoop: Binding.constant(false),
                    currentCombobox: Binding.constant(false),
                    label: "loan_online_1_village",
                    isMustHave: false,
                    index: 13
                )

                // MARK: ĐỊA CHỈ
                LoanOnlineTextField(
                    isStartRed: $isStartRed,
                    value: $dataRentOnline.tab_1_strAddress,
                    selectedIndex: $selectedIndexTab_1,
                    isTapComponent: Binding.constant(false),
                    isTapLoop: Binding.constant(false),
                    currentCombobox: Binding.constant(false),
                    label: "loan_online_1_address",
                    isMustHave: false,
                    index: 14
                )
            }.padding(.top, H(19))
                .padding(.bottom, H(30))
                .background(Color.white)
                .padding(.horizontal, 16)
                .cornerRadius(0)
                .shadow(color: Color.init(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.1574878961)), radius: 6, x: 0, y: 3)
        }
    }
}

struct LoanOnlineCombobox: View {
    @Binding var indexForEachBinding: Int
    @Binding var moreComboIndex: Int
    @Binding var labelCombo: String
    @Binding var isChangeColor: Bool
    @Binding var isShowCombobox: Bool
    @Binding var isStartRed: Bool
    @Binding var value: String
    @Binding var selectedIndex: Int
    @Binding var isTapComponent: Bool
    @Binding var isTapLoop: Bool
    @Binding var currentCombobox: Bool

    @State var label = ""
    @State var isMustHave = true
    @State var isTooLong = false
    @State var isStartAnimation = false
    @State var index = 0
    @State var isLoop = false
    @State var isSpecialAll = false
    @State var isBorderRed = false
    @State var isNew = false
    @State var indexForEach = 0

    var body: some View {
        ZStack {
            if isStartRed {
                Text("").onAppear {
                    self.isBorderRed = true
                }
            } else {
                Text("").onAppear {
                    self.isBorderRed = false
                }
            }
            Button(action: {
                UIApplication.shared.endEditing()
                self.indexForEachBinding = self.indexForEach // i
                self.moreComboIndex = -1
                self.selectedIndex = self.index
                if !self.isLoop {
                    self.isTapComponent = true
                } else {
                    self.moreComboIndex = self.index // 9 10 11 12
                    self.isTapLoop = true
                    self.currentCombobox = true
                }
                self.labelCombo = NSLocalizedString(self.label, comment: "")
                self.isChangeColor = true
                self.isShowCombobox = true
            }) {
                if isTooLong {
                    ZStack (alignment: .trailing) {
                        HStack (spacing: 0) {
                            TextCustom(text: NSLocalizedString(label, comment: ""), font: REGULAR, size: 14, color: #colorLiteral(red: 0.6533299685, green: 0.6326879859, blue: 0.6321712136, alpha: 1))
                                .padding(.leading, 10)
                            TextCustom(text: isMustHave ? "*" : "", font: REGULAR, size: 14, color: #colorLiteral(red: 0.932536602, green: 0.2507158816, blue: 0.2460758984, alpha: 1))
                            Spacer()
                        }
                        HStack (spacing: 9) {
                            TextCustom(text: value, size: 14, lineLimit: 1, color: #colorLiteral(red: 0.1422221363, green: 0.1236664429, blue: 0.1232500449, alpha: 1))
                                .fixedSize(horizontal: true, vertical: false)
                            ImageCustom(name: "comboIconOnline", w: 14.5, h: 8)
                                .padding(.trailing, 16)
                        }
                    }.frame(height: H(40))
                        .background(Color.white)
                        .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.init(!isNew && isBorderRed && value.isEmpty && (isMustHave || isSpecialAll) ? #colorLiteral(red: 0.932536602, green: 0.2507158816, blue: 0.2460758984, alpha: 1): selectedIndex == index ? #colorLiteral(red: 0.4281106591, green: 0.1894766092, blue: 0.6721540093, alpha: 1): #colorLiteral(red: 0.9008283615, green: 0.9009366632, blue: 0.9007915854, alpha: 1)), lineWidth: 1))
                        .padding(.horizontal, 14)
                } else {
                    HStack (spacing: 0) {
                        TextCustom(text: NSLocalizedString(label, comment: ""), font: REGULAR, size: 14, color: #colorLiteral(red: 0.6533299685, green: 0.6326879859, blue: 0.6321712136, alpha: 1))
                            .padding(.leading, 10)
                        TextCustom(text: isMustHave ? "*" : "", font: REGULAR, size: 14, color: #colorLiteral(red: 0.932536602, green: 0.2507158816, blue: 0.2460758984, alpha: 1))
                        ZStack (alignment: .trailing) {
                            Rectangle()
                                .foregroundColor(.white)
                                .frame(height: H(40))
                            HStack (spacing: 9) {
                                TextCustom(text: value, size: 14, lineLimit: 1, color: #colorLiteral(red: 0.1422221363, green: 0.1236664429, blue: 0.1232500449, alpha: 1))
                                    .fixedSize(horizontal: true, vertical: false)
                                ImageCustom(name: "comboIconOnline", w: 14.5, h: 8)
                                    .padding(.trailing, 16)
                            }
                        }
                    }.frame(height: H(40))
                        .background(Color.white)
                        .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.init(!isNew && isBorderRed && value.isEmpty && (isMustHave || isSpecialAll) ? #colorLiteral(red: 0.932536602, green: 0.2507158816, blue: 0.2460758984, alpha: 1): selectedIndex == index ? #colorLiteral(red: 0.4281106591, green: 0.1894766092, blue: 0.6721540093, alpha: 1): #colorLiteral(red: 0.9008283615, green: 0.9009366632, blue: 0.9007915854, alpha: 1)), lineWidth: 1))
                        .padding(.horizontal, 14)
                }
            }.buttonStyle(ButtonTapScale())
                .animation(isStartAnimation ? .easeInOut(duration: 0.1) : .none)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        self.isStartAnimation = true
                    }
            }
        }
    }
}

struct LoanOnlineDateField: View {
    @Binding var indexForEachBinding: Int
    @Binding var labelDatePicker: String
    @Binding var isChangeColor: Bool
    @Binding var isShowDatePicker: Bool
    @Binding var initValue: Int
    @Binding var valueDate: Date
    @Binding var isStartRed: Bool
    @Binding var valueIndex: Int
    @Binding var value: String
    @Binding var selectedIndex: Int
    @Binding var isTapComponent: Bool
    @Binding var isTapLoop: Bool
    @Binding var currentCombobox: Bool

    @State var label = ""
    @State var isMustHave = true
    @State var isTooLong = false
    @State var isStartAnimation = false
    @State var index = 0
    @State var isLoop = false
    @State var isSpecialAll = false
    @State var isBorderRed = false
    @State var isTrueDate = false
    @State var indexForEach = 0

    var dateFormatter: DateFormatter {
        let df = DateFormatter()
        df.dateFormat = "dd-MM-yyyy"
        return df
    }

    var body: some View {
        ZStack {
            if isStartRed {
                Text("").onAppear {
                    self.isBorderRed = true
                }
            } else {
                Text("").onAppear {
                    self.isBorderRed = false
                }
            }
            Button(action: {
                UIApplication.shared.endEditing()
                self.indexForEachBinding = self.indexForEach // i
                self.selectedIndex = self.index
                if !self.isLoop {
                    self.isTapComponent = true
                } else {
                    self.isTapLoop = true
                    self.currentCombobox = true
                }
                self.labelDatePicker = self.label
                self.isShowDatePicker = true
                self.isChangeColor = true
            }) {
                if isTooLong {
                    ZStack (alignment: .trailing) {
                        HStack (spacing: 0) {
                            TextCustom(text: NSLocalizedString(label, comment: ""), font: REGULAR, size: 14, color: #colorLiteral(red: 0.6533299685, green: 0.6326879859, blue: 0.6321712136, alpha: 1))
                                .padding(.leading, 10)
                            TextCustom(text: isMustHave ? "*" : "", font: REGULAR, size: 14, color: #colorLiteral(red: 0.932536602, green: 0.2507158816, blue: 0.2460758984, alpha: 1))
                            Spacer()
                        }
                        HStack (spacing: 9) {
                            if isTrueDate {
                                Text("\(valueDate, formatter: dateFormatter)")
                                    .foregroundColor(.init(#colorLiteral(red: 0.1422221363, green: 0.1236664429, blue: 0.1232500449, alpha: 1)))
                                    .font(.custom(BOLD, size: H(14)))
                                    .lineLimit(1)
                                    .fixedSize(horizontal: true, vertical: false)
                                    .opacity(initValue != 0 ? 1 : 0)
                            } else {
                                ZStack (alignment: .trailing) {
                                    TextCustom(text: value, size: 14, lineLimit: 1, color: #colorLiteral(red: 0.1422221363, green: 0.1236664429, blue: 0.1232500449, alpha: 1))
                                        .fixedSize(horizontal: true, vertical: false)
                                        .opacity(initValue != 0 ? 1 : 0)
                                }
                            }
                            ImageCustom(name: "iconCalendar", w: 14.5, h: 16.6)
                                .padding(.trailing, 16)
                        }
                    }.frame(height: H(40))
                        .background(Color.white)
                        .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.init(isBorderRed && initValue == 0 && (isMustHave || isSpecialAll) ? #colorLiteral(red: 0.932536602, green: 0.2507158816, blue: 0.2460758984, alpha: 1): selectedIndex == index ? #colorLiteral(red: 0.4281106591, green: 0.1894766092, blue: 0.6721540093, alpha: 1): #colorLiteral(red: 0.9008283615, green: 0.9009366632, blue: 0.9007915854, alpha: 1)), lineWidth: 1))
                        .padding(.horizontal, 14)
                } else {
                    HStack (spacing: 0) {
                        TextCustom(text: NSLocalizedString(label, comment: ""), font: REGULAR, size: 14, color: #colorLiteral(red: 0.6533299685, green: 0.6326879859, blue: 0.6321712136, alpha: 1))
                            .padding(.leading, 10)
                        TextCustom(text: isMustHave ? "*" : "", font: REGULAR, size: 14, color: #colorLiteral(red: 0.932536602, green: 0.2507158816, blue: 0.2460758984, alpha: 1))
                        ZStack (alignment: .trailing) {
                            Rectangle()
                                .foregroundColor(.white)
                                .frame(height: H(40))
                            HStack (spacing: 9) {
                                if isTrueDate {
                                    Text("\(valueDate, formatter: dateFormatter)")
                                        .foregroundColor(.init(#colorLiteral(red: 0.1422221363, green: 0.1236664429, blue: 0.1232500449, alpha: 1)))
                                        .font(.custom(BOLD, size: H(14)))
                                        .lineLimit(1)
                                        .fixedSize(horizontal: true, vertical: false)
                                        .opacity(initValue != 0 ? 1 : 0)
                                } else {
                                    ZStack (alignment: .trailing) {
                                        TextCustom(text: value, size: 14, lineLimit: 1, color: #colorLiteral(red: 0.1422221363, green: 0.1236664429, blue: 0.1232500449, alpha: 1))
                                            .fixedSize(horizontal: true, vertical: false)
                                            .opacity(initValue != 0 ? 1 : 0)
                                    }
                                }
                                ImageCustom(name: "iconCalendar", w: 14.5, h: 16.6)
                                    .padding(.trailing, 16)
                            }
                        }
                    }.frame(height: H(40))
                        .background(Color.white)
                        .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.init(isBorderRed && initValue == 0 && (isMustHave || isSpecialAll) ? #colorLiteral(red: 0.932536602, green: 0.2507158816, blue: 0.2460758984, alpha: 1): selectedIndex == index ? #colorLiteral(red: 0.4281106591, green: 0.1894766092, blue: 0.6721540093, alpha: 1): #colorLiteral(red: 0.9008283615, green: 0.9009366632, blue: 0.9007915854, alpha: 1)), lineWidth: 1))
                        .padding(.horizontal, 14)
                }
            }.buttonStyle(ButtonTapScale())
                .animation(isStartAnimation ? .easeInOut(duration: 0.1) : .none)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        self.isStartAnimation = true
                    }
            }
        }
    }
}

struct LoanOnlineTextField: View {
    @Binding var isStartRed: Bool
    @Binding var value: String
    @Binding var selectedIndex: Int
    @Binding var isTapComponent: Bool
    @Binding var isTapLoop: Bool
    @Binding var currentCombobox: Bool

    @State var label = ""
    @State var isMustHave = true
    @State var isNumber = false
    @State var isEmail = false
    @State var isEditing = false
    @State var rightHolder = ""
    @State var index = 0
    @State var isLoop = false
    @State var isSpecialAll = false
    @State var isBorderRed = false
    @State var isNew = false
    @State var isNumberComma = false
    @State var isDoneEditing = true
    @State var isClear = false
    @State var isEnableEdit = true

    var body: some View {
        ZStack {
            if isStartRed {
                Text("").onAppear {
                    self.isBorderRed = true
                }
            } else {
                Text("").onAppear {
                    self.isBorderRed = false
                }
            }
            if value.isEmpty {
                Text("").onAppear {
                    self.isClear = true
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        self.isClear = false
                    }
                }
            }
            HStack (spacing: 0) {
                TextCustom(text: NSLocalizedString(label, comment: ""), font: REGULAR, size: 14, color: #colorLiteral(red: 0.6533299685, green: 0.6326879859, blue: 0.6321712136, alpha: 1))
                    .fixedSize(horizontal: true, vertical: false)
                    .padding(.leading, 10)
                TextCustom(text: isMustHave ? "*" : "", font: REGULAR, size: 14, color: #colorLiteral(red: 0.932536602, green: 0.2507158816, blue: 0.2460758984, alpha: 1))
                ZStack (alignment: .trailing) {
                    if label == "loan_online_1_phone" {
                        TFPhoneNumner(align: "right", font: BOLD, size: 14, color: #colorLiteral(red: 0.1422221363, green: 0.1236664429, blue: 0.1232500449, alpha: 1),
                            changeHandler: { rs in
                                self.value = rs
                            },
                            didBeginEditing: { rs in
                                if rs {
                                    self.isDoneEditing = false
                                    self.isEditing = true
                                    if !self.isLoop {
                                        self.isTapComponent = true
                                    } else {
                                        self.isTapLoop = true
                                        self.currentCombobox = true
                                    }
                                    if self.isEditing {
                                        self.selectedIndex = self.index
                                    } else {
                                        self.selectedIndex = -1
                                    }
                                }
                            },
                            didEndEditing: { rs in
                                if rs {
                                    self.self.isEditing = false
                                    self.selectedIndex = -1
                                    self.isDoneEditing = true
                                }
                            }, isClear: $isClear, value: self.$value, isEnableEdit: self.$isEnableEdit)
                            .frame(height: H(14))
                    } else {
                        TextCustom(text: isNumberComma ? Utils.formatHighNumber(Double(value) ?? 0) == "0" ? "" : Utils.formatHighNumber(Double(value) ?? 0): value, size: 14, color: #colorLiteral(red: 0.1422221363, green: 0.1236664429, blue: 0.1232500449, alpha: 1))
                            .opacity(isDoneEditing ? 1 : 0)
                        TextField("", text: $value, onEditingChanged: { rs in
                            if rs {
                                self.isDoneEditing = false
                                self.isEditing = true
                                if !self.isLoop {
                                    self.isTapComponent = true
                                } else {
                                    self.isTapLoop = true
                                    self.currentCombobox = true
                                }
                                if self.isEditing {
                                    self.selectedIndex = self.index
                                } else {
                                    self.selectedIndex = -1
                                }
                            } else {
                                self.self.isEditing = false
                                self.selectedIndex = -1
                                self.isDoneEditing = true
                            }
                        }).multilineTextAlignment(.trailing)
                            .keyboardType(isNumber ? .numberPad : isEmail ? .emailAddress : .default)
                            .font(.custom(BOLD, size: H(14)))
                            .foregroundColor(.init(isDoneEditing ? #colorLiteral(red: 0.1422221363, green: 0.1236664429, blue: 0.1232500449, alpha: 0): #colorLiteral(red: 0.1422221363, green: 0.1236664429, blue: 0.1232500449, alpha: 1)))
                    }
                }.padding(.leading, 16)
                    .padding(.trailing, rightHolder.isEmpty ? 16 : 5)
                    .frame(height: H(40))
                if !rightHolder.isEmpty {
                    if rightHolder == "m2" {
                        TextCustom(text: "m", font: REGULAR, size: 14, color: #colorLiteral(red: 0.665820241, green: 0.6659018993, blue: 0.6657924652, alpha: 1))
                        TextCustom(text: "2", font: REGULAR, size: 8, color: #colorLiteral(red: 0.665820241, green: 0.6659018993, blue: 0.6657924652, alpha: 1)).offset(y: -3)
                            .padding(.trailing, 16)
                    } else {
                        TextCustom(text: NSLocalizedString(rightHolder, comment: ""), font: REGULAR, size: 14, color: #colorLiteral(red: 0.665820241, green: 0.6659018993, blue: 0.6657924652, alpha: 1))
                            .padding(.trailing, 16)
                    }
                }
            }.frame(height: H(40))
                .background(Color.white)
                .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.init(
                            !isNew
                                && isBorderRed
                                && (value.isEmpty || (label == "EMAIL" && !Utils.isValidEmail(email: value)) || (label == "loan_online_1_phone" && formattedNumberPhone(number: value).count < 12))
                                && (isMustHave || isSpecialAll) ?
                            #colorLiteral(red: 0.932536602, green: 0.2507158816, blue: 0.2460758984, alpha: 1)
                                : selectedIndex == index ? #colorLiteral(red: 0.4281106591, green: 0.1894766092, blue: 0.6721540093, alpha: 1): #colorLiteral(red: 0.9008283615, green: 0.9009366632, blue: 0.9007915854, alpha: 1)
                            ), lineWidth: 1))
                .padding(.horizontal, 14)
        }
    }
}

struct TabChangeLoanOnline: View {
    @Binding var currentSelectedFirstTab: Bool
    @Binding var selectedIndexPage: Int
    @State var index_1 = -1
    @State var index_2 = -1
    @State var label_1 = ""
    @State var label_2 = ""
    @State var isStartAnimation = false

    var body: some View {
        HStack (spacing: 0) {
            Button(action: {
                if self.selectedIndexPage != self.index_1 {
                    self.selectedIndexPage = self.index_1
                    self.currentSelectedFirstTab = true
                }
            }) {
                ZStack (alignment: .leading) {
                    Rectangle()
                        .frame(width: (FULL_W - 32) / 2, height: H(56))
                        .foregroundColor(.init(self.selectedIndexPage == self.index_1 ? #colorLiteral(red: 0.9795636535, green: 0.9728637338, blue: 1, alpha: 1): #colorLiteral(red: 0.7887268662, green: 0.7888224125, blue: 0.7886943817, alpha: 1)))
                    Rectangle()
                        .frame(width: 4, height: H(56))
                        .foregroundColor(.init(self.selectedIndexPage == self.index_1 ? #colorLiteral(red: 0.4281106591, green: 0.1894766092, blue: 0.6721540093, alpha: 1): #colorLiteral(red: 0.7887268662, green: 0.7888224125, blue: 0.7886943817, alpha: 1)))
                    ZStack {
                        TextCustom(text: NSLocalizedString(label_1, comment: ""), size: 16, lineLimit: 2, color: #colorLiteral(red: 0.4281106591, green: 0.1894766092, blue: 0.6721540093, alpha: 1))
                            .opacity(self.selectedIndexPage == self.index_1 ? 1 : 0)
                        TextCustom(text: NSLocalizedString(label_1, comment: ""), font: REGULAR, size: 16, lineLimit: 2, color: #colorLiteral(red: 0.4117531478, green: 0.411806047, blue: 0.4117352366, alpha: 1))
                            .opacity(self.selectedIndexPage == self.index_2 ? 1 : 0)
                    }.padding(.leading, 34)
                }.cornerRadius(4)
            }.buttonStyle(ButtonTapScale())
            Button(action: {
                if self.selectedIndexPage != self.index_2 {
                    self.selectedIndexPage = self.index_2
                    self.currentSelectedFirstTab = false
                }
            }) {
                ZStack (alignment: .leading) {
                    Rectangle()
                        .frame(width: (FULL_W - 32) / 2, height: H(56))
                        .foregroundColor(.init(self.selectedIndexPage == self.index_2 ? #colorLiteral(red: 0.9795636535, green: 0.9728637338, blue: 1, alpha: 1): #colorLiteral(red: 0.7887268662, green: 0.7888224125, blue: 0.7886943817, alpha: 1)))
                    Rectangle()
                        .frame(width: 4, height: H(56))
                        .foregroundColor(.init(self.selectedIndexPage == self.index_2 ? #colorLiteral(red: 0.4281106591, green: 0.1894766092, blue: 0.6721540093, alpha: 1): #colorLiteral(red: 0.7887268662, green: 0.7888224125, blue: 0.7886943817, alpha: 1)))
                    ZStack {
                        TextCustom(text: NSLocalizedString(label_2, comment: ""), size: 16, lineLimit: 2, color: #colorLiteral(red: 0.4281106591, green: 0.1894766092, blue: 0.6721540093, alpha: 1))
                            .opacity(self.selectedIndexPage == self.index_2 ? 1 : 0)
                        TextCustom(text: NSLocalizedString(label_2, comment: ""), font: REGULAR, size: 16, lineLimit: 2, color: #colorLiteral(red: 0.4117531478, green: 0.411806047, blue: 0.4117352366, alpha: 1))
                            .opacity(self.selectedIndexPage == self.index_1 ? 1 : 0)
                    }.padding(.leading, 34)
                }.cornerRadius(4)
            }.buttonStyle(ButtonTapScale())
                .opacity(label_2.isEmpty ? 0 : 1)
        }.animation(isStartAnimation ? .easeInOut(duration: 0.1) : .none)
            .onAppear {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    self.isStartAnimation = true
                }
        }
    }
}
