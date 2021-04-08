// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import SwiftUI

struct TypeCombo4Value: Identifiable, Hashable {
    var id = UUID()
    var combo: String
    var comboIndex: Int
    var value_1: String
    var value_2: String
    var value_3: String
    var value_4: String
    var index: Int
}

struct TypeVehicle: Identifiable, Hashable {
    var id = UUID()
    var value_1: String
    var value_2: String
    var value_3: String
    var date: Date
    var initValueDate: Int
    var value_4: String
    var index: Int
}

struct TypeOtherRent: Identifiable, Hashable {
    var id = UUID()
    var value_1: String
    var value_2: String
    var value_3: String
    var index: Int
}

struct LoanOnlineTab_4: View {
    @Binding var dataRentOnline: ModalRentOnline
    @Binding var labelDatePicker: String
    @Binding var isShowDatePicker: Bool
    @Binding var labelCombo: String
    @Binding var selectedIndexTab_4: Int
    @Binding var isShowCombobox: Bool
    @Binding var isChangeColor: Bool

    @Binding var isStartRed_6: Bool
    @Binding var isStartRed_7: Bool

    @State var selectedTab = 0
    
    @State var isStartAnimation = false
    @State var isTapComponent = false
    @State var isTapLoop = false
    
    var body: some View {
        VStack (spacing: H(16)) {
            ZStack {
                VStack {
                    TabChangeLoanOnline(
                        currentSelectedFirstTab: $dataRentOnline.is_6,
                        selectedIndexPage: $dataRentOnline.selectedIndexPage,
                        index_1: 6,
                        index_2: 7,
                        label_1: "loan_online_4_title_1",
                        label_2: "loan_online_4_title_2"
                    )
                    Spacer()
                }.frame(width: FULL_W)

                // MARK: NHU CẦU VAY VỐN
                if dataRentOnline.selectedIndexPage == 6 {
                    VStack (spacing: 0) {
                        VStack (alignment: .leading, spacing: H(20)) {
                            // MARK: TỔNG NHU CẦU VỐN
                            LoanOnlineTextField(
                                isStartRed: $isStartRed_6,
                                value: $dataRentOnline.tab_4_strNeedCost,
                                selectedIndex: $selectedIndexTab_4,
                                isTapComponent: Binding.constant(false),
                                isTapLoop: Binding.constant(false),
                                currentCombobox: Binding.constant(false),
                                label: "loan_online_4_sum_need_money",
                                isNumber: true,
                                rightHolder: "VND",
                                index: 0,
                                isNumberComma: true
                            )
                            
                            // MARK: VỐN TỰ CÓ
                            LoanOnlineTextField(
                                isStartRed: $isStartRed_6,
                                value: $dataRentOnline.tab_4_strAlreadyCost,
                                selectedIndex: $selectedIndexTab_4,
                                isTapComponent: Binding.constant(false),
                                isTapLoop: Binding.constant(false),
                                currentCombobox: Binding.constant(false),
                                label: "loan_online_4_sum_self_money",
                                isNumber: true,
                                rightHolder: "VND",
                                index: 1,
                                isNumberComma: true
                            )
                            
                            // MARK: SỐ TIỀN ĐỀ NGHỊ VAY
                            LoanOnlineTextField(
                                isStartRed: $isStartRed_6,
                                value: $dataRentOnline.tab_4_strDecideRent,
                                selectedIndex: $selectedIndexTab_4,
                                isTapComponent: Binding.constant(false),
                                isTapLoop: Binding.constant(false),
                                currentCombobox: Binding.constant(false),
                                label: "loan_online_4_money_decide_rent",
                                isNumber: true,
                                rightHolder: "VND",
                                index: 2,
                                isNumberComma: true
                            )
                            
                            // MARK: THỜI HẠN VAY VỐN
                            LoanOnlineTextField(
                                isStartRed: $isStartRed_6,
                                value: $dataRentOnline.tab_4_strDeadLineRent,
                                selectedIndex: $selectedIndexTab_4,
                                isTapComponent: Binding.constant(false),
                                isTapLoop: Binding.constant(false),
                                currentCombobox: Binding.constant(false),
                                label: "loan_online_4_deadline_rent",
                                isNumber: true,
                                rightHolder: "loan_online_3_year",
                                index: 3,
                                isNumberComma: true
                            )
                        }.padding(.top, H(21))
                            .padding(.bottom, H(30))
                            .frame(width: FULL_W - 32, alignment: .leading)
                            .background(Color.white)
                            .padding(.bottom, H(16))

                        VStack (alignment: .leading, spacing: H(20)) {
                            // MARK: LOẠI HÌNH NHÀ/ĐẤT
                            LoanOnlineCombobox(
                                indexForEachBinding: Binding.constant(0),
                                moreComboIndex: Binding.constant(0),
                                labelCombo: $labelCombo,
                                isChangeColor: $isChangeColor,
                                isShowCombobox: $isShowCombobox,
                                isStartRed: $isStartRed_6,
                                value: $dataRentOnline.tab_4_strTypeArea,
                                selectedIndex: $selectedIndexTab_4,
                                isTapComponent: Binding.constant(false),
                                isTapLoop: Binding.constant(false),
                                currentCombobox: Binding.constant(false),
                                label: "loan_online_4_type_house",
                                index: 4
                            )
                            
                            // MARK: DIỆN TÍCH MẶT BẰNG
                            LoanOnlineTextField(
                                isStartRed: $isStartRed_6,
                                value: $dataRentOnline.tab_4_strAcreage,
                                selectedIndex: $selectedIndexTab_4,
                                isTapComponent: Binding.constant(false),
                                isTapLoop: Binding.constant(false),
                                currentCombobox: Binding.constant(false),
                                label: "loan_online_4_acreage",
                                isNumber: true,
                                rightHolder: "m2",
                                index: 5,
                                isNumberComma: true
                            )
                            
                            // MARK: TỈNH/THÀNH PHỐ
                            LoanOnlineCombobox(
                                indexForEachBinding: Binding.constant(0),
                                moreComboIndex: Binding.constant(0),
                                labelCombo: $labelCombo,
                                isChangeColor: $isChangeColor,
                                isShowCombobox: $isShowCombobox,
                                isStartRed: $isStartRed_6,
                                value: $dataRentOnline.tab_4_strCity,
                                selectedIndex: $selectedIndexTab_4,
                                isTapComponent: Binding.constant(false),
                                isTapLoop: Binding.constant(false),
                                currentCombobox: Binding.constant(false),
                                label: "loan_online_4_city",
                                isMustHave: false,
                                index: 6
                            )
                            
                            // MARK: QUẬN/HUYỆN
                            LoanOnlineCombobox(
                                indexForEachBinding: Binding.constant(0),
                                moreComboIndex: Binding.constant(0),
                                labelCombo: $labelCombo,
                                isChangeColor: $isChangeColor,
                                isShowCombobox: $isShowCombobox,
                                isStartRed: $isStartRed_6,
                                value: $dataRentOnline.tab_4_strDistrict,
                                selectedIndex: $selectedIndexTab_4,
                                isTapComponent: Binding.constant(false),
                                isTapLoop: Binding.constant(false),
                                currentCombobox: Binding.constant(false),
                                label: "loan_online_4_district",
                                isMustHave: false,
                                index: 7
                            )
                            
                            // MARK: PHƯỜNG/XÃ
                            LoanOnlineCombobox(
                                indexForEachBinding: Binding.constant(0),
                                moreComboIndex: Binding.constant(0),
                                labelCombo: $labelCombo,
                                isChangeColor: $isChangeColor,
                                isShowCombobox: $isShowCombobox,
                                isStartRed: $isStartRed_6,
                                value: $dataRentOnline.tab_4_strVillage,
                                selectedIndex: $selectedIndexTab_4,
                                isTapComponent: Binding.constant(false),
                                isTapLoop: Binding.constant(false),
                                currentCombobox: Binding.constant(false),
                                label: "loan_online_4_village",
                                isMustHave: false,
                                index: 8
                            )
                            
                            // MARK: ĐỊA CHỈ
                            LoanOnlineTextField(
                                isStartRed: $isStartRed_6,
                                value: $dataRentOnline.tab_4_strAddress,
                                selectedIndex: $selectedIndexTab_4,
                                isTapComponent: Binding.constant(false),
                                isTapLoop: Binding.constant(false),
                                currentCombobox: Binding.constant(false),
                                label: "loan_online_4_address",
                                isMustHave: false,
                                index: 9
                            )
                        }.padding(.top, H(21))
                            .padding(.bottom, H(30))
                            .frame(width: FULL_W - 32, alignment: .leading)
                            .background(Color.white)
                    }.padding(.top, H(56))
                        .padding(.horizontal, 16)

                } else { // MARK: TÀI SẢN BẢO ĐẢM TIỀN
                    VStack (spacing: H(16)) {
                        VStack (alignment: .leading, spacing: H(8)) {
                            TextCustom(text: NSLocalizedString("loan_online_4_sure_treasure", comment: ""), font: MEDIUM, size: 16, color: #colorLiteral(red: 0.4281106591, green: 0.1894766092, blue: 0.6721540093, alpha: 1))
                                .padding(.leading, 14)
                            Button(action: {
                                self.dataRentOnline.tab_4_optional_1.toggle()
                            }) {
                                HStack (spacing: 8) {
                                    ZStack {
                                        Rectangle()
                                            .foregroundColor(dataRentOnline.tab_4_optional_1 ? .init(#colorLiteral(red: 0.9200527072, green: 0.8800705075, blue: 0.9638360143, alpha: 1)) : .clear)
                                            .frame(width: W(19), height: W(19))
                                            .overlay(RoundedRectangle(cornerRadius: .infinity).stroke(Color.init(dataRentOnline.tab_4_optional_1 ? #colorLiteral(red: 0.4281106591, green: 0.1894766092, blue: 0.6721540093, alpha: 1): #colorLiteral(red: 0.6533299685, green: 0.6326879859, blue: 0.6321712136, alpha: 1)), lineWidth: 1.5))
                                            .cornerRadius(.infinity)
                                        Rectangle()
                                            .cornerRadius(.infinity)
                                            .foregroundColor(.init(#colorLiteral(red: 0.4281106591, green: 0.1894766092, blue: 0.6721540093, alpha: 1)))
                                            .frame(width: W(11), height: W(11)).opacity(dataRentOnline.tab_4_optional_1 ? 1 : 0)
                                    }
                                    TextCustom(text: NSLocalizedString("loan_online_4_role_use_house", comment: ""), font: REGULAR, size: 14, color: #colorLiteral(red: 0.4117531478, green: 0.411806047, blue: 0.4117352366, alpha: 1))
                                }
                            }.buttonStyle(ButtonTapScale())
                                .animation(isStartAnimation ? .easeInOut(duration: 0.1) : .none)
                                .padding(.leading, 14)
                            if dataRentOnline.tab_4_optional_1 {
                                VStack (alignment: .leading, spacing: 0) {
                                    if !dataRentOnline.tab_4_isAppendingRentTreasure {
                                        VStack (alignment: .leading, spacing: H(20)) {
                                            ForEach(0 ..< dataRentOnline.tab_4_arrRentTreasure.count) { i in
                                                if i > 0 {
                                                    Rectangle()
                                                        .foregroundColor(.init(#colorLiteral(red: 0.665820241, green: 0.6659018993, blue: 0.6657924652, alpha: 1)))
                                                        .frame(width: FULL_W - 60, height: 1)
                                                        .padding(.leading, 14)
                                                }
                                                if i >= self.dataRentOnline.tab_4_countArrRentTreasure {
                                                    RentTreasureView(
                                                        indexRentTreasure: self.$dataRentOnline.tab_4_indexRentTreasure,
                                                        moreComboIndex: self.$dataRentOnline.tab_4_moreComboIndex,
                                                        labelCombo: self.$labelCombo,
                                                        isChangeColor: self.$isChangeColor,
                                                        isShowCombobox: self.$isShowCombobox,
                                                        oldOptional: self.$dataRentOnline.tab_4_oldOptional_1,
                                                        optional: self.$dataRentOnline.tab_4_optional_1,
                                                        isStartRed: self.$isStartRed_7,
                                                        arr: self.$dataRentOnline.tab_4_arrRentTreasure,
                                                        data: self.$dataRentOnline.tab_4_arrRentTreasure[i],
                                                        isTapComponent: self.$isTapComponent,
                                                        isTapLoop: self.$isTapLoop,
                                                        isNew: true,
                                                        index: i
                                                    )
                                                } else {
                                                    RentTreasureView(
                                                        indexRentTreasure: self.$dataRentOnline.tab_4_indexRentTreasure,
                                                        moreComboIndex: self.$dataRentOnline.tab_4_moreComboIndex,
                                                        labelCombo: self.$labelCombo,
                                                        isChangeColor: self.$isChangeColor,
                                                        isShowCombobox: self.$isShowCombobox,
                                                        oldOptional: self.$dataRentOnline.tab_4_oldOptional_1,
                                                        optional: self.$dataRentOnline.tab_4_optional_1,
                                                        isStartRed: self.$isStartRed_7,
                                                        arr: self.$dataRentOnline.tab_4_arrRentTreasure,
                                                        data: self.$dataRentOnline.tab_4_arrRentTreasure[i],
                                                        isTapComponent: self.$isTapComponent,
                                                        isTapLoop: self.$isTapLoop,
                                                        index: i
                                                    )
                                                }
                                            }
                                        }
                                    }
                                    ZStack (alignment: .leading) {
                                        Button(action: {
                                            UIApplication.shared.endEditing()
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                                self.appendRentTreasure()
                                            }
                                        }) {
                                            HStack (spacing: 10) {
                                                ImageCustom(name: "iconFeatherPlusCircle", w: 16, h: 16)
                                                TextCustom(text: NSLocalizedString("loan_online_4_add_more_rent_treasure", comment: ""), font: REGULAR, size: 14, color: #colorLiteral(red: 0.4281106591, green: 0.1894766092, blue: 0.6721540093, alpha: 1))
                                            }
                                        }.buttonStyle(ButtonTapScale())
                                        HStack {
                                            Spacer()
                                            Button(action: {
                                                UIApplication.shared.endEditing()
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                                    self.removeRentTreasure()
                                                }
                                            }) {
                                                HStack (spacing: 10) {
                                                    ImageCustom(name: "iconFeatherMinusCircle", w: 16, h: 16)
                                                    TextCustom(text: NSLocalizedString("loan_online_4_remove_rent_treasure", comment: ""), font: REGULAR, size: 14, color: #colorLiteral(red: 0.9133259654, green: 0.297054708, blue: 0.2958536744, alpha: 1))
                                                }
                                            }.buttonStyle(ButtonTapScale())
                                        }.opacity(dataRentOnline.tab_4_arrRentTreasure.count > 1 ? 1 : 0)
                                    }.frame(width: FULL_W - 60)
                                        .animation(isStartAnimation ? .easeInOut(duration: 0.1) : .none)
                                        .padding(.leading, 14)
                                        .padding(.top, H(20))
                                }.padding(.top, H(12))
                            }
                        }.padding(.top, H(21))
                            .padding(.bottom, H(21))
                            .frame(width: FULL_W - 32, alignment: .leading)
                            .background(Color.white)

                        VStack (alignment: .leading, spacing: H(8)) {
                            TextCustom(text: NSLocalizedString("loan_online_4_sure_treasure_other", comment: ""), font: MEDIUM, size: 16, color: #colorLiteral(red: 0.4281106591, green: 0.1894766092, blue: 0.6721540093, alpha: 1))
                                .padding(.leading, 14)
                            Button(action: {
                                self.dataRentOnline.tab_4_optional_2.toggle()
                            }) {
                                HStack (spacing: 8) {
                                    ZStack {
                                        Rectangle()
                                            .foregroundColor(dataRentOnline.tab_4_optional_2 ? .init(#colorLiteral(red: 0.9200527072, green: 0.8800705075, blue: 0.9638360143, alpha: 1)) : .clear)
                                            .frame(width: W(19), height: W(19))
                                            .overlay(RoundedRectangle(cornerRadius: .infinity).stroke(Color.init(dataRentOnline.tab_4_optional_2 ? #colorLiteral(red: 0.4281106591, green: 0.1894766092, blue: 0.6721540093, alpha: 1): #colorLiteral(red: 0.6533299685, green: 0.6326879859, blue: 0.6321712136, alpha: 1)), lineWidth: 1.5))
                                            .cornerRadius(.infinity)
                                        Rectangle()
                                            .cornerRadius(.infinity)
                                            .foregroundColor(.init(#colorLiteral(red: 0.4281106591, green: 0.1894766092, blue: 0.6721540093, alpha: 1)))
                                            .frame(width: W(11), height: W(11)).opacity(dataRentOnline.tab_4_optional_2 ? 1 : 0)
                                    }
                                    TextCustom(text: NSLocalizedString("loan_online_4_device", comment: ""), font: REGULAR, size: 14, color: #colorLiteral(red: 0.4117531478, green: 0.411806047, blue: 0.4117352366, alpha: 1))
                                }
                            }.buttonStyle(ButtonTapScale())
                                .animation(isStartAnimation ? .easeInOut(duration: 0.1) : .none)
                                .padding(.leading, 14)
                            if dataRentOnline.tab_4_optional_2 {
                                VStack (alignment: .leading, spacing: 0) {
                                    if !dataRentOnline.tab_4_isAppendingVehicle {
                                        VStack (alignment: .leading, spacing: H(20)) {
                                            ForEach(0 ..< dataRentOnline.tab_4_arrVehicle.count) { i in
                                                if i > 0 {
                                                    Rectangle()
                                                        .foregroundColor(.init(#colorLiteral(red: 0.665820241, green: 0.6659018993, blue: 0.6657924652, alpha: 1)))
                                                        .frame(width: FULL_W - 60, height: 1)
                                                        .padding(.leading, 14)
                                                }
                                                if i >= self.dataRentOnline.tab_4_countArrVehicle {
                                                    VehicleTreasureView(
                                                        indexForEachBinding: self.$dataRentOnline.tab_4_indexVehicle,
                                                        labelDatePicker: self.$labelDatePicker,
                                                        isShowDatePicker: self.$isShowDatePicker,
                                                        isChangeColor: self.$isChangeColor,
                                                        oldOptional: self.$dataRentOnline.tab_4_oldOptional_2,
                                                        optional: self.$dataRentOnline.tab_4_optional_2,
                                                        isStartRed: self.$isStartRed_7,
                                                        arr: self.$dataRentOnline.tab_4_arrVehicle,
                                                        data: self.$dataRentOnline.tab_4_arrVehicle[i],
                                                        isTapComponent: self.$isTapComponent,
                                                        isTapLoop: self.$isTapLoop,
                                                        isNew: true,
                                                        index: i
                                                    )
                                                } else {
                                                    VehicleTreasureView(
                                                        indexForEachBinding: self.$dataRentOnline.tab_4_indexVehicle,
                                                        labelDatePicker: self.$labelDatePicker,
                                                        isShowDatePicker: self.$isShowDatePicker,
                                                        isChangeColor: self.$isChangeColor,
                                                        oldOptional: self.$dataRentOnline.tab_4_oldOptional_2,
                                                        optional: self.$dataRentOnline.tab_4_optional_2,
                                                        isStartRed: self.$isStartRed_7,
                                                        arr: self.$dataRentOnline.tab_4_arrVehicle,
                                                        data: self.$dataRentOnline.tab_4_arrVehicle[i],
                                                        isTapComponent: self.$isTapComponent,
                                                        isTapLoop: self.$isTapLoop,
                                                        index: i
                                                    )
                                                }
                                            }
                                        }
                                    }
                                    ZStack (alignment: .leading) {
                                        Button(action: {
                                            UIApplication.shared.endEditing()
                                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                                self.appendVehicle()
                                            }
                                        }) {
                                            HStack (spacing: 10) {
                                                ImageCustom(name: "iconFeatherPlusCircle", w: 16, h: 16)
                                                TextCustom(text: NSLocalizedString("loan_online_4_add_more_rent_treasure", comment: ""), font: REGULAR, size: 14, color: #colorLiteral(red: 0.4281106591, green: 0.1894766092, blue: 0.6721540093, alpha: 1))
                                            }
                                        }.buttonStyle(ButtonTapScale())
                                        HStack {
                                            Spacer()
                                            Button(action: {
                                                UIApplication.shared.endEditing()
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                                    self.removeVehicle()
                                                }
                                            }) {
                                                HStack (spacing: 10) {
                                                    ImageCustom(name: "iconFeatherMinusCircle", w: 16, h: 16)
                                                    TextCustom(text: NSLocalizedString("loan_online_4_remove_rent_treasure", comment: ""), font: REGULAR, size: 14, color: #colorLiteral(red: 0.9133259654, green: 0.297054708, blue: 0.2958536744, alpha: 1))
                                                }
                                            }.buttonStyle(ButtonTapScale())
                                        }.opacity(dataRentOnline.tab_4_arrVehicle.count > 1 ? 1 : 0)
                                    }.frame(width: FULL_W - 60)
                                        .animation(isStartAnimation ? .easeInOut(duration: 0.1) : .none)
                                        .padding(.leading, 14)
                                        .padding(.top, H(20))
                                }.padding(.top, H(12))
                            }
                            if !dataRentOnline.tab_4_optional_2 && !dataRentOnline.tab_4_optional_3 {
                                Button(action: {
                                    self.dataRentOnline.tab_4_optional_3.toggle()
                                }) {
                                    HStack (spacing: 8) {
                                        ZStack {
                                            Rectangle()
                                                .foregroundColor(dataRentOnline.tab_4_optional_3 ? .init(#colorLiteral(red: 0.9200527072, green: 0.8800705075, blue: 0.9638360143, alpha: 1)) : .clear)
                                                .frame(width: W(19), height: W(19))
                                                .overlay(RoundedRectangle(cornerRadius: .infinity).stroke(Color.init(dataRentOnline.tab_4_optional_3 ? #colorLiteral(red: 0.4281106591, green: 0.1894766092, blue: 0.6721540093, alpha: 1): #colorLiteral(red: 0.6533299685, green: 0.6326879859, blue: 0.6321712136, alpha: 1)), lineWidth: 1.5))
                                                .cornerRadius(.infinity)
                                            Rectangle()
                                                .cornerRadius(.infinity)
                                                .foregroundColor(.init(#colorLiteral(red: 0.4281106591, green: 0.1894766092, blue: 0.6721540093, alpha: 1)))
                                                .frame(width: W(11), height: W(11)).opacity(dataRentOnline.tab_4_optional_3 ? 1 : 0)
                                        }
                                        TextCustom(text: NSLocalizedString("loan_online_4_another", comment: ""), font: REGULAR, size: 14, color: #colorLiteral(red: 0.4117531478, green: 0.411806047, blue: 0.4117352366, alpha: 1))
                                    }
                                }.buttonStyle(ButtonTapScale())
                                    .animation(isStartAnimation ? .easeInOut(duration: 0.1) : .none)
                                    .padding(.leading, 14)
                            }
                        }.padding(.top, H(21))
                            .padding(.bottom, H(21))
                            .frame(width: FULL_W - 32, alignment: .leading)
                            .background(Color.white)
                        if dataRentOnline.tab_4_optional_3 || (dataRentOnline.tab_4_optional_2 && !dataRentOnline.tab_4_optional_3) {
                            VStack (alignment: .leading, spacing: H(8)) {
                                Button(action: {
                                    self.dataRentOnline.tab_4_optional_3.toggle()
                                }) {
                                    HStack (spacing: 8) {
                                        ZStack {
                                            Rectangle()
                                                .foregroundColor(dataRentOnline.tab_4_optional_3 ? .init(#colorLiteral(red: 0.9200527072, green: 0.8800705075, blue: 0.9638360143, alpha: 1)) : .clear)
                                                .frame(width: W(19), height: W(19))
                                                .overlay(RoundedRectangle(cornerRadius: .infinity).stroke(Color.init(dataRentOnline.tab_4_optional_3 ? #colorLiteral(red: 0.4281106591, green: 0.1894766092, blue: 0.6721540093, alpha: 1): #colorLiteral(red: 0.6533299685, green: 0.6326879859, blue: 0.6321712136, alpha: 1)), lineWidth: 1.5))
                                                .cornerRadius(.infinity)
                                            Rectangle()
                                                .cornerRadius(.infinity)
                                                .foregroundColor(.init(#colorLiteral(red: 0.4281106591, green: 0.1894766092, blue: 0.6721540093, alpha: 1)))
                                                .frame(width: W(11), height: W(11)).opacity(dataRentOnline.tab_4_optional_3 ? 1 : 0)
                                        }
                                        TextCustom(text: NSLocalizedString("loan_online_4_another", comment: ""), font: REGULAR, size: 14, color: #colorLiteral(red: 0.4117531478, green: 0.411806047, blue: 0.4117352366, alpha: 1))
                                    }
                                }.buttonStyle(ButtonTapScale())
                                    .animation(isStartAnimation ? .easeInOut(duration: 0.1) : .none)
                                    .padding(.leading, 14)
                                if dataRentOnline.tab_4_optional_3 {
                                    VStack (alignment: .leading, spacing: 0) {
                                        if !dataRentOnline.tab_4_isAppendingOtherRent {
                                            VStack (alignment: .leading, spacing: H(20)) {
                                                ForEach(0 ..< dataRentOnline.tab_4_arrOtherRent.count) { i in
                                                    if i > 0 {
                                                        Rectangle()
                                                            .foregroundColor(.init(#colorLiteral(red: 0.665820241, green: 0.6659018993, blue: 0.6657924652, alpha: 1)))
                                                            .frame(width: FULL_W - 60, height: 1)
                                                            .padding(.leading, 14)
                                                    }
                                                    if i >= self.dataRentOnline.tab_4_countArrOtherRent {
                                                        OtherRentView(
                                                            oldOptional: self.$dataRentOnline.tab_4_oldOptional_3,
                                                            optional: self.$dataRentOnline.tab_4_optional_3,
                                                            isStartRed: self.$isStartRed_7,
                                                            arr: self.$dataRentOnline.tab_4_arrOtherRent,
                                                            data: self.$dataRentOnline.tab_4_arrOtherRent[i],
                                                            isTapComponent: self.$isTapComponent,
                                                            isTapLoop: self.$isTapLoop,
                                                            isNew: true
                                                        )
                                                    } else {
                                                        OtherRentView(
                                                            oldOptional: self.$dataRentOnline.tab_4_oldOptional_3,
                                                            optional: self.$dataRentOnline.tab_4_optional_3,
                                                            isStartRed: self.$isStartRed_7,
                                                            arr: self.$dataRentOnline.tab_4_arrOtherRent,
                                                            data: self.$dataRentOnline.tab_4_arrOtherRent[i],
                                                            isTapComponent: self.$isTapComponent,
                                                            isTapLoop: self.$isTapLoop
                                                        )
                                                    }
                                                }
                                            }
                                        }
                                        ZStack (alignment: .leading) {
                                            Button(action: {
                                                UIApplication.shared.endEditing()
                                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                                    self.appendOtherRent()
                                                }
                                            }) {
                                                HStack (spacing: 10) {
                                                    ImageCustom(name: "iconFeatherPlusCircle", w: 16, h: 16)
                                                    TextCustom(text: NSLocalizedString("loan_online_4_add_more_rent_treasure", comment: ""), font: REGULAR, size: 14, color: #colorLiteral(red: 0.4281106591, green: 0.1894766092, blue: 0.6721540093, alpha: 1))
                                                }
                                            }.buttonStyle(ButtonTapScale())
                                            HStack {
                                                Spacer()
                                                Button(action: {
                                                    UIApplication.shared.endEditing()
                                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                                        self.removeOtherRent()
                                                    }
                                                }) {
                                                    HStack (spacing: 10) {
                                                        ImageCustom(name: "iconFeatherMinusCircle", w: 16, h: 16)
                                                        TextCustom(text: NSLocalizedString("loan_online_4_remove_rent_treasure", comment: ""), font: REGULAR, size: 14, color: #colorLiteral(red: 0.9133259654, green: 0.297054708, blue: 0.2958536744, alpha: 1))
                                                    }
                                                }.buttonStyle(ButtonTapScale())
                                            }.opacity(dataRentOnline.tab_4_arrOtherRent.count > 1 ? 1 : 0)
                                        }.frame(width: FULL_W - 60)
                                            .animation(isStartAnimation ? .easeInOut(duration: 0.1) : .none)
                                            .padding(.leading, 14)
                                            .padding(.top, H(20))
                                    }.padding(.top, H(12))
                                }
                            }.padding(.vertical, H(21))
                                .frame(width: FULL_W - 32, alignment: .leading)
                                .background(Color.white)
                        }
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
            self.selectedIndexTab_4 = -1
        }
    }

    func appendRentTreasure() {
        self.dataRentOnline.tab_4_isAppendingRentTreasure = true
        dataRentOnline.tab_4_arrRentTreasure.append(TypeCombo4Value(combo: "", comboIndex: -1, value_1: "", value_2: "", value_3: "", value_4: "", index: self.dataRentOnline.tab_4_arrRentTreasure.count))
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            self.dataRentOnline.tab_4_isAppendingRentTreasure = false
        }
    }

    func appendVehicle() {
        self.dataRentOnline.tab_4_isAppendingVehicle = true
        dataRentOnline.tab_4_arrVehicle.append(TypeVehicle(value_1: "", value_2: "", value_3: "", date: Date(), initValueDate: 0, value_4: "", index: self.dataRentOnline.tab_4_arrVehicle.count))
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            self.dataRentOnline.tab_4_isAppendingVehicle = false
        }
    }

    func appendOtherRent() {
        self.dataRentOnline.tab_4_isAppendingOtherRent = true
        dataRentOnline.tab_4_arrOtherRent.append(TypeOtherRent(value_1: "", value_2: "", value_3: "", index: self.dataRentOnline.tab_4_arrOtherRent.count))
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
            self.dataRentOnline.tab_4_isAppendingOtherRent = false
        }
    }

    func removeRentTreasure() {
        if dataRentOnline.tab_4_isAppendingRentTreasure {
            dataRentOnline.tab_4_arrRentTreasure.removeLast()
            if dataRentOnline.tab_4_arrRentTreasure.count == dataRentOnline.tab_4_countArrRentTreasure - 1 {
                dataRentOnline.tab_4_countArrRentTreasure = dataRentOnline.tab_4_arrRentTreasure.count
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                self.dataRentOnline.tab_4_isAppendingRentTreasure = false
                return
            }
        } else {
            dataRentOnline.tab_4_isAppendingRentTreasure = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                self.removeRentTreasure()
            }
        }
    }

    func removeVehicle() {
        if dataRentOnline.tab_4_isAppendingVehicle {
            dataRentOnline.tab_4_arrVehicle.removeLast()
            if dataRentOnline.tab_4_arrVehicle.count == dataRentOnline.tab_4_countArrVehicle - 1 {
                dataRentOnline.tab_4_countArrVehicle = dataRentOnline.tab_4_arrVehicle.count
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                self.dataRentOnline.tab_4_isAppendingVehicle = false
                return
            }
        } else {
            dataRentOnline.tab_4_isAppendingVehicle = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                self.removeVehicle()
            }
        }
    }

    func removeOtherRent() {
        if dataRentOnline.tab_4_isAppendingOtherRent {
            dataRentOnline.tab_4_arrOtherRent.removeLast()
            if dataRentOnline.tab_4_arrOtherRent.count == dataRentOnline.tab_4_countArrOtherRent - 1 {
                dataRentOnline.tab_4_countArrOtherRent = dataRentOnline.tab_4_arrOtherRent.count
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                self.dataRentOnline.tab_4_isAppendingOtherRent = false
                return
            }
        } else {
            dataRentOnline.tab_4_isAppendingOtherRent = true
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.01) {
                self.removeOtherRent()
            }
        }
    }
}

struct RentTreasureView: View {
    @Binding var indexRentTreasure: Int
    @Binding var moreComboIndex: Int
    @Binding var labelCombo: String
    @Binding var isChangeColor: Bool
    @Binding var isShowCombobox: Bool
    @Binding var oldOptional: Bool
    @Binding var optional: Bool
    @Binding var isStartRed: Bool
    @Binding var arr: [TypeCombo4Value]
    @Binding var data: TypeCombo4Value
    @Binding var isTapComponent: Bool
    @Binding var isTapLoop: Bool

    @State var selectedIndex = -1
    @State var currentCombobox = false
    @State var isNew = false
    @State var isBorderRed = false
    @State var index = 0
    
    var body: some View {
        ZStack {
            if isStartRed && optional {
                Text("").onAppear {
                    if !self.oldOptional {
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
                    indexForEachBinding: $indexRentTreasure,
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
                    label: "loan_online_4_type_image",
                    isMustHave: false,
                    index: 10,
                    isLoop: true,
                    indexForEach: index
                )
                LoanOnlineTextField(
                    isStartRed: $isBorderRed,
                    value: $data.value_1,
                    selectedIndex: $selectedIndex,
                    isTapComponent: $isTapComponent,
                    isTapLoop: $isTapLoop,
                    currentCombobox: $currentCombobox,
                    label: "loan_online_4_certificate",
                    isMustHave: false,
                    index: 11,
                    isLoop: true
                )
                LoanOnlineTextField(
                    isStartRed: $isBorderRed,
                    value: $data.value_2,
                    selectedIndex: $selectedIndex,
                    isTapComponent: $isTapComponent,
                    isTapLoop: $isTapLoop,
                    currentCombobox: $currentCombobox,
                    label: "loan_online_4_owner",
                    isMustHave: false,
                    index: 12,
                    isLoop: true
                )
                LoanOnlineTextField(
                    isStartRed: $isBorderRed,
                    value: $data.value_3,
                    selectedIndex: $selectedIndex,
                    isTapComponent: $isTapComponent,
                    isTapLoop: $isTapLoop,
                    currentCombobox: $currentCombobox,
                    label: "loan_online_3_value",
                    isNumber: true,
                    rightHolder: "VND",
                    index: 13,
                    isLoop: true,
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
                    label: "loan_online_4_address",
                    isMustHave: false,
                    index: 14,
                    isLoop: true
                )
            }
        }
    }
}

struct VehicleTreasureView: View {
    @Binding var indexForEachBinding: Int
    @Binding var labelDatePicker: String
    @Binding var isShowDatePicker: Bool
    @Binding var isChangeColor: Bool
    @Binding var oldOptional: Bool
    @Binding var optional: Bool
    @Binding var isStartRed: Bool
    @Binding var arr: [TypeVehicle]
    @Binding var data: TypeVehicle
    @Binding var isTapComponent: Bool
    @Binding var isTapLoop: Bool

    @State var selectedIndex = -1
    @State var currentCombobox = false
    @State var isNew = false
    @State var isBorderRed = false
    @State var tempDate = Date()
    @State var index = 0
    
    var body: some View {
        ZStack {
            if isStartRed && optional {
                Text("").onAppear {
                    if !self.oldOptional {
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
                    label: "loan_online_4_regist_paper",
                    isMustHave: false,
                    index: 0,
                    isLoop: true
                )
                LoanOnlineTextField(
                    isStartRed: $isBorderRed,
                    value: $data.value_2,
                    selectedIndex: $selectedIndex,
                    isTapComponent: $isTapComponent,
                    isTapLoop: $isTapLoop,
                    currentCombobox: $currentCombobox,
                    label: "loan_online_4_owner",
                    isMustHave: false,
                    index: 1,
                    isLoop: true
                )
                LoanOnlineTextField(
                    isStartRed: $isBorderRed,
                    value: $data.value_3,
                    selectedIndex: $selectedIndex,
                    isTapComponent: $isTapComponent,
                    isTapLoop: $isTapLoop,
                    currentCombobox: $currentCombobox,
                    label: "loan_online_4_vehicle_company",
                    isMustHave: false,
                    isNumber: true,
                    rightHolder: "VND",
                    index: 2,
                    isLoop: true
                )
                LoanOnlineDateField(
                    indexForEachBinding: $indexForEachBinding,
                    labelDatePicker: $labelDatePicker,
                    isChangeColor: $isChangeColor,
                    isShowDatePicker: $isShowDatePicker,
                    initValue: $data.initValueDate,
                    valueDate: $data.date,
                    isStartRed: $isBorderRed,
                    valueIndex: Binding.constant(0),
                    value: Binding.constant(""),
                    selectedIndex: $selectedIndex,
                    isTapComponent: $isTapComponent,
                    isTapLoop: $isTapLoop,
                    currentCombobox: $currentCombobox,
                    label: "loan_online_4_year_reduce",
                    isMustHave: false,
                    index: 3,
                    isLoop: true,
                    isTrueDate: true,
                    indexForEach: index
                )
                LoanOnlineTextField(
                    isStartRed: $isBorderRed,
                    value: $data.value_4,
                    selectedIndex: $selectedIndex,
                    isTapComponent: $isTapComponent,
                    isTapLoop: $isTapLoop,
                    currentCombobox: $currentCombobox,
                    label: "loan_online_3_value",
                    index: 4,
                    isLoop: true,
                    isNew: isNew,
                    isNumberComma: true
                )
            }
        }
    }
}

struct OtherRentView: View {
    @Binding var oldOptional: Bool
    @Binding var optional: Bool
    @Binding var isStartRed: Bool
    @Binding var arr: [TypeOtherRent]
    @Binding var data: TypeOtherRent
    @Binding var isTapComponent: Bool
    @Binding var isTapLoop: Bool

    @State var selectedIndex = -1
    @State var currentCombobox = false
    @State var isNew = false
    @State var isBorderRed = false

    var body: some View {
        ZStack {
            if isStartRed && optional {
                Text("").onAppear {
                    if !self.oldOptional {
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
                    label: "loan_online_4_special_point",
                    isMustHave: false,
                    index: 0,
                    isLoop: true
                )
                LoanOnlineTextField(
                    isStartRed: $isBorderRed,
                    value: $data.value_2,
                    selectedIndex: $selectedIndex,
                    isTapComponent: $isTapComponent,
                    isTapLoop: $isTapLoop,
                    currentCombobox: $currentCombobox,
                    label: "loan_online_3_value",
                    isNumber: true,
                    rightHolder: "VND",
                    index: 1,
                    isLoop: true,
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
                    label: "loan_online_4_owner",
                    isMustHave: false,
                    index: 2,
                    isLoop: true
                )
            }
        }
    }
}
