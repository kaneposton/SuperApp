// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import SwiftUI

struct LoanRule_2: View {
    @Binding var isNextOld: Bool
    @Binding var isRoot: Bool
    @Binding var projectURL: String

    @Binding var typeLoan: Int
    @Binding var sumMoney: String
    @Binding var moneyFirst: String
    @Binding var payTimes: Int

    // MARK: DATA RENT ONLINE
    @Binding var dataRentOnline: ModalRentOnline

    // MARK: OTHER
    @State var month = ""
    @State var isCheckBox2_3 = false
    @State var time = ""
    @State var fee = ""
    @State var isCheckBox2_2 = false
    @State var time2_2 = ""
    @State var fee2_2 = ""
    @State var date_Step_1 = Date()
    @State var date_Step_2 = Date()
    @State var typeAlert = 0
    @State var isNext = false
    @State var isChangeColor = false
    @State var isShowDatePicker = false
    @State var showNextFailed = false
    @State var labelDatePicker = ""
    @State var isPaddingBottomKeyboard = false
    @State var isKeyboardPush = false
    @State var initValue = 1

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
                                TextCustom(text: NSLocalizedString("sale_policy_step2", comment: ""), font: REGULAR, size: 18, color: #colorLiteral(red: 0.6533299685, green: 0.6326879859, blue: 0.6321712136, alpha: 1))
                                TextCustom(text: NSLocalizedString("sale_policy_step2_title", comment: ""), size: 18, color: #colorLiteral(red: 0.4263509512, green: 0.1872772872, blue: 0.6715394855, alpha: 1))
                            }.padding(.top, H(20))
                                .padding(.bottom, H(19))
                            ZStack {
                                Rectangle()
                                    .frame(height: H(4))
                                    .foregroundColor(.init(#colorLiteral(red: 0.66581285, green: 0.6659106016, blue: 0.6657914519, alpha: 1)))
                                    .padding(.horizontal, 95)
                                HStack(spacing: 0) {
                                    SalePolicyCustomImage(step: 2, imageName: "stepCheck", index: 1)
                                    Spacer()
                                    SalePolicyCustomImage(step: 2, imageName: "calculatorPurple", index: 2)
                                    Spacer()
                                    SalePolicyCustomImage(step: 2, imageName: "addCheckWhite", index: 3)
                                }.frame(width: FULL_W - 190)
                            }
                            DetailStep_2(
                                isNext: $isNext,
                                selectedMethod: $dataRentOnline.selectedMethod,
                                isChangeColor: $isChangeColor,
                                isShowDatePicker: $isShowDatePicker,
                                labelDatePicker: $labelDatePicker,
                                showNextFailed: $showNextFailed,
                                isPaddingBottomKeyboard: $isPaddingBottomKeyboard,
                                isKeyboardPush: $isKeyboardPush,
                                loanMoney: $dataRentOnline.loanMoney,
                                year: $dataRentOnline.year,
                                month: $month,
                                isCheckBox2_3: $isCheckBox2_3,
                                time: $time,
                                fee: $fee,
                                isCheckBox2_2: $isCheckBox2_2,
                                time2_2: $time2_2,
                                fee2_2: $fee2_2,
                                date_Step_1: $date_Step_1,
                                date_Step_2: $date_Step_2,
                                initValue: $initValue,
                                purple: $dataRentOnline.purple,
                                sumMoney: $sumMoney,
                                green: $dataRentOnline.green,
                                typeAlert: $typeAlert
                            )
                        }
                    }.resignKeyboardOnDragGesture()
                }.padding(.top, H(64))
                ZStack (alignment: .top) {
                    Rectangle()
                        .opacity(isShowDatePicker || showNextFailed ? 0.65 : 0)
                        .edgesIgnoringSafeArea(.all)
                        .animation(.easeInOut(duration: 0.2))
                        .onTapGesture {
                            self.showNextFailed = false
                            self.isShowDatePicker = false
                            self.isChangeColor = false
                    }
                    ShowNextFailed(
                        isChangeColor: $isChangeColor,
                        showNextFailed: $showNextFailed,
                        typeAlert: $typeAlert
                    )
                    ShowDatePickerView(
                        indexForEach: Binding.constant(0),
                        selectedIndexPage: Binding.constant(0),
                        selectedIndexTab: Binding.constant(0),
                        dataTab_4: Binding.constant([]),
                        date: dataRentOnline.selectedMethod == 0 ? $date_Step_1: $date_Step_2,
                        valueIndex: Binding.constant(0),
                        valueName: Binding.constant(""),
                        labelDatePicker: $labelDatePicker,
                        isChangeColor: $isChangeColor,
                        isShowDatePicker: $isShowDatePicker,
                        initValue: $initValue
                    )
                }
                VStack {
                    NavigationWhite(
                        isTapSearch: Binding.constant(false),
                        isLogin: Binding.constant(false),
                        isChangeColor: $isChangeColor,
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
                        LoanRule_3(
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
            }.onTapGesture {
                UIApplication.shared.endEditing()
                self.isKeyboardPush = false
                self.isPaddingBottomKeyboard = false
            }.navigationBarHidden(true)
                .navigationBarTitle("")
                .navigationBarBackButtonHidden(true)
        }.navigationBarHidden(true)
            .navigationBarTitle("")
            .navigationBarBackButtonHidden(true)
    }
}
