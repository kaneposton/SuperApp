// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import SwiftUI

struct TypeTreasure: Identifiable, Hashable {
    var id = UUID()
    var combo: String
    var comboIndex: Int
    var value_1: String
    var value_2: String
    var index: Int
}

struct TypeRent: Identifiable, Hashable {
    var id = UUID()
    var value_1: String
    var value_2: String
    var value_3: String
    var value_4: String
    var index: Int
}

struct LoanOnlineTab_3: View {
    @Binding var dataRentOnline: ModalRentOnline
    @Binding var labelCombo: String
    @Binding var isShowCombobox: Bool
    @Binding var isChangeColor: Bool

    @Binding var isStartRed_4: Bool
    @Binding var isStartRed_5: Bool

    @State var selectedTab = 0
    @State var isStartAnimation = false
    @State var isTapComponent = false
    @State var isTapLoop = false
    @State var highLightOption_1 = false
    @State var highLightOption_2 = false
    @State var highLightOption_3 = false


    var body: some View {
        VStack (spacing: H(16)) {
            ZStack {
                if isStartRed_5 {
                    Text("").onAppear {
                        self.checkEmptyTab_3()
                    }
                }
                VStack {
                    TabChangeLoanOnline(
                        currentSelectedFirstTab: $dataRentOnline.is_4,
                        selectedIndexPage: $dataRentOnline.selectedIndexPage,
                        index_1: 4,
                        index_2: 5,
                        label_1: "loan_online_3_title_1",
                        label_2: "loan_online_3_title_2"
                    )
                    Spacer()
                }.frame(width: FULL_W)

                // MARK: TÀI SẢN HIỆN CÓ
                if dataRentOnline.selectedIndexPage == 4 {
                    VStack (alignment: .leading, spacing: H(20)) {
                        if !dataRentOnline.tab_3_isAppendingTreasure {
                            ForEach(0 ..< dataRentOnline.tab_3_arrTreasure.count) { i in
                                if i > 0 {
                                    Rectangle()
                                        .foregroundColor(.init(#colorLiteral(red: 0.665820241, green: 0.6659018993, blue: 0.6657924652, alpha: 1)))
                                        .frame(width: FULL_W - 60, height: 1)
                                        .padding(.leading, 14)
                                }
                                if i >= self.dataRentOnline.tab_3_countArrTreasure {
                                    TreasureView(
                                        indexTreasure: self.$dataRentOnline.tab_3_indexTreasure,
                                        labelCombo: self.$labelCombo,
                                        isChangeColor: self.$isChangeColor,
                                        isShowCombobox: self.$isShowCombobox,
                                        isStartRed: self.$isStartRed_4,
                                        arr: self.$dataRentOnline.tab_3_arrTreasure,
                                        data: self.$dataRentOnline.tab_3_arrTreasure[i],
                                        isTapComponent: self.$isTapComponent,
                                        isTapLoop: self.$isTapLoop,
                                        isNew: true,
                                        index: i
                                    )
                                } else {
                                    TreasureView(
                                        indexTreasure: self.$dataRentOnline.tab_3_indexTreasure,
                                        labelCombo: self.$labelCombo,
                                        isChangeColor: self.$isChangeColor,
                                        isShowCombobox: self.$isShowCombobox,
                                        isStartRed: self.$isStartRed_4,
                                        arr: self.$dataRentOnline.tab_3_arrTreasure,
                                        data: self.$dataRentOnline.tab_3_arrTreasure[i],
                                        isTapComponent: self.$isTapComponent,
                                        isTapLoop: self.$isTapLoop,
                                        index: i
                                    )
                                }
                            }
                        }
                        ZStack (alignment: .leading) {
                            Button(action: {
                                UIApplication.shared.endEditing()
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                    self.appendTreasure()
                                }
                            }) {
                                HStack (spacing: 10) {
                                    ImageCustom(name: "iconFeatherPlusCircle", w: 16, h: 16)
                                    TextCustom(text: NSLocalizedString("loan_online_3_add_more_preasure", comment: ""), font: REGULAR, size: 14, color: #colorLiteral(red: 0.4281106591, green: 0.1894766092, blue: 0.6721540093, alpha: 1))
                                }
                            }.buttonStyle(ButtonTapScale())
                            HStack {
                                Spacer()
                                Button(action: {
                                    UIApplication.shared.endEditing()
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                        self.removeTreasure()
                                    }
                                }) {
                                    HStack (spacing: 10) {
                                        ImageCustom(name: "iconFeatherMinusCircle", w: 16, h: 16)
                                        TextCustom(text: NSLocalizedString("loan_online_3_remove_preasure", comment: ""), font: REGULAR, size: 14, color: #colorLiteral(red: 0.9133259654, green: 0.297054708, blue: 0.2958536744, alpha: 1))
                                    }
                                }.buttonStyle(ButtonTapScale())
                            }.opacity(dataRentOnline.tab_3_arrTreasure.count > 1 ? 1 : 0)
                        }.frame(width: FULL_W - 60)
                            .animation(isStartAnimation ? .easeInOut(duration: 0.1) : .none)
                            .padding(.leading, 14)
                        LoanOnlineDisableField(value: "--", label: "loan_online_3_sum_amount_treasure", rightHolder: "VND")
                    }.padding(.top, H(21))
                        .padding(.bottom, H(30))
                        .frame(width: FULL_W - 32, alignment: .leading)
                        .background(Color.white)
                        .padding(.top, H(56))
                } else { // MARK: TÌNH HÌNH KHOẢN VAY
                    VStack (spacing: H(16)) {
                        VStack (alignment: .leading, spacing: H(8)) {
                            HStack (spacing: 0) {
                                Text(NSLocalizedString("loan_online_3_relation_with_scb", comment: "")).foregroundColor(.init(isStartRed_5 && dataRentOnline.tab_3_optional_1 == 0 ? #colorLiteral(red: 0.932536602, green: 0.2507158816, blue: 0.2460758984, alpha: 1): #colorLiteral(red: 0.1422221363, green: 0.1236664429, blue: 0.1232500449, alpha: 1)))
                                    + Text(" *").foregroundColor(.init(#colorLiteral(red: 0.932536602, green: 0.2507158816, blue: 0.2460758984, alpha: 1)))
                                    + Text(":").foregroundColor(.init(#colorLiteral(red: 0.1422221363, green: 0.1236664429, blue: 0.1232500449, alpha: 1)))
                            }.font(.custom(MEDIUM, size: H(16)))
                                .padding(.horizontal, 14)
                            Button(action: {
                                if self.dataRentOnline.tab_3_optional_1 == 1 {
                                    self.dataRentOnline.tab_3_optional_1 = 0
                                } else {
                                    self.dataRentOnline.tab_3_optional_1 = 1
                                }
                            }) {
                                HStack (spacing: 8) {
                                    ZStack {
                                        Rectangle()
                                            .foregroundColor(dataRentOnline.tab_3_optional_1 == 1 ? .init(#colorLiteral(red: 0.9200527072, green: 0.8800705075, blue: 0.9638360143, alpha: 1)) : .clear)
                                            .frame(width: W(19), height: W(19))
                                            .overlay(RoundedRectangle(cornerRadius: .infinity).stroke(Color.init(dataRentOnline.tab_3_optional_1 == 1 ? #colorLiteral(red: 0.4281106591, green: 0.1894766092, blue: 0.6721540093, alpha: 1): #colorLiteral(red: 0.6533299685, green: 0.6326879859, blue: 0.6321712136, alpha: 1)), lineWidth: 1.5))
                                            .cornerRadius(.infinity)
                                        Rectangle()
                                            .cornerRadius(.infinity)
                                            .foregroundColor(.init(#colorLiteral(red: 0.4281106591, green: 0.1894766092, blue: 0.6721540093, alpha: 1)))
                                            .frame(width: W(11), height: W(11)).opacity(dataRentOnline.tab_3_optional_1 == 1 ? 1 : 0)
                                    }
                                    TextCustom(text: NSLocalizedString("loan_online_3_yes", comment: ""), font: REGULAR, size: 14, color: #colorLiteral(red: 0.4117531478, green: 0.411806047, blue: 0.4117352366, alpha: 1))
                                }
                            }.buttonStyle(ButtonTapScale())
                                .animation(isStartAnimation ? .easeInOut(duration: 0.1) : .none)
                                .padding(.leading, 14)
                            Button(action: {
                                if self.dataRentOnline.tab_3_optional_1 == -1 {
                                    self.dataRentOnline.tab_3_optional_1 = 0
                                } else {
                                    self.dataRentOnline.tab_3_optional_1 = -1
                                }
                            }) {
                                HStack (spacing: 8) {
                                    ZStack {
                                        Rectangle()
                                            .foregroundColor(dataRentOnline.tab_3_optional_1 == -1 ? .init(#colorLiteral(red: 0.9200527072, green: 0.8800705075, blue: 0.9638360143, alpha: 1)) : .clear)
                                            .frame(width: W(19), height: W(19))
                                            .overlay(RoundedRectangle(cornerRadius: .infinity).stroke(Color.init(dataRentOnline.tab_3_optional_1 == -1 ? #colorLiteral(red: 0.4281106591, green: 0.1894766092, blue: 0.6721540093, alpha: 1): #colorLiteral(red: 0.6533299685, green: 0.6326879859, blue: 0.6321712136, alpha: 1)), lineWidth: 1.5))
                                            .cornerRadius(.infinity)
                                        Rectangle()
                                            .cornerRadius(.infinity)
                                            .foregroundColor(.init(#colorLiteral(red: 0.4281106591, green: 0.1894766092, blue: 0.6721540093, alpha: 1)))
                                            .frame(width: W(11), height: W(11)).opacity(dataRentOnline.tab_3_optional_1 == -1 ? 1 : 0)
                                    }
                                    TextCustom(text: NSLocalizedString("loan_online_3_no", comment: ""), font: REGULAR, size: 14, color: #colorLiteral(red: 0.4117531478, green: 0.411806047, blue: 0.4117352366, alpha: 1))
                                }
                            }.buttonStyle(ButtonTapScale())
                                .animation(isStartAnimation ? .easeInOut(duration: 0.1) : .none)
                                .padding(.leading, 14)
                            if dataRentOnline.tab_3_optional_1 == 1 {
                                VStack (alignment: .leading, spacing: 0) {
                                    if !dataRentOnline.tab_3_isAppendingRent {
                                        VStack (alignment: .leading, spacing: H(20)) {
                                            ForEach(0 ..< dataRentOnline.tab_3_arrRent.count) { i in
                                                if i > 0 {
                                                    Rectangle()
                                                        .foregroundColor(.init(#colorLiteral(red: 0.665820241, green: 0.6659018993, blue: 0.6657924652, alpha: 1)))
                                                        .frame(width: FULL_W - 60, height: 1)
                                                        .padding(.leading, 14)
                                                }
                                                if i >= self.dataRentOnline.tab_3_countArrRent {
                                                    RentView(
                                                        optional: self.$dataRentOnline.tab_3_optional_1,
                                                        isStartRed: self.$isStartRed_5,
                                                        arr: self.$dataRentOnline.tab_3_arrRent,
                                                        data: self.$dataRentOnline.tab_3_arrRent[i],
                                                        isTapComponent: self.$isTapComponent,
                                                        isTapLoop: self.$isTapLoop,
                                                        oldOptional: self.$dataRentOnline.tab_3_oldOptional_1,
                                                        isNew: true
                                                    )
                                                } else {
                                                    RentView(
                                                        optional: self.$dataRentOnline.tab_3_optional_1,
                                                        isStartRed: self.$isStartRed_5,
                                                        arr: self.$dataRentOnline.tab_3_arrRent,
                                                        data: self.$dataRentOnline.tab_3_arrRent[i],
                                                        isTapComponent: self.$isTapComponent,
                                                        isTapLoop: self.$isTapLoop,
                                                        oldOptional: self.$dataRentOnline.tab_3_oldOptional_1
                                                    )
                                                }
                                            }
                                        }
                                    }
                                    HStack {
                                        TextCustom(text: NSLocalizedString("loan_online_3_over_borrow", comment: ""), font: REGULAR, size: 14, color: #colorLiteral(red: 0.1422221363, green: 0.1236664429, blue: 0.1232500449, alpha: 1))
                                        Spacer()
                                        ZStack (alignment: dataRentOnline.tab_3_isOverBorrow ? .trailing : .leading) {
                                            Rectangle()
                                                .frame(width: W(40), height: W(20))
                                                .foregroundColor(.init(dataRentOnline.tab_3_isOverBorrow ? #colorLiteral(red: 0.4281106591, green: 0.1894766092, blue: 0.6721540093, alpha: 1): #colorLiteral(red: 0.6533299685, green: 0.6326879859, blue: 0.6321712136, alpha: 1)))
                                                .cornerRadius(10)
                                            Rectangle()
                                                .foregroundColor(.white)
                                                .cornerRadius(.infinity)
                                                .shadow(color: .init(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.3541577483)), radius: 3)
                                                .frame(width: W(16), height: W(16))
                                                .padding(dataRentOnline.tab_3_isOverBorrow ? .trailing : .leading, W(2))
                                        }.animation(.easeInOut(duration: 0.1))
                                            .onTapGesture {
                                                self.dataRentOnline.tab_3_isOverBorrow.toggle()
                                        }
                                    }.frame(width: FULL_W - 60, alignment: .leading)
                                        .padding(.top, H(19))
                                        .padding(.bottom, H(12))
                                        .padding(.leading, 14)
                                    ZStack (alignment: .leading) {
                                        Button(action: {
                                            UIApplication.shared.endEditing()
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                                self.appendRent()
                                            }
                                        }) {
                                            HStack (spacing: 10) {
                                                ImageCustom(name: "iconFeatherPlusCircle", w: 16, h: 16)
                                                TextCustom(text: NSLocalizedString("loan_online_3_add_more_rent", comment: ""), font: REGULAR, size: 14, color: #colorLiteral(red: 0.4281106591, green: 0.1894766092, blue: 0.6721540093, alpha: 1))
                                            }
                                        }.buttonStyle(ButtonTapScale())
                                        HStack {
                                            Spacer()
                                            Button(action: {
                                                UIApplication.shared.endEditing()
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                                    self.removeRent()
                                                }
                                            }) {
                                                HStack (spacing: 10) {
                                                    ImageCustom(name: "iconFeatherMinusCircle", w: 16, h: 16)
                                                    TextCustom(text: NSLocalizedString("loan_online_3_remove_rent", comment: ""), font: REGULAR, size: 14, color: #colorLiteral(red: 0.9133259654, green: 0.297054708, blue: 0.2958536744, alpha: 1))
                                                }
                                            }.buttonStyle(ButtonTapScale())
                                        }.opacity(dataRentOnline.tab_3_arrRent.count > 1 ? 1 : 0)
                                    }.frame(width: FULL_W - 60)
                                        .animation(isStartAnimation ? .easeInOut(duration: 0.1) : .none)
                                        .padding(.leading, 14)
                                }.padding(.top, H(12))
                            }
                        }.padding(.top, H(21))
                            .padding(.bottom, H(dataRentOnline.tab_3_optional_1 == 1 ? 21 : 17))
                            .frame(width: FULL_W - 32, alignment: .leading)
                            .background(Color.white)

                        VStack (alignment: .leading, spacing: H(8)) {
                            HStack (spacing: 0) {
                                Text(NSLocalizedString("loan_online_3_relation_with_other_company", comment: "")).foregroundColor(.init(isStartRed_5 && dataRentOnline.tab_3_optional_2 == 0 ? #colorLiteral(red: 0.932536602, green: 0.2507158816, blue: 0.2460758984, alpha: 1): #colorLiteral(red: 0.1422221363, green: 0.1236664429, blue: 0.1232500449, alpha: 1)))
                                    + Text(" *").foregroundColor(.init(#colorLiteral(red: 0.932536602, green: 0.2507158816, blue: 0.2460758984, alpha: 1)))
                                    + Text(":").foregroundColor(.init(#colorLiteral(red: 0.1422221363, green: 0.1236664429, blue: 0.1232500449, alpha: 1)))
                            }.font(.custom(MEDIUM, size: H(16)))
                                .padding(.horizontal, 14)
                            Button(action: {
                                if self.dataRentOnline.tab_3_optional_2 == 1 {
                                    self.dataRentOnline.tab_3_optional_2 = 0
                                } else {
                                    self.dataRentOnline.tab_3_optional_2 = 1
                                }
                            }) {
                                HStack (spacing: 8) {
                                    ZStack {
                                        Rectangle()
                                            .foregroundColor(dataRentOnline.tab_3_optional_2 == 1 ? .init(#colorLiteral(red: 0.9200527072, green: 0.8800705075, blue: 0.9638360143, alpha: 1)) : .clear)
                                            .frame(width: W(19), height: W(19))
                                            .overlay(RoundedRectangle(cornerRadius: .infinity).stroke(Color.init(dataRentOnline.tab_3_optional_2 == 1 ? #colorLiteral(red: 0.4281106591, green: 0.1894766092, blue: 0.6721540093, alpha: 1): #colorLiteral(red: 0.6533299685, green: 0.6326879859, blue: 0.6321712136, alpha: 1)), lineWidth: 1.5))
                                            .cornerRadius(.infinity)
                                        Rectangle()
                                            .cornerRadius(.infinity)
                                            .foregroundColor(.init(#colorLiteral(red: 0.4281106591, green: 0.1894766092, blue: 0.6721540093, alpha: 1)))
                                            .frame(width: W(11), height: W(11)).opacity(dataRentOnline.tab_3_optional_2 == 1 ? 1 : 0)
                                    }
                                    TextCustom(text: NSLocalizedString("loan_online_3_yes", comment: ""), font: REGULAR, size: 14, color: #colorLiteral(red: 0.4117531478, green: 0.411806047, blue: 0.4117352366, alpha: 1))
                                }
                            }.buttonStyle(ButtonTapScale())
                                .animation(isStartAnimation ? .easeInOut(duration: 0.1) : .none)
                                .padding(.leading, 14)
                            Button(action: {
                                if self.dataRentOnline.tab_3_optional_2 == -1 {
                                    self.dataRentOnline.tab_3_optional_2 = 0
                                } else {
                                    self.dataRentOnline.tab_3_optional_2 = -1
                                }
                            }) {
                                HStack (spacing: 8) {
                                    ZStack {
                                        Rectangle()
                                            .foregroundColor(dataRentOnline.tab_3_optional_2 == -1 ? .init(#colorLiteral(red: 0.9200527072, green: 0.8800705075, blue: 0.9638360143, alpha: 1)) : .clear)
                                            .frame(width: W(19), height: W(19))
                                            .overlay(RoundedRectangle(cornerRadius: .infinity).stroke(Color.init(dataRentOnline.tab_3_optional_2 == -1 ? #colorLiteral(red: 0.4281106591, green: 0.1894766092, blue: 0.6721540093, alpha: 1): #colorLiteral(red: 0.6533299685, green: 0.6326879859, blue: 0.6321712136, alpha: 1)), lineWidth: 1.5))
                                            .cornerRadius(.infinity)
                                        Rectangle()
                                            .cornerRadius(.infinity)
                                            .foregroundColor(.init(#colorLiteral(red: 0.4281106591, green: 0.1894766092, blue: 0.6721540093, alpha: 1)))
                                            .frame(width: W(11), height: W(11)).opacity(dataRentOnline.tab_3_optional_2 == -1 ? 1 : 0)
                                    }
                                    TextCustom(text: NSLocalizedString("loan_online_3_no", comment: ""), font: REGULAR, size: 14, color: #colorLiteral(red: 0.4117531478, green: 0.411806047, blue: 0.4117352366, alpha: 1))
                                }
                            }.buttonStyle(ButtonTapScale())
                                .animation(isStartAnimation ? .easeInOut(duration: 0.1) : .none)
                                .padding(.leading, 14)
                            if dataRentOnline.tab_3_optional_2 == 1 {
                                VStack (alignment: .leading, spacing: 0) {
                                    if !dataRentOnline.tab_3_isAppendingRentOther {
                                        VStack (alignment: .leading, spacing: H(20)) {
                                            ForEach(0 ..< dataRentOnline.tab_3_arrRentOther.count) { i in
                                                if i > 0 {
                                                    Rectangle()
                                                        .foregroundColor(.init(#colorLiteral(red: 0.665820241, green: 0.6659018993, blue: 0.6657924652, alpha: 1)))
                                                        .frame(width: FULL_W - 60, height: 1)
                                                        .padding(.leading, 14)
                                                }
                                                if i >= self.dataRentOnline.tab_3_countArrRentOther {
                                                    RentOtherPersonView(
                                                        indexForEachBinding: self.$dataRentOnline.tab_3_indexRentOther,
                                                        moreComboIndex: self.$dataRentOnline.tab_3_moreComboIndex,
                                                        labelCombo: self.$labelCombo,
                                                        isChangeColor: self.$isChangeColor,
                                                        isShowCombobox: self.$isShowCombobox,
                                                        optional: self.$dataRentOnline.tab_3_optional_2,
                                                        isStartRed: self.$isStartRed_5,
                                                        arr: self.$dataRentOnline.tab_3_arrRentOther,
                                                        data: self.$dataRentOnline.tab_3_arrRentOther[i],
                                                        isTapComponent: self.$isTapComponent,
                                                        isTapLoop: self.$isTapLoop,
                                                        oldOptional: self.$dataRentOnline.tab_3_oldOptional_2,
                                                        isNew: true,
                                                        index: i
                                                    )
                                                } else {
                                                    RentOtherPersonView(
                                                        indexForEachBinding: self.$dataRentOnline.tab_3_indexRentOther,
                                                        moreComboIndex: self.$dataRentOnline.tab_3_moreComboIndex,
                                                        labelCombo: self.$labelCombo,
                                                        isChangeColor: self.$isChangeColor,
                                                        isShowCombobox: self.$isShowCombobox,
                                                        optional: self.$dataRentOnline.tab_3_optional_2,
                                                        isStartRed: self.$isStartRed_5,
                                                        arr: self.$dataRentOnline.tab_3_arrRentOther,
                                                        data: self.$dataRentOnline.tab_3_arrRentOther[i],
                                                        isTapComponent: self.$isTapComponent,
                                                        isTapLoop: self.$isTapLoop,
                                                        oldOptional: self.$dataRentOnline.tab_3_oldOptional_2,
                                                        index: i
                                                    )
                                                }
                                            }
                                        }
                                    }
                                    HStack {
                                        TextCustom(text: NSLocalizedString("loan_online_3_over_borrow", comment: ""), font: REGULAR, size: 14, color: #colorLiteral(red: 0.1422221363, green: 0.1236664429, blue: 0.1232500449, alpha: 1))
                                        Spacer()
                                        ZStack (alignment: dataRentOnline.tab_3_isOverBorrowOther ? .trailing : .leading) {
                                            Rectangle()
                                                .frame(width: W(40), height: W(20))
                                                .foregroundColor(.init(dataRentOnline.tab_3_isOverBorrowOther ? #colorLiteral(red: 0.4281106591, green: 0.1894766092, blue: 0.6721540093, alpha: 1): #colorLiteral(red: 0.6533299685, green: 0.6326879859, blue: 0.6321712136, alpha: 1)))
                                                .cornerRadius(10)
                                            Rectangle()
                                                .foregroundColor(.white)
                                                .cornerRadius(.infinity)
                                                .shadow(color: .init(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.3541577483)), radius: 3)
                                                .frame(width: W(16), height: W(16))
                                                .padding(dataRentOnline.tab_3_isOverBorrowOther ? .trailing : .leading, W(2))
                                        }.animation(.easeInOut(duration: 0.1))
                                            .onTapGesture {
                                                self.dataRentOnline.tab_3_isOverBorrowOther.toggle()
                                        }
                                    }.frame(width: FULL_W - 60, alignment: .leading)
                                        .padding(.top, H(19))
                                        .padding(.bottom, H(12))
                                        .padding(.leading, 14)
                                    ZStack (alignment: .leading) {
                                        Button(action: {
                                            UIApplication.shared.endEditing()
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                                self.appendRentOther()
                                            }
                                        }) {
                                            HStack (spacing: 10) {
                                                ImageCustom(name: "iconFeatherPlusCircle", w: 16, h: 16)
                                                TextCustom(text: NSLocalizedString("loan_online_3_add_more_rent", comment: ""), font: REGULAR, size: 14, color: #colorLiteral(red: 0.4281106591, green: 0.1894766092, blue: 0.6721540093, alpha: 1))
                                            }
                                        }.buttonStyle(ButtonTapScale())
                                        HStack {
                                            Spacer()
                                            Button(action: {
                                                UIApplication.shared.endEditing()
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                                    self.removeRentOther()
                                                }
                                            }) {
                                                HStack (spacing: 10) {
                                                    ImageCustom(name: "iconFeatherMinusCircle", w: 16, h: 16)
                                                    TextCustom(text: NSLocalizedString("loan_online_3_remove_rent", comment: ""), font: REGULAR, size: 14, color: #colorLiteral(red: 0.9133259654, green: 0.297054708, blue: 0.2958536744, alpha: 1))
                                                }
                                            }.buttonStyle(ButtonTapScale())
                                        }.opacity(dataRentOnline.tab_3_arrRentOther.count > 1 ? 1 : 0)
                                    }.frame(width: FULL_W - 60)
                                        .animation(isStartAnimation ? .easeInOut(duration: 0.1) : .none)
                                        .padding(.leading, 14)
                                }.padding(.top, H(12))
                            }
                        }.padding(.top, H(21))
                            .padding(.bottom, H(dataRentOnline.tab_3_optional_2 == 1 ? 21 : 17))
                            .frame(width: FULL_W - 32, alignment: .leading)
                            .background(Color.white)

                        VStack (alignment: .leading, spacing: H(8)) {
                            HStack (spacing: 0) {
                                Text(NSLocalizedString("loan_online_3_rent_other", comment: "")).foregroundColor(.init(isStartRed_5 && dataRentOnline.tab_3_optional_3 == 0 ? #colorLiteral(red: 0.932536602, green: 0.2507158816, blue: 0.2460758984, alpha: 1): #colorLiteral(red: 0.1422221363, green: 0.1236664429, blue: 0.1232500449, alpha: 1)))
                                    + Text(" *").foregroundColor(.init(#colorLiteral(red: 0.932536602, green: 0.2507158816, blue: 0.2460758984, alpha: 1)))
                                    + Text(":").foregroundColor(.init(#colorLiteral(red: 0.1422221363, green: 0.1236664429, blue: 0.1232500449, alpha: 1)))
                            }.font(.custom(MEDIUM, size: H(16)))
                                .padding(.horizontal, 14)
                            Button(action: {
                                if self.dataRentOnline.tab_3_optional_3 == 1 {
                                    self.dataRentOnline.tab_3_optional_3 = 0
                                } else {
                                    self.dataRentOnline.tab_3_optional_3 = 1
                                }
                            }) {
                                HStack (spacing: 8) {
                                    ZStack {
                                        Rectangle()
                                            .foregroundColor(dataRentOnline.tab_3_optional_3 == 1 ? .init(#colorLiteral(red: 0.9200527072, green: 0.8800705075, blue: 0.9638360143, alpha: 1)) : .clear)
                                            .frame(width: W(19), height: W(19))
                                            .overlay(RoundedRectangle(cornerRadius: .infinity).stroke(Color.init(dataRentOnline.tab_3_optional_3 == 1 ? #colorLiteral(red: 0.4281106591, green: 0.1894766092, blue: 0.6721540093, alpha: 1): #colorLiteral(red: 0.6533299685, green: 0.6326879859, blue: 0.6321712136, alpha: 1)), lineWidth: 1.5))
                                            .cornerRadius(.infinity)
                                        Rectangle()
                                            .cornerRadius(.infinity)
                                            .foregroundColor(.init(#colorLiteral(red: 0.4281106591, green: 0.1894766092, blue: 0.6721540093, alpha: 1)))
                                            .frame(width: W(11), height: W(11)).opacity(dataRentOnline.tab_3_optional_3 == 1 ? 1 : 0)
                                    }
                                    TextCustom(text: NSLocalizedString("loan_online_3_yes", comment: ""), font: REGULAR, size: 14, color: #colorLiteral(red: 0.4117531478, green: 0.411806047, blue: 0.4117352366, alpha: 1))
                                }
                            }.buttonStyle(ButtonTapScale())
                                .animation(isStartAnimation ? .easeInOut(duration: 0.1) : .none)
                                .padding(.leading, 14)
                            Button(action: {
                                if self.dataRentOnline.tab_3_optional_3 == -1 {
                                    self.dataRentOnline.tab_3_optional_3 = 0
                                } else {
                                    self.dataRentOnline.tab_3_optional_3 = -1
                                }
                            }) {
                                HStack (spacing: 8) {
                                    ZStack {
                                        Rectangle()
                                            .foregroundColor(dataRentOnline.tab_3_optional_3 == -1 ? .init(#colorLiteral(red: 0.9200527072, green: 0.8800705075, blue: 0.9638360143, alpha: 1)) : .clear)
                                            .frame(width: W(19), height: W(19))
                                            .overlay(RoundedRectangle(cornerRadius: .infinity).stroke(Color.init(dataRentOnline.tab_3_optional_3 == -1 ? #colorLiteral(red: 0.4281106591, green: 0.1894766092, blue: 0.6721540093, alpha: 1): #colorLiteral(red: 0.6533299685, green: 0.6326879859, blue: 0.6321712136, alpha: 1)), lineWidth: 1.5))
                                            .cornerRadius(.infinity)
                                        Rectangle()
                                            .cornerRadius(.infinity)
                                            .foregroundColor(.init(#colorLiteral(red: 0.4281106591, green: 0.1894766092, blue: 0.6721540093, alpha: 1)))
                                            .frame(width: W(11), height: W(11)).opacity(dataRentOnline.tab_3_optional_3 == -1 ? 1 : 0)
                                    }
                                    TextCustom(text: NSLocalizedString("loan_online_3_no", comment: ""), font: REGULAR, size: 14, color: #colorLiteral(red: 0.4117531478, green: 0.411806047, blue: 0.4117352366, alpha: 1))
                                }
                            }.buttonStyle(ButtonTapScale())
                                .animation(isStartAnimation ? .easeInOut(duration: 0.1) : .none)
                                .padding(.leading, 14)
                            if dataRentOnline.tab_3_optional_3 == 1 {
                                VStack (alignment: .leading, spacing: 0) {
                                    if !dataRentOnline.tab_3_isAppendingRentPerson {
                                        VStack (alignment: .leading, spacing: H(20)) {
                                            ForEach(0 ..< dataRentOnline.tab_3_arrRentPerson.count) { i in
                                                if i > 0 {
                                                    Rectangle()
                                                        .foregroundColor(.init(#colorLiteral(red: 0.665820241, green: 0.6659018993, blue: 0.6657924652, alpha: 1)))
                                                        .frame(width: FULL_W - 60, height: 1)
                                                        .padding(.leading, 14)
                                                }
                                                if i >= self.dataRentOnline.tab_3_countArrRentPerson {
                                                    RentOtherPersonView(
                                                        indexForEachBinding: self.$dataRentOnline.tab_3_indexRentPerson,
                                                        moreComboIndex: self.$dataRentOnline.tab_3_moreComboIndex,
                                                        labelCombo: self.$labelCombo,
                                                        isChangeColor: self.$isChangeColor,
                                                        isShowCombobox: self.$isShowCombobox,
                                                        optional: self.$dataRentOnline.tab_3_optional_3,
                                                        isStartRed: self.$isStartRed_5,
                                                        arr: self.$dataRentOnline.tab_3_arrRentPerson,
                                                        data: self.$dataRentOnline.tab_3_arrRentPerson[i],
                                                        isTapComponent: self.$isTapComponent,
                                                        isTapLoop: self.$isTapLoop,
                                                        isPerson: true,
                                                        oldOptional: self.$dataRentOnline.tab_3_oldOptional_3,
                                                        isNew: true,
                                                        index: i
                                                    )
                                                } else {
                                                    RentOtherPersonView(
                                                        indexForEachBinding: self.$dataRentOnline.tab_3_indexRentPerson,
                                                        moreComboIndex: self.$dataRentOnline.tab_3_moreComboIndex,
                                                        labelCombo: self.$labelCombo,
                                                        isChangeColor: self.$isChangeColor,
                                                        isShowCombobox: self.$isShowCombobox,
                                                        optional: self.$dataRentOnline.tab_3_optional_3,
                                                        isStartRed: self.$isStartRed_5,
                                                        arr: self.$dataRentOnline.tab_3_arrRentPerson,
                                                        data: self.$dataRentOnline.tab_3_arrRentPerson[i],
                                                        isTapComponent: self.$isTapComponent,
                                                        isTapLoop: self.$isTapLoop,
                                                        isPerson: true,
                                                        oldOptional: self.$dataRentOnline.tab_3_oldOptional_3,
                                                        index: i
                                                    )
                                                }
                                            }
                                        }.padding(.bottom, H(20))
                                    }
                                    ZStack (alignment: .leading) {
                                        Button(action: {
                                            UIApplication.shared.endEditing()
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                                self.appendRentPerson()
                                            }
                                        }) {
                                            HStack (spacing: 10) {
                                                ImageCustom(name: "iconFeatherPlusCircle", w: 16, h: 16)
                                                TextCustom(text: NSLocalizedString("loan_online_3_add_more_rent", comment: ""), font: REGULAR, size: 14, color: #colorLiteral(red: 0.4281106591, green: 0.1894766092, blue: 0.6721540093, alpha: 1))
                                            }
                                        }.buttonStyle(ButtonTapScale())
                                        HStack {
                                            Spacer()
                                            Button(action: {
                                                UIApplication.shared.endEditing()
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                                    self.removeRentPerson()
                                                }
                                            }) {
                                                HStack (spacing: 10) {
                                                    ImageCustom(name: "iconFeatherMinusCircle", w: 16, h: 16)
                                                    TextCustom(text: NSLocalizedString("loan_online_3_remove_rent", comment: ""), font: REGULAR, size: 14, color: #colorLiteral(red: 0.9133259654, green: 0.297054708, blue: 0.2958536744, alpha: 1))
                                                }
                                            }.buttonStyle(ButtonTapScale())
                                        }.opacity(dataRentOnline.tab_3_arrRentPerson.count > 1 ? 1 : 0)
                                    }.frame(width: FULL_W - 60)
                                        .animation(isStartAnimation ? .easeInOut(duration: 0.1) : .none)
                                        .padding(.leading, 14)
                                }.padding(.top, H(12))
                            }
                        }.padding(.top, H(21))
                            .padding(.bottom, H(dataRentOnline.tab_3_optional_3 == 1 ? 21 : 17))
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
        }
    }

    func checkEmptyTab_3() {
        if dataRentOnline.tab_3_optional_1 == 0 {
            self.highLightOption_1 = true
        }
        if dataRentOnline.tab_3_optional_2 == 0 {
            self.highLightOption_2 = true
        }
        if dataRentOnline.tab_3_optional_3 == 0 {
            self.highLightOption_3 = true
        }
    }

    func appendTreasure() {
        self.dataRentOnline.tab_3_isAppendingTreasure = true
        dataRentOnline.tab_3_arrTreasure.append(TypeTreasure(combo: "", comboIndex: -1, value_1: "", value_2: "", index: self.dataRentOnline.tab_3_arrTreasure.count))
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            self.dataRentOnline.tab_3_isAppendingTreasure = false
        }
    }

    func appendRent() {
        dataRentOnline.tab_3_isAppendingRent = true
        dataRentOnline.tab_3_arrRent.append(TypeRent(value_1: "", value_2: "", value_3: "", value_4: "", index: self.dataRentOnline.tab_3_arrRent.count))
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            self.dataRentOnline.tab_3_isAppendingRent = false
        }
    }

    func appendRentOther() {
        dataRentOnline.tab_3_isAppendingRentOther = true
        dataRentOnline.tab_3_arrRentOther.append(TypeCombo4Value(combo: "", comboIndex: -1, value_1: "", value_2: "", value_3: "", value_4: "", index: self.dataRentOnline.tab_3_arrRentOther.count))
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            self.dataRentOnline.tab_3_isAppendingRentOther = false
        }
    }

    func appendRentPerson() {
        dataRentOnline.tab_3_isAppendingRentPerson = true
        dataRentOnline.tab_3_arrRentPerson.append(TypeCombo4Value(combo: "", comboIndex: -1, value_1: "", value_2: "", value_3: "", value_4: "", index: self.dataRentOnline.tab_3_arrRentPerson.count))
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            self.dataRentOnline.tab_3_isAppendingRentPerson = false
        }
    }

    func removeTreasure() {
        if dataRentOnline.tab_3_isAppendingTreasure {
            dataRentOnline.tab_3_arrTreasure.removeLast()
            if dataRentOnline.tab_3_arrTreasure.count == dataRentOnline.tab_3_countArrTreasure - 1 {
                dataRentOnline.tab_3_countArrTreasure = dataRentOnline.tab_3_arrTreasure.count
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                self.dataRentOnline.tab_3_isAppendingTreasure = false
                return
            }
        } else {
            dataRentOnline.tab_3_isAppendingTreasure = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                self.removeTreasure()
            }
        }
    }

    func removeRent() {
        if dataRentOnline.tab_3_isAppendingRent {
            dataRentOnline.tab_3_arrRent.removeLast()
            if dataRentOnline.tab_3_arrRent.count == dataRentOnline.tab_3_countArrRent - 1 {
                dataRentOnline.tab_3_countArrRent = dataRentOnline.tab_3_arrRent.count
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                self.dataRentOnline.tab_3_isAppendingRent = false
                return
            }
        } else {
            dataRentOnline.tab_3_isAppendingRent = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                self.removeRent()
            }
        }
    }

    func removeRentOther() {
        if dataRentOnline.tab_3_isAppendingRentOther {
            dataRentOnline.tab_3_arrRentOther.removeLast()
            if dataRentOnline.tab_3_arrRentOther.count == dataRentOnline.tab_3_countArrRentOther - 1 {
                dataRentOnline.tab_3_countArrRentOther = dataRentOnline.tab_3_arrRentOther.count
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                self.dataRentOnline.tab_3_isAppendingRentOther = false
                return
            }
        } else {
            dataRentOnline.tab_3_isAppendingRentOther = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                self.removeRentOther()
            }
        }
    }

    func removeRentPerson() {
        if dataRentOnline.tab_3_isAppendingRentPerson {
            dataRentOnline.tab_3_arrRentPerson.removeLast()
            if dataRentOnline.tab_3_arrRentPerson.count == dataRentOnline.tab_3_countArrRentPerson - 1 {
                dataRentOnline.tab_3_countArrRentPerson = dataRentOnline.tab_3_arrRentPerson.count
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                self.dataRentOnline.tab_3_isAppendingRentPerson = false
                return
            }
        } else {
            dataRentOnline.tab_3_isAppendingRentPerson = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                self.removeRentPerson()
            }
        }
    }
}

struct TreasureView: View {
    @Binding var indexTreasure: Int
    @Binding var labelCombo: String
    @Binding var isChangeColor: Bool
    @Binding var isShowCombobox: Bool
    @Binding var isStartRed: Bool
    @Binding var arr: [TypeTreasure]
    @Binding var data: TypeTreasure
    @Binding var isTapComponent: Bool
    @Binding var isTapLoop: Bool

    @State var selectedIndex = -1
    @State var currentCombobox = false
    @State var isNew = false
    @State var index = 0

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
                    indexForEachBinding: $indexTreasure,
                    moreComboIndex: Binding.constant(-1),
                    labelCombo: $labelCombo,
                    isChangeColor: $isChangeColor,
                    isShowCombobox: $isShowCombobox,
                    isStartRed: $isStartRed,
                    value: $data.combo,
                    selectedIndex: $selectedIndex,
                    isTapComponent: $isTapComponent,
                    isTapLoop: $isTapLoop,
                    currentCombobox: $currentCombobox,
                    label: "loan_online_3_treasure_type",
                    index: 0,
                    isLoop: true,
                    isNew: isNew,
                    indexForEach: index
                )
                LoanOnlineTextField(
                    isStartRed: $isStartRed,
                    value: $data.value_1,
                    selectedIndex: $selectedIndex,
                    isTapComponent: $isTapComponent,
                    isTapLoop: $isTapLoop,
                    currentCombobox: $currentCombobox,
                    label: "loan_online_3_amount",
                    isNumber: true,
                    index: 1,
                    isLoop: true,
                    isNew: isNew,
                    isNumberComma: true
                )
                LoanOnlineTextField(
                    isStartRed: $isStartRed,
                    value: $data.value_2,
                    selectedIndex: $selectedIndex,
                    isTapComponent: $isTapComponent,
                    isTapLoop: $isTapLoop,
                    currentCombobox: $currentCombobox,
                    label: "loan_online_3_value",
                    isNumber: true,
                    rightHolder: "VND",
                    index: 2,
                    isLoop: true,
                    isNew: isNew,
                    isNumberComma: true
                )
            }
        }
    }
}

struct RentView: View {
    @Binding var optional: Int
    @Binding var isStartRed: Bool
    @Binding var arr: [TypeRent]
    @Binding var data: TypeRent
    @Binding var isTapComponent: Bool
    @Binding var isTapLoop: Bool
    @Binding var oldOptional: Int

    @State var selectedIndex = -1
    @State var currentCombobox = false
    @State var isBorderRed = false
    @State var isNew = false

    var body: some View {
        ZStack {
            if isStartRed && optional == 1 {
                Text("").onAppear {
                    if self.oldOptional != 1 {
                        self.isBorderRed = false
                    } else {
                        self.isBorderRed = true
                    }
                }
            }
            if isStartRed {
                Text("").onAppear {
                    self.isBorderRed = true
                }
            } else {
                Text("").onAppear {
                    self.isBorderRed = false
                }
            }
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
                LoanOnlineTextField(
                    isStartRed: $isBorderRed,
                    value: $data.value_1,
                    selectedIndex: $selectedIndex,
                    isTapComponent: $isTapComponent,
                    isTapLoop: $isTapLoop,
                    currentCombobox: $currentCombobox,
                    label: "loan_online_3_sheet_code",
                    isMustHave: false,
                    index: 0,
                    isLoop: true,
                    isSpecialAll: true,
                    isNew: isNew
                )
                LoanOnlineTextField(
                    isStartRed: $isBorderRed,
                    value: $data.value_2,
                    selectedIndex: $selectedIndex,
                    isTapComponent: $isTapComponent,
                    isTapLoop: $isTapLoop,
                    currentCombobox: $currentCombobox,
                    label: "loan_online_3_money_rent",
                    isMustHave: false,
                    isNumber: true,
                    rightHolder: "VND",
                    index: 1,
                    isLoop: true,
                    isSpecialAll: true,
                    isNew: isNew,
                    isNumberComma: true
                )
                LoanOnlineTextField(
                    isStartRed: $isBorderRed,
                    value: $data.value_3,
                    selectedIndex: $selectedIndex,
                    isTapComponent: $isTapComponent,
                    isTapLoop: $isTapLoop,
                    currentCombobox: $currentCombobox,
                    label: "loan_online_3_money_left",
                    isMustHave: false,
                    isNumber: true,
                    rightHolder: "VND",
                    index: 2,
                    isLoop: true,
                    isSpecialAll: true,
                    isNew: isNew,
                    isNumberComma: true
                )
                LoanOnlineTextField(
                    isStartRed: $isBorderRed,
                    value: $data.value_4,
                    selectedIndex: $selectedIndex,
                    isTapComponent: $isTapComponent,
                    isTapLoop: $isTapLoop,
                    currentCombobox: $currentCombobox,
                    label: "loan_online_3_rent_time",
                    isMustHave: false,
                    isNumber: true,
                    rightHolder: "loan_online_3_year",
                    index: 3,
                    isLoop: true,
                    isSpecialAll: true,
                    isNew: isNew,
                    isNumberComma: true
                )
            }
        }
    }
}

struct RentOtherPersonView: View {
    @Binding var indexForEachBinding: Int
    @Binding var moreComboIndex: Int
    @Binding var labelCombo: String
    @Binding var isChangeColor: Bool
    @Binding var isShowCombobox: Bool
    @Binding var optional: Int
    @Binding var isStartRed: Bool
    @Binding var arr: [TypeCombo4Value]
    @Binding var data: TypeCombo4Value
    @Binding var isTapComponent: Bool
    @Binding var isTapLoop: Bool

    @State var selectedIndex = -1
    @State var currentCombobox = false
    @State var isPerson = false
    @Binding var oldOptional: Int
    @State var isBorderRed = false
    @State var isNew = false
    @State var index = 0

    var body: some View {
        ZStack {
            if isStartRed && optional == 1 {
                Text("").onAppear {
                    if self.oldOptional != 1 {
                        self.isBorderRed = false
                    } else {
                        self.isBorderRed = true
                    }
                }
            }
            if isStartRed {
                Text("").onAppear {
                    self.isBorderRed = true
                }
            } else {
                Text("").onAppear {
                    self.isBorderRed = false
                }
            }
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
                    isStartRed: $isBorderRed,
                    value: $data.combo,
                    selectedIndex: $selectedIndex,
                    isTapComponent: $isTapComponent,
                    isTapLoop: $isTapLoop,
                    currentCombobox: $currentCombobox,
                    label: isPerson ? "loan_online_3_relation" : "loan_online_3_banking",
                    isMustHave: false,
                    index: !isPerson ? 20 : 25,
                    isLoop: true,
                    isSpecialAll: true,
                    isNew: isNew,
                    indexForEach: index
                )
                LoanOnlineTextField(
                    isStartRed: $isBorderRed,
                    value: $data.value_1,
                    selectedIndex: $selectedIndex,
                    isTapComponent: $isTapComponent,
                    isTapLoop: $isTapLoop,
                    currentCombobox: $currentCombobox,
                    label: isPerson ? "loan_online_3_personRenter" : "loan_online_3_sheet_code",
                    isMustHave: false,
                    index: !isPerson ? 21 : 26,
                    isLoop: true,
                    isSpecialAll: true,
                    isNew: isNew
                )
                LoanOnlineTextField(
                    isStartRed: $isBorderRed,
                    value: $data.value_2,
                    selectedIndex: $selectedIndex,
                    isTapComponent: $isTapComponent,
                    isTapLoop: $isTapLoop,
                    currentCombobox: $currentCombobox,
                    label: "loan_online_3_money_rent",
                    isMustHave: false,
                    isNumber: true,
                    rightHolder: "VND",
                    index: !isPerson ? 22 : 27,
                    isLoop: true,
                    isSpecialAll: true,
                    isNew: isNew,
                    isNumberComma: true
                )
                LoanOnlineTextField(
                    isStartRed: $isBorderRed,
                    value: $data.value_3,
                    selectedIndex: $selectedIndex,
                    isTapComponent: $isTapComponent,
                    isTapLoop: $isTapLoop,
                    currentCombobox: $currentCombobox,
                    label: "loan_online_3_money_left",
                    isMustHave: false,
                    isNumber: true,
                    rightHolder: "VND",
                    index: !isPerson ? 23 : 28,
                    isLoop: true,
                    isSpecialAll: true,
                    isNew: isNew,
                    isNumberComma: true
                )
                LoanOnlineTextField(
                    isStartRed: $isBorderRed,
                    value: $data.value_4,
                    selectedIndex: $selectedIndex,
                    isTapComponent: $isTapComponent,
                    isTapLoop: $isTapLoop,
                    currentCombobox: $currentCombobox,
                    label: "loan_online_3_rent_time",
                    isMustHave: false,
                    isNumber: true,
                    rightHolder: "loan_online_3_year",
                    index: !isPerson ? 24 : 29,
                    isLoop: true,
                    isSpecialAll: true,
                    isNew: isNew,
                    isNumberComma: true
                )
            }
        }
    }
}
