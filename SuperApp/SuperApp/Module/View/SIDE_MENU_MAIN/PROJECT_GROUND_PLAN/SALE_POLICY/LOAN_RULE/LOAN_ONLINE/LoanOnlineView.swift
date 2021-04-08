// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import SwiftUI
import SDWebImageSwiftUI

struct LoanOnlineView: View {
    // MARK: DEFAULT
    @Binding var isNextOld: Bool
    @Binding var isRoot: Bool
    @Binding var projectURL: String
    @Binding var typeLoan: Int
    @Binding var sumMoney: String
    @Binding var moneyFirst: String
    @Binding var payTimes: Int

    // MARK: DATA RENT ONLINE
    @Binding var dataRentOnline: ModalRentOnline

    // MARK: NO NEED BINDING
    @State var labelCombo = ""
    @State var isKeepStatus = false
    @State var isShowCombobox = false
    @State var isChangeColor = false
    @State var isNext = false
    @State var isShowDatePicker = false
    @State var selectedIndexTab_1 = -1
    @State var selectedIndexTab_2 = -1
    @State var selectedIndexTab_4 = -1
    @State var labelDatePicker = ""
    @State var isShowPopUpBackConfirm = false
    @State var isStartRed_1 = false
    @State var isStartRed_2 = false
    @State var isStartRed_3 = false
    @State var isStartRed_4 = false
    @State var isStartRed_5 = false
    @State var isStartRed_6 = false
    @State var isStartRed_7 = false

    @State var keyboardHeight: CGFloat = 0

    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                ZStack {
                    if projectURL.isEmpty {
                        Image("default_large")
                            .resizable()
                    } else {
                        ZStack {
                            Rectangle().foregroundColor(.init(#colorLiteral(red: 0.9756801724, green: 0.9647900462, blue: 0.9644319415, alpha: 1)))
                            WebImage(url: URL(string: projectURL))
                                .resizable()
                        }
                    }
                }.aspectRatio(contentMode: .fill)
                    .frame(width: FULL_W)
                    .edgesIgnoringSafeArea([.top, .bottom])
                Rectangle()
                    .foregroundColor(.init(#colorLiteral(red: 0.9319038987, green: 0.9284480214, blue: 0.9502727389, alpha: 1)))
                    .edgesIgnoringSafeArea(.all)
                VStack (spacing: 0) {
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.init(#colorLiteral(red: 0.6533299685, green: 0.6326879859, blue: 0.6321712136, alpha: 1)))
                    ScrollView (showsIndicators: false) {
                        VStack (spacing: 0) {
                            customLoanCaculator(
                                dataRentOnline: $dataRentOnline,
                                checkEmptyInfoTab: { self.checkEmptyInfoTab() }
                            ).padding(.top, H(25))

                            // MARK: THÔNG TIN KHÁCH HÀNG
                            if dataRentOnline.selectedIndexPage == 1 {
                                LoanOnlineTab_1(
                                    dataRentOnline: $dataRentOnline,
                                    labelDatePicker: $labelDatePicker,
                                    labelCombo: $labelCombo,
                                    isShowCombobox: $isShowCombobox,
                                    isChangeColor: $isChangeColor,
                                    selectedIndexTab_1: $selectedIndexTab_1,

                                    // MARK: VALUE TAB 1
                                    isStartRed: $isStartRed_1,
                                    isShowDatePicker: $isShowDatePicker
                                )
                            }

                            // MARK: THÔNG TIN NGHỀ NGHIỆP || THU NHẬP HIỆN CÓ
                                else if dataRentOnline.selectedIndexPage == 2 || dataRentOnline.selectedIndexPage == 3 {
                                    LoanOnlineTab_2(
                                        dataRentOnline: $dataRentOnline,
                                        labelDatePicker: $labelDatePicker,
                                        labelCombo: $labelCombo,
                                        selectedIndexTab_2: $selectedIndexTab_2,
                                        isShowDatePicker: $isShowDatePicker,
                                        isShowCombobox: $isShowCombobox,
                                        isChangeColor: $isChangeColor,

                                        // MARK: VALUE TAB 2
                                        isStartRed_2: $isStartRed_2,
                                        isStartRed_3: $isStartRed_3
                                    )
                            }

                            // MARK: TÀI SẢN HIỆN CÓ || TÌNH HÌNH KHOẢN VAY
                                else if dataRentOnline.selectedIndexPage == 4 || dataRentOnline.selectedIndexPage == 5 {
                                    LoanOnlineTab_3(
                                        dataRentOnline: $dataRentOnline,
                                        labelCombo: $labelCombo,
                                        isShowCombobox: $isShowCombobox,
                                        isChangeColor: $isChangeColor,

                                        // MARK: VALUE TAB 3
                                        isStartRed_4: $isStartRed_4,
                                        isStartRed_5: $isStartRed_5
                                    )
                            }

                            // MARK: NHU CẦU VAY VỐN || TÀI SẢN BẢO ĐẢM TIỀN VAY
                                else if dataRentOnline.selectedIndexPage == 6 || dataRentOnline.selectedIndexPage == 7 {
                                    LoanOnlineTab_4(
                                        dataRentOnline: $dataRentOnline,
                                        labelDatePicker: $labelDatePicker,
                                        isShowDatePicker: $isShowDatePicker,
                                        labelCombo: $labelCombo,
                                        selectedIndexTab_4: $selectedIndexTab_4,
                                        isShowCombobox: $isShowCombobox,
                                        isChangeColor: $isChangeColor,

                                        // MARK: VALUE TAB 4
                                        isStartRed_6: $isStartRed_6,
                                        isStartRed_7: $isStartRed_7
                                    )
                            }

                            // MARK: THÔNG TIN VAY VỐN || THU NHẬP & TÀI SẢN HIỆN CÓ
                                else if dataRentOnline.selectedIndexPage == 8 || dataRentOnline.selectedIndexPage == 9 {
                                    LoanOnlineTab_5(
                                        dataRentOnline: $dataRentOnline,
                                        typeLoan: $typeLoan,
                                        sumMoney: $sumMoney,
                                        moneyFirst: $moneyFirst,
                                        payTimes: $payTimes
                                    )
                            }

                            // MARK: LƯU THÔNG TIN
                            HStack {
                                TextCustom(text: NSLocalizedString("loan_online_saveInformation", comment: ""), font: REGULAR, size: 16, color: #colorLiteral(red: 0.1422221363, green: 0.1236664429, blue: 0.1232500449, alpha: 1))
                                Spacer()
                                ZStack (alignment: dataRentOnline.isSaveInfo ? .trailing : .leading) {
                                    Rectangle()
                                        .frame(width: W(40), height: W(20))
                                        .foregroundColor(.init(dataRentOnline.isSaveInfo ? #colorLiteral(red: 0.4281106591, green: 0.1894766092, blue: 0.6721540093, alpha: 1): #colorLiteral(red: 0.6533299685, green: 0.6326879859, blue: 0.6321712136, alpha: 1)))
                                        .cornerRadius(10)
                                    Rectangle()
                                        .foregroundColor(.white)
                                        .cornerRadius(.infinity)
                                        .shadow(color: .init(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.3541577483)), radius: 3)
                                        .frame(width: W(16), height: W(16))
                                        .padding(dataRentOnline.isSaveInfo ? .trailing : .leading, W(2))
                                }.animation(.easeInOut(duration: 0.1))
                                    .onTapGesture {
                                        self.dataRentOnline.isSaveInfo.toggle()
                                }
                            }.frame(width: FULL_W - 32)
                                .padding(.top, H(21))
                                .padding(.bottom, H(41))

                            VStack (spacing: H(11)) {
                                // MARK: BUTTON HUỶ
                                Button(action: {
                                    if self.dataRentOnline.selectedIndexPage == 8 || self.dataRentOnline.selectedIndexPage == 9 {
                                        self.checkEmptyInfoTab()
                                        self.dataRentOnline.selectedIndexPage -= 1
                                        self.checkCurrentTab()
                                    } else {
                                        self.isShowPopUpBackConfirm = true
                                    }
                                }) {
                                    ZStack {
                                        Rectangle()
                                            .frame(width: FULL_W - 32, height: H(38))
                                            .foregroundColor(.white)
                                            .cornerRadius(4)
                                            .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.init(#colorLiteral(red: 0.4281106591, green: 0.1894766092, blue: 0.6721540093, alpha: 1)), lineWidth: 1))
                                            .shadow(color: Color.init(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2018942637)), radius: 6, x: 3, y: 3)
                                        TextCustom(text: NSLocalizedString("loan_online_cancel", comment: ""), font: MEDIUM, size: 16, color: #colorLiteral(red: 0.4281106591, green: 0.1894766092, blue: 0.6721540093, alpha: 1))
                                    }
                                }.buttonStyle(ButtonTapScale())
                                    .animation(.easeInOut(duration: 0.1))

                                // MARK: BUTTON TIẾP THEO
                                Button(action: {
                                    if self.dataRentOnline.selectedIndexPage != 8 && self.dataRentOnline.selectedIndexPage != 9 {
                                        self.checkEmptyInfoTab()
                                        self.dataRentOnline.selectedIndexPage += 1
                                        self.checkCurrentTab()
                                    } else {
                                        if self.checkResult() == -1 {
                                            self.isNext = true
                                            self.isKeepStatus = true
                                        } else {
                                            UIApplication.shared.endEditing()
                                            self.selectedIndexTab_1 = -1
                                            self.selectedIndexTab_2 = -1
                                            self.selectedIndexTab_4 = -1
                                            self.dataRentOnline.tab_4_countArrRentTreasure = self.dataRentOnline.tab_4_arrRentTreasure.count
                                            self.dataRentOnline.tab_4_countArrVehicle = self.dataRentOnline.tab_4_arrVehicle.count
                                            self.dataRentOnline.tab_4_countArrOtherRent = self.dataRentOnline.tab_4_arrOtherRent.count
                                            self.dataRentOnline.tab_3_countArrTreasure = self.dataRentOnline.tab_3_arrTreasure.count
                                            self.dataRentOnline.tab_4_oldOptional_1 = self.dataRentOnline.tab_4_optional_1
                                            self.dataRentOnline.tab_4_oldOptional_2 = self.dataRentOnline.tab_4_optional_2
                                            self.dataRentOnline.tab_4_oldOptional_3 = self.dataRentOnline.tab_4_optional_3
                                            self.dataRentOnline.tab_3_countArrRent = self.dataRentOnline.tab_3_arrRent.count
                                            self.dataRentOnline.tab_3_countArrRentOther = self.dataRentOnline.tab_3_arrRentOther.count
                                            self.dataRentOnline.tab_3_countArrRentPerson = self.dataRentOnline.tab_3_arrRentPerson.count
                                            self.dataRentOnline.tab_3_oldOptional_1 = self.dataRentOnline.tab_3_optional_1
                                            self.dataRentOnline.tab_3_oldOptional_2 = self.dataRentOnline.tab_3_optional_2
                                            self.dataRentOnline.tab_3_oldOptional_3 = self.dataRentOnline.tab_3_optional_3
                                            self.isStartRed_1 = false
                                            self.isStartRed_2 = false
                                            self.isStartRed_3 = false
                                            self.isStartRed_4 = false
                                            self.isStartRed_5 = false
                                            self.isStartRed_6 = false
                                            self.isStartRed_7 = false
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                                self.isStartRed_1 = true
                                                self.isStartRed_2 = true
                                                self.isStartRed_3 = true
                                                self.isStartRed_4 = true
                                                self.isStartRed_5 = true
                                                self.isStartRed_6 = true
                                                self.isStartRed_7 = true
                                            }
                                            self.dataRentOnline.selectedIndexPage = self.checkResult()
                                        }
                                    }
                                }) {
                                    ZStack {
                                        TextCustom(text: NSLocalizedString(dataRentOnline.selectedIndexPage == 8 || dataRentOnline.selectedIndexPage == 9 ? "loan_online_complete" : "loan_online_next", comment: "")
                                            , font: MEDIUM, size: 16, color: .white)
                                    }.frame(width: FULL_W - 32, height: H(40))
                                        .background(Color.init(#colorLiteral(red: 0.4281106591, green: 0.1894766092, blue: 0.6721540093, alpha: 1)))
                                        .cornerRadius(4)
                                        .shadow(color: Color.init(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2018942637)), radius: 6, x: 3, y: 3)
                                }.buttonStyle(ButtonTapScale())
                                    .animation(.easeInOut(duration: 0.1))
                                    .padding(.bottom, H(35))
                            }
                        }.offset(y: keyboardHeight > 0 ? -keyboardHeight : 0)
                    }.resignKeyboardOnDragGesture()
                }.padding(.top, H(64))
                Rectangle()
                    .foregroundColor(.black)
                    .opacity(isShowDatePicker || isShowCombobox ? 0.5 : 0)
                    .edgesIgnoringSafeArea(.all)
                    .animation(.easeInOut(duration: 0.2))
                    .onTapGesture {
                        self.isShowCombobox = false
                        self.isShowDatePicker = false
                        self.isChangeColor = false
                }
                NavigationWhite(
                    isTapSearch: Binding.constant(false),
                    isLogin: Binding.constant(false),
                    isChangeColor: $isChangeColor,
                    isOpenSideMenu: Binding.constant(false),
                    strSearch: Binding.constant(""),
                    isShowCalendar: Binding.constant(false),
                    isChooseValueDate: Binding.constant(false),
                    title: "loan_online_title",
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
                ShowDatePickerView(
                    indexForEach: $dataRentOnline.tab_4_indexVehicle,
                    selectedIndexPage: $dataRentOnline.selectedIndexPage,
                    selectedIndexTab:
                        dataRentOnline.selectedIndexPage == 1 ? $selectedIndexTab_1:
                        dataRentOnline.selectedIndexPage == 2 ? $selectedIndexTab_2: $selectedIndexTab_2,
                    dataTab_4: $dataRentOnline.tab_4_arrVehicle,
                    date:
                        selectedIndexTab_1 == 1 ? $dataRentOnline.tab_1_dateBirthday: selectedIndexTab_1 == 4 ? $dataRentOnline.tab_1_dateGiveDate: Binding.constant(Date()),
                    valueIndex:
                        dataRentOnline.selectedIndexPage == 2 ?
                    selectedIndexTab_2 == 4 ? $dataRentOnline.tab_2_indexWorkTime: Binding.constant(0)
                        : Binding.constant(0),
                    valueName:
                        dataRentOnline.selectedIndexPage == 2 ?
                    selectedIndexTab_2 == 4 ? $dataRentOnline.tab_2_strWorkTime: Binding.constant("")
                        : Binding.constant(""),
                    labelDatePicker: $labelDatePicker,
                    isChangeColor: $isChangeColor,
                    isShowDatePicker: $isShowDatePicker,
                    initValue:
                        dataRentOnline.selectedIndexPage == 1 ?
                    selectedIndexTab_1 == 1 ? $dataRentOnline.tab_1_initValueBirthday:
                        selectedIndexTab_1 == 4 ? $dataRentOnline.tab_1_initValueGiveDate: Binding.constant(0)

                        : dataRentOnline.selectedIndexPage == 2 ?
                    $dataRentOnline.tab_2_initValueWorkTime: Binding.constant(0)
                )
                ShowComboboxView(
                    selectedIndexPage: $dataRentOnline.selectedIndexPage, // 1 2 3 4 5 6 7 8 9

                    // MARK: DATA MORE
                    dataOtherSalary: // []
                    dataRentOnline.tab_2_moreComboIndex == 9 ? $dataRentOnline.tab_2_arrOtherSalary: $dataRentOnline.tab_2_arrPaySource,

                    dataCombo4Value: // []
                    dataRentOnline.selectedIndexPage == 5 ?
                    dataRentOnline.tab_3_moreComboIndex == 20 ? $dataRentOnline.tab_3_arrRentOther: $dataRentOnline.tab_3_arrRentPerson

                        : dataRentOnline.selectedIndexPage == 7 ?
                    $dataRentOnline.tab_4_arrRentTreasure
                        : Binding.constant([]),

                    dataTreasure: $dataRentOnline.tab_3_arrTreasure,

                    // MARK: INDEX FOR EACH
                    indexForEach: // i
                    dataRentOnline.selectedIndexPage == 3 ?
                    dataRentOnline.tab_2_moreComboIndex == 9 ? $dataRentOnline.tab_2_indexOtherSalary: $dataRentOnline.tab_2_indexPaySource

                        : dataRentOnline.selectedIndexPage == 4 ?
                    $dataRentOnline.tab_3_indexTreasure

                        : dataRentOnline.selectedIndexPage == 5 ?
                    dataRentOnline.tab_3_moreComboIndex == 20 ? $dataRentOnline.tab_3_indexRentOther: $dataRentOnline.tab_3_indexRentPerson

                        : dataRentOnline.selectedIndexPage == 7 ?
                    $dataRentOnline.tab_4_indexRentTreasure: Binding.constant(0),

                    // MARK: COLOR
                    isChangeColor: $isChangeColor,

                    // MARK: SHOW
                    isShowCombobox: $isShowCombobox,

                    // MARK: INDEX
                    selectedComboIndex:
                        dataRentOnline.selectedIndexPage == 1 ?
                    selectedIndexTab_1 == 2 ? $dataRentOnline.tab_1_selectedComboGender:
                        selectedIndexTab_1 == 5 ? $dataRentOnline.tab_1_selectedComboGivePlace:
                        selectedIndexTab_1 == 8 ? $dataRentOnline.tab_1_selectedComboEducation:
                        selectedIndexTab_1 == 9 ? $dataRentOnline.tab_1_selectedComboMarry:
                        selectedIndexTab_1 == 10 ? $dataRentOnline.tab_1_selectedComboHaveHouse:
                        selectedIndexTab_1 == 11 ? $dataRentOnline.tab_1_selectedComboCity:
                        selectedIndexTab_1 == 12 ? $dataRentOnline.tab_1_selectedComboDistrict:
                        selectedIndexTab_1 == 13 ? $dataRentOnline.tab_1_selectedComboVillage: Binding.constant(-1)

                        : dataRentOnline.selectedIndexPage == 2 ?
                    selectedIndexTab_2 == 1 ? $dataRentOnline.tab_2_selectedComboCompanyType:
                        selectedIndexTab_2 == 2 ? $dataRentOnline.tab_2_selectedComboLevel:
                        selectedIndexTab_2 == 3 ? $dataRentOnline.tab_2_selectedComboWorkSheet:
                        selectedIndexTab_2 == 5 ? $dataRentOnline.tab_2_selectedComboPayWay: Binding.constant(-1)

                        : dataRentOnline.selectedIndexPage == 6 ?
                    selectedIndexTab_4 == 4 ? $dataRentOnline.tab_4_selectedComboTypeArea:
                        selectedIndexTab_4 == 6 ? $dataRentOnline.tab_4_selectedComboCity:
                        selectedIndexTab_4 == 7 ? $dataRentOnline.tab_4_selectedComboDistrict:
                        selectedIndexTab_4 == 8 ? $dataRentOnline.tab_4_selectedComboVillage: Binding.constant(-1)
                        : Binding.constant(-1),

                    // MARK: NAME
                    selectedComboName:
                        dataRentOnline.selectedIndexPage == 1 ?
                    selectedIndexTab_1 == 2 ? $dataRentOnline.tab_1_strGender:
                        selectedIndexTab_1 == 5 ? $dataRentOnline.tab_1_strGivePlace:
                        selectedIndexTab_1 == 8 ? $dataRentOnline.tab_1_strEducation:
                        selectedIndexTab_1 == 9 ? $dataRentOnline.tab_1_strMarry:
                        selectedIndexTab_1 == 10 ? $dataRentOnline.tab_1_strHaveHouse:
                        selectedIndexTab_1 == 11 ? $dataRentOnline.tab_1_strCity:
                        selectedIndexTab_1 == 12 ? $dataRentOnline.tab_1_strDistrict:
                        selectedIndexTab_1 == 13 ? $dataRentOnline.tab_1_strVillage: Binding.constant("")

                        : dataRentOnline.selectedIndexPage == 2 ?
                    selectedIndexTab_2 == 1 ? $dataRentOnline.tab_2_strCompanyType:
                        selectedIndexTab_2 == 2 ? $dataRentOnline.tab_2_strLevel:
                        selectedIndexTab_2 == 3 ? $dataRentOnline.tab_2_strWorkSheet:
                        selectedIndexTab_2 == 5 ? $dataRentOnline.tab_2_strPayWay: Binding.constant("")

                        : dataRentOnline.selectedIndexPage == 6 ?
                    selectedIndexTab_4 == 4 ? $dataRentOnline.tab_4_strTypeArea:
                        selectedIndexTab_4 == 6 ? $dataRentOnline.tab_4_strCity:
                        selectedIndexTab_4 == 7 ? $dataRentOnline.tab_4_strDistrict:
                        selectedIndexTab_4 == 8 ? $dataRentOnline.tab_4_strVillage: Binding.constant("")
                        : Binding.constant(""),

                    // MARK: LABEL
                    label: $labelCombo,

                    // MARK: DATA
                    data:
                        dataRentOnline.selectedIndexPage == 1 ?
                    selectedIndexTab_1 == 2 ? $dataRentOnline.tab_1_genderData:
                        selectedIndexTab_1 == 5 ? $dataRentOnline.tab_1_givePlaceData:
                        selectedIndexTab_1 == 8 ? $dataRentOnline.tab_1_educationData:
                        selectedIndexTab_1 == 9 ? $dataRentOnline.tab_1_marryData:
                        selectedIndexTab_1 == 10 ? $dataRentOnline.tab_1_haveHouseData:
                        selectedIndexTab_1 == 11 ? $dataRentOnline.tab_1_cityData:
                        selectedIndexTab_1 == 12 ? $dataRentOnline.tab_1_districtData:
                        selectedIndexTab_1 == 13 ? $dataRentOnline.tab_1_villageData: Binding.constant([])

                        : dataRentOnline.selectedIndexPage == 2 ?
                    selectedIndexTab_2 == 1 ? $dataRentOnline.tab_2_companyTypeData:
                        selectedIndexTab_2 == 2 ? $dataRentOnline.tab_2_levelData:
                        selectedIndexTab_2 == 3 ? $dataRentOnline.tab_2_workSheetData:
                        selectedIndexTab_2 == 5 ? $dataRentOnline.tab_2_payWayData: Binding.constant([])

                        : dataRentOnline.selectedIndexPage == 3 ?
                    dataRentOnline.tab_2_moreComboIndex == 9 ? $dataRentOnline.tab_2_otherSalaryData: $dataRentOnline.tab_2_paySourceData

                        : dataRentOnline.selectedIndexPage == 4 ?
                    $dataRentOnline.tab_3_treasureData

                        : dataRentOnline.selectedIndexPage == 5 ?
                    dataRentOnline.tab_3_moreComboIndex == 20 ? $dataRentOnline.tab_3_rentOtherData: $dataRentOnline.tab_3_rentPersonData

                        : dataRentOnline.selectedIndexPage == 6 ?
                    selectedIndexTab_4 == 4 ? $dataRentOnline.tab_4_typeAreaData:
                        selectedIndexTab_4 == 6 ? $dataRentOnline.tab_4_cityData:
                        selectedIndexTab_4 == 7 ? $dataRentOnline.tab_4_districtData:
                        selectedIndexTab_4 == 8 ? $dataRentOnline.tab_4_villageData: Binding.constant([])

                        : dataRentOnline.selectedIndexPage == 7 ?
                            $dataRentOnline.tab_4_rentTreasureData: Binding.constant([])
                ).animation(.easeInOut(duration: 0.2))
                Rectangle()
                    .foregroundColor(.black)
                    .opacity(isShowPopUpBackConfirm ? 0.5 : 0)
                    .edgesIgnoringSafeArea(.all)
                    .animation(.easeInOut(duration: 0.2))
                    .onTapGesture {
                        self.isShowPopUpBackConfirm = false
                }
                VStack {
                    Spacer()
                    ShowBackConfirmPopup(
                        isShowPopUpBackConfirm: $isShowPopUpBackConfirm,
                        clearTab: {
                            self.isShowCombobox = false
                            self.isChangeColor = false
                            self.isShowDatePicker = false
                            UIApplication.shared.endEditing()
                            self.selectedIndexTab_1 = -1
                            self.selectedIndexTab_2 = -1
                            self.selectedIndexTab_4 = -1
                            if self.dataRentOnline.selectedIndexPage == 1 {
                                self.clearTab(index: 1)
                                self.isStartRed_1 = false
                            } else if self.dataRentOnline.selectedIndexPage == 2 {
                                self.clearTab(index: 2)
                                self.isStartRed_2 = false
                            } else if self.dataRentOnline.selectedIndexPage == 3 {
                                self.clearTab(index: 3)
                                self.isStartRed_3 = false
                            } else if self.dataRentOnline.selectedIndexPage == 4 {
                                self.clearTab(index: 4)
                                self.isStartRed_4 = false
                            } else if self.dataRentOnline.selectedIndexPage == 5 {
                                self.clearTab(index: 5)
                                self.isStartRed_5 = false
                            } else if self.dataRentOnline.selectedIndexPage == 6 {
                                self.clearTab(index: 6)
                                self.isStartRed_6 = false
                            } else if self.dataRentOnline.selectedIndexPage == 7 {
                                self.clearTab(index: 7)
                                self.isStartRed_7 = false
                            }
                        }
                    )
                    Spacer()
                }
                NavigationLink(destination: LoanOnlineResultView(isNextOld: $isNext, isRoot: $isRoot), isActive: $isNext) {
                    EmptyView()
                }
            }.keyboardAppear(keyboardHeight: $keyboardHeight)
                .onAppear {
                    if !self.dataRentOnline.isSaveInfo && !self.isKeepStatus {
                        self.dataRentOnline.selectedIndexPage = 1

                        self.dataRentOnline.is_2 = true
                        self.dataRentOnline.is_4 = true
                        self.dataRentOnline.is_6 = true
                        self.dataRentOnline.is_8 = true

                        self.dataRentOnline.isFull_1 = false
                        self.dataRentOnline.isFull_2 = false
                        self.dataRentOnline.isFull_4 = false
                        self.dataRentOnline.isFull_6 = false

                        self.dataRentOnline.isEmpty_1 = true
                        self.dataRentOnline.isEmpty_2 = true
                        self.dataRentOnline.isEmpty_4 = true
                        self.dataRentOnline.isEmpty_6 = true

                        self.clearTab(index: 99)
                    }
                    if self.isKeepStatus {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            self.isKeepStatus = false
                        }
                    }
                    self.checkEmptyInfoTab()
                }.onTapGesture {
                    UIApplication.shared.endEditing()
                }.navigationBarTitle("")
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
        }.navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
    }

    func checkResult() -> Int {
        // MARK: THÔNG TIN KHÁCH HÀNG
        if dataRentOnline.tab_1_strName.isEmpty || dataRentOnline.tab_1_initValueBirthday == 0 || dataRentOnline.tab_1_selectedComboGender == -1 || dataRentOnline.tab_1_strCMND.isEmpty || dataRentOnline.tab_1_strPhone.isEmpty || formattedNumberPhone(number: dataRentOnline.tab_1_strPhone).count < 12 || dataRentOnline.tab_1_strEmail.isEmpty || !Utils.isValidEmail(email: dataRentOnline.tab_1_strEmail) || dataRentOnline.tab_1_selectedComboHaveHouse == -1 {
            return 1
        }
        // MARK: THÔNG TIN NGHỀ NGHIỆP
        if dataRentOnline.tab_2_strCompany.isEmpty || dataRentOnline.tab_2_selectedComboCompanyType == -1 || dataRentOnline.tab_2_selectedComboLevel == -1 || dataRentOnline.tab_2_selectedComboWorkSheet == -1 || dataRentOnline.tab_2_initValueWorkTime == 0 || dataRentOnline.tab_2_selectedComboPayWay == -1 {
            return 2
        }
        // MARK: THU NHẬP HIỆN CÓ
        if dataRentOnline.tab_2_strRealSalary.isEmpty || dataRentOnline.tab_2_strOtherSalary.isEmpty || dataRentOnline.tab_2_strPayment.isEmpty {
            return 3
        }
        // MARK: TÀI SẢN HIỆN CÓ
        for i in 0 ..< dataRentOnline.tab_3_arrTreasure.count {
            if dataRentOnline.tab_3_arrTreasure[i].comboIndex == -1 || dataRentOnline.tab_3_arrTreasure[i].value_1.isEmpty || dataRentOnline.tab_3_arrTreasure[i].value_2.isEmpty {
                return 4
            }
        }
        // MARK: TÌNH HÌNH KHOẢN VAY
        if dataRentOnline.tab_3_optional_1 == 0 || dataRentOnline.tab_3_optional_2 == 0 || dataRentOnline.tab_3_optional_3 == 0 {
            return 5
        }
        if dataRentOnline.tab_3_optional_1 == 1 {
            for i in 0 ..< dataRentOnline.tab_3_arrRent.count {
                if dataRentOnline.tab_3_arrRent[i].value_1.isEmpty || dataRentOnline.tab_3_arrRent[i].value_2.isEmpty || dataRentOnline.tab_3_arrRent[i].value_3.isEmpty ||
                    dataRentOnline.tab_3_arrRent[i].value_4.isEmpty {
                    return 5
                }
            }
        }
        if dataRentOnline.tab_3_optional_2 == 1 {
            for i in 0 ..< dataRentOnline.tab_3_arrRentOther.count {
                if dataRentOnline.tab_3_arrRentOther[i].comboIndex == -1 || dataRentOnline.tab_3_arrRentOther[i].value_1.isEmpty || dataRentOnline.tab_3_arrRentOther[i].value_2.isEmpty || dataRentOnline.tab_3_arrRentOther[i].value_3.isEmpty ||
                    dataRentOnline.tab_3_arrRentOther[i].value_4.isEmpty {
                    return 5
                }
            }
        }
        if dataRentOnline.tab_3_optional_3 == 1 {
            for i in 0 ..< dataRentOnline.tab_3_arrRentPerson.count {
                if dataRentOnline.tab_3_arrRentPerson[i].comboIndex == -1 || dataRentOnline.tab_3_arrRentPerson[i].value_1.isEmpty || dataRentOnline.tab_3_arrRentPerson[i].value_2.isEmpty || dataRentOnline.tab_3_arrRentPerson[i].value_3.isEmpty ||
                    dataRentOnline.tab_3_arrRentPerson[i].value_4.isEmpty {
                    return 5
                }
            }
        }
        // MARK: NHU CẦU VAY VỐN
        if dataRentOnline.tab_4_strNeedCost.isEmpty || dataRentOnline.tab_4_strAlreadyCost.isEmpty || dataRentOnline.tab_4_strDecideRent.isEmpty || dataRentOnline.tab_4_strDeadLineRent.isEmpty || dataRentOnline.tab_4_selectedComboTypeArea == -1 || dataRentOnline.tab_4_strAcreage.isEmpty {
            return 6
        }
        // MARK: TÀI SẢN BẢO ĐẢM TIỀN VAY
        if dataRentOnline.tab_4_optional_1 {
            for i in 0 ..< dataRentOnline.tab_4_arrRentTreasure.count {
                if dataRentOnline.tab_4_arrRentTreasure[i].value_3.isEmpty {
                    return 7
                }
            }
        }
        if dataRentOnline.tab_4_optional_2 {
            for i in 0 ..< dataRentOnline.tab_4_arrVehicle.count {
                if dataRentOnline.tab_4_arrVehicle[i].value_4.isEmpty {
                    return 7
                }
            }
        }
        if dataRentOnline.tab_4_optional_3 {
            for i in 0 ..< dataRentOnline.tab_4_arrOtherRent.count {
                if dataRentOnline.tab_4_arrOtherRent[i].value_2.isEmpty {
                    return 7
                }
            }
        }
        return -1
    }

    func clearTab(index: Int) {
        if index == 99 {
            // MARK: TAB 1
            dataRentOnline.tab_1_strName = ""

            dataRentOnline.tab_1_dateBirthday = Date()
            dataRentOnline.tab_1_initValueBirthday = 0

            dataRentOnline.tab_1_strGender = ""
            dataRentOnline.tab_1_selectedComboGender = -1

            dataRentOnline.tab_1_strCMND = ""

            dataRentOnline.tab_1_dateGiveDate = Date()
            dataRentOnline.tab_1_initValueGiveDate = 0

            dataRentOnline.tab_1_strGivePlace = ""
            dataRentOnline.tab_1_selectedComboGivePlace = -1

            dataRentOnline.tab_1_strPhone = ""
            dataRentOnline.tab_1_strEmail = ""

            dataRentOnline.tab_1_strEducation = ""
            dataRentOnline.tab_1_selectedComboEducation = -1

            dataRentOnline.tab_1_strMarry = ""
            dataRentOnline.tab_1_selectedComboMarry = -1

            dataRentOnline.tab_1_strHaveHouse = ""
            dataRentOnline.tab_1_selectedComboHaveHouse = -1

            dataRentOnline.tab_1_strCity = ""
            dataRentOnline.tab_1_selectedComboCity = -1

            dataRentOnline.tab_1_strDistrict = ""
            dataRentOnline.tab_1_selectedComboDistrict = -1

            dataRentOnline.tab_1_strVillage = ""
            dataRentOnline.tab_1_selectedComboVillage = -1

            dataRentOnline.tab_1_strAddress = ""

            // MARK: TAB 2_1
            dataRentOnline.tab_2_strCompany = ""

            dataRentOnline.tab_2_strCompanyType = ""
            dataRentOnline.tab_2_selectedComboCompanyType = -1

            dataRentOnline.tab_2_strLevel = ""
            dataRentOnline.tab_2_selectedComboLevel = -1

            dataRentOnline.tab_2_strWorkSheet = ""
            dataRentOnline.tab_2_selectedComboWorkSheet = -1

            dataRentOnline.tab_2_indexWorkTime = 0
            dataRentOnline.tab_2_initValueWorkTime = 0
            dataRentOnline.tab_2_strWorkTime = ""

            dataRentOnline.tab_2_strPayWay = ""
            dataRentOnline.tab_2_selectedComboPayWay = -1

            // MARK: TAB 2_2
            dataRentOnline.tab_2_strRealSalary = ""
            dataRentOnline.tab_2_strOtherSalary = ""
            dataRentOnline.tab_2_strPayment = ""
            dataRentOnline.tab_2_isAppendingOtherSalary = true
            dataRentOnline.tab_2_isAppendingPaySource = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                self.dataRentOnline.tab_2_arrOtherSalary = [TypeOtherSalary(combo: "", comboIndex: -1, value: "", index: 0)]
                self.dataRentOnline.tab_2_arrPaySource = [TypeOtherSalary(combo: "", comboIndex: -1, value: "", index: 0)]
                self.dataRentOnline.tab_2_isAppendingOtherSalary = false
                self.dataRentOnline.tab_2_isAppendingPaySource = false
            }

            // MARK: TAB 3_1
            dataRentOnline.tab_3_isAppendingTreasure = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                self.dataRentOnline.tab_3_arrTreasure = [TypeTreasure(combo: "", comboIndex: -1, value_1: "", value_2: "", index: 0)]
                self.dataRentOnline.tab_3_isAppendingTreasure = false
            }

            // MARK: TAB 3_2
            dataRentOnline.tab_3_isAppendingRent = true
            dataRentOnline.tab_3_isAppendingRentOther = true
            dataRentOnline.tab_3_isAppendingRentPerson = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                self.dataRentOnline.tab_3_arrRent = [TypeRent(value_1: "", value_2: "", value_3: "", value_4: "", index: 0)]
                self.dataRentOnline.tab_3_arrRentOther = [TypeCombo4Value(combo: "", comboIndex: -1, value_1: "", value_2: "", value_3: "", value_4: "", index: 0)]
                self.dataRentOnline.tab_3_arrRentPerson = [TypeCombo4Value(combo: "", comboIndex: -1, value_1: "", value_2: "", value_3: "", value_4: "", index: 0)]
                self.dataRentOnline.tab_3_isAppendingRent = false
                self.dataRentOnline.tab_3_isAppendingRentOther = false
                self.dataRentOnline.tab_3_isAppendingRentPerson = false
            }
            dataRentOnline.tab_3_optional_1 = 0
            dataRentOnline.tab_3_optional_2 = 0
            dataRentOnline.tab_3_optional_3 = 0
            dataRentOnline.tab_3_isOverBorrow = false
            dataRentOnline.tab_3_isOverBorrowOther = false

            // MARK: TAB 4_1
            dataRentOnline.tab_4_strNeedCost = ""
            dataRentOnline.tab_4_strAlreadyCost = ""
            dataRentOnline.tab_4_strDecideRent = ""
            dataRentOnline.tab_4_strDeadLineRent = ""

            dataRentOnline.tab_4_strTypeArea = ""
            dataRentOnline.tab_4_selectedComboTypeArea = -1

            dataRentOnline.tab_4_strAcreage = ""

            dataRentOnline.tab_4_strCity = ""
            dataRentOnline.tab_4_selectedComboCity = -1

            dataRentOnline.tab_4_strDistrict = ""
            dataRentOnline.tab_4_selectedComboDistrict = -1

            dataRentOnline.tab_4_strVillage = ""
            dataRentOnline.tab_4_selectedComboVillage = -1

            dataRentOnline.tab_4_strAddress = ""

            // MARK: TAB 4_2
            dataRentOnline.tab_4_optional_1 = false
            dataRentOnline.tab_4_optional_2 = false
            dataRentOnline.tab_4_optional_3 = false
            dataRentOnline.tab_4_isAppendingRentTreasure = true
            dataRentOnline.tab_4_isAppendingVehicle = true
            dataRentOnline.tab_4_isAppendingOtherRent = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                self.dataRentOnline.tab_4_arrRentTreasure = [TypeCombo4Value(combo: "", comboIndex: -1, value_1: "", value_2: "", value_3: "", value_4: "", index: 0)]
                self.dataRentOnline.tab_4_arrVehicle = [TypeVehicle(value_1: "", value_2: "", value_3: "", date: Date(), initValueDate: 0, value_4: "", index: 0)]
                self.dataRentOnline.tab_4_arrOtherRent = [TypeOtherRent(value_1: "", value_2: "", value_3: "", index: 0)]
                self.dataRentOnline.tab_4_isAppendingRentTreasure = false
                self.dataRentOnline.tab_4_isAppendingVehicle = false
                self.dataRentOnline.tab_4_isAppendingOtherRent = false
            }
        } else {
            if index == 1 {
                dataRentOnline.tab_1_strName = ""

                dataRentOnline.tab_1_dateBirthday = Date()
                dataRentOnline.tab_1_initValueBirthday = 0

                dataRentOnline.tab_1_strGender = ""
                dataRentOnline.tab_1_selectedComboGender = -1

                dataRentOnline.tab_1_strCMND = ""

                dataRentOnline.tab_1_dateGiveDate = Date()
                dataRentOnline.tab_1_initValueGiveDate = 0

                dataRentOnline.tab_1_strGivePlace = ""
                dataRentOnline.tab_1_selectedComboGivePlace = -1

                dataRentOnline.tab_1_strPhone = ""
                dataRentOnline.tab_1_strEmail = ""

                dataRentOnline.tab_1_strEducation = ""
                dataRentOnline.tab_1_selectedComboEducation = -1

                dataRentOnline.tab_1_strMarry = ""
                dataRentOnline.tab_1_selectedComboMarry = -1

                dataRentOnline.tab_1_strHaveHouse = ""
                dataRentOnline.tab_1_selectedComboHaveHouse = -1

                dataRentOnline.tab_1_strCity = ""
                dataRentOnline.tab_1_selectedComboCity = -1

                dataRentOnline.tab_1_strDistrict = ""
                dataRentOnline.tab_1_selectedComboDistrict = -1

                dataRentOnline.tab_1_strVillage = ""
                dataRentOnline.tab_1_selectedComboVillage = -1

                dataRentOnline.tab_1_strAddress = ""

                checkEmptyInfoTab()
                checkCurrentTab()
            } else if index == 2 {
                dataRentOnline.tab_2_strCompany = ""

                dataRentOnline.tab_2_strCompanyType = ""
                dataRentOnline.tab_2_selectedComboCompanyType = -1

                dataRentOnline.tab_2_strLevel = ""
                dataRentOnline.tab_2_selectedComboLevel = -1

                dataRentOnline.tab_2_strWorkSheet = ""
                dataRentOnline.tab_2_selectedComboWorkSheet = -1

                dataRentOnline.tab_2_indexWorkTime = 0
                dataRentOnline.tab_2_initValueWorkTime = 0
                dataRentOnline.tab_2_strWorkTime = ""

                dataRentOnline.tab_2_strPayWay = ""
                dataRentOnline.tab_2_selectedComboPayWay = -1

                checkEmptyInfoTab()
                dataRentOnline.selectedIndexPage -= 1
                checkCurrentTab()
            } else if index == 3 {
                dataRentOnline.tab_2_strRealSalary = ""
                dataRentOnline.tab_2_strOtherSalary = ""
                dataRentOnline.tab_2_strPayment = ""
                dataRentOnline.tab_2_isAppendingOtherSalary = true
                dataRentOnline.tab_2_isAppendingPaySource = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                    self.dataRentOnline.tab_2_arrOtherSalary = [TypeOtherSalary(combo: "", comboIndex: -1, value: "", index: 0)]
                    self.dataRentOnline.tab_2_arrPaySource = [TypeOtherSalary(combo: "", comboIndex: -1, value: "", index: 0)]
                    self.dataRentOnline.tab_2_isAppendingOtherSalary = false
                    self.dataRentOnline.tab_2_isAppendingPaySource = false

                    self.checkEmptyInfoTab()
                    self.dataRentOnline.selectedIndexPage -= 1
                    self.checkCurrentTab()
                }
            } else if index == 4 {
                dataRentOnline.tab_3_isAppendingTreasure = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                    self.dataRentOnline.tab_3_arrTreasure = [TypeTreasure(combo: "", comboIndex: -1, value_1: "", value_2: "", index: 0)]
                    self.dataRentOnline.tab_3_isAppendingTreasure = false

                    self.checkEmptyInfoTab()
                    self.dataRentOnline.selectedIndexPage -= 1
                    self.checkCurrentTab()
                }
            } else if index == 5 {
                dataRentOnline.tab_3_isAppendingRent = true
                dataRentOnline.tab_3_isAppendingRentOther = true
                dataRentOnline.tab_3_isAppendingRentPerson = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                    self.dataRentOnline.tab_3_arrRent = [TypeRent(value_1: "", value_2: "", value_3: "", value_4: "", index: 0)]
                    self.dataRentOnline.tab_3_arrRentOther = [TypeCombo4Value(combo: "", comboIndex: -1, value_1: "", value_2: "", value_3: "", value_4: "", index: 0)]
                    self.dataRentOnline.tab_3_arrRentPerson = [TypeCombo4Value(combo: "", comboIndex: -1, value_1: "", value_2: "", value_3: "", value_4: "", index: 0)]
                    self.dataRentOnline.tab_3_isAppendingRent = false
                    self.dataRentOnline.tab_3_isAppendingRentOther = false
                    self.dataRentOnline.tab_3_isAppendingRentPerson = false

                    self.checkEmptyInfoTab()
                    self.dataRentOnline.selectedIndexPage -= 1
                    self.checkCurrentTab()
                }
                dataRentOnline.tab_3_optional_1 = 0
                dataRentOnline.tab_3_optional_2 = 0
                dataRentOnline.tab_3_optional_3 = 0
                dataRentOnline.tab_3_isOverBorrow = false
                dataRentOnline.tab_3_isOverBorrowOther = false
            } else if index == 6 {
                dataRentOnline.tab_4_strNeedCost = ""
                dataRentOnline.tab_4_strAlreadyCost = ""
                dataRentOnline.tab_4_strDecideRent = ""
                dataRentOnline.tab_4_strDeadLineRent = ""

                dataRentOnline.tab_4_strTypeArea = ""
                dataRentOnline.tab_4_selectedComboTypeArea = -1

                dataRentOnline.tab_4_strAcreage = ""

                dataRentOnline.tab_4_strCity = ""
                dataRentOnline.tab_4_selectedComboCity = -1

                dataRentOnline.tab_4_strDistrict = ""
                dataRentOnline.tab_4_selectedComboDistrict = -1

                dataRentOnline.tab_4_strVillage = ""
                dataRentOnline.tab_4_selectedComboVillage = -1

                dataRentOnline.tab_4_strAddress = ""

                self.checkEmptyInfoTab()
                self.dataRentOnline.selectedIndexPage -= 1
                self.checkCurrentTab()
            } else if index == 7 {
                dataRentOnline.tab_4_optional_1 = false
                dataRentOnline.tab_4_optional_2 = false
                dataRentOnline.tab_4_optional_3 = false
                dataRentOnline.tab_4_isAppendingRentTreasure = true
                dataRentOnline.tab_4_isAppendingVehicle = true
                dataRentOnline.tab_4_isAppendingOtherRent = true
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                    self.dataRentOnline.tab_4_arrRentTreasure = [TypeCombo4Value(combo: "", comboIndex: -1, value_1: "", value_2: "", value_3: "", value_4: "", index: 0)]
                    self.dataRentOnline.tab_4_arrVehicle = [TypeVehicle(value_1: "", value_2: "", value_3: "", date: Date(), initValueDate: 0, value_4: "", index: 0)]
                    self.dataRentOnline.tab_4_arrOtherRent = [TypeOtherRent(value_1: "", value_2: "", value_3: "", index: 0)]
                    self.dataRentOnline.tab_4_isAppendingRentTreasure = false
                    self.dataRentOnline.tab_4_isAppendingVehicle = false
                    self.dataRentOnline.tab_4_isAppendingOtherRent = false

                    self.checkEmptyInfoTab()
                    self.dataRentOnline.selectedIndexPage -= 1
                    self.checkCurrentTab()
                }
            }
        }
    }

    func checkEmptyInfoTab() {
        var countArrTab_2_1_AtLeast = 0
        var countArrTab_2_2_AtLeast = 0

        var countArrTab_3_1_Full = 0
        var countArrTab_3_1_AtLeast = 0

        var countArrTab_3_2_Full = 0
        var countArrTab_3_2_AtLeast = 0

        var countArrTab_3_3_Full = 0
        var countArrTab_3_3_AtLeast = 0

        var countArrTab_3_4_Full = 0
        var countArrTab_3_4_AtLeast = 0

        var countArrTab_4_1_Full = 0
        var countArrTab_4_1_AtLeast = 0

        var countArrTab_4_2_Full = 0
        var countArrTab_4_2_AtLeast = 0

        var countArrTab_4_3_Full = 0
        var countArrTab_4_3_AtLeast = 0

        // MARK: TAB 1
        if !dataRentOnline.tab_1_strName.isEmpty || dataRentOnline.tab_1_initValueBirthday != 0 || dataRentOnline.tab_1_selectedComboGender != -1 || !dataRentOnline.tab_1_strCMND.isEmpty || dataRentOnline.tab_1_initValueGiveDate != 0 || dataRentOnline.tab_1_selectedComboGivePlace != -1 || !dataRentOnline.tab_1_strPhone.isEmpty || !dataRentOnline.tab_1_strEmail.isEmpty || dataRentOnline.tab_1_selectedComboEducation != -1 || dataRentOnline.tab_1_selectedComboMarry != -1 || dataRentOnline.tab_1_selectedComboHaveHouse != -1 || dataRentOnline.tab_1_selectedComboCity != -1 || dataRentOnline.tab_1_selectedComboDistrict != -1 || dataRentOnline.tab_1_selectedComboVillage != -1 || !dataRentOnline.tab_1_strAddress.isEmpty {
            dataRentOnline.isEmpty_1 = false
            dataRentOnline.isFull_1 = false
        }
        if !dataRentOnline.tab_1_strName.isEmpty && dataRentOnline.tab_1_initValueBirthday != 0 && dataRentOnline.tab_1_selectedComboGender != -1 && !dataRentOnline.tab_1_strCMND.isEmpty && !dataRentOnline.tab_1_strPhone.isEmpty && formattedNumberPhone(number: dataRentOnline.tab_1_strPhone).count == 12 && !dataRentOnline.tab_1_strEmail.isEmpty && Utils.isValidEmail(email: dataRentOnline.tab_1_strEmail) && dataRentOnline.tab_1_selectedComboHaveHouse != -1 {
            dataRentOnline.isFull_1 = true
            dataRentOnline.isEmpty_1 = false
        }
        if dataRentOnline.tab_1_strName.isEmpty && dataRentOnline.tab_1_initValueBirthday == 0 && dataRentOnline.tab_1_selectedComboGender == -1 && dataRentOnline.tab_1_strCMND.isEmpty && dataRentOnline.tab_1_initValueGiveDate == 0 && dataRentOnline.tab_1_selectedComboGivePlace == -1 && dataRentOnline.tab_1_strPhone.isEmpty && dataRentOnline.tab_1_strEmail.isEmpty && dataRentOnline.tab_1_selectedComboEducation == -1 && dataRentOnline.tab_1_selectedComboMarry == -1 && dataRentOnline.tab_1_selectedComboHaveHouse == -1 && dataRentOnline.tab_1_selectedComboCity == -1 && dataRentOnline.tab_1_selectedComboDistrict == -1 && dataRentOnline.tab_1_selectedComboVillage == -1 && dataRentOnline.tab_1_strAddress.isEmpty {
            dataRentOnline.isEmpty_1 = true
            dataRentOnline.isFull_1 = false
        }

        // MARK: TAB 2
        for i in 0 ..< dataRentOnline.tab_2_arrOtherSalary.count {
            if dataRentOnline.tab_2_arrOtherSalary[i].comboIndex != -1 || !dataRentOnline.tab_2_arrOtherSalary[i].value.isEmpty {
                countArrTab_2_1_AtLeast += 1
            }
        }
        for i in 0 ..< dataRentOnline.tab_2_arrPaySource.count {
            if !dataRentOnline.tab_2_arrPaySource[i].combo.isEmpty || !dataRentOnline.tab_2_arrPaySource[i].value.isEmpty {
                countArrTab_2_2_AtLeast += 1
            }
        }
        if !dataRentOnline.tab_2_strCompany.isEmpty || dataRentOnline.tab_2_selectedComboCompanyType != -1 || dataRentOnline.tab_2_selectedComboLevel != -1 || dataRentOnline.tab_2_selectedComboWorkSheet != -1 || dataRentOnline.tab_2_initValueWorkTime != 0 || dataRentOnline.tab_2_selectedComboPayWay != -1 || !dataRentOnline.tab_2_strRealSalary.isEmpty || !dataRentOnline.tab_2_strOtherSalary.isEmpty || !dataRentOnline.tab_2_strPayment.isEmpty || countArrTab_2_1_AtLeast > 0 || countArrTab_2_2_AtLeast > 0 || dataRentOnline.tab_2_arrOtherSalary.count > 1 || dataRentOnline.tab_2_arrPaySource.count > 1 {
            dataRentOnline.isEmpty_2 = false
            dataRentOnline.isFull_2 = false
        }
        if !dataRentOnline.tab_2_strCompany.isEmpty && dataRentOnline.tab_2_selectedComboCompanyType != -1 && dataRentOnline.tab_2_selectedComboLevel != -1 && dataRentOnline.tab_2_selectedComboWorkSheet != -1 && dataRentOnline.tab_2_initValueWorkTime != 0 && dataRentOnline.tab_2_selectedComboPayWay != -1 && !dataRentOnline.tab_2_strRealSalary.isEmpty && !dataRentOnline.tab_2_strOtherSalary.isEmpty && !dataRentOnline.tab_2_strPayment.isEmpty {
            dataRentOnline.isFull_2 = true
            dataRentOnline.isEmpty_2 = false
        }
        if dataRentOnline.tab_2_strCompany.isEmpty && dataRentOnline.tab_2_selectedComboCompanyType == -1 && dataRentOnline.tab_2_selectedComboLevel == -1 && dataRentOnline.tab_2_selectedComboWorkSheet == -1 && dataRentOnline.tab_2_initValueWorkTime == 0 && dataRentOnline.tab_2_selectedComboPayWay == -1 && dataRentOnline.tab_2_strRealSalary.isEmpty && dataRentOnline.tab_2_strOtherSalary.isEmpty && dataRentOnline.tab_2_strPayment.isEmpty
            && (dataRentOnline.tab_2_arrOtherSalary.count == 1 && countArrTab_2_1_AtLeast == 0)
            && (dataRentOnline.tab_2_arrPaySource.count == 1 && countArrTab_2_2_AtLeast == 0) {
            dataRentOnline.isEmpty_2 = true
            dataRentOnline.isFull_2 = false
        }

        // MARK: TAB 3
        if dataRentOnline.tab_3_optional_1 == 1 {
            for i in 0 ..< dataRentOnline.tab_3_arrRent.count {
                if !dataRentOnline.tab_3_arrRent[i].value_1.isEmpty || !dataRentOnline.tab_3_arrRent[i].value_2.isEmpty || !dataRentOnline.tab_3_arrRent[i].value_3.isEmpty ||
                    !dataRentOnline.tab_3_arrRent[i].value_4.isEmpty {
                    countArrTab_3_2_AtLeast += 1
                }
                if !dataRentOnline.tab_3_arrRent[i].value_1.isEmpty && !dataRentOnline.tab_3_arrRent[i].value_2.isEmpty && !dataRentOnline.tab_3_arrRent[i].value_3.isEmpty && !dataRentOnline.tab_3_arrRent[i].value_4.isEmpty {
                    countArrTab_3_2_Full += 1
                }
            }
        }
        if dataRentOnline.tab_3_optional_2 == 1 {
            for i in 0 ..< dataRentOnline.tab_3_arrRentOther.count {
                if dataRentOnline.tab_3_arrRentOther[i].comboIndex != -1 || !dataRentOnline.tab_3_arrRentOther[i].value_1.isEmpty || !dataRentOnline.tab_3_arrRentOther[i].value_2.isEmpty || !dataRentOnline.tab_3_arrRentOther[i].value_3.isEmpty ||
                    !dataRentOnline.tab_3_arrRentOther[i].value_4.isEmpty {
                    countArrTab_3_3_AtLeast += 1
                }
                if dataRentOnline.tab_3_arrRentOther[i].comboIndex != -1 && !dataRentOnline.tab_3_arrRentOther[i].value_1.isEmpty && !dataRentOnline.tab_3_arrRentOther[i].value_2.isEmpty && !dataRentOnline.tab_3_arrRentOther[i].value_3.isEmpty && !dataRentOnline.tab_3_arrRentOther[i].value_4.isEmpty {
                    countArrTab_3_3_Full += 1
                }
            }
        }
        if dataRentOnline.tab_3_optional_3 == 1 {
            for i in 0 ..< dataRentOnline.tab_3_arrRentPerson.count {
                if dataRentOnline.tab_3_arrRentPerson[i].comboIndex != -1 || !dataRentOnline.tab_3_arrRentPerson[i].value_1.isEmpty || !dataRentOnline.tab_3_arrRentPerson[i].value_2.isEmpty || !dataRentOnline.tab_3_arrRentPerson[i].value_3.isEmpty ||
                    !dataRentOnline.tab_3_arrRentPerson[i].value_4.isEmpty {
                    countArrTab_3_4_AtLeast += 1
                }
                if dataRentOnline.tab_3_arrRentPerson[i].comboIndex != -1 && !dataRentOnline.tab_3_arrRentPerson[i].value_1.isEmpty && !dataRentOnline.tab_3_arrRentPerson[i].value_2.isEmpty && !dataRentOnline.tab_3_arrRentPerson[i].value_3.isEmpty && !dataRentOnline.tab_3_arrRentPerson[i].value_4.isEmpty {
                    countArrTab_3_4_Full += 1
                }
            }
        }
        for i in 0 ..< dataRentOnline.tab_3_arrTreasure.count {
            if dataRentOnline.tab_3_arrTreasure[i].comboIndex != -1 || !dataRentOnline.tab_3_arrTreasure[i].value_1.isEmpty || !dataRentOnline.tab_3_arrTreasure[i].value_2.isEmpty {
                countArrTab_3_1_AtLeast += 1
            }
            if dataRentOnline.tab_3_arrTreasure[i].comboIndex != -1 && !dataRentOnline.tab_3_arrTreasure[i].value_1.isEmpty && !dataRentOnline.tab_3_arrTreasure[i].value_2.isEmpty {
                countArrTab_3_1_Full += 1
            }
        }
        if countArrTab_3_1_AtLeast > 0 || dataRentOnline.tab_3_arrRent.count > 1 || dataRentOnline.tab_3_optional_1 == 1 || dataRentOnline.tab_3_isOverBorrow || dataRentOnline.tab_3_arrRent.count > 1 || dataRentOnline.tab_3_arrTreasure.count > 1
            || dataRentOnline.tab_3_optional_1 != 0 || countArrTab_3_2_AtLeast > 0
            || dataRentOnline.tab_3_optional_2 != 0 || countArrTab_3_3_AtLeast > 0
            || dataRentOnline.tab_3_optional_3 != 0 || countArrTab_3_4_AtLeast > 0 {
            dataRentOnline.isEmpty_4 = false
            dataRentOnline.isFull_4 = false
        }
        if countArrTab_3_1_Full == dataRentOnline.tab_3_arrTreasure.count
            && (dataRentOnline.tab_3_optional_1 == -1 || (dataRentOnline.tab_3_optional_1 == 1 && countArrTab_3_2_Full == dataRentOnline.tab_3_arrRent.count))
            && (dataRentOnline.tab_3_optional_2 == -1 || (dataRentOnline.tab_3_optional_2 == 1 && countArrTab_3_3_Full == dataRentOnline.tab_3_arrRentOther.count))
            && (dataRentOnline.tab_3_optional_3 == -1 || (dataRentOnline.tab_3_optional_3 == 1 && countArrTab_3_4_Full == dataRentOnline.tab_3_arrRentPerson.count)) {
            dataRentOnline.isFull_4 = true
            dataRentOnline.isEmpty_4 = false
        }
        if countArrTab_3_1_AtLeast == 0 && dataRentOnline.tab_3_arrTreasure.count == 1
            && dataRentOnline.tab_3_optional_1 == 0
            && dataRentOnline.tab_3_optional_2 == 0
            && dataRentOnline.tab_3_optional_3 == 0 {
            dataRentOnline.isEmpty_4 = true
            dataRentOnline.isFull_4 = false
        }

        // MARK: TAB 4
        if dataRentOnline.tab_4_optional_1 {
            for i in 0 ..< dataRentOnline.tab_4_arrRentTreasure.count {
                if dataRentOnline.tab_4_arrRentTreasure[i].comboIndex != -1 || !dataRentOnline.tab_4_arrRentTreasure[i].value_1.isEmpty || !dataRentOnline.tab_4_arrRentTreasure[i].value_2.isEmpty || !dataRentOnline.tab_4_arrRentTreasure[i].value_3.isEmpty || !dataRentOnline.tab_4_arrRentTreasure[i].value_4.isEmpty {
                    countArrTab_4_1_AtLeast += 1
                }
                if !dataRentOnline.tab_4_arrRentTreasure[i].value_3.isEmpty {
                    countArrTab_4_1_Full += 1
                }
            }
        }
        if dataRentOnline.tab_4_optional_2 {
            for i in 0 ..< dataRentOnline.tab_4_arrVehicle.count {
                if !dataRentOnline.tab_4_arrVehicle[i].value_1.isEmpty || !dataRentOnline.tab_4_arrVehicle[i].value_2.isEmpty || !dataRentOnline.tab_4_arrVehicle[i].value_3.isEmpty || dataRentOnline.tab_4_arrVehicle[i].initValueDate != 0 || !dataRentOnline.tab_4_arrVehicle[i].value_4.isEmpty {
                    countArrTab_4_2_AtLeast += 1
                }
                if !dataRentOnline.tab_4_arrVehicle[i].value_4.isEmpty {
                    countArrTab_4_2_Full += 1
                }
            }
        }
        if dataRentOnline.tab_4_optional_3 {
            for i in 0 ..< dataRentOnline.tab_4_arrOtherRent.count {
                if !dataRentOnline.tab_4_arrOtherRent[i].value_1.isEmpty || !dataRentOnline.tab_4_arrOtherRent[i].value_2.isEmpty && !dataRentOnline.tab_4_arrOtherRent[i].value_3.isEmpty {
                    countArrTab_4_3_AtLeast += 1
                }
                if !dataRentOnline.tab_4_arrOtherRent[i].value_2.isEmpty {
                    countArrTab_4_3_Full += 1
                }
            }
        }
        if !dataRentOnline.tab_4_strNeedCost.isEmpty || !dataRentOnline.tab_4_strAlreadyCost.isEmpty || !dataRentOnline.tab_4_strDecideRent.isEmpty || !dataRentOnline.tab_4_strDeadLineRent.isEmpty || dataRentOnline.tab_4_selectedComboTypeArea != -1 || !dataRentOnline.tab_4_strAcreage.isEmpty || dataRentOnline.tab_4_selectedComboCity != -1 || dataRentOnline.tab_4_selectedComboDistrict != -1 || dataRentOnline.tab_4_selectedComboVillage != -1 || !dataRentOnline.tab_4_strAddress.isEmpty
            || dataRentOnline.tab_4_optional_1 || countArrTab_4_1_AtLeast > 0
            || dataRentOnline.tab_4_optional_2 || countArrTab_4_2_AtLeast > 0
            || dataRentOnline.tab_4_optional_3 || countArrTab_4_3_AtLeast > 0 {
            dataRentOnline.isEmpty_6 = false
            dataRentOnline.isFull_6 = false
        }
        if !dataRentOnline.tab_4_strNeedCost.isEmpty && !dataRentOnline.tab_4_strAlreadyCost.isEmpty && !dataRentOnline.tab_4_strDecideRent.isEmpty && !dataRentOnline.tab_4_strDeadLineRent.isEmpty && dataRentOnline.tab_4_selectedComboTypeArea != -1 && !dataRentOnline.tab_4_strAcreage.isEmpty
            && (!dataRentOnline.tab_4_optional_1 || (dataRentOnline.tab_4_optional_1 && countArrTab_4_1_Full == dataRentOnline.tab_4_arrRentTreasure.count))
            && (!dataRentOnline.tab_4_optional_2 || (dataRentOnline.tab_4_optional_2 && countArrTab_4_2_Full == dataRentOnline.tab_4_arrVehicle.count))
            && (!dataRentOnline.tab_4_optional_3 || (dataRentOnline.tab_4_optional_3 && countArrTab_4_3_Full == dataRentOnline.tab_4_arrOtherRent.count)) {
            dataRentOnline.isFull_6 = true
            dataRentOnline.isEmpty_6 = false
        }
        if dataRentOnline.tab_4_strNeedCost.isEmpty && dataRentOnline.tab_4_strAlreadyCost.isEmpty && dataRentOnline.tab_4_strDecideRent.isEmpty && dataRentOnline.tab_4_strDeadLineRent.isEmpty && dataRentOnline.tab_4_selectedComboTypeArea == -1 && dataRentOnline.tab_4_strAcreage.isEmpty && dataRentOnline.tab_4_selectedComboCity == -1 && dataRentOnline.tab_4_selectedComboDistrict == -1 && dataRentOnline.tab_4_selectedComboVillage == -1 && dataRentOnline.tab_4_strAddress.isEmpty
            && !dataRentOnline.tab_4_optional_1
            && !dataRentOnline.tab_4_optional_2
            && !dataRentOnline.tab_4_optional_3 {
            dataRentOnline.isEmpty_6 = true
            dataRentOnline.isFull_6 = false
        }
    }

    func checkCurrentTab() {
        if self.dataRentOnline.selectedIndexPage == 2 {
            self.dataRentOnline.is_2 = true
        } else if self.dataRentOnline.selectedIndexPage == 3 {
            self.dataRentOnline.is_2 = false
        } else if self.dataRentOnline.selectedIndexPage == 4 {
            self.dataRentOnline.is_4 = true
        } else if self.dataRentOnline.selectedIndexPage == 5 {
            self.dataRentOnline.is_4 = false
        } else if self.dataRentOnline.selectedIndexPage == 6 {
            self.dataRentOnline.is_6 = true
        } else if self.dataRentOnline.selectedIndexPage == 7 {
            self.dataRentOnline.is_6 = false
        } else if self.dataRentOnline.selectedIndexPage == 8 {
            self.dataRentOnline.is_8 = true
        } else if self.dataRentOnline.selectedIndexPage == 9 {
            self.dataRentOnline.is_8 = false
        }
    }
}

struct ShowBackConfirmPopup: View {
    @Binding var isShowPopUpBackConfirm: Bool
    let clearTab: () -> Void

    var body: some View {
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
                TextCustom(text: NSLocalizedString("loan_online_title_cancel", comment: ""), size: 18, color: #colorLiteral(red: 0.4281106591, green: 0.1894766092, blue: 0.6721540093, alpha: 1))
                    .padding(.bottom, H(16))
                // MARK: CHƯA BIẾT CÁCH LOCALIZE TEXT CÓ ""
                TextCustom(text: """
Khi bạn bấm "hủy",mọi thông tin bạn điền sẽ bị mất. Bạn chắc chắn muốn hủy hồ sơ cho vay online chứ?
""", font: REGULAR, size: 16, color: #colorLiteral(red: 0.2495550513, green: 0.2954892516, blue: 0.4120893478, alpha: 1))
                    .lineSpacing(5)
                    .multilineTextAlignment(.center)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(.horizontal, 33)
                    .padding(.bottom, H(23))
            }
            HStack (spacing: 10) {
                Button(action: {
                    self.isShowPopUpBackConfirm = false
                }) {
                    ZStack {
                        Rectangle()
                            .cornerRadius(4)
                            .foregroundColor(.white)
                            .frame(width: (FULL_W - 72) / 2 - 5, height: H(40))
                            .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.init(#colorLiteral(red: 0.4282599092, green: 0.1879977882, blue: 0.6717798114, alpha: 1)), lineWidth: 1))
                        TextCustom(text: NSLocalizedString("loan_online_cancel", comment: ""), font: MEDIUM, size: 16, color: #colorLiteral(red: 0.4269524217, green: 0.1874135733, blue: 0.6712699533, alpha: 1))
                    }
                }.buttonStyle(ButtonTapScale())
                Button(action: {
                    self.isShowPopUpBackConfirm = false
                    self.clearTab()
                }) {
                    ZStack {
                        Rectangle()
                            .cornerRadius(4)
                            .foregroundColor(.init(#colorLiteral(red: 0.4282599092, green: 0.1879977882, blue: 0.6717798114, alpha: 1)))
                            .frame(width: (FULL_W - 72) / 2 - 5, height: H(40))
                            .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.init(#colorLiteral(red: 0.4282599092, green: 0.1879977882, blue: 0.6717798114, alpha: 1)), lineWidth: 1))
                        TextCustom(text: NSLocalizedString("loan_online_accept", comment: ""), font: MEDIUM, size: 16, color: .white)
                    }
                }.buttonStyle(ButtonTapScale())
            }.animation(.easeInOut(duration: 0.1))
        }.padding(.bottom, H(26))
            .background(
                Image("union150")
                    .resizable()
                    .frame(width: FULL_W - 42)
                    .shadow(color: .init(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2016802226)), radius: 6)
            ).scaleEffect(isShowPopUpBackConfirm ? 1 : 0.1)
            .opacity(isShowPopUpBackConfirm ? 1 : 0)
            .animation(.easeInOut(duration: 0.2))
    }
}

struct customLoanCaculator: View {
    @Binding var dataRentOnline: ModalRentOnline
    let checkEmptyInfoTab: () -> Void

    @State var frameButtonSwicth: CGFloat = 0
    @State var widthPartTable: CGFloat = 0

    var body: some View {
        VStack (spacing: 0) {
            if dataRentOnline.selectedIndexPage == 1 {
                TextCustom(text: NSLocalizedString("loan_online_infoCommon", comment: ""), size: 18, color: #colorLiteral(red: 0.4282599092, green: 0.1879977882, blue: 0.6717798114, alpha: 1))
                    .padding(.vertical, H(20))
            } else if dataRentOnline.selectedIndexPage == 2 || dataRentOnline.selectedIndexPage == 3 {
                TextCustom(text: NSLocalizedString("loan_online_tab_title_2", comment: ""), size: 18, color: #colorLiteral(red: 0.4282599092, green: 0.1879977882, blue: 0.6717798114, alpha: 1))
                    .padding(.vertical, H(20))
            } else if dataRentOnline.selectedIndexPage == 4 || dataRentOnline.selectedIndexPage == 5 {
                TextCustom(text: NSLocalizedString("loan_online_tab_title_4", comment: ""), size: 18, color: #colorLiteral(red: 0.4282599092, green: 0.1879977882, blue: 0.6717798114, alpha: 1))
                    .padding(.vertical, H(20))
            } else if dataRentOnline.selectedIndexPage == 6 || dataRentOnline.selectedIndexPage == 7 {
                TextCustom(text: NSLocalizedString("loan_online_tab_title_6", comment: ""), size: 18, color: #colorLiteral(red: 0.4282599092, green: 0.1879977882, blue: 0.6717798114, alpha: 1))
                    .padding(.vertical, H(20))
            } else {
                TextCustom(text: NSLocalizedString("loan_online_tab_title_8", comment: ""), size: 18, color: #colorLiteral(red: 0.4282599092, green: 0.1879977882, blue: 0.6717798114, alpha: 1))
                    .padding(.vertical, H(20))
            }
            ZStack (alignment: .top) {
                CircleChartCustom(purple: $dataRentOnline.purple, green: $dataRentOnline.green, type: 1)
                    .padding(.top,
                        FULL_H == H_SE && FULL_W == W_SE ? 30 + frameButtonSwicth: // iPhone SE 1st generation
                        FULL_H == H_8 && FULL_W == W_8 ? 35 + frameButtonSwicth: // iPhone 8 && iPhone SE 2nd generation
                        FULL_H == H_8Plus && FULL_W == W_8Plus ? 40 + frameButtonSwicth: // iPhone 8 Plus
                        FULL_H == H_11 && FULL_W == W_11 ? 40 + frameButtonSwicth: // iPhone 11 && iPhone 11 Pro Max
                        FULL_H == H_11Pro && FULL_W == W_11Pro ? 30 + frameButtonSwicth : 0 // iPhone 11 Pro
                    )
                LocationSelectedTab(selectedIndexPage: $dataRentOnline.selectedIndexPage, frameButtonSwicth: $frameButtonSwicth)
                ZStack (alignment: .topLeading) {
                    //MARK: 1. THÔNG TIN KHÁCH HÀNG
                    VStack {
                        Spacer()
                        HStack {
                            Button(action: {
                                self.checkEmptyInfoTab()
                                self.dataRentOnline.selectedIndexPage = 1
                            }) {
                                Image(dataRentOnline.selectedIndexPage == 1 ?
                                    "customerInfoPurple":
                                        dataRentOnline.isFull_1 ?
                                    "checkGreen":
                                        dataRentOnline.isEmpty_1 ?
                                    "customerInfoWhite":
                                        "customerInfoGreen"
                                ).resizable()
                                    .frame(width: frameButtonSwicth, height: frameButtonSwicth)
                            }.buttonStyle(ButtonTapScale())
                                .shadow(color: Color.init(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.1574878961)), radius: 6)
                                .animation(.easeInOut(duration: 0.1))
                                .padding(.leading, 20)
                            Spacer()
                        }
                    }

                    // MARK: 2. THÔNG TIN NGHỀ NGHIỆP || THU NHẬP HIỆN CÓ
                    Button(action: {
                        self.checkEmptyInfoTab()
                        if self.dataRentOnline.is_2 {
                            self.dataRentOnline.selectedIndexPage = 2
                        } else {
                            self.dataRentOnline.selectedIndexPage = 3
                        }
                    }) {
                        Image(dataRentOnline.selectedIndexPage == 2 || dataRentOnline.selectedIndexPage == 3 ?
                            "jobInfoPurple":
                                dataRentOnline.isFull_2 ?
                            "checkGreen":
                                dataRentOnline.isEmpty_2 ?
                            "jobInfoWhite":
                                "jobInfoGreen"
                        ).resizable()
                            .frame(width: frameButtonSwicth, height: frameButtonSwicth)
                    }.buttonStyle(ButtonTapScale())
                        .shadow(color: Color.init(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.1574878961)), radius: 6)
                        .animation(.easeInOut(duration: 0.1))
                        .padding(.leading,
                            FULL_H == H_SE && FULL_W == W_SE ? 37: // iPhone SE 1st generation
                            FULL_H == H_8 && FULL_W == W_8 ? 45: // iPhone 8 && iPhone SE 2nd generation
                            FULL_H == H_8Plus && FULL_W == W_8Plus ? 49: // iPhone 8 Plus
                            FULL_H == H_11 && FULL_W == W_11 ? 49: // iPhone 11 && iPhone 11 Pro Max
                            FULL_H == H_11Pro && FULL_W == W_11Pro ? 43 : 0 // iPhone 11 Pro
                        ).padding(.top,
                            FULL_H == H_SE && FULL_W == W_SE ? 50: // iPhone SE 1st generation
                            FULL_H == H_8 && FULL_W == W_8 ? 60: // iPhone 8 && iPhone SE 2nd generation
                            FULL_H == H_8Plus && FULL_W == W_8Plus ? 60: // iPhone 8 Plus
                            FULL_H == H_11 && FULL_W == W_11 ? 60: // iPhone 11 && iPhone 11 Pro Max
                            FULL_H == H_11Pro && FULL_W == W_11Pro ? 60 : 0 // iPhone 11 Pro
                        )

                    // MARK: 3. TÀI SẢN HIỆN CÓ || TÌNH HÌNH KHOẢN VAY
                    VStack {
                        HStack {
                            Spacer()
                            Button(action: {
                                self.checkEmptyInfoTab()
                                if self.dataRentOnline.is_4 {
                                    self.dataRentOnline.selectedIndexPage = 4
                                } else {
                                    self.dataRentOnline.selectedIndexPage = 5
                                }
                            }) {
                                Image(dataRentOnline.selectedIndexPage == 4 || dataRentOnline.selectedIndexPage == 5 ? "cashHavePurple":
                                        dataRentOnline.isFull_4 ? "checkGreen" : dataRentOnline.isEmpty_4 ? "cashHaveWhite" : "cashHaveGreen"
                                ).resizable()
                                    .frame(width: frameButtonSwicth, height: frameButtonSwicth)
                            }.buttonStyle(ButtonTapScale())
                                .shadow(color: Color.init(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.1574878961)), radius: 6)
                                .animation(.easeInOut(duration: 0.1))
                            Spacer()
                        }
                        Spacer()
                    }

                    // MARK: 4. NHU CẦU VAY VỐN || TÀI SẢN BẢO ĐẢM TIỀN VAY
                    HStack {
                        Spacer()
                        Button(action: {
                            self.checkEmptyInfoTab()
                            if self.dataRentOnline.is_6 {
                                self.dataRentOnline.selectedIndexPage = 6
                            } else {
                                self.dataRentOnline.selectedIndexPage = 7
                            }
                        }) {
                            Image(dataRentOnline.selectedIndexPage == 6 || dataRentOnline.selectedIndexPage == 7 ? "moneyPurple":
                                    dataRentOnline.isFull_6 ? "checkGreen" : dataRentOnline.isEmpty_6 ? "moneyWhite" : "moneyGreen"
                            ).resizable()
                                .frame(width: frameButtonSwicth, height: frameButtonSwicth)
                        }.buttonStyle(ButtonTapScale())
                            .shadow(color: Color.init(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.1574878961)), radius: 6)
                            .animation(.easeInOut(duration: 0.1))
                            .padding(.trailing,
                                FULL_H == H_SE && FULL_W == W_SE ? 37: // iPhone SE 1st generation
                                FULL_H == H_8 && FULL_W == W_8 ? 45: // iPhone 8 && iPhone SE 2nd generation
                                FULL_H == H_8Plus && FULL_W == W_8Plus ? 49: // iPhone 8 Plus
                                FULL_H == H_11 && FULL_W == W_11 ? 49: // iPhone 11 && iPhone 11 Pro Max
                                FULL_H == H_11Pro && FULL_W == W_11Pro ? 43 : 0 // iPhone 11 Pro
                            )
                    }.padding(.top,
                        FULL_H == H_SE && FULL_W == W_SE ? 50: // iPhone SE 1st generation
                        FULL_H == H_8 && FULL_W == W_8 ? 60: // iPhone 8 && iPhone SE 2nd generation
                        FULL_H == H_8Plus && FULL_W == W_8Plus ? 60: // iPhone 8 Plus
                        FULL_H == H_11 && FULL_W == W_11 ? 60: // iPhone 11 && iPhone 11 Pro Max
                        FULL_H == H_11Pro && FULL_W == W_11Pro ? 60 : 0 // iPhone 11 Pro
                    )

                    // MARK: 5. THÔNG TIN VAY VỐN || THU NHẬP && TÀI SẢN HIỆN CÓ
                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            Button(action: {
                                self.checkEmptyInfoTab()
                                if self.dataRentOnline.is_8 {
                                    self.dataRentOnline.selectedIndexPage = 8
                                } else {
                                    self.dataRentOnline.selectedIndexPage = 9
                                }
                            }) {
                                Image(dataRentOnline.selectedIndexPage == 8 || dataRentOnline.selectedIndexPage == 9 ? "resultPurple" : "resultWhite")
                                    .resizable()
                                    .frame(width: frameButtonSwicth, height: frameButtonSwicth)
                            }.buttonStyle(ButtonTapScale())
                                .shadow(color: Color.init(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.1574878961)), radius: 6)
                                .animation(.easeInOut(duration: 0.1))
                                .padding(.trailing, 20)
                        }
                    }
                }.frame(width: FULL_W - 32, height:
                        FULL_H == H_SE && FULL_W == W_SE ? (frameButtonSwicth * 3) + 80 + 16 - 37: // iPhone SE 1st generation
                    FULL_H == H_8 && FULL_W == W_8 ? (frameButtonSwicth * 3) + 80 + 16 - 17: // iPhone 8 && iPhone SE 2nd generation
                    FULL_H == H_8Plus && FULL_W == W_8Plus ? (frameButtonSwicth * 3) + 80 + 16: // iPhone 8 Plus
                    FULL_H == H_11 && FULL_W == W_11 ? (frameButtonSwicth * 3) + 80 + 16: // iPhone 11 && iPhone 11 Pro Max
                    FULL_H == H_11Pro && FULL_W == W_11Pro ? (frameButtonSwicth * 3) + 80 + 16 - 17: 0 // iPhone 11 Pro
                )
            }
            ZStack(alignment: .leading) {
                ZStack {
                    Rectangle()
                        .frame(width: FULL_W - (widthPartTable + 60), height: H(62) + 2)
                        .foregroundColor(.init(#colorLiteral(red: 0.932536602, green: 0.2507158816, blue: 0.2460758984, alpha: 1)))
                        .cornerRadius(4, corners: [.topRight, .bottomRight])
                    Rectangle()
                        .frame(width: FULL_W - (widthPartTable + 62), height: H(62))
                        .foregroundColor(.white)
                        .cornerRadius(4, corners: [.topRight, .bottomRight])
                    Rectangle()
                        .foregroundColor(.init(#colorLiteral(red: 0.932536602, green: 0.2507158816, blue: 0.2460758984, alpha: 1)))
                        .frame(width: FULL_W - (widthPartTable + 60), height: 1)
                    HStack {
                        VStack(alignment: .leading) {
                            HStack (spacing: 0) {
                                Rectangle()
                                    .frame(width: 8, height: 8)
                                    .foregroundColor(.init(#colorLiteral(red: 0.3190362453, green: 0.7693782449, blue: 0.442176193, alpha: 1)))
                                    .cornerRadius(.infinity)
                                    .padding(.trailing, 6)
                                    .padding(.leading, 8)
                                TextCustom(text: NSLocalizedString("loan_online_amountMoneySum", comment: ""), font: REGULAR, size: 14, color: #colorLiteral(red: 0.6665948629, green: 0.6667092443, blue: 0.6665788293, alpha: 1))
                                    .fixedSize(horizontal: true, vertical: false)
                                    .padding(.trailing,
                                        FULL_H == H_SE && FULL_W == W_SE ? 5: // iPhone SE 1st generation
                                        FULL_H == H_8 && FULL_W == W_8 ? 6: // iPhone 8 && iPhone SE 2nd generation
                                        FULL_H == H_8Plus && FULL_W == W_8Plus ? 6: // iPhone 8 Plus
                                        FULL_H == H_11 && FULL_W == W_11 ? 10: // iPhone 11 && iPhone 11 Pro Max
                                        FULL_H == H_11Pro && FULL_W == W_11Pro ? 6 : 0 // iPhone 11 Pro
                                    )
                                TextCustom(text: Utils.formatHighNumber(Double(dataRentOnline.green)), size: 16, color: #colorLiteral(red: 0.1400775909, green: 0.1216219291, blue: 0.1212796792, alpha: 1))
                                    .frame(width:
                                            FULL_H == H_SE && FULL_W == W_SE ? 95: // iPhone SE 1st generation
                                        FULL_H == H_8 && FULL_W == W_8 ? 130: // iPhone 8 && iPhone SE 2nd generation
                                        FULL_H == H_8Plus && FULL_W == W_8Plus ? 140: // iPhone 8 Plus
                                        FULL_H == H_11 && FULL_W == W_11 ? 120: // iPhone 11 && iPhone 11 Pro Max
                                        FULL_H == H_11Pro && FULL_W == W_11Pro ? 100 : 0 // iPhone 11 Pro
                                        , alignment: .trailing)
                            }
                            HStack (spacing: 0) {
                                Rectangle()
                                    .frame(width: 8, height: 8)
                                    .foregroundColor(.init(#colorLiteral(red: 0.9813259244, green: 0.5715919137, blue: 0.2061223388, alpha: 1)))
                                    .cornerRadius(.infinity)
                                    .padding(.trailing, 6)
                                    .padding(.leading, 8)
                                TextCustom(text: NSLocalizedString("loan_online_amountMoneySumMore", comment: ""), font: REGULAR, size: 14, color: #colorLiteral(red: 0.6665948629, green: 0.6667092443, blue: 0.6665788293, alpha: 1))
                                    .fixedSize(horizontal: true, vertical: false)
                                    .padding(.trailing,
                                        FULL_H == H_SE && FULL_W == W_SE ? 5: // iPhone SE 1st generation
                                        FULL_H == H_8 && FULL_W == W_8 ? 6: // iPhone 8 && iPhone SE 2nd generation
                                        FULL_H == H_8Plus && FULL_W == W_8Plus ? 6: // iPhone 8 Plus
                                        FULL_H == H_11 && FULL_W == W_11 ? 10: // iPhone 11 && iPhone 11 Pro Max
                                        FULL_H == H_11Pro && FULL_W == W_11Pro ? 6 : 0 // iPhone 11 Pro
                                    )
                                TextCustom(text: "42,583,334", size: 16, color: #colorLiteral(red: 0.1400775909, green: 0.1216219291, blue: 0.1212796792, alpha: 1))
                                    .frame(width:
                                            FULL_H == H_SE && FULL_W == W_SE ? 95: // iPhone SE 1st generation
                                        FULL_H == H_8 && FULL_W == W_8 ? 130: // iPhone 8 && iPhone SE 2nd generation
                                        FULL_H == H_8Plus && FULL_W == W_8Plus ? 140: // iPhone 8 Plus
                                        FULL_H == H_11 && FULL_W == W_11 ? 120: // iPhone 11 && iPhone 11 Pro Max
                                        FULL_H == H_11Pro && FULL_W == W_11Pro ? 100 : 0 // iPhone 11 Pro
                                        , alignment: .trailing)
                            }
                        }
                        Spacer()
                    }.frame(width: FULL_W - (widthPartTable + 62), height: H(62))
                }.padding(.leading, widthPartTable)
                ZStack (alignment: .leading) {
                    Rectangle()
                        .foregroundColor(.init(#colorLiteral(red: 0.932536602, green: 0.2507158816, blue: 0.2460758984, alpha: 1)))
                        .frame(width: widthPartTable, height: H(62) + 2)
                        .cornerRadius(4, corners: [.topLeft, .bottomLeft])
                    VStack (alignment: .leading, spacing: H(5)) {
                        TextCustom(text: NSLocalizedString("loan_online_amountMoneyRent", comment: ""), font: REGULAR, size: 13, color: #colorLiteral(red: 0.8730918765, green: 0.8731970787, blue: 0.8730561733, alpha: 1))
                        TextCustom(text: Utils.formatHighNumber(Double(dataRentOnline.purple)), size: 16, color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
                    }.padding(.leading, 9)
                }
            }.padding(.bottom, H(28))
        }.frame(width: FULL_W - 32)
            .background(Color.init(#colorLiteral(red: 0.9522359967, green: 0.9490477443, blue: 0.9561609626, alpha: 1)))
            .cornerRadius(0)
            .shadow(color: Color.init(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.1574878961)), radius: 6, x: 0, y: 3)
            .onAppear {
                self.widthPartTable =
                    FULL_H == H_SE && FULL_W == W_SE ? 80: // iPhone SE 1st generation
                FULL_H == H_8 && FULL_W == W_8 ? 90: // iPhone 8 && iPhone SE 2nd generation
                FULL_H == H_8Plus && FULL_W == W_8Plus ? 110: // iPhone 8 Plus
                FULL_H == H_11 && FULL_W == W_11 ? 110: // iPhone 11 && iPhone 11 Pro Max
                FULL_H == H_11Pro && FULL_W == W_11Pro ? 110 : 0 // iPhone 11 Pro

                self.frameButtonSwicth =
                    FULL_H == H_SE && FULL_W == W_SE ? 35: // iPhone SE 1st generation
                FULL_H == H_8 && FULL_W == W_8 ? 38: // iPhone 8 && iPhone SE 2nd generation
                FULL_H == H_8Plus && FULL_W == W_8Plus ? 44: // iPhone 8 Plus
                FULL_H == H_11 && FULL_W == W_11 ? 44: // iPhone 11 && iPhone 11 Pro Max
                FULL_H == H_11Pro && FULL_W == W_11Pro ? 40 : 0 // iPhone 11 Pro
        }
    }
}

struct LocationSelectedTab: View {
    @Binding var selectedIndexPage: Int
    @Binding var frameButtonSwicth: CGFloat
    @State var widthHStack: CGFloat =
        FULL_H == H_SE && FULL_W == W_SE ? 161: // iPhone SE 1st generation
    FULL_H == H_8 && FULL_W == W_8 ? 191: // iPhone 8 && iPhone SE 2nd generation
    FULL_H == H_8Plus && FULL_W == W_8Plus ? 221: // iPhone 8 Plus
    FULL_H == H_11 && FULL_W == W_11 ? 221: // iPhone 11 && iPhone 11 Pro Max
    FULL_H == H_11Pro && FULL_W == W_11Pro ? 201 : 0 // iPhone 11 Pro

    var body: some View {
        ZStack (alignment: .top) {
            Circle()
                .trim(from: 0, to: 0.59375)
                .stroke(Color.init(#colorLiteral(red: 0.4282599092, green: 0.1879977882, blue: 0.6717798114, alpha: 1)), lineWidth: 1)
                .frame(width:
                        FULL_H == H_SE && FULL_W == W_SE ? 161: // iPhone SE 1st generation
                    FULL_H == H_8 && FULL_W == W_8 ? 191: // iPhone 8 && iPhone SE 2nd generation
                    FULL_H == H_8Plus && FULL_W == W_8Plus ? 221: // iPhone 8 Plus
                    FULL_H == H_11 && FULL_W == W_11 ? 221: // iPhone 11 && iPhone 11 Pro Max
                    FULL_H == H_11Pro && FULL_W == W_11Pro ? 201 : 0 // iPhone 11 Pro
                    , height:
                        FULL_H == H_SE && FULL_W == W_SE ? 161: // iPhone SE 1st generation
                    FULL_H == H_8 && FULL_W == W_8 ? 191: // iPhone 8 && iPhone SE 2nd generation
                    FULL_H == H_8Plus && FULL_W == W_8Plus ? 221: // iPhone 8 Plus
                    FULL_H == H_11 && FULL_W == W_11 ? 221: // iPhone 11 && iPhone 11 Pro Max
                    FULL_H == H_11Pro && FULL_W == W_11Pro ? 201 : 0 // iPhone 11 Pro
                ).rotationEffect(.degrees(163.125))

            // MARK: 1
            HStack {
                Rectangle()
                    .frame(width: 10, height: 10)
                    .foregroundColor(.init(#colorLiteral(red: 0.4282599092, green: 0.1879977882, blue: 0.6717798114, alpha: 1)))
                    .cornerRadius(.infinity)
                    .shadow(color: Color.init(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2169038955)), radius: 6)
                    .offset(x:
                            FULL_H == H_SE && FULL_W == W_SE ? -4.5: // iPhone SE 1st generation
                        FULL_H == H_8 && FULL_W == W_8 ? -4: // iPhone 8 && iPhone SE 2nd generation
                        FULL_H == H_8Plus && FULL_W == W_8Plus ? -3.5: // iPhone 8 Plus
                        FULL_H == H_11 && FULL_W == W_11 ? -3.75: // iPhone 11 && iPhone 11 Pro Max
                        FULL_H == H_11Pro && FULL_W == W_11Pro ? -3.75 : 0 // iPhone 11 Pro
                        , y:
                            FULL_H == H_SE && FULL_W == W_SE ? 84: // iPhone SE 1st generation
                        FULL_H == H_8 && FULL_W == W_8 ? 104: // iPhone 8 && iPhone SE 2nd generation
                        FULL_H == H_8Plus && FULL_W == W_8Plus ? 123: // iPhone 8 Plus
                        FULL_H == H_11 && FULL_W == W_11 ? 123: // iPhone 11 && iPhone 11 Pro Max
                        FULL_H == H_11Pro && FULL_W == W_11Pro ? 110 : 0 // iPhone 11 Pro
                    ).opacity(selectedIndexPage == 1 ? 1 : 0)
                Spacer()
            }.frame(width: widthHStack)

            // MARK: 2
            Rectangle()
                .frame(width: 10, height: 10)
                .foregroundColor(.init(#colorLiteral(red: 0.4282599092, green: 0.1879977882, blue: 0.6717798114, alpha: 1)))
                .cornerRadius(.infinity)
                .shadow(color: Color.init(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2169038955)), radius: 6)
                .offset(x:
                        FULL_H == H_SE && FULL_W == W_SE ? -66.5: // iPhone SE 1st generation
                    FULL_H == H_8 && FULL_W == W_8 ? -80: // iPhone 8 && iPhone SE 2nd generation
                    FULL_H == H_8Plus && FULL_W == W_8Plus ? -87.5: // iPhone 8 Plus
                    FULL_H == H_11 && FULL_W == W_11 ? -87.5: // iPhone 11 && iPhone 11 Pro Max
                    FULL_H == H_11Pro && FULL_W == W_11Pro ? -83 : 0 // iPhone 11 Pro
                    , y:
                        FULL_H == H_SE && FULL_W == W_SE ? 30: // iPhone SE 1st generation
                    FULL_H == H_8 && FULL_W == W_8 ? 38: // iPhone 8 && iPhone SE 2nd generation
                    FULL_H == H_8Plus && FULL_W == W_8Plus ? 38: // iPhone 8 Plus
                    FULL_H == H_11 && FULL_W == W_11 ? 38: // iPhone 11 && iPhone 11 Pro Max
                    FULL_H == H_11Pro && FULL_W == W_11Pro ? 39 : 0 // iPhone 11 Pro
                ).opacity(selectedIndexPage == 2 || selectedIndexPage == 3 ? 1 : 0)

            // MARK: 3
            Rectangle()
                .frame(width: 10, height: 10)
                .foregroundColor(.init(#colorLiteral(red: 0.4282599092, green: 0.1879977882, blue: 0.6717798114, alpha: 1)))
                .cornerRadius(.infinity)
                .shadow(color: Color.init(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.1574878961)), radius: 6)
                .offset(y: -5)
                .opacity(selectedIndexPage == 4 || selectedIndexPage == 5 ? 1 : 0)

            // MARK: 4
            Rectangle()
                .frame(width: 10, height: 10)
                .foregroundColor(.init(#colorLiteral(red: 0.4282599092, green: 0.1879977882, blue: 0.6717798114, alpha: 1)))
                .cornerRadius(.infinity)
                .shadow(color: Color.init(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2169038955)), radius: 6)
                .offset(x:
                        FULL_H == H_SE && FULL_W == W_SE ? 66.5: // iPhone SE 1st generation
                    FULL_H == H_8 && FULL_W == W_8 ? 80: // iPhone 8 && iPhone SE 2nd generation
                    FULL_H == H_8Plus && FULL_W == W_8Plus ? 87.5: // iPhone 8 Plus
                    FULL_H == H_11 && FULL_W == W_11 ? 87.5: // iPhone 11 && iPhone 11 Pro Max
                    FULL_H == H_11Pro && FULL_W == W_11Pro ? 83 : 0 // iPhone 11 Pro
                    , y:
                        FULL_H == H_SE && FULL_W == W_SE ? 30: // iPhone SE 1st generation
                    FULL_H == H_8 && FULL_W == W_8 ? 38: // iPhone 8 && iPhone SE 2nd generation
                    FULL_H == H_8Plus && FULL_W == W_8Plus ? 38: // iPhone 8 Plus
                    FULL_H == H_11 && FULL_W == W_11 ? 38: // iPhone 11 && iPhone 11 Pro Max
                    FULL_H == H_11Pro && FULL_W == W_11Pro ? 39 : 0 // iPhone 11 Pro
                ).opacity(selectedIndexPage == 6 || selectedIndexPage == 7 ? 1 : 0)

            // MARK: 5
            HStack {
                Spacer()
                Rectangle()
                    .frame(width: 10, height: 10)
                    .foregroundColor(.init(#colorLiteral(red: 0.4282599092, green: 0.1879977882, blue: 0.6717798114, alpha: 1)))
                    .cornerRadius(.infinity)
                    .shadow(color: Color.init(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2169038955)), radius: 6)
                    .offset(x:
                            FULL_H == H_SE && FULL_W == W_SE ? 4.5: // iPhone SE 1st generation
                        FULL_H == H_8 && FULL_W == W_8 ? 4: // iPhone 8 && iPhone SE 2nd generation
                        FULL_H == H_8Plus && FULL_W == W_8Plus ? 3.5: // iPhone 8 Plus
                        FULL_H == H_11 && FULL_W == W_11 ? 3.75: // iPhone 11 && iPhone 11 Pro Max
                        FULL_H == H_11Pro && FULL_W == W_11Pro ? 3.75 : 0 // iPhone 11 Pro
                        , y:
                            FULL_H == H_SE && FULL_W == W_SE ? 84: // iPhone SE 1st generation
                        FULL_H == H_8 && FULL_W == W_8 ? 104: // iPhone 8 && iPhone SE 2nd generation
                        FULL_H == H_8Plus && FULL_W == W_8Plus ? 123: // iPhone 8 Plus
                        FULL_H == H_11 && FULL_W == W_11 ? 123: // iPhone 11 && iPhone 11 Pro Max
                        FULL_H == H_11Pro && FULL_W == W_11Pro ? 110 : 0 // iPhone 11 Pro
                    ).opacity(selectedIndexPage == 8 || selectedIndexPage == 9 ? 1 : 0)
            }.frame(width: widthHStack)
        }.padding(.top,
            FULL_H == H_SE && FULL_W == W_SE ? 13 + frameButtonSwicth: // iPhone SE 1st generation
            FULL_H == H_8 && FULL_W == W_8 ? 18 + frameButtonSwicth: // iPhone 8 && iPhone SE 2nd generation
            FULL_H == H_8Plus && FULL_W == W_8Plus ? 23 + frameButtonSwicth: // iPhone 8 Plus
            FULL_H == H_11 && FULL_W == W_11 ? 23 + frameButtonSwicth: // iPhone 11 && iPhone 11 Pro Max
            FULL_H == H_11Pro && FULL_W == W_11Pro ? 13 + frameButtonSwicth : 0 // iPhone 11 Pro
        )
    }
}
