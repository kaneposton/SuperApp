// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import SwiftUI

struct LoanOnlineTab_5: View {
    @Binding var dataRentOnline: ModalRentOnline
        
    @Binding var typeLoan: Int
    @Binding var sumMoney: String
    @Binding var moneyFirst: String
    @Binding var payTimes: Int
   
    @State var strFullAddress = ""
    @State var typeLoanStr = ""
    @State var payTimesStr = ""
    @State var selectedMethodName = ""
    @State var allMoneyPay = ""
    @State var realSalaryInt = 0
    @State var realSalary = ""
    @State var allOtherSalaryInt = 0
    @State var allOtherSalary = ""
    @State var allSumTreasureAmountInt = 0
    @State var allSumTreasureAmount = ""

    var body: some View {
        VStack (spacing: H(16)) {
            ZStack {
                VStack {
                    TabChangeLoanOnline(
                        currentSelectedFirstTab: $dataRentOnline.is_8,
                        selectedIndexPage: $dataRentOnline.selectedIndexPage,
                        index_1: 8,
                        index_2: 9,
                        label_1: "loan_online_5_title_1",
                        label_2: "loan_online_5_title_2"
                    )
                    Spacer()
                }.frame(width: FULL_W)

                // MARK: THÔNG TIN VAY VỐN
                if dataRentOnline.selectedIndexPage == 8 {
                    VStack (spacing: 0) {
                        // MARK: HỒ SƠ VAY
                        VStack (alignment: .leading, spacing: H(20)) {
                            TextCustom(text: NSLocalizedString("loan_online_5_sheet_rent", comment: ""), font: MEDIUM, size: 16, color: #colorLiteral(red: 0.4281106591, green: 0.1894766092, blue: 0.6721540093, alpha: 1))
                            HStack (alignment: .top) {
                                VStack (alignment: .leading, spacing: H(5)) {
                                    TextCustom(text: NSLocalizedString("loan_online_5_sheet_rent_code", comment: ""), font: REGULAR, size: 14, color: #colorLiteral(red: 0.6533299685, green: 0.6326879859, blue: 0.6321712136, alpha: 1))
                                    TextCustom(text: "#ID12450", size: 16, color: #colorLiteral(red: 0.2916272283, green: 0.233222574, blue: 0.7998139262, alpha: 1))
                                }
                                Spacer()
                                ZStack {
                                    Rectangle()
                                        .foregroundColor(.clear)
                                        .frame(width: W(150), height: W(63))
                                        .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.init(#colorLiteral(red: 0.9200527072, green: 0.8800705075, blue: 0.9638360143, alpha: 1)), lineWidth: 2))
                                        .cornerRadius(4)
                                    ImageCustom(name: "logoSCB", w: 108, h: 35)
                                }
                            }
                            RentInfoLine(label: "loan_online_5_rent_person", value: $dataRentOnline.tab_1_strName)
                            RentInfoLine(label: "loan_online_5_phone", value: $dataRentOnline.tab_1_strPhone)
                            RentInfoLine(label: "loan_online_5_address", value: $strFullAddress)
                            RentInfoLine(label: "EMAIL", value: $dataRentOnline.tab_1_strEmail)
                        }.padding(.top, H(21))
                            .padding(.bottom, H(25))
                            .padding(.horizontal, 14)
                            .frame(width: FULL_W - 32, alignment: .leading)
                            .background(Color.white)
                            .padding(.bottom, H(16))

                        // MARK: CHÍNH SÁCH BÁN HÀNG
                        VStack (alignment: .leading, spacing: H(20)) {
                            TextCustom(text: NSLocalizedString("loan_online_5_sale_way", comment: ""), font: MEDIUM, size: 16, color: #colorLiteral(red: 0.4281106591, green: 0.1894766092, blue: 0.6721540093, alpha: 1))
                            RentInfoLine(label: "loan_online_5_type_sale_way", value: $typeLoanStr)
                            RentInfoLine(label: "loan_online_5_money_first", value: $moneyFirst, isNumberComma: true)
                            RentInfoLine(label: "loan_online_5_time_pay", value: $payTimesStr)
                            RentInfoLine(label: "loan_online_5_sum_money", value: $sumMoney, isNumberComma: true)
                        }.padding(.top, H(21))
                            .padding(.bottom, H(25))
                            .padding(.horizontal, 14)
                            .frame(width: FULL_W - 32, alignment: .leading)
                            .background(Color.white)
                            .padding(.bottom, H(16))

                        // MARK: CHÍNH SÁCH VAY
                        VStack (alignment: .leading, spacing: H(20)) {
                            TextCustom(text: NSLocalizedString("loan_online_5_rent_way", comment: ""), font: MEDIUM, size: 16, color: #colorLiteral(red: 0.4281106591, green: 0.1894766092, blue: 0.6721540093, alpha: 1))
                            RentInfoLine(label: "loan_online_5_rent_wayment", value: $selectedMethodName)
                            RentInfoLine(label: "loan_online_5_rent_money_amount", value: $dataRentOnline.loanMoney, isNumberComma: true)
                            RentInfoLine(label: "loan_online_5_rent_time", value: $dataRentOnline.year)
                            RentInfoLine(label: "loan_online_5_sum_pay_back", value: $allMoneyPay, isNumberComma: true)
                        }.padding(.top, H(21))
                            .padding(.bottom, H(25))
                            .padding(.horizontal, 14)
                            .frame(width: FULL_W - 32, alignment: .leading)
                            .background(Color.white)
                    }.padding(.top, H(56))
                        .padding(.horizontal, 16)
                } else { // MARK: THU NHẬP & TÀI SẢN HIỆN CÓ
                    VStack (spacing: 0) {
                        // MARK: THU NHẬP
                        VStack (alignment: .leading, spacing: H(20)) {
                            TextCustom(text: NSLocalizedString("loan_online_5_income", comment: ""), font: MEDIUM, size: 16, color: #colorLiteral(red: 0.4281106591, green: 0.1894766092, blue: 0.6721540093, alpha: 1))
                            RentInfoLine(label: "loan_online_5_salary_month", value: $realSalary, isNumberComma: true)
                            RentInfoLine(label: "loan_online_5_sub_salary_other", value: $allOtherSalary, isNumberComma: true)
                        }.padding(.top, H(21))
                            .padding(.bottom, H(25))
                            .padding(.horizontal, 14)
                            .frame(width: FULL_W - 32, alignment: .leading)
                            .background(Color.white)
                            .padding(.bottom, H(16))

                        // MARK: GIÁ TRỊ TÀI SẢN
                        VStack (alignment: .leading, spacing: H(20)) {
                            TextCustom(text: NSLocalizedString("loan_online_5_treasure_value", comment: ""), font: MEDIUM, size: 16, color: #colorLiteral(red: 0.4281106591, green: 0.1894766092, blue: 0.6721540093, alpha: 1))
                            ForEach(dataRentOnline.tab_3_arrTreasure) { data in
                                RentInfoLine(label: "\(data.combo.uppercased())", value: Binding.constant(""), isX: true, value_1: data.value_1, value_2: data.value_2, isNumberComma: true)
                            }
                            RentInfoLine(label: "loan_online_5_now_money", value: $allSumTreasureAmount, isRed: true, isNumberComma: true)
                        }.padding(.top, H(21))
                            .padding(.bottom, H(25))
                            .padding(.horizontal, 14)
                            .frame(width: FULL_W - 32, alignment: .leading)
                            .background(Color.white)
                    }.padding(.top, H(56))
                        .padding(.horizontal, 16)
                }
            }.cornerRadius(0)
                .shadow(color: Color.init(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.1574878961)), radius: 6, x: 0, y: 3)
                .padding(.top, H(30))
        }.onAppear {
            // MARK: ĐỊA CHỈ
            let commaAddress = self.dataRentOnline.tab_1_strAddress.isEmpty ? "" : self.dataRentOnline.tab_1_strVillage.isEmpty && self.dataRentOnline.tab_1_strDistrict.isEmpty && self.dataRentOnline.tab_1_strCity.isEmpty ? "" : ", "
            let commaVillage = self.dataRentOnline.tab_1_strVillage.isEmpty ? "" : self.dataRentOnline.tab_1_strDistrict.isEmpty && self.dataRentOnline.tab_1_strCity.isEmpty ? "" : ", "
            let commaDistrict = self.dataRentOnline.tab_1_strDistrict.isEmpty ? "" : self.dataRentOnline.tab_1_strCity.isEmpty ? "" : ", "
            self.strFullAddress = "\(self.dataRentOnline.tab_1_strAddress)\(commaAddress)\(self.dataRentOnline.tab_1_strVillage)\(commaVillage)\(self.dataRentOnline.tab_1_strDistrict)\(commaDistrict)\(self.dataRentOnline.tab_1_strCity)"

            // MARK: LOẠI CHÍNH SÁCH BÁN HÀNG
            self.typeLoanStr = self.typeLoan == 0 ? "result_cs_tieu_chuan" : "result_cs_chiet_khau"

            // MARK: SỐ LẦN TRẢ
            self.payTimesStr = String(self.payTimes)

            // MARK: PHƯƠNG THỨC VAY
            self.selectedMethodName =
                Int(self.dataRentOnline.selectedMethod) == 0 ? "loan_online_5_vay_tha_noi":
                Int(self.dataRentOnline.selectedMethod) == 1 ? "loan_online_5_vay_tra_gop_deu" : "loan_online_5_vay_du_no_ban_dau"

            // MARK: TỔNG TIỀN TRẢ
            self.allMoneyPay = self.dataRentOnline.loanMoney // + thêm lãi suất %/năm ...

            // MARK: LƯƠNG THÁNG
            self.realSalaryInt = Int(self.dataRentOnline.tab_2_strRealSalary) ?? 0
            self.realSalary = "\(self.realSalaryInt)"

            // MARK: THU NHẬP PHỤ Ở NGOÀI BUÔN BÁN
            for i in 0 ..< self.dataRentOnline.tab_2_arrOtherSalary.count {
                self.allOtherSalaryInt += Int(self.dataRentOnline.tab_2_arrOtherSalary[i].value) ?? 0
            }
            self.allOtherSalaryInt += Int(self.dataRentOnline.tab_2_strOtherSalary) ?? 0
            self.allOtherSalary = "\(self.allOtherSalaryInt)"

            // MARK: TỔNG SỐ TIỀN HIỆN CÓ
            for i in 0 ..< self.dataRentOnline.tab_3_arrTreasure.count {
                self.allSumTreasureAmountInt += (Int(self.dataRentOnline.tab_3_arrTreasure[i].value_1) ?? 0) * (Int(self.dataRentOnline.tab_3_arrTreasure[i].value_2) ?? 0)
            }
            self.allSumTreasureAmount = "\(self.allSumTreasureAmountInt)"
        }
    }
}

struct RentInfoLine: View {
    @State var label = ""
    @Binding var value: String
    @State var isRed = false
    @State var isX = false
    @State var value_1 = ""
    @State var value_2 = ""
    @State var isNumberComma = false

    var body: some View {
        VStack (alignment: .leading, spacing: H(5)) {
            TextCustom(text: NSLocalizedString(label, comment: "").isEmpty ? "-" : NSLocalizedString(label, comment: ""), font: REGULAR, size: 14, color: isRed ? #colorLiteral(red: 0.932536602, green: 0.2507158816, blue: 0.2460758984, alpha: 1): #colorLiteral(red: 0.6533299685, green: 0.6326879859, blue: 0.6321712136, alpha: 1))
            TextCustom(text:
                    isX ? Utils.formatHighNumber(Double("\((Int(value_1) ?? 0) * (Int(value_2) ?? 0))") ?? 0):
                    value.isEmpty ? "-":
                    isNumberComma ? Utils.formatHighNumber(Double(NSLocalizedString(value, comment: "")) ?? 0)
                    : NSLocalizedString(value, comment: "")
                , size: 14, color: isRed ? #colorLiteral(red: 0.932536602, green: 0.2507158816, blue: 0.2460758984, alpha: 1): #colorLiteral(red: 0.1422221363, green: 0.1236664429, blue: 0.1232500449, alpha: 1))
        }
    }
}
