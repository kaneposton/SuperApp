// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import SwiftUI

struct TypeOtherSalary: Identifiable, Hashable {
    var id = UUID()
    var combo: String
    var comboIndex: Int
    var value: String
    var index: Int
}

struct LoanOnlineTab_2: View {
    @Binding var dataRentOnline: ModalRentOnline
    @Binding var labelDatePicker: String
    @Binding var labelCombo: String
    @Binding var selectedIndexTab_2: Int
    @Binding var isShowDatePicker: Bool
    @Binding var isShowCombobox: Bool
    @Binding var isChangeColor: Bool

    // MARK: THU NHẬP HIỆN CÓ
    @Binding var isStartRed_2: Bool
    @Binding var isStartRed_3: Bool

    @State var selectedTab = 0

    @State var isStartAnimation = false
    @State var isTapComponent = false
    @State var isTapLoop = false

    var body: some View {
        VStack (spacing: H(16)) {
            ZStack {
                VStack {
                    TabChangeLoanOnline(
                        currentSelectedFirstTab: $dataRentOnline.is_2,
                        selectedIndexPage: $dataRentOnline.selectedIndexPage,
                        index_1: 2,
                        index_2: 3,
                        label_1: "loan_online_2_title_1",
                        label_2: "loan_online_2_title_2"
                    )
                    Spacer()
                }
                // MARK: THÔNG TIN NGHỀ NGHIỆP
                if dataRentOnline.selectedIndexPage == 2 {
                    VStack (spacing: H(20)) {
                        LoanOnlineTextField(
                            isStartRed: $isStartRed_2,
                            value: $dataRentOnline.tab_2_strCompany,
                            selectedIndex: $selectedIndexTab_2,
                            isTapComponent: $isTapComponent,
                            isTapLoop: Binding.constant(false),
                            currentCombobox: Binding.constant(false),
                            label: "loan_online_2_company_work",
                            index: 0
                        )
                        LoanOnlineCombobox(
                            indexForEachBinding: Binding.constant(0),
                            moreComboIndex: Binding.constant(0),
                            labelCombo: $labelCombo,
                            isChangeColor: $isChangeColor,
                            isShowCombobox: $isShowCombobox,
                            isStartRed: $isStartRed_2,
                            value: $dataRentOnline.tab_2_strCompanyType,
                            selectedIndex: $selectedIndexTab_2,
                            isTapComponent: $isTapComponent,
                            isTapLoop: Binding.constant(false),
                            currentCombobox: Binding.constant(false),
                            label: "loan_online_2_company_type",
                            isTooLong: true,
                            index: 1
                        )
                        LoanOnlineCombobox(
                            indexForEachBinding: Binding.constant(0),
                            moreComboIndex: Binding.constant(0),
                            labelCombo: $labelCombo,
                            isChangeColor: $isChangeColor,
                            isShowCombobox: $isShowCombobox,
                            isStartRed: $isStartRed_2,
                            value: $dataRentOnline.tab_2_strLevel,
                            selectedIndex: $selectedIndexTab_2,
                            isTapComponent: $isTapComponent,
                            isTapLoop: Binding.constant(false),
                            currentCombobox: Binding.constant(false),
                            label: "loan_online_2_location_work",
                            index: 2
                        )
                        LoanOnlineCombobox(
                            indexForEachBinding: Binding.constant(0),
                            moreComboIndex: Binding.constant(0),
                            labelCombo: $labelCombo,
                            isChangeColor: $isChangeColor,
                            isShowCombobox: $isShowCombobox,
                            isStartRed: $isStartRed_2,
                            value: $dataRentOnline.tab_2_strWorkSheet,
                            selectedIndex: $selectedIndexTab_2,
                            isTapComponent: $isTapComponent,
                            isTapLoop: Binding.constant(false),
                            currentCombobox: Binding.constant(false),
                            label: "loan_online_2_sheet_work",
                            index: 3
                        )
                        LoanOnlineDateField(
                            indexForEachBinding: Binding.constant(0),
                            labelDatePicker: $labelDatePicker,
                            isChangeColor: $isChangeColor,
                            isShowDatePicker: $isShowDatePicker,
                            initValue: $dataRentOnline.tab_2_initValueWorkTime,
                            valueDate: Binding.constant(Date()),
                            isStartRed: $isStartRed_2,
                            valueIndex: $dataRentOnline.tab_2_indexWorkTime,
                            value: $dataRentOnline.tab_2_strWorkTime,
                            selectedIndex: $selectedIndexTab_2,
                            isTapComponent: $isTapComponent,
                            isTapLoop: Binding.constant(false),
                            currentCombobox: Binding.constant(false),
                            label: "loan_online_2_time_work",
                            isTooLong: true,
                            index: 4
                        )
                        LoanOnlineCombobox(
                            indexForEachBinding: Binding.constant(0),
                            moreComboIndex: Binding.constant(0),
                            labelCombo: $labelCombo,
                            isChangeColor: $isChangeColor,
                            isShowCombobox: $isShowCombobox,
                            isStartRed: $isStartRed_2,
                            value: $dataRentOnline.tab_2_strPayWay,
                            selectedIndex: $selectedIndexTab_2,
                            isTapComponent: $isTapComponent,
                            isTapLoop: Binding.constant(false),
                            currentCombobox: Binding.constant(false),
                            label: "loan_online_2_pay_way",
                            isTooLong: true,
                            index: 5
                        )
                    }.padding(.top, H(21))
                        .padding(.bottom, H(30))
                        .background(Color.white)
                        .padding(.top, H(56))
                        .padding(.horizontal, 16)
                } else { // MARK: THU NHẬP HIỆN CÓ
                    VStack (spacing: 0) {
                        VStack (spacing: H(20)) {
                            LoanOnlineTextField(
                                isStartRed: $isStartRed_3,
                                value: $dataRentOnline.tab_2_strRealSalary,
                                selectedIndex: $selectedIndexTab_2,
                                isTapComponent: $isTapComponent,
                                isTapLoop: Binding.constant(false),
                                currentCombobox: Binding.constant(false),
                                label: "loan_online_2_real_salary",
                                isNumber: true,
                                rightHolder: "VND",
                                index: 6,
                                isNumberComma: true
                            )
                            LoanOnlineTextField(
                                isStartRed: $isStartRed_3,
                                value: $dataRentOnline.tab_2_strOtherSalary,
                                selectedIndex: $selectedIndexTab_2,
                                isTapComponent: $isTapComponent,
                                isTapLoop: Binding.constant(false),
                                currentCombobox: Binding.constant(false),
                                label: "loan_online_2_other_income",
                                isNumber: true,
                                rightHolder: "VND",
                                index: 7,
                                isNumberComma: true
                            )
                            LoanOnlineTextField(
                                isStartRed: $isStartRed_3,
                                value: $dataRentOnline.tab_2_strPayment,
                                selectedIndex: $selectedIndexTab_2,
                                isTapComponent: $isTapComponent,
                                isTapLoop: Binding.constant(false),
                                currentCombobox: Binding.constant(false),
                                label: "loan_online_2_payment",
                                isNumber: true,
                                rightHolder: "VND",
                                index: 8,
                                isNumberComma: true
                            )
                            LoanOnlineDisableField(value: "--", label: "loan_online_2_save_salary", rightHolder: "VND")
                        }.padding(.top, H(21))
                            .padding(.bottom, H(30))
                            .background(Color.white)
                            .padding(.bottom, H(16))

                        // MARK: CHI TIẾT KHOẢN THU NHẬP KHÁC
                        VStack (alignment: .leading, spacing: H(20)) {
                            TextCustom(text: NSLocalizedString("loan_online_2_detail_other_income", comment: ""), font: MEDIUM, size: 16, color: #colorLiteral(red: 0.4281106591, green: 0.1894766092, blue: 0.6721540093, alpha: 1))
                                .padding(.bottom, H(6))
                                .padding(.leading, 14)
                            if !dataRentOnline.tab_2_isAppendingOtherSalary {
                                ForEach(0 ..< dataRentOnline.tab_2_arrOtherSalary.count) { i in
                                    if i > 0 {
                                        Rectangle()
                                            .foregroundColor(.init(#colorLiteral(red: 0.665820241, green: 0.6659018993, blue: 0.6657924652, alpha: 1)))
                                            .frame(width: FULL_W - 60, height: 1)
                                            .padding(.leading, 14)
                                    }
                                    OtherSalaryView(
                                        indexForEachBinding: self.$dataRentOnline.tab_2_indexOtherSalary,
                                        moreComboIndex: self.$dataRentOnline.tab_2_moreComboIndex,
                                        labelCombo: self.$labelCombo,
                                        isChangeColor: self.$isChangeColor,
                                        isShowCombobox: self.$isShowCombobox,
                                        isStartRed: self.$isStartRed_3,
                                        arr: self.$dataRentOnline.tab_2_arrOtherSalary,
                                        data: self.$dataRentOnline.tab_2_arrOtherSalary[i],
                                        isTapComponent: self.$isTapComponent,
                                        isTapLoop: self.$isTapLoop,
                                        index: i,
                                        number: 0
                                    )
                                }
                            }
                            ZStack (alignment: .leading) {
                                Button(action: {
                                    UIApplication.shared.endEditing()
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                        self.appendOtherSalary()
                                    }
                                }) {
                                    HStack (spacing: 10) {
                                        ImageCustom(name: "iconFeatherPlusCircle", w: 16, h: 16)
                                        TextCustom(text: NSLocalizedString("loan_online_2_add_more_income", comment: ""), font: REGULAR, size: 14, color: #colorLiteral(red: 0.4281106591, green: 0.1894766092, blue: 0.6721540093, alpha: 1))
                                    }
                                }.buttonStyle(ButtonTapScale())
                                HStack {
                                    Spacer()
                                    Button(action: {
                                        UIApplication.shared.endEditing()
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                            self.removeOtherSalary()
                                        }
                                    }) {
                                        HStack (spacing: 10) {
                                            ImageCustom(name: "iconFeatherMinusCircle", w: 16, h: 16)
                                            TextCustom(text: NSLocalizedString("loan_online_2_remove_income", comment: ""), font: REGULAR, size: 14, color: #colorLiteral(red: 0.9133259654, green: 0.297054708, blue: 0.2958536744, alpha: 1))
                                        }
                                    }.buttonStyle(ButtonTapScale())
                                }.opacity(dataRentOnline.tab_2_arrOtherSalary.count > 1 ? 1 : 0)
                            }.frame(width: FULL_W - 60)
                                .animation(isStartAnimation ? .easeInOut(duration: 0.1) : .none)
                                .padding(.leading, 14)
                        }.padding(.vertical, H(21))
                            .frame(width: FULL_W - 32, alignment: .leading)
                            .background(Color.white)
                            .padding(.bottom, H(16))

                        // MARK: CHI TIẾT KHOẢN CHI TIÊU
                        VStack (alignment: .leading, spacing: H(20)) {
                            TextCustom(text: NSLocalizedString("loan_online_2_detail_pay_source", comment: ""), font: MEDIUM, size: 16, color: #colorLiteral(red: 0.4281106591, green: 0.1894766092, blue: 0.6721540093, alpha: 1))
                                .padding(.bottom, H(6))
                                .padding(.leading, 14)
                            if !dataRentOnline.tab_2_isAppendingPaySource {
                                ForEach(0 ..< dataRentOnline.tab_2_arrPaySource.count) { i in
                                    if i > 0 {
                                        Rectangle()
                                            .foregroundColor(.init(#colorLiteral(red: 0.665820241, green: 0.6659018993, blue: 0.6657924652, alpha: 1)))
                                            .frame(width: FULL_W - 60, height: 1)
                                            .padding(.leading, 14)
                                    }
                                    OtherSalaryView(
                                        indexForEachBinding: self.$dataRentOnline.tab_2_indexPaySource,
                                        moreComboIndex: self.$dataRentOnline.tab_2_moreComboIndex,
                                        labelCombo: self.$labelCombo,
                                        isChangeColor: self.$isChangeColor,
                                        isShowCombobox: self.$isShowCombobox,
                                        isStartRed: self.$isStartRed_3,
                                        arr: self.$dataRentOnline.tab_2_arrPaySource,
                                        data: self.$dataRentOnline.tab_2_arrPaySource[i],
                                        isTapComponent: self.$isTapComponent,
                                        isTapLoop: self.$isTapLoop,
                                        index: i,
                                        number: 1
                                    )
                                }
                            }
                            ZStack (alignment: .leading) {
                                Button(action: {
                                    UIApplication.shared.endEditing()
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                        self.appendPaySource()
                                    }
                                }) {
                                    HStack (spacing: 10) {
                                        ImageCustom(name: "iconFeatherPlusCircle", w: 16, h: 16)
                                        TextCustom(text: NSLocalizedString("loan_online_2_add_more_income_source", comment: ""), font: REGULAR, size: 14, color: #colorLiteral(red: 0.4281106591, green: 0.1894766092, blue: 0.6721540093, alpha: 1))
                                    }
                                }.buttonStyle(ButtonTapScale())
                                HStack {
                                    Spacer()
                                    Button(action: {
                                        UIApplication.shared.endEditing()
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                            self.removePaySource()
                                        }
                                    }) {
                                        HStack (spacing: 10) {
                                            ImageCustom(name: "iconFeatherMinusCircle", w: 16, h: 16)
                                            TextCustom(text: NSLocalizedString("loan_online_2_remove_income_source", comment: ""), font: REGULAR, size: 14, color: #colorLiteral(red: 0.9133259654, green: 0.297054708, blue: 0.2958536744, alpha: 1))
                                        }
                                    }.buttonStyle(ButtonTapScale())
                                }.opacity(dataRentOnline.tab_2_arrPaySource.count > 1 ? 1 : 0)
                            }.frame(width: FULL_W - 60)
                                .animation(isStartAnimation ? .easeInOut(duration: 0.1) : .none)
                                .padding(.leading, 14)
                        }.padding(.vertical, H(21))
                            .frame(width: FULL_W - 32, alignment: .leading)
                            .background(Color.white)
                    }.padding(.top, H(56))
                        .padding(.horizontal, 16)
                }
            }.cornerRadius(0)
                .shadow(color: Color.init(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.1574878961)), radius: 6, x: 0, y: 3)
                .padding(.top, H(30))
        }.onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                self.isStartAnimation = true
            }
        }.onTapGesture {
            self.selectedIndexTab_2 = -1
        }
    }

    func appendOtherSalary() {
        self.dataRentOnline.tab_2_isAppendingOtherSalary = true
        dataRentOnline.tab_2_arrOtherSalary.append(TypeOtherSalary(combo: "", comboIndex: -1, value: "", index: self.dataRentOnline.tab_2_arrOtherSalary.count))
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            self.dataRentOnline.tab_2_isAppendingOtherSalary = false
        }
    }

    func appendPaySource() {
        self.dataRentOnline.tab_2_isAppendingPaySource = true
        dataRentOnline.tab_2_arrPaySource.append(TypeOtherSalary(combo: "", comboIndex: -1, value: "", index: self.dataRentOnline.tab_2_arrPaySource.count))
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            self.dataRentOnline.tab_2_isAppendingPaySource = false
        }
    }

    func removeOtherSalary() {
        if dataRentOnline.tab_2_isAppendingOtherSalary {
            dataRentOnline.tab_2_arrOtherSalary.removeLast()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                self.dataRentOnline.tab_2_isAppendingOtherSalary = false
                return
            }
        } else {
            dataRentOnline.tab_2_isAppendingOtherSalary = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                self.removeOtherSalary()
            }
        }
    }

    func removePaySource() {
        if dataRentOnline.tab_2_isAppendingPaySource {
            dataRentOnline.tab_2_arrPaySource.removeLast()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.005) {
                self.dataRentOnline.tab_2_isAppendingPaySource = false
                return
            }
        } else {
            dataRentOnline.tab_2_isAppendingPaySource = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.005) {
                self.removePaySource()
            }
        }
    }
}

struct OtherSalaryView: View {
    @Binding var indexForEachBinding: Int
    @Binding var moreComboIndex: Int
    @Binding var labelCombo: String
    @Binding var isChangeColor: Bool
    @Binding var isShowCombobox: Bool
    @Binding var isStartRed: Bool
    @Binding var arr: [TypeOtherSalary]
    @Binding var data: TypeOtherSalary
    @Binding var isTapComponent: Bool
    @Binding var isTapLoop: Bool

    @State var index = 0
    @State var number = 0
    @State var selectedIndex = -1
    @State var currentCombobox = false

    var body: some View {
        ZStack {
            if isTapComponent {
                Text("").onAppear {
                    self.selectedIndex = -1
                    self.isTapComponent = false
                }
            }
            if isTapLoop {
                Text("").onAppear {
                    if !self.currentCombobox {
                        self.selectedIndex = -1
                        self.isTapLoop = false
                    } else {
                        self.isTapLoop = false
                    }
                    self.currentCombobox = false
                }
            }
            VStack (spacing: H(20)) {
                LoanOnlineCombobox(
                    indexForEachBinding: $indexForEachBinding,
                    moreComboIndex: $moreComboIndex,
                    labelCombo: $labelCombo,
                    isChangeColor: $isChangeColor,
                    isShowCombobox: $isShowCombobox,
                    isStartRed: $isStartRed,
                    value: $data.combo,
                    selectedIndex: $selectedIndex,
                    isTapComponent: $isTapComponent,
                    isTapLoop: $isTapLoop,
                    currentCombobox: $currentCombobox,
                    label: number == 0 ? "loan_online_2_type_earn" : "loan_online_2_type_pay",
                    isMustHave: false,
                    index: number == 0 ? 9 : 11, // cần khi có 2 vùng thêm
                    isLoop: true,
                    indexForEach: index
                )
                LoanOnlineTextField(
                    isStartRed: $isStartRed,
                    value: $data.value,
                    selectedIndex: $selectedIndex,
                    isTapComponent: $isTapComponent,
                    isTapLoop: $isTapLoop,
                    currentCombobox: $currentCombobox,
                    label: "loan_online_2_money_amount",
                    isMustHave: false,
                    isNumber: true,
                    rightHolder: "VND",
                    index: number == 0 ? 10 : 12,
                    isLoop: true,
                    isNumberComma: true
                )
            }
        }
    }
}

struct LoanOnlineDisableField: View {
    @State var value = ""
    @State var label = ""
    @State var rightHolder = ""

    var body: some View {
        HStack (spacing: 0) {
            TextCustom(text: NSLocalizedString(label, comment: ""), font: REGULAR, size: 14, color: #colorLiteral(red: 0.665820241, green: 0.6659018993, blue: 0.6657924652, alpha: 1))
                .padding(.leading, 10)
            Spacer()
            TextCustom(text: value, size: 14, color: #colorLiteral(red: 0.1422221363, green: 0.1236664429, blue: 0.1232500449, alpha: 1))
                .padding(.trailing, rightHolder.isEmpty ? 16 : 5)
            if !rightHolder.isEmpty {
                TextCustom(text: rightHolder, font: REGULAR, size: 14, color: #colorLiteral(red: 0.665820241, green: 0.6659018993, blue: 0.6657924652, alpha: 1))
                    .padding(.trailing, 16)
            }
        }.frame(height: H(40))
            .background(Color.init(#colorLiteral(red: 0.9111830592, green: 0.9112924337, blue: 0.9111458659, alpha: 1)))
            .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.init(#colorLiteral(red: 0.9111830592, green: 0.9112924337, blue: 0.9111458659, alpha: 1)), lineWidth: 1))
            .padding(.horizontal, 14)
    }
}

