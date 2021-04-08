// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import SwiftUI

struct DetailStep_2: View {
    @Binding var isNext: Bool
    @Binding var selectedMethod: CGFloat
    @Binding var isChangeColor: Bool
    @Binding var isShowDatePicker: Bool
    @Binding var labelDatePicker: String
    @Binding var showNextFailed: Bool
    @Binding var isPaddingBottomKeyboard: Bool
    @Binding var isKeyboardPush: Bool
    @Binding var loanMoney: String
    @Binding var year: String
    @Binding var month: String
    @Binding var isCheckBox2_3: Bool
    @Binding var time: String
    @Binding var fee: String
    @Binding var isCheckBox2_2: Bool
    @Binding var time2_2: String
    @Binding var fee2_2: String
    @Binding var date_Step_1: Date
    @Binding var date_Step_2: Date
    @Binding var initValue: Int
    @Binding var purple: Int
    @Binding var sumMoney: String
    @Binding var green: Int
    @Binding var typeAlert: Int

    @State var initLoan = "--"
    @State var afterLoan = "--"
    
    @State var keyboardHeight: CGFloat = 0
    
    func nextStep() {
        if Int(loanMoney) ?? 0 < 100000000 { // MIN VALUE DEPENDS ON API
            self.showNextFailed = true
            self.typeAlert = 1
        } else {
            self.isNext = true
            self.initValue += 1
        }
    }

    func lackFail() {
        self.showNextFailed = true
        self.typeAlert = 0
    }

    var body: some View {
        VStack (spacing: 0) {
            VStack(spacing: 0) {
                SalePolicyStep2_1(
                    sumMoney: $sumMoney,
                    loanMoney: $loanMoney,
                    year: $year,
                    isPaddingBottomKeyboard: $isPaddingBottomKeyboard
                )
                SalePolicyStep2_2(
                    isKeyboardPush: $isKeyboardPush,
                    initLoan: $initLoan,
                    month: $month,
                    selectedMethod: $selectedMethod,
                    isChangeColor: $isChangeColor,
                    isShowDatePicker: $isShowDatePicker,
                    labelDatePicker: $labelDatePicker,
                    isCheckBox2_2: $isCheckBox2_2,
                    time2_2: $time2_2,
                    fee2_2: $fee2_2,
                    date_Step_2: $date_Step_2,
                    initValue: $initValue
                )
                if selectedMethod == 0 {
                    SalePolicyStep2_3(
                        isKeyboardPush: $isKeyboardPush,
                        afterLoan: $afterLoan,
                        time: $time,
                        fee: $fee,
                        isChangeColor: $isChangeColor,
                        isShowDatePicker: $isShowDatePicker,
                        labelDatePicker: $labelDatePicker,
                        isCheckBox2_3: $isCheckBox2_3,
                        date_Step_1: $date_Step_1,
                        initValue: $initValue
                    )
                }
            }.padding(.vertical, H(30))
                .padding(.horizontal, 16)
                .cornerRadius(0)
                .shadow(color: Color.init(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.1574878961)), radius: 6, x: 0, y: 3)
            Button(action: {
                self.green = Int(self.sumMoney) ?? 0
                self.purple = Int(self.loanMoney) ?? 0
                if self.selectedMethod == 0 {
                    if self.initValue != 1 && !self.loanMoney.isEmpty && !self.year.isEmpty && !self.month.isEmpty {
                        if self.isCheckBox2_3 {
                            if !self.time.isEmpty && !self.fee.isEmpty {
                                self.nextStep()
                            } else { self.lackFail() }
                        } else { self.nextStep() }
                    } else { self.lackFail() }
                } else {
                    if self.initValue != 1 && !self.loanMoney.isEmpty && !self.year.isEmpty {
                        if self.isCheckBox2_2 {
                            if !self.time2_2.isEmpty && !self.fee2_2.isEmpty {
                                self.nextStep()
                            } else { self.lackFail() }
                        } else { self.nextStep() }
                    } else { self.lackFail() }
                }
            }) {
                ZStack {
                    TextCustom(text: NSLocalizedString("sale_policy_step2_seeresults", comment: ""), font: MEDIUM, size: 16, color: .white)
                }.frame(width: FULL_W - 32, height: H(40))
                    .background(Color.init(#colorLiteral(red: 0.4281106591, green: 0.1894766092, blue: 0.6721540093, alpha: 1)))
                    .cornerRadius(4)
                    .shadow(color: Color.init(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.4005511558)), radius: 6, x: 3, y: 3)
            }.buttonStyle(ButtonTapScale())
                .padding(.bottom, H(35))
        }.keyboardAppear(keyboardHeight: $keyboardHeight)
            .animation(.easeInOut(duration: 0.1))
            .padding(.bottom, isPaddingBottomKeyboard && keyboardHeight > 0 ? keyboardHeight : 0)
            .offset(y: isKeyboardPush && keyboardHeight > 0 ? -keyboardHeight : 0)
    }
}

struct SalePolicyStep2_1: View {
    @Binding var sumMoney: String
    @Binding var loanMoney: String
    @Binding var year: String
    @Binding var isPaddingBottomKeyboard: Bool

    @State var viewPointerYear = CGSize.zero
    @State var saveWidthYear: CGFloat = 0
    @State var maxValueYear: CGFloat = 25
    @State var arrYearTemp = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12", "13", "14", "15", "16", "17", "18", "19", "20", "21", "22", "23", "24", "25"]
    @State var isSlide = false
    @State var isDoneEditingLoanMoney = true

    var body: some View {
        VStack (alignment: .leading, spacing: 0) {
            // MARK: TỔNG SỐ TIỀN (VND) =============================
            SalePolicyLabelCommon(label: "sale_policy_step2_totalmoney", type: "sale_policy_step2_unitmoney")
                .padding(.top, H(20))
                .padding(.leading, 14)
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundColor(.init(#colorLiteral(red: 0.9111830592, green: 0.9112924337, blue: 0.9111458659, alpha: 1)))
                    .frame(height: H(40))
                    .cornerRadius(4)
                TextCustom(text: Utils.formatHighNumber(Double(sumMoney) ?? 0), font: MEDIUM, size: 14, color: #colorLiteral(red: 0.1415808201, green: 0.1235596463, blue: 0.1233097687, alpha: 1))
                    .padding(.horizontal, 16)
            }.padding(.horizontal, 14)

            // MARK: SỐ TIỀN CẦN VAY =============================
            SalePolicyLabelCommon(label: "sale_policy_step2_loanmoney", type: "sale_policy_step2_unitmoney")
                .padding(.top, H(24))
                .padding(.leading, 14)
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(height: H(38))
                    .cornerRadius(4)
                    .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.init(#colorLiteral(red: 0.9008185267, green: 0.9009482265, blue: 0.9007901549, alpha: 1)), lineWidth: 1))
                ZStack (alignment: .leading) {
                    TextCustom(text: NSLocalizedString("sale_policy_step2_input_loanmoney", comment: ""), font: ITALIC, size: 14, color: #colorLiteral(red: 0.66581285, green: 0.6659106016, blue: 0.6657914519, alpha: 1))
                        .opacity(loanMoney.isEmpty ? 1 : 0)
                        .padding(.leading, 14)
                    ZStack (alignment: .leading) {
                        TextCustom(text: Utils.formatHighNumber(Double(loanMoney) ?? 0) == "0" ? "" : Utils.formatHighNumber(Double(loanMoney) ?? 0)
                            , font: MEDIUM, size: 14, color: #colorLiteral(red: 0.1422221363, green: 0.1236664429, blue: 0.1232500449, alpha: 1))
                            .opacity(isDoneEditingLoanMoney ? 1 : 0)
                        TextField("", text: $loanMoney, onEditingChanged: { rs in
                            if rs {
                                self.isPaddingBottomKeyboard = true
                                self.isDoneEditingLoanMoney = false
                            } else {
                                self.isPaddingBottomKeyboard = false
                                self.isDoneEditingLoanMoney = true
                            }
                        }).keyboardType(.numberPad)
                            .font(.custom(MEDIUM, size: H(14)))
                            .foregroundColor(.init(isDoneEditingLoanMoney ?#colorLiteral(red: 0.1422221363, green: 0.1236664429, blue: 0.1232500449, alpha: 0): #colorLiteral(red: 0.1422221363, green: 0.1236664429, blue: 0.1232500449, alpha: 1)))
                    }.frame(height: H(14))
                        .padding(.horizontal, 14)
                }
            }.padding(.horizontal, 14)

            // MARK: THỜI HẠN VAY =============================
            SalePolicyLabelCommon(label: "sale_policy_step2_loabdealine", type: "sale_policy_step2_unityear")
                .padding(.top, H(24))
                .padding(.leading, 14)
            ZStack {
                if self.year == "0" {
                    Text("").onAppear {
                        self.year = "1"
                        self.viewPointerYear.width = 0
                        self.saveWidthYear = 0
                    }
                }
                if self.year.isEmpty {
                    Text("").onAppear {
                        self.viewPointerYear.width = 0
                        self.saveWidthYear = 0
                    }
                }
                if CGFloat(truncating: NumberFormatter().number(from: self.year) ?? 1) > maxValueYear {
                    Text("").onAppear {
                        self.year = "\(Utils.formatIntNumber(Double(self.maxValueYear)))"
                        self.saveWidthYear = FULL_W - 74
                    }
                }
                if !isSlide {
                    ForEach(0 ..< self.arrYearTemp.count) { i in
                        if self.year == self.arrYearTemp[i] {
                            Text("").onAppear {
                                self.viewPointerYear.width = (CGFloat(truncating: NumberFormatter().number(from: self.year) ?? 1) - 1) * ((FULL_W - 74) / (self.maxValueYear - 1))
                                self.saveWidthYear = self.viewPointerYear.width
                            }
                        }
                    }
                }
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(height: H(38))
                    .cornerRadius(4)
                    .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.init(#colorLiteral(red: 0.9008185267, green: 0.9009482265, blue: 0.9007901549, alpha: 1)), lineWidth: 1))
                ZStack (alignment: .leading) {
                    TextCustom(text: NSLocalizedString("sale_policy_step2_inputnumberyear", comment: ""), font: ITALIC, size: 14, color: #colorLiteral(red: 0.66581285, green: 0.6659106016, blue: 0.6657914519, alpha: 1))
                        .opacity(year.isEmpty ? 1 : 0)
                        .padding(.leading, 14)
                    CustomTextField2Number(textDefault: $year, changeHandler: { rs in
                        self.year = rs
                        for i in 0 ..< self.arrYearTemp.count {
                            if self.year == self.arrYearTemp[i] {
                                self.viewPointerYear.width = (CGFloat(truncating: NumberFormatter().number(from: self.year) ?? 1) - 1) * ((FULL_W - 74) / (self.maxValueYear - 1))
                                self.saveWidthYear = self.viewPointerYear.width
                            }
                        }
                    }).onTapGesture {
                        self.isPaddingBottomKeyboard = true
                    }.padding(.horizontal, 14)
                        .frame(height: H(14))
                }
            }.padding(.horizontal, 14)
                .padding(.bottom, H(14))
            HStack {
                TextCustom(text: "1 \(NSLocalizedString("sale_policy_step2_year", comment: ""))", font: REGULAR, size: 14, color: #colorLiteral(red: 0.665820241, green: 0.6659018993, blue: 0.6657924652, alpha: 1))
                Spacer()
                TextCustom(text: "25 \(NSLocalizedString("sale_policy_step2_year", comment: ""))", font: REGULAR, size: 14, color: #colorLiteral(red: 0.665820241, green: 0.6659018993, blue: 0.6657924652, alpha: 1))
            }.frame(width: FULL_W - 60)
                .padding(.leading, 14)
            CustomerSliderStep(type: "year", isSlide: $isSlide, value: $year, viewPointer: $viewPointerYear, saveWidth: $saveWidthYear, maxValue: maxValueYear)
                .offset(y: -9)
        }.background(Color.init(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
            .padding(.bottom, H(30))
    }
}

struct SalePolicyStep2_2: View {
    @Binding var isKeyboardPush: Bool
    @Binding var initLoan: String
    @Binding var month: String
    @Binding var selectedMethod: CGFloat
    @Binding var isChangeColor: Bool
    @Binding var isShowDatePicker: Bool
    @Binding var labelDatePicker: String
    @Binding var isCheckBox2_2: Bool
    @Binding var time2_2: String
    @Binding var fee2_2: String
    @Binding var date_Step_2: Date
    @Binding var initValue: Int

    @State var viewPointerMonth = CGSize.zero
    @State var saveWidthMonth: CGFloat = 0
    @State var maxValueMonth: CGFloat = 12
    @State var arrMonthTemp = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"]
    @State var isSlide = false

    var dateFormatter: DateFormatter {
        let df = DateFormatter()
        df.dateFormat = "dd/MM/yyyy"
        return df
    }

    var body: some View {
        VStack (alignment: .leading, spacing: 0) {
            // MARK: LÃI SUẤT VAY BAN ĐẦU (%/năm)=============================
            SalePolicyLabelCommon(label: selectedMethod == 0 ? "sale_policy_step2_initloan" : "sale_policy_step2_init", type: "sale_policy_step2_ratioyear")
                .padding(.top, H(20))
                .padding(.leading, 14)
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundColor(.init(#colorLiteral(red: 0.9111830592, green: 0.9112924337, blue: 0.9111458659, alpha: 1)))
                    .frame(height: H(40))
                    .cornerRadius(4)
                TextCustom(text: "\(self.initLoan)", font: MEDIUM, size: 14, color: #colorLiteral(red: 0.1415808201, green: 0.1235596463, blue: 0.1233097687, alpha: 1))
                    .padding(.horizontal, 16)
            }.padding(.horizontal, 14)

            if selectedMethod == 0 {
                // MARK: THỜI HẠN CỐ ĐỊNH LÃI SUẤT (tháng)=============================
                SalePolicyLabelCommon(label: "sale_policy_step2_timepermanent", type: "sale_policy_step2_unitmonth")
                    .padding(.top, H(24))
                    .padding(.leading, 14)
                ZStack {
                    if self.month == "0" {
                        Text("").onAppear {
                            self.month = "1"
                            self.viewPointerMonth.width = 0
                            self.saveWidthMonth = 0
                        }
                    }
                    if self.month.isEmpty {
                        Text("").onAppear {
                            self.viewPointerMonth.width = 0
                            self.saveWidthMonth = 0
                        }
                    }
                    if CGFloat(truncating: NumberFormatter().number(from: self.month) ?? 1) > maxValueMonth {
                        Text("").onAppear {
                            self.month = "\(Utils.formatIntNumber(Double(self.maxValueMonth)))"
                            self.saveWidthMonth = FULL_W - 74
                        }
                    }
                    if !isSlide {
                        ForEach(0 ..< self.arrMonthTemp.count) { i in
                            if self.month == self.arrMonthTemp[i] {
                                Text("").onAppear {
                                    self.viewPointerMonth.width = (CGFloat(truncating: NumberFormatter().number(from: self.month) ?? 1) - 1) * ((FULL_W - 74) / (self.maxValueMonth - 1))
                                    self.saveWidthMonth = self.viewPointerMonth.width
                                }
                            }
                        }
                    }
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(height: H(38))
                        .cornerRadius(4)
                        .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.init(#colorLiteral(red: 0.9008185267, green: 0.9009482265, blue: 0.9007901549, alpha: 1)), lineWidth: 1))
                    ZStack (alignment: .leading) {
                        TextCustom(text: NSLocalizedString("sale_policy_step2_inputmonth", comment: ""), font: ITALIC, size: 14, color: #colorLiteral(red: 0.66581285, green: 0.6659106016, blue: 0.6657914519, alpha: 1))
                            .opacity(month.isEmpty ? 1 : 0)
                            .padding(.leading, 14)
                        CustomTextField2Number(textDefault: $month, changeHandler: { rs in
                            self.month = rs
                            for i in 0 ..< self.arrMonthTemp.count {
                                if self.month == self.arrMonthTemp[i] {
                                    self.viewPointerMonth.width = (CGFloat(truncating: NumberFormatter().number(from: self.month) ?? 1) - 1) * ((FULL_W - 74) / (self.maxValueMonth - 1))
                                    self.saveWidthMonth = self.viewPointerMonth.width
                                }
                            }
                        }).padding(.horizontal, 14)
                            .frame(height: H(14))
                            .onTapGesture {
                                self.isKeyboardPush = true
                        }
                    }
                }.padding(.horizontal, 14)
                    .padding(.bottom, H(14))
                HStack {
                    TextCustom(text: "1 \(NSLocalizedString("sale_policy_step2_unitmonth", comment: ""))", font: REGULAR, size: 14, color: #colorLiteral(red: 0.665820241, green: 0.6659018993, blue: 0.6657924652, alpha: 1))
                    Spacer()
                    TextCustom(text: "12 \(NSLocalizedString("sale_policy_step2_unitmonth", comment: ""))", font: REGULAR, size: 14, color: #colorLiteral(red: 0.665820241, green: 0.6659018993, blue: 0.6657924652, alpha: 1))
                }.frame(width: FULL_W - 60)
                    .padding(.leading, 14)
                CustomerSliderStep(type: "month", isSlide: $isSlide, value: $month, viewPointer: $viewPointerMonth, saveWidth: $saveWidthMonth, maxValue: maxValueMonth)
                    .offset(y: -9)
            } else {
                // MARK: THỜI HẠN CỐ ĐỊNH LÃI SUẤT
                TextCustom(text: NSLocalizedString(selectedMethod == 1 ? "sale_policy_step2_datepaymore" : "sale_policy_step2_datepaymoreFirst", comment: ""), size: 16, color: #colorLiteral(red: 0.1415808201, green: 0.1235596463, blue: 0.1233097687, alpha: 1))
                    .padding(.top, H(24))
                    .padding(.leading, 14)
                    .padding(.bottom, H(8))
                Button(action: {
                    self.isShowDatePicker = true
                    self.isChangeColor = true
                    self.labelDatePicker = self.selectedMethod == 1 ? "sale_policy_step2_datepaymore" : "sale_policy_step2_datepaymoreFirst"
                }) {
                    ZStack (alignment: .trailing) {
                        Rectangle()
                            .foregroundColor(.white)
                            .frame(width: FULL_W - 62, height: H(38))
                            .cornerRadius(4)
                            .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.init(#colorLiteral(red: 0.9008185267, green: 0.9009482265, blue: 0.9007901549, alpha: 1)), lineWidth: 1))
                        HStack {
                            ZStack (alignment: .leading) {
                                Text("---")
                                    .foregroundColor(.init(#colorLiteral(red: 0.665820241, green: 0.6659018993, blue: 0.6657924652, alpha: 1)))
                                    .font(.custom(ITALIC, size: H(14)))
                                    .opacity(initValue == 1 ? 1 : 0)
                                Text("\(date_Step_2, formatter: dateFormatter)")
                                    .foregroundColor(.init(#colorLiteral(red: 0.1422221363, green: 0.1236664429, blue: 0.1232500449, alpha: 1)))
                                    .font(.custom(MEDIUM, size: H(14)))
                                    .opacity(initValue != 1 ? 1 : 0)
                            }.padding(.leading, 14)
                            Spacer()
                        }.frame(width: FULL_W - 62, height: H(38))
                        ImageCustom(name: "iconCalendar", w: 16, h: 18)
                            .padding(.trailing, 22)
                    }.padding(.leading, 14)
                }.buttonStyle(ButtonTapScale())
                    .animation(.easeInOut(duration: 0.1))

                // MARK: THANH TOÁN TRƯỚC HẠN?
                Button(action: {
                    self.isCheckBox2_2.toggle()
                    if !self.isCheckBox2_2 {
                        self.time2_2 = ""
                        self.fee2_2 = ""
                    }
                }) {
                    HStack(spacing: 0) {
                        ZStack {
                            if !isCheckBox2_2 {
                                Rectangle()
                                    .foregroundColor(.clear)
                                    .frame(width: W(21), height: W(21))
                                    .overlay(RoundedRectangle(cornerRadius: 2).stroke(Color.init(#colorLiteral(red: 0.9008283615, green: 0.9009366632, blue: 0.9007915854, alpha: 1)), lineWidth: 1))
                            } else {
                                ImageCustom(name: "checkPurpleStep", w: 21, h: 21)
                            }
                        }
                        TextCustom(text: NSLocalizedString("sale_policy_step2_paybeforematurity", comment: ""), font: REGULAR, size: 14, color: #colorLiteral(red: 0.1415808201, green: 0.1235596463, blue: 0.1233097687, alpha: 1))
                            .padding(.leading, 12)
                    }
                }.buttonStyle(ButtonTapScale())
                    .padding(.top, H(18))
                    .padding(.bottom, H(20))
                    .padding(.leading, 14)
                if self.isCheckBox2_2 {
                    VStack(alignment: .leading, spacing: 0) {
                        // MARK: THỜI GIAN DỰ TÍNH THANH TOÁN (tháng)=============================
                        SalePolicyLabelCommon(label: "sale_policy_step2_estimatedtimeofpayment", type: "sale_policy_step2_unitmonth")
                            .padding(.leading, 14)
                        ZStack(alignment: .leading) {
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(height: H(38))
                                .cornerRadius(4)
                                .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.init(#colorLiteral(red: 0.9008185267, green: 0.9009482265, blue: 0.9007901549, alpha: 1)), lineWidth: 1))
                            ZStack (alignment: .leading) {
                                TextCustom(text: NSLocalizedString("sale_policy_step2_inputdate", comment: ""), font: ITALIC, size: 14, color: #colorLiteral(red: 0.66581285, green: 0.6659106016, blue: 0.6657914519, alpha: 1))
                                    .opacity(time2_2.isEmpty ? 1 : 0)
                                    .padding(.leading, 14)
                                TextField("", text: $time2_2, onEditingChanged: { rs in
                                    if rs { self.isKeyboardPush = true }
                                    else { self.isKeyboardPush = false }
                                }).frame(height: H(14))
                                    .keyboardType(.numberPad)
                                    .font(.custom(MEDIUM, size: H(14)))
                                    .foregroundColor(.init(#colorLiteral(red: 0.1422221363, green: 0.1236664429, blue: 0.1232500449, alpha: 1)))
                                    .padding(.horizontal, 14)
                            }
                        }.padding(.horizontal, 14)

                        // MARK: PHÍ THANH TOÁN TRƯỚC HẠN (%)=============================
                        SalePolicyLabelCommon(label: "sale_policy_step2_earlypaymentfee", type: "sale_policy_step2_ratio")
                            .padding(.leading, 14)
                            .padding(.top, H(24))
                        ZStack(alignment: .leading) {
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(height: H(38))
                                .cornerRadius(4)
                                .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.init(#colorLiteral(red: 0.9008185267, green: 0.9009482265, blue: 0.9007901549, alpha: 1)), lineWidth: 1))
                            ZStack (alignment: .leading) {
                                TextCustom(text: NSLocalizedString("sale_policy_step2_usually", comment: ""), font: ITALIC, size: 14, color: #colorLiteral(red: 0.66581285, green: 0.6659106016, blue: 0.6657914519, alpha: 1))
                                    .opacity(fee2_2.isEmpty ? 1 : 0)
                                    .padding(.leading, 14)
                                TextField("", text: $fee2_2, onEditingChanged: { rs in
                                    if rs { self.isKeyboardPush = true }
                                    else { self.isKeyboardPush = false }
                                }).frame(height: H(14))
                                    .keyboardType(.numberPad)
                                    .font(.custom(MEDIUM, size: H(14)))
                                    .foregroundColor(.init(#colorLiteral(red: 0.1422221363, green: 0.1236664429, blue: 0.1232500449, alpha: 1)))
                                    .padding(.horizontal, 14)
                            }
                        }.padding(.horizontal, 14)
                            .padding(.bottom, H(24))
                    }
                }
            }
        }.background(Color.init(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
            .padding(.bottom, H(selectedMethod == 0 ? 30 : 0))
    }
}

struct CustomerSliderStep: View {
    @State var type = ""
    @Binding var isSlide: Bool
    @Binding var value: String
    @Binding var viewPointer: CGSize
    @Binding var saveWidth: CGFloat
    @State var maxValue: CGFloat = 10
    @State var maxSlider = FULL_W - 74
    @State var a: CGFloat = 0

    var body: some View {
        VStack (alignment: .leading, spacing: 0) {
            HStack {
                Spacer()
                ZStack (alignment: .leading) {
                    Rectangle()
                        .foregroundColor(.init(#colorLiteral(red: 0.4274509804, green: 0.1882352941, blue: 0.6705882353, alpha: 1)))
                        .frame(width: maxSlider, height: 8)
                        .cornerRadius(4)
                        .offset(x: -7)
                    Rectangle()
                        .foregroundColor(.clear)
                        .background(LinearGradient(gradient: Gradient(colors: [.init(#colorLiteral(red: 0.4274509804, green: 0.1882352941, blue: 0.6705882353, alpha: 1)), .init(#colorLiteral(red: 0.2901960784, green: 0.231372549, blue: 0.8, alpha: 1))]), startPoint: .leading, endPoint: .trailing))
                        .frame(width: maxSlider, height: 8)
                        .cornerRadius(4)
                    Rectangle()
                        .foregroundColor(.init(#colorLiteral(red: 0.9316962957, green: 0.9284904599, blue: 0.9356402159, alpha: 1)))
                        .frame(width: 14, height: 8)
                        .cornerRadius(4)
                        .offset(x: maxSlider - 7)
                    Rectangle().cornerRadius(4)
                        .foregroundColor(.init(#colorLiteral(red: 0.9316962957, green: 0.9284904599, blue: 0.9356402159, alpha: 1)))
                        .frame(width: a * (maxValue - CGFloat(truncating: NumberFormatter().number(from: self.value) ?? 1)), height: 8)
                        .padding(.leading, a * (CGFloat(truncating: NumberFormatter().number(from: self.value) ?? 1) - 1))

                    // MARK: SLIDER
                    ZStack {
                        Image("pointerMove")
                            .resizable()
                            .frame(width: 14, height: 14)
                            .shadow(color: Color.init(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2)), radius: 3)
                        Image("EmptyPicture")
                            .resizable()
                            .frame(width: 38, height: 38)
                    }.offset(x: -19)
                        .offset(x: viewPointer.width >= 0 && viewPointer.width <= maxSlider ? viewPointer.width : viewPointer.width > maxSlider ? maxSlider : 0)
                        .gesture(
                            DragGesture()
                                .onChanged({ value in
                                    self.isSlide = true
                                    if self.viewPointer.width >= 0 && self.viewPointer.width <= self.maxSlider {
                                        self.viewPointer.width = value.translation.width + self.saveWidth
                                        self.sliderValue()
                                    }
                                })
                                .onEnded({ value in
                                    // MARK: THẢ SLIDER TRONG VÙNG CHO PHÉP
                                    if self.viewPointer.width >= 0 && self.viewPointer.width <= self.maxSlider {
                                        self.viewPointer.width = value.translation.width + self.saveWidth
                                        self.sliderValue()
                                    }
                                    self.saveWidth = self.viewPointer.width
                                    self.isSlide = false
                                })
                        )
                }
                Spacer()
            }.frame(width: FULL_W - 32)
            if !value.isEmpty && value != "0" && value != "1" && value != "\(Utils.formatIntNumber(Double(self.maxValue)))" {
                ZStack {
                    TextCustom(text: "\(value) \(NSLocalizedString(type == "month" ? "sale_policy_step2_unitmonth" : "sale_policy_step2_year", comment: ""))", size: 14, color: #colorLiteral(red: 0.4281106591, green: 0.1894766092, blue: 0.6721540093, alpha: 1))
                }.frame(width: type == "year" ?
                    FULL_H == H_SE && FULL_W == W_SE ? 31: // iPhone SE 1st generation
                    FULL_H == H_8 && FULL_W == W_8 ? 37: // iPhone 8 && iPhone SE 2nd generation
                    FULL_H == H_8Plus && FULL_W == W_8Plus ? 40: // iPhone 8 Plus
                    FULL_H == H_11 && FULL_W == W_11 ? 49: // iPhone 11 && iPhone 11 Pro Max
                    FULL_H == H_11Pro && FULL_W == W_11Pro ? 44 : 0 // iPhone 11 Pro
                    : // type month
                    FULL_H == H_SE && FULL_W == W_SE ? 35: // iPhone SE 1st generation
                    FULL_H == H_8 && FULL_W == W_8 ? 43: // iPhone 8 && iPhone SE 2nd generation
                    FULL_H == H_8Plus && FULL_W == W_8Plus ? 48: // iPhone 8 Plus
                    FULL_H == H_11 && FULL_W == W_11 ? 58: // iPhone 11 && iPhone 11 Pro Max
                    FULL_H == H_11Pro && FULL_W == W_11Pro ? 54 : 0 // iPhone 11 Pro
                ).padding(.horizontal, 6)
                    .padding(.bottom, 5)
                    .padding(.top, 12)
                    .background(
                        Image("purpleBubble")
                            .resizable()
                            .shadow(color: Color.init(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.1574878961)), radius: 4)
                    ).padding(.bottom, !value.isEmpty && value != "0" && value != "1" && value != "\(Utils.formatIntNumber(Double(self.maxValue)))" ? 6 : 0)
                    .offset(x: type == "year" ?
                        FULL_H == H_SE && FULL_W == W_SE ? -0.5: // iPhone SE 1st generation
                        FULL_H == H_8 && FULL_W == W_8 ? -4: // iPhone 8 && iPhone SE 2nd generation
                        FULL_H == H_8Plus && FULL_W == W_8Plus ? -5.5: // iPhone 8 Plus
                        FULL_H == H_11 && FULL_W == W_11 ? -10: // iPhone 11 && iPhone 11 Pro Max
                        FULL_H == H_11Pro && FULL_W == W_11Pro ? -7.5 : 0 // iPhone 11 Pro
                        : // type month
                        FULL_H == H_SE && FULL_W == W_SE ? -2.5: // iPhone SE 1st generation
                        FULL_H == H_8 && FULL_W == W_8 ? -6.5: // iPhone 8 && iPhone SE 2nd generation
                        FULL_H == H_8Plus && FULL_W == W_8Plus ? -10: // iPhone 8 Plus
                        FULL_H == H_11 && FULL_W == W_11 ? -14.5: // iPhone 11 && iPhone 11 Pro Max
                        FULL_H == H_11Pro && FULL_W == W_11Pro ? -12.5 : 0 // iPhone 11 Pro
                    )
                    .offset(x: viewPointer.width >= 0 && viewPointer.width <= maxSlider ? viewPointer.width : viewPointer.width > maxSlider ? maxSlider : 0, y: -6)
            }
        }.animation(.none)
            .onAppear {
                self.a = (self.maxSlider) / (self.maxValue - 1)
        }
    }

    func sliderValue() {
        if self.viewPointer.width <= 0.5 * self.a {
            self.value = "1"
            self.viewPointer.width = 0 * self.a
        }
        for i in 0 ..< Int(maxValue - 1) {
            if self.viewPointer.width > (CGFloat(i) + 0.5) * self.a && self.viewPointer.width <= (CGFloat(i) + 1.5) * self.a {
                self.value = "\(i + 2)"
                self.viewPointer.width = CGFloat(i + 1) * self.a
            }
        }
        if self.viewPointer.width > (self.maxValue - 1.5) * self.a {
            self.value = "\(Utils.formatIntNumber(Double(self.maxValue)))"
            self.viewPointer.width = (self.maxValue - 1) * self.a
        }
    }
}

struct SalePolicyStep2_3: View {
    @Binding var isKeyboardPush: Bool
    @Binding var afterLoan: String
    @Binding var time: String
    @Binding var fee: String
    @Binding var isChangeColor: Bool
    @Binding var isShowDatePicker: Bool
    @Binding var labelDatePicker: String
    @Binding var isCheckBox2_3: Bool
    @Binding var date_Step_1: Date
    @Binding var initValue: Int

    var dateFormatter: DateFormatter {
        let df = DateFormatter()
        df.dateFormat = "dd/MM/yyyy"
        return df
    }

    var body: some View {
        VStack (alignment: .leading, spacing: 0) {
            // MARK: LÃI SUẤT TRUNG BÌNH SAU ƯU ĐÃI (%/năm)=============================
            SalePolicyLabelCommon(label: "sale_policy_step2_averageinterest", type: "sale_policy_step2_ratioyear")
                .padding(.top, H(20))
                .padding(.leading, 14)
            ZStack(alignment: .leading) {
                Rectangle()
                    .foregroundColor(.init(#colorLiteral(red: 0.9111830592, green: 0.9112924337, blue: 0.9111458659, alpha: 1)))
                    .frame(height: H(40))
                    .cornerRadius(4)
                TextCustom(text: "\(self.afterLoan)", font: MEDIUM, size: 14, color: #colorLiteral(red: 0.1415808201, green: 0.1235596463, blue: 0.1233097687, alpha: 1))
                    .padding(.horizontal, 16)
            }.padding(.horizontal, 14)

            // MARK: NGÀY TRẢ
            TextCustom(text: NSLocalizedString("sale_policy_step2_datepaymore", comment: ""), size: 16, color: #colorLiteral(red: 0.1415808201, green: 0.1235596463, blue: 0.1233097687, alpha: 1))
                .padding(.top, H(24))
                .padding(.leading, 14)
                .padding(.bottom, H(8))
            Button(action: {
                self.isShowDatePicker = true
                self.isChangeColor = true
                self.labelDatePicker = "sale_policy_step2_datepaymore"
            }) {
                ZStack (alignment: .trailing) {
                    Rectangle()
                        .foregroundColor(.white)
                        .frame(width: FULL_W - 62, height: H(38))
                        .cornerRadius(4)
                        .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.init(#colorLiteral(red: 0.9008185267, green: 0.9009482265, blue: 0.9007901549, alpha: 1)), lineWidth: 1))
                    HStack {
                        ZStack (alignment: .leading) {
                            Text("---")
                                .foregroundColor(.init(#colorLiteral(red: 0.665820241, green: 0.6659018993, blue: 0.6657924652, alpha: 1)))
                                .font(.custom(ITALIC, size: H(14)))
                                .opacity(initValue == 1 ? 1 : 0)
                            Text("\(date_Step_1, formatter: dateFormatter)")
                                .foregroundColor(.init(#colorLiteral(red: 0.1422221363, green: 0.1236664429, blue: 0.1232500449, alpha: 1)))
                                .font(.custom(MEDIUM, size: H(14)))
                                .opacity(initValue != 1 ? 1 : 0)
                        }.padding(.leading, 14)
                        Spacer()
                    }.frame(width: FULL_W - 62, height: H(38))
                    ImageCustom(name: "iconCalendar", w: 16, h: 18)
                        .padding(.trailing, 22)
                }.padding(.leading, 14)
            }.buttonStyle(ButtonTapScale())
                .animation(.easeInOut(duration: 0.1))

            // MARK: THANH TOÁN TRƯỚC HẠN?
            Button(action: {
                self.isCheckBox2_3.toggle()
                if !self.isCheckBox2_3 {
                    self.time = ""
                    self.fee = ""
                }
            }) {
                HStack(spacing: 0) {
                    ZStack {
                        if !isCheckBox2_3 {
                            Rectangle()
                                .foregroundColor(.clear)
                                .frame(width: W(21), height: W(21))
                                .overlay(RoundedRectangle(cornerRadius: 2).stroke(Color.init(#colorLiteral(red: 0.9008283615, green: 0.9009366632, blue: 0.9007915854, alpha: 1)), lineWidth: 1))
                        } else {
                            ImageCustom(name: "checkPurpleStep", w: 21, h: 21)
                        }
                    }
                    TextCustom(text: NSLocalizedString("sale_policy_step2_paybeforematurity", comment: ""), font: REGULAR, size: 14, color: #colorLiteral(red: 0.1415808201, green: 0.1235596463, blue: 0.1233097687, alpha: 1))
                        .padding(.leading, 12)
                }
            }.buttonStyle(ButtonTapScale())
                .padding(.top, H(18))
                .padding(.bottom, H(20))
                .padding(.leading, 14)
            if self.isCheckBox2_3 {
                VStack(alignment: .leading, spacing: 0) {
                    // MARK: THỜI GIAN DỰ TÍNH THANH TOÁN (tháng)=============================
                    SalePolicyLabelCommon(label: "sale_policy_step2_estimatedtimeofpayment", type: "sale_policy_step2_unitmonth")
                        .padding(.leading, 14)
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(height: H(38))
                            .cornerRadius(4)
                            .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.init(#colorLiteral(red: 0.9008185267, green: 0.9009482265, blue: 0.9007901549, alpha: 1)), lineWidth: 1))
                        ZStack (alignment: .leading) {
                            TextCustom(text: NSLocalizedString("sale_policy_step2_inputdate", comment: ""), font: ITALIC, size: 14, color: #colorLiteral(red: 0.66581285, green: 0.6659106016, blue: 0.6657914519, alpha: 1))
                                .opacity(time.isEmpty ? 1 : 0)
                                .padding(.leading, 14)
                            TextField("", text: $time, onEditingChanged: { rs in
                                if rs { self.isKeyboardPush = true }
                                else { self.isKeyboardPush = false }
                            }).frame(height: H(14))
                                .keyboardType(.numberPad)
                                .font(.custom(MEDIUM, size: H(14)))
                                .foregroundColor(.init(#colorLiteral(red: 0.1422221363, green: 0.1236664429, blue: 0.1232500449, alpha: 1)))
                                .padding(.horizontal, 14)
                        }
                    }.padding(.horizontal, 14)

                    // MARK: PHÍ THANH TOÁN TRƯỚC HẠN (%)=============================
                    SalePolicyLabelCommon(label: "sale_policy_step2_earlypaymentfee", type: "sale_policy_step2_ratio")
                        .padding(.leading, 14)
                        .padding(.top, H(24))
                    ZStack(alignment: .leading) {
                        Rectangle()
                            .foregroundColor(.clear)
                            .frame(height: H(38))
                            .cornerRadius(4)
                            .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.init(#colorLiteral(red: 0.9008185267, green: 0.9009482265, blue: 0.9007901549, alpha: 1)), lineWidth: 1))
                        ZStack (alignment: .leading) {
                            TextCustom(text: NSLocalizedString("sale_policy_step2_usually", comment: ""), font: ITALIC, size: 14, color: #colorLiteral(red: 0.66581285, green: 0.6659106016, blue: 0.6657914519, alpha: 1))
                                .opacity(fee.isEmpty ? 1 : 0)
                                .padding(.leading, 14)
                            TextField("", text: $fee, onEditingChanged: { rs in
                                if rs { self.isKeyboardPush = true }
                                else { self.isKeyboardPush = false }
                            }).frame(height: H(14))
                                .keyboardType(.numberPad)
                                .font(.custom(MEDIUM, size: H(14)))
                                .foregroundColor(.init(#colorLiteral(red: 0.1422221363, green: 0.1236664429, blue: 0.1232500449, alpha: 1)))
                                .padding(.horizontal, 14)
                        }
                    }.padding(.horizontal, 14)
                        .padding(.bottom, H(24))
                }
            }
        }.background(Color.init(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
    }
}

struct SalePolicyLabelCommon: View {
    @State var label = ""
    @State var type = ""
    @State var isHaveDot = true

    var body: some View {
        HStack(spacing: 0) {
            TextCustom(text: "\(NSLocalizedString(label, comment: "")) ", size: 16, color: #colorLiteral(red: 0.1415808201, green: 0.1235596463, blue: 0.1233097687, alpha: 1))
            TextCustom(text: "(\(NSLocalizedString(type, comment: "")))", font: REGULAR, size: 16, color: #colorLiteral(red: 0.1415808201, green: 0.1235596463, blue: 0.1233097687, alpha: 1))
            if isHaveDot {
                TextCustom(text: ":", font: MEDIUM, size: 16, color: #colorLiteral(red: 0.1415808201, green: 0.1235596463, blue: 0.1233097687, alpha: 1))
            }
        }.padding(.bottom, H(8))
    }
}
