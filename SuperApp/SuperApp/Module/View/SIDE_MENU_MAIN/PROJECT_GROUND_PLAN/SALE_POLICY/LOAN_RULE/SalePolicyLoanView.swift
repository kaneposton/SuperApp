//  Created by Tran Thien Phu on 4/23/20.
import SwiftUI

struct SalePolicyLoan: View {
    @Binding var isNextOld: Bool
    @Binding var isRoot: Bool
    @Binding var typeLoan: Int
    @Binding var sumMoney: String
    @Binding var moneyFirst: String
    @Binding var payTimes: Int
    @Binding var projectURL: String

    @State var tempStr = ""
    @State var tempBool = false
    @State var step = 1
    @State var isKeyboardStep2 = false
    @State var isNextLoanContact = false
    @State var isNextLoanOnline = false
    @State var isShowDatePicker = false
    @State var isChangeColor = false
    @State var labelDatePicker = ""
    @State var showNextFailed = false
    @State var isPaddingBottomKeyboard = false
    @State var isKeyboardPush = false
    @State var tempInt = 0
    @State var tempVehicle = [TypeVehicle(value_1: "", value_2: "", value_3: "", date: Date(), initValueDate: 0, value_4: "", index: 0)]
    @State var isSaveInfo = false

    // MARK: STEP 1
    @State var selectedMethod: CGFloat = 0
    @State var initValue = 0

    // MARK: STEP 2
    @State var loanMoney = ""
    @State var year = ""
    @State var month = ""
    @State var isCheckBox2_3 = false
    @State var time = ""
    @State var fee = ""
    @State var isCheckBox2_2 = false
    @State var time2_2 = ""
    @State var fee2_2 = ""
    @State var date_Step_1 = Date()
    @State var date_Step_2 = Date()
    @State var purple = 0
    @State var green = 0
    @State var typeAlert = 0

    var body: some View {
        NavigationView {
            ZStack(alignment: .top) {
                Text("A")
            }.navigationBarHidden(true)
                .navigationBarTitle("")
                .navigationBarBackButtonHidden(true)
                .edgesIgnoringSafeArea(.bottom)
        }.navigationBarHidden(true)
            .navigationBarTitle("")
            .navigationBarBackButtonHidden(true)
    }
}

