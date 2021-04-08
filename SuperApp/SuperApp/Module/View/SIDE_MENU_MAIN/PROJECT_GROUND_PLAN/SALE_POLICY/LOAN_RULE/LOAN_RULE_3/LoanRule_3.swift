// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import SwiftUI

struct LoanRule_3: View {
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
    @State var isNextLoanContact = false
    @State var isNextLoanOnline = false

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
                                TextCustom(text: NSLocalizedString("sale_policy_step3", comment: ""), font: REGULAR, size: 18, color: #colorLiteral(red: 0.6533299685, green: 0.6326879859, blue: 0.6321712136, alpha: 1))
                                TextCustom(text: NSLocalizedString("sale_policy_step3_title", comment: ""), size: 18, color: #colorLiteral(red: 0.4263509512, green: 0.1872772872, blue: 0.6715394855, alpha: 1))
                            }.padding(.top, H(20))
                                .padding(.bottom, H(19))
                            ZStack {
                                Rectangle()
                                    .frame(height: H(4))
                                    .foregroundColor(.init(#colorLiteral(red: 0.66581285, green: 0.6659106016, blue: 0.6657914519, alpha: 1)))
                                    .padding(.horizontal, 95)
                                HStack(spacing: 0) {
                                    SalePolicyCustomImage(step: 3, imageName: "stepCheck", index: 1)
                                    Spacer()
                                    SalePolicyCustomImage(step: 3, imageName: "stepCheck", index: 2)
                                    Spacer()
                                    SalePolicyCustomImage(step: 3, imageName: "addCheckPurple", index: 3)
                                }.frame(width: FULL_W - 190)
                            }
                            DetailStep_3(
                                loanMoney: $dataRentOnline.loanMoney,
                                purple: $dataRentOnline.purple,
                                green: $dataRentOnline.green,
                                isNextLoanContact: $isNextLoanContact,
                                isNextLoanOnline: $isNextLoanOnline
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
                        SalePolicyContactBuy(
                            isNextOld: $isNextLoanContact,
                            isRoot: $isRoot
                        ), isActive: $isNextLoanContact) {
                    EmptyView()
                }
                NavigationLink(destination:
                        LoanOnlineView(
                            // MARK: DEFAULT
                            isNextOld: $isNextLoanOnline,
                            isRoot: $isRoot,
                            projectURL: $projectURL,
                            
                            typeLoan: $typeLoan,
                            sumMoney: $sumMoney,
                            moneyFirst: $moneyFirst,
                            payTimes: $payTimes,
                            
                            // MARK: DATA RENT ONLINE
                            dataRentOnline: $dataRentOnline                            
                        ), isActive: $isNextLoanOnline) {
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
  
