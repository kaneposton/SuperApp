// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import SwiftUI

struct SalePolicyView: View {
    @Binding var isNextOld: Bool
    @Binding var isRoot: Bool
    @Binding var projectURL: String

    @State var selectedTabIndex = 0
    @State var isNextLoanRule = false
    @State var isNextLoanContact = false
    @State var isExpand_1 = false
    @State var isExpand_2 = false
    @State var viewState = CGSize.zero

    @State var isShowComboboxStandard = false
    @State var isShowComboboxDiscout = false
    @State var selectedComboStartdard = -1
    @State var selectedComboDiscout = -1
    @State var selectedComboStartdardName = ""
    @State var selectedComboDiscoutName = ""
    @State var dataStandard = [typeCombobox(id: 0, name: "Tiến độ chuẩn")]
    @State var dataDiscout = [typeCombobox(id: 0, name: "Thanh toán sớm 30%")]
    @State var isChangeColor = false
    @State var labelCombobox = "sale_policy_progress_pay"
    
    // MARK: BINDING RESULT ONLINE
    @State var sumMoney = "3000000000"
    @State var moneyFirst = "100000000"
    @State var payTimes = 1

    var body: some View {
        NavigationView {
            ZStack (alignment: .top) {
                Rectangle()
                    .foregroundColor(.white)
                    .edgesIgnoringSafeArea(.all)
                VStack (spacing: 0) {
                    Rectangle()
                        .frame(height: 1)
                        .foregroundColor(.init(#colorLiteral(red: 0.6533299685, green: 0.6326879859, blue: 0.6321712136, alpha: 1)))
                        .padding(.top, H(64))
                    ScrollView (showsIndicators: false) {
                        VStack (spacing: 0) {
                            HStack (spacing: 0) {
                                salePolicyTapp(btnName: "sale_policy_cs_tieu_chuan", btnIndex: 0, selectedIndex: $selectedTabIndex)
                                    .frame(width: FULL_W / 2)
                                    .offset(x: 20)
                                salePolicyTapp(btnName: "sale_policy_cs_chiet_khau", btnIndex: 1, selectedIndex: $selectedTabIndex)
                                    .frame(width: FULL_W / 2)
                                    .offset(x: -20)
                            }.padding(.top, H(24))
                            HStack {
                                ZStack {
                                    Rectangle()
                                        .frame(height: 2)
                                        .foregroundColor(.init(#colorLiteral(red: 0.4281106591, green: 0.1894766092, blue: 0.6721540093, alpha: 1)))
                                        .padding(.horizontal, 45)
                                        .padding(.top, H(5.5))
                                        .offset(x: 20)
                                        .offset(x: selectedTabIndex == 0 ? 0 : FULL_W / 2 - 40)
                                        .animation(.easeInOut(duration: 0.2))
                                }.frame(width: FULL_W / 2)
                                Spacer()
                            }.padding(.bottom, H(24.5))
                            if selectedTabIndex == 0 {
                                SalePolicyStandardView(
                                    payTimes: $payTimes,
                                    moneyFirst: $moneyFirst,
                                    sumMoney: $sumMoney,
                                    isExpand: $isExpand_1,
                                    isNextLoanRule: $isNextLoanRule,
                                    isNextLoanContact: $isNextLoanContact,
                                    isShowComboboxStandard: $isShowComboboxStandard,
                                    selectedComboStartdard: $selectedComboStartdard,
                                    isChangeColor: $isChangeColor,
                                    selectedComboStartdardName: $selectedComboStartdardName
                                )
                            } else {
                                SalePolicy_DiscountView(
                                    payTimes: $payTimes,
                                    sumMoney: $sumMoney,
                                    isExpand: $isExpand_2,
                                    isNextLoanRule: $isNextLoanRule,
                                    isNextLoanContact: $isNextLoanContact,
                                    isShowComboboxDiscout: $isShowComboboxDiscout,
                                    selectedComboDiscout: $selectedComboDiscout,
                                    isChangeColor: $isChangeColor,
                                    selectedComboDiscoutName: $selectedComboDiscoutName
                                )
                            }
                        }
                    }
                }
                Rectangle()
                    .opacity(isShowComboboxStandard || isShowComboboxDiscout ? 0.65 : 0)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        self.isShowComboboxStandard = false
                        self.isShowComboboxDiscout = false
                        self.isChangeColor = false
                    }.animation(.easeInOut(duration: 0.2))
                ShowComboboxView(
                    selectedIndexPage: Binding.constant(0),
                    dataOtherSalary: Binding.constant([]),
                    dataCombo4Value: Binding.constant([]),
                    dataTreasure: Binding.constant([]),
                    indexForEach: Binding.constant(0),
                    isChangeColor: $isChangeColor,
                    isShowCombobox: $isShowComboboxStandard,
                    selectedComboIndex: $selectedComboStartdard,
                    selectedComboName: $selectedComboStartdardName,
                    label: $labelCombobox,
                    data: $dataStandard
                )
                ShowComboboxView(
                    selectedIndexPage: Binding.constant(0),
                    dataOtherSalary: Binding.constant([]),
                    dataCombo4Value: Binding.constant([]),
                    dataTreasure: Binding.constant([]),
                    indexForEach: Binding.constant(0),
                    isChangeColor: $isChangeColor,
                    isShowCombobox: $isShowComboboxDiscout,
                    selectedComboIndex: $selectedComboDiscout,
                    selectedComboName: $selectedComboDiscoutName,
                    label: $labelCombobox,
                    data: $dataDiscout
                )

                NavigationWhite(
                    isTapSearch: Binding.constant(false),
                    isLogin: Binding.constant(false),
                    isChangeColor: $isChangeColor,
                    isOpenSideMenu: Binding.constant(false),
                    strSearch: Binding.constant(""),
                    isShowCalendar: Binding.constant(false),
                    isChooseValueDate: Binding.constant(false),
                    title: "sale_policy_planning",
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
                        LoanRule_1(
                            isNextOld: $isNextLoanRule,
                            isRoot: $isRoot,
                            typeLoan: $selectedTabIndex,
                            sumMoney: $sumMoney,
                            moneyFirst: $moneyFirst,
                            payTimes: $payTimes,
                            projectURL: $projectURL
                        ), isActive: $isNextLoanRule) {
                    EmptyView()
                }
                NavigationLink(destination:
                        SalePolicyContactBuy(isNextOld: $isNextLoanContact, isRoot: $isRoot), isActive: $isNextLoanContact) {
                    EmptyView()
                }
            }.onTapGesture {
                UIApplication.shared.endEditing()
            }.navigationBarTitle("")
                .navigationBarHidden(true)
                .navigationBarBackButtonHidden(true)
        }.navigationBarTitle("")
            .navigationBarHidden(true)
            .navigationBarBackButtonHidden(true)
    }
}

struct salePolicyTapp: View {
    var btnName = ""
    var btnIndex = 0

    @Binding var selectedIndex: Int

    var body: some View {
        HStack {
            Button(action: {
                self.selectedIndex = self.btnIndex
                UIApplication.shared.endEditing()
            }) {
                ZStack {
                    TextCustom(text: NSLocalizedString(btnName, comment: ""), font: MEDIUM, size: 18, lineLimit: 1, color: #colorLiteral(red: 0.4281106591, green: 0.1894766092, blue: 0.6721540093, alpha: 1))
                        .opacity(selectedIndex == btnIndex ? 1 : 0)
                        .fixedSize(horizontal: true, vertical: false)
                    TextCustom(text: NSLocalizedString(btnName, comment: ""), font: REGULAR, size: 18, lineLimit: 1, color: #colorLiteral(red: 0.665820241, green: 0.6659018993, blue: 0.6657924652, alpha: 1))
                        .opacity(selectedIndex == btnIndex ? 0 : 1)
                        .fixedSize(horizontal: true, vertical: false)
                }
            }.buttonStyle(ButtonTapScale())
                .animation(.easeInOut(duration: 0.1))
        }
    }
}

struct SalePolicyTabView: View {
    var tabName = ""
    var tabIndex = 0

    @Binding var selectedTabIndex: Int

    var body: some View {
        HStack {
            Button(action: {
                self.selectedTabIndex = self.tabIndex
            }) {
                VStack (spacing: H(5.5)) {
                    ZStack {
                        TextCustom(text: tabName, size: 18, color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
                            .opacity(selectedTabIndex == tabIndex ? 1 : 0)
                        TextCustom(text: tabName, size: 18, color: #colorLiteral(red: 0.4303680956, green: 0.1883601248, blue: 0.6711185575, alpha: 1))
                            .opacity(selectedTabIndex == tabIndex ? 0 : 1)
                    }
                    Capsule().fill(Color.init(selectedTabIndex == tabIndex ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1): .clear))
                        .frame(width: W(106), height: H(2))
                }
            }
        }
    }
}

struct TabViewCustom {
    var id: Int
    var tabNAME: String
}
