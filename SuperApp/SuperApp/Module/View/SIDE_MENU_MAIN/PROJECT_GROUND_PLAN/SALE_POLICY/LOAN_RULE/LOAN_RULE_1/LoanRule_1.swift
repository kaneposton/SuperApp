// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import SwiftUI

struct LoanRule_1: View {
    @Binding var isNextOld: Bool
    @Binding var isRoot: Bool
    @Binding var typeLoan: Int
    @Binding var sumMoney: String
    @Binding var moneyFirst: String
    @Binding var payTimes: Int
    @Binding var projectURL: String

    @State var isNext = false

    // MARK: DATA RENT ONLINE
    @State var dataRentOnline = ModalRentOnline(
        // MARK: STEP 1
        selectedMethod: 0,

        // MARK: STEP 2
        loanMoney: "",
        year: "",
        purple: 0,
        green: 0,

        // MARK: BIẾN VAY ONLINE
        isSaveInfo: false,
        selectedIndexPage: 1,

        is_2: true,
        is_4: true,
        is_6: true,
        is_8: true,

        isFull_1: false,
        isFull_2: false,
        isFull_4: false,
        isFull_6: false,

        isEmpty_1: true,
        isEmpty_2: true,
        isEmpty_4: true,
        isEmpty_6: true,

        // MARK: VALUE TAB 1
        tab_1_strName: "",
        tab_1_dateBirthday: Date(),
        tab_1_initValueBirthday: 0,
        tab_1_strGender: "",
        tab_1_selectedComboGender: -1,
        tab_1_genderData: [
            typeCombobox(id: 0, name: "Nam"),
            typeCombobox(id: 1, name: "Nữ")
        ],
        tab_1_strCMND: "",
        tab_1_dateGiveDate: Date(),
        tab_1_initValueGiveDate: 0,
        tab_1_strGivePlace: "",
        tab_1_selectedComboGivePlace: -1,
        tab_1_givePlaceData: [
            typeCombobox(id: 0, name: "Tp Hồ Chí Minh")
        ],
        tab_1_strPhone: "",
        tab_1_strEmail: "",
        tab_1_strEducation: "",
        tab_1_selectedComboEducation: -1,
        tab_1_educationData: [
            typeCombobox(id: 0, name: "Đại học"),
            typeCombobox(id: 1, name: "Cao đẳng"),
            typeCombobox(id: 2, name: "Trung cấp")
        ],
        tab_1_strMarry: "",
        tab_1_selectedComboMarry: -1,
        tab_1_marryData: [
            typeCombobox(id: 0, name: "Độc thân"),
            typeCombobox(id: 1, name: "Đã kết hôn")
        ],
        tab_1_strHaveHouse: "",
        tab_1_selectedComboHaveHouse: -1,
        tab_1_haveHouseData: [
            typeCombobox(id: 0, name: "Không"),
            typeCombobox(id: 1, name: "Có")
        ],
        tab_1_strCity: "",
        tab_1_selectedComboCity: -1,
        tab_1_cityData: [
            typeCombobox(id: 0, name: "Tp Hồ Chí Minh")
        ],
        tab_1_strDistrict: "",
        tab_1_selectedComboDistrict: -1,
        tab_1_districtData: [
            typeCombobox(id: 0, name: "Quận Bình Thạnh")
        ],
        tab_1_strVillage: "",
        tab_1_selectedComboVillage: -1,
        tab_1_villageData: [
            typeCombobox(id: 0, name: "Phường 12")
        ],
        tab_1_strAddress: "",

        // MARK: VALUE TAB 2
        tab_2_strCompany: "",
        tab_2_strCompanyType: "",
        tab_2_selectedComboCompanyType: -1,
        tab_2_companyTypeData: [
            typeCombobox(id: 0, name: "Công ty Cổ phần")
        ],
        tab_2_strLevel: "",
        tab_2_selectedComboLevel: -1,
        tab_2_levelData: [
            typeCombobox(id: 0, name: "Nhân viên"),
            typeCombobox(id: 1, name: "Trưởng phòng"),
            typeCombobox(id: 2, name: "Thư ký"),
            typeCombobox(id: 3, name: "Giám đốc")
        ],
        tab_2_strWorkSheet: "",
        tab_2_selectedComboWorkSheet: -1,
        tab_2_workSheetData: [
            typeCombobox(id: 0, name: "Có"),
            typeCombobox(id: 1, name: "Không")
        ],
        tab_2_indexWorkTime: 0,
        tab_2_strWorkTime: "",
        tab_2_initValueWorkTime: 0,
        tab_2_strPayWay: "",
        tab_2_selectedComboPayWay: -1,
        tab_2_payWayData: [
            typeCombobox(id: 0, name: "Trả qua thẻ ATM"),
            typeCombobox(id: 1, name: "Trả tiền mặt")
        ],
        tab_2_strRealSalary: "",
        tab_2_strOtherSalary: "",
        tab_2_strPayment: "",
        tab_2_moreComboIndex: -1,
        tab_2_arrOtherSalary: [TypeOtherSalary(combo: "", comboIndex: -1, value: "", index: 0)],
        tab_2_indexOtherSalary: 0,
        tab_2_otherSalaryData: [
            typeCombobox(id: 0, name: "Kinh doanh"),
            typeCombobox(id: 1, name: "Lương")
        ],
        tab_2_arrPaySource: [TypeOtherSalary(combo: "", comboIndex: -1, value: "", index: 0)],
        tab_2_indexPaySource: 0,
        tab_2_paySourceData: [
            typeCombobox(id: 0, name: "Ăn uống"),
            typeCombobox(id: 1, name: "Đổ xăng"),
            typeCombobox(id: 2, name: "Mua sắm"),
            typeCombobox(id: 3, name: "Tiền điện nước"),
            typeCombobox(id: 4, name: "Đầu tư"),
            typeCombobox(id: 5, name: "Giải trí"),
            typeCombobox(id: 6, name: "Cho vay")
        ],
        tab_2_isAppendingOtherSalary: false,
        tab_2_isAppendingPaySource: false,

        // MARK: VALUE TAB 3
        tab_3_arrTreasure: [TypeTreasure(combo: "", comboIndex: -1, value_1: "", value_2: "", index: 0)],
        tab_3_indexTreasure: 0,
        tab_3_treasureData: [
            typeCombobox(id: 0, name: "Đất nông nghiệp"),
            typeCombobox(id: 1, name: "Nền nhà thổ cư"),
            typeCombobox(id: 2, name: "Xe máy"),
            typeCombobox(id: 3, name: "Quỹ tiết kiệm")
        ],
        tab_3_arrRent: [TypeRent(value_1: "", value_2: "", value_3: "", value_4: "", index: 0)],
        tab_3_moreComboIndex: -1,
        tab_3_arrRentOther: [TypeCombo4Value(combo: "", comboIndex: -1, value_1: "", value_2: "", value_3: "", value_4: "", index: 0)],
        tab_3_indexRentOther: 0,
        tab_3_rentOtherData: [
            typeCombobox(id: 0, name: "Sacombank")
        ],
        tab_3_arrRentPerson: [TypeCombo4Value(combo: "", comboIndex: -1, value_1: "", value_2: "", value_3: "", value_4: "", index: 0)],
        tab_3_indexRentPerson: 0,
        tab_3_rentPersonData: [
            typeCombobox(id: 0, name: "Người thân")
        ],
        tab_3_isAppendingTreasure: false,
        tab_3_isAppendingRent: false,
        tab_3_isAppendingRentOther: false,
        tab_3_isAppendingRentPerson: false,
        tab_3_optional_1: 0,
        tab_3_optional_2: 0,
        tab_3_optional_3: 0,
        tab_3_oldOptional_1: 0,
        tab_3_oldOptional_2: 0,
        tab_3_oldOptional_3: 0,
        tab_3_isOverBorrow: false,
        tab_3_isOverBorrowOther: false,
        tab_3_countArrTreasure: 0,
        tab_3_countArrRent: 0,
        tab_3_countArrRentOther: 0,
        tab_3_countArrRentPerson: 0,

        // MARK: VALUE TAB 4
        tab_4_strNeedCost: "",
        tab_4_strAlreadyCost: "",
        tab_4_strDecideRent: "",
        tab_4_strDeadLineRent: "",
        tab_4_strTypeArea: "",
        tab_4_selectedComboTypeArea: -1,
        tab_4_typeAreaData: [
            typeCombobox(id: 0, name: "Cấp 1"),
            typeCombobox(id: 1, name: "Cấp 2"),
            typeCombobox(id: 2, name: "Cấp 3"),
            typeCombobox(id: 3, name: "Cấp 4")
        ],
        tab_4_strAcreage: "",
        tab_4_strCity: "",
        tab_4_selectedComboCity: -1,
        tab_4_cityData: [
            typeCombobox(id: 0, name: "Tp Hồ Chí Minh")
        ],
        tab_4_strDistrict: "",
        tab_4_selectedComboDistrict: -1,
        tab_4_districtData: [
            typeCombobox(id: 0, name: "Quận Bình Thạnh")
        ],
        tab_4_strVillage: "",
        tab_4_selectedComboVillage: -1,
        tab_4_villageData: [
            typeCombobox(id: 0, name: "Phường 12")
        ],
        tab_4_strAddress: "",
        tab_4_optional_1: false,
        tab_4_optional_2: false,
        tab_4_optional_3: false,
        tab_4_oldOptional_1: false,
        tab_4_oldOptional_2: false,
        tab_4_oldOptional_3: false,
        tab_4_moreComboIndex: -1,
        tab_4_arrRentTreasure: [TypeCombo4Value(combo: "", comboIndex: -1, value_1: "", value_2: "", value_3: "", value_4: "", index: 0)],
        tab_4_indexRentTreasure: 0,
        tab_4_rentTreasureData: [
            typeCombobox(id: 0, name: "Bất động sản")
        ],
        tab_4_arrVehicle: [TypeVehicle(value_1: "", value_2: "", value_3: "", date: Date(), initValueDate: 0, value_4: "", index: 0)],
        tab_4_indexVehicle: 0,
        tab_4_arrOtherRent: [TypeOtherRent(value_1: "", value_2: "", value_3: "", index: 0)],
        tab_4_isAppendingRentTreasure: false,
        tab_4_isAppendingVehicle: false,
        tab_4_isAppendingOtherRent: false,
        tab_4_countArrRentTreasure: 0,
        tab_4_countArrVehicle: 0,
        tab_4_countArrOtherRent: 0
    )

    var body: some View {
        NavigationView {
            ZStack (alignment: .top) {
                Rectangle()
                    .foregroundColor(.init(#colorLiteral(red: 0.9319038987, green: 0.9284480214, blue: 0.9502727389, alpha: 1)))
                    .edgesIgnoringSafeArea(.all)
                VStack (spacing: 0) {
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.init(#colorLiteral(red: 0.6533299685, green: 0.6326879859, blue: 0.6321712136, alpha: 1)))
                    ScrollView (showsIndicators: false) {
                        VStack (spacing: 0) {
                            HStack (spacing: 8) {
                                TextCustom(text: NSLocalizedString("sale_policy_step_1", comment: ""), font: REGULAR, size: 18, color: #colorLiteral(red: 0.6533299685, green: 0.6326879859, blue: 0.6321712136, alpha: 1))
                                TextCustom(text: NSLocalizedString("sale_policy_step_1_title", comment: ""), size: 18, color: #colorLiteral(red: 0.4263509512, green: 0.1872772872, blue: 0.6715394855, alpha: 1))
                            }.padding(.top, H(20))
                                .padding(.bottom, H(19))
                            ZStack {
                                Rectangle()
                                    .frame(height: H(4))
                                    .foregroundColor(.init(#colorLiteral(red: 0.66581285, green: 0.6659106016, blue: 0.6657914519, alpha: 1)))
                                    .padding(.horizontal, 95)
                                HStack(spacing: 0) {
                                    SalePolicyCustomImage(step: 1, imageName: "creditCard", index: 1)
                                    Spacer()
                                    SalePolicyCustomImage(step: 1, imageName: "calculatorWhite", index: 2)
                                    Spacer()
                                    SalePolicyCustomImage(step: 1, imageName: "addCheckWhite", index: 3)
                                }.frame(width: FULL_W - 190)
                            }
                            DetailStep_1(
                                selectedMethod: $dataRentOnline.selectedMethod,
                                isNext: $isNext
                            )
                        }
                    }
                }.padding(.top, H(64))
                VStack {
                    NavigationWhite(
                        isTapSearch: Binding.constant(false),
                        isLogin: Binding.constant(false),
                        isChangeColor: Binding.constant(false),
                        isOpenSideMenu: Binding.constant(false),
                        strSearch: Binding.constant(""),
                        isShowCalendar: Binding.constant(false),
                        isChooseValueDate: Binding.constant(false),
                        title: "sale_policy_loan",
                        title_2: "",
                        backFunc: {
                            self.isNextOld = false
                        },
                        mapFunc: { },
                        filterFunc: { },
                        optionFunc: { },
                        callFunc: { },
                        textFunc: { },
                        isCallAndTextBlack: true,
                        noCallAndText: true
                    )
                    Spacer()
                }
                NavigationLink(destination:
                        LoanRule_2(
                            isNextOld: $isNext,
                            isRoot: $isRoot,
                            projectURL: $projectURL,
                            
                            typeLoan: $typeLoan,
                            sumMoney: $sumMoney,
                            moneyFirst: $moneyFirst,
                            payTimes: $payTimes,

                            // MARK: DATA RENT ONLINE
                            dataRentOnline: $dataRentOnline
                        ), isActive: $isNext) {
                    EmptyView()
                }
            }.navigationBarHidden(true)
                .navigationBarTitle("")
                .navigationBarBackButtonHidden(true)
        }.navigationBarHidden(true)
            .navigationBarTitle("")
            .navigationBarBackButtonHidden(true)
    }
}

struct ModalRentOnline: Identifiable, Hashable {
    var id = UUID()

    // MARK: STEP 1
    var selectedMethod: CGFloat

    // MARK: STEP 2
    var loanMoney: String
    var year: String
    var purple: Int
    var green: Int

    // MARK: BIẾN VAY ONLINE
    var isSaveInfo: Bool
    var selectedIndexPage: Int

    var is_2: Bool
    var is_4: Bool
    var is_6: Bool
    var is_8: Bool

    var isFull_1: Bool
    var isFull_2: Bool
    var isFull_4: Bool
    var isFull_6: Bool

    var isEmpty_1: Bool
    var isEmpty_2: Bool
    var isEmpty_4: Bool
    var isEmpty_6: Bool

    // MARK: VALUE TAB 1
    var tab_1_strName: String
    var tab_1_dateBirthday: Date
    var tab_1_initValueBirthday: Int
    var tab_1_strGender: String
    var tab_1_selectedComboGender: Int
    var tab_1_genderData: [typeCombobox]
    var tab_1_strCMND: String
    var tab_1_dateGiveDate: Date
    var tab_1_initValueGiveDate: Int
    var tab_1_strGivePlace: String
    var tab_1_selectedComboGivePlace: Int
    var tab_1_givePlaceData: [typeCombobox]
    var tab_1_strPhone: String
    var tab_1_strEmail: String
    var tab_1_strEducation: String
    var tab_1_selectedComboEducation: Int
    var tab_1_educationData: [typeCombobox]
    var tab_1_strMarry: String
    var tab_1_selectedComboMarry: Int
    var tab_1_marryData: [typeCombobox]
    var tab_1_strHaveHouse: String
    var tab_1_selectedComboHaveHouse: Int
    var tab_1_haveHouseData: [typeCombobox]
    var tab_1_strCity: String
    var tab_1_selectedComboCity: Int
    var tab_1_cityData: [typeCombobox]
    var tab_1_strDistrict: String
    var tab_1_selectedComboDistrict: Int
    var tab_1_districtData: [typeCombobox]
    var tab_1_strVillage: String
    var tab_1_selectedComboVillage: Int
    var tab_1_villageData: [typeCombobox]
    var tab_1_strAddress: String

    // MARK: VALUE TAB 2
    var tab_2_strCompany: String
    var tab_2_strCompanyType: String
    var tab_2_selectedComboCompanyType: Int
    var tab_2_companyTypeData: [typeCombobox]
    var tab_2_strLevel: String
    var tab_2_selectedComboLevel: Int
    var tab_2_levelData: [typeCombobox]
    var tab_2_strWorkSheet: String
    var tab_2_selectedComboWorkSheet: Int
    var tab_2_workSheetData: [typeCombobox]
    var tab_2_indexWorkTime: Int
    var tab_2_strWorkTime: String
    var tab_2_initValueWorkTime: Int
    var tab_2_strPayWay: String
    var tab_2_selectedComboPayWay: Int
    var tab_2_payWayData: [typeCombobox]
    var tab_2_strRealSalary: String
    var tab_2_strOtherSalary: String
    var tab_2_strPayment: String
    var tab_2_moreComboIndex: Int
    var tab_2_arrOtherSalary: [TypeOtherSalary]
    var tab_2_indexOtherSalary: Int
    var tab_2_otherSalaryData: [typeCombobox]
    var tab_2_arrPaySource: [TypeOtherSalary]
    var tab_2_indexPaySource: Int
    var tab_2_paySourceData: [typeCombobox]
    var tab_2_isAppendingOtherSalary: Bool
    var tab_2_isAppendingPaySource: Bool

    // MARK: VALUE TAB 3
    var tab_3_arrTreasure: [TypeTreasure]
    var tab_3_indexTreasure: Int
    var tab_3_treasureData: [typeCombobox]
    var tab_3_arrRent: [TypeRent]
    var tab_3_moreComboIndex: Int
    var tab_3_arrRentOther: [TypeCombo4Value]
    var tab_3_indexRentOther: Int
    var tab_3_rentOtherData: [typeCombobox]
    var tab_3_arrRentPerson: [TypeCombo4Value]
    var tab_3_indexRentPerson: Int
    var tab_3_rentPersonData: [typeCombobox]
    var tab_3_isAppendingTreasure: Bool
    var tab_3_isAppendingRent: Bool
    var tab_3_isAppendingRentOther: Bool
    var tab_3_isAppendingRentPerson: Bool
    var tab_3_optional_1: Int
    var tab_3_optional_2: Int
    var tab_3_optional_3: Int
    var tab_3_oldOptional_1: Int
    var tab_3_oldOptional_2: Int
    var tab_3_oldOptional_3: Int
    var tab_3_isOverBorrow: Bool
    var tab_3_isOverBorrowOther: Bool
    var tab_3_countArrTreasure: Int
    var tab_3_countArrRent: Int
    var tab_3_countArrRentOther: Int
    var tab_3_countArrRentPerson: Int

    // MARK: VALUE TAB 4
    var tab_4_strNeedCost: String
    var tab_4_strAlreadyCost: String
    var tab_4_strDecideRent: String
    var tab_4_strDeadLineRent: String
    var tab_4_strTypeArea: String
    var tab_4_selectedComboTypeArea: Int
    var tab_4_typeAreaData: [typeCombobox]
    var tab_4_strAcreage: String
    var tab_4_strCity: String
    var tab_4_selectedComboCity: Int
    var tab_4_cityData: [typeCombobox]
    var tab_4_strDistrict: String
    var tab_4_selectedComboDistrict: Int
    var tab_4_districtData: [typeCombobox]
    var tab_4_strVillage: String
    var tab_4_selectedComboVillage: Int
    var tab_4_villageData: [typeCombobox]
    var tab_4_strAddress: String
    var tab_4_optional_1: Bool
    var tab_4_optional_2: Bool
    var tab_4_optional_3: Bool
    var tab_4_oldOptional_1: Bool
    var tab_4_oldOptional_2: Bool
    var tab_4_oldOptional_3: Bool
    var tab_4_moreComboIndex: Int
    var tab_4_arrRentTreasure: [TypeCombo4Value]
    var tab_4_indexRentTreasure: Int
    var tab_4_rentTreasureData: [typeCombobox]
    var tab_4_arrVehicle: [TypeVehicle]
    var tab_4_indexVehicle: Int
    var tab_4_arrOtherRent: [TypeOtherRent]
    var tab_4_isAppendingRentTreasure: Bool
    var tab_4_isAppendingVehicle: Bool
    var tab_4_isAppendingOtherRent: Bool
    var tab_4_countArrRentTreasure: Int
    var tab_4_countArrVehicle: Int
    var tab_4_countArrOtherRent: Int
}
