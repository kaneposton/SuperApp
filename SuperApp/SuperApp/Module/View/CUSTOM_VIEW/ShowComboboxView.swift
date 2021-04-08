// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import SwiftUI

struct typeCombobox: Identifiable, Hashable {
    let uuid = UUID()
    var id: Int
    var name: String
}

struct ShowComboboxView: View {
    @Binding var selectedIndexPage: Int
    @Binding var dataOtherSalary: [TypeOtherSalary]
    @Binding var dataCombo4Value: [TypeCombo4Value]
    @Binding var dataTreasure: [TypeTreasure]
    @Binding var indexForEach: Int
    @Binding var isChangeColor: Bool
    @Binding var isShowCombobox: Bool
    @Binding var selectedComboIndex: Int
    @Binding var selectedComboName: String
    @Binding var label: String
    @Binding var data: [typeCombobox]

    @State var temp_selectedComboIndex = -1
    @State var temp_selectedComboName = ""
    @State var isParticipate = false

    var body: some View {
        ZStack {
            if isShowCombobox {
                Text("").onAppear {
                    self.temp_selectedComboIndex =
                        self.selectedIndexPage == 3 ? self.dataOtherSalary[self.indexForEach].comboIndex:
                        self.selectedIndexPage == 4 ? self.dataTreasure[self.indexForEach].comboIndex:
                        self.selectedIndexPage == 5 || self.selectedIndexPage == 7 ? self.dataCombo4Value[self.indexForEach].comboIndex : self.selectedComboIndex
                }
            } else {
                Text("").onAppear {
                    self.temp_selectedComboIndex = -1
                    self.temp_selectedComboName = ""
                }
            }
            VStack {
                Spacer()
                VStack(spacing: 0) {
                    if !isParticipate {
                        Rectangle()
                            .frame(width: W(74), height: W(4))
                            .foregroundColor(.init(#colorLiteral(red: 0.5111798048, green: 0.3070217371, blue: 0.7141162753, alpha: 1)))
                            .padding(.top, H(8))
                    }
                    ZStack {
                        HStack {
                            Button(action: {
                                self.isShowCombobox = false
                                self.isChangeColor = false
                            }) {
                                TextCustom(text: NSLocalizedString("project_ground_plan_popup_cancel", comment: ""), font: REGULAR, size: 18, color: #colorLiteral(red: 0.4038758278, green: 0.4039486051, blue: 0.403865695, alpha: 1))
                            }.buttonStyle(ButtonTapScale())
                                .animation(.easeInOut(duration: 0.1))
                            Spacer()
                        }
                        TextCustom(text: NSLocalizedString(label, comment: "").lowercased().firstUppercased, font: MEDIUM, size: 22, lineLimit: 1, color: #colorLiteral(red: 0.1363612413, green: 0.1216128543, blue: 0.1213363782, alpha: 1))
                            .frame(width: FULL_W - 60 - 30 - 60)
                        HStack {
                            Spacer()
                            Button(action: {
                                if self.selectedIndexPage == 3 {
                                    self.dataOtherSalary[self.indexForEach].comboIndex = self.temp_selectedComboIndex
                                    self.dataOtherSalary[self.indexForEach].combo = self.temp_selectedComboName
                                } else if self.selectedIndexPage == 4 {
                                    self.dataTreasure[self.indexForEach].comboIndex = self.temp_selectedComboIndex
                                    self.dataTreasure[self.indexForEach].combo = self.temp_selectedComboName
                                } else if self.selectedIndexPage == 5 || self.selectedIndexPage == 7 {
                                    self.dataCombo4Value[self.indexForEach].comboIndex = self.temp_selectedComboIndex
                                    self.dataCombo4Value[self.indexForEach].combo = self.temp_selectedComboName
                                } else {
                                    self.selectedComboIndex = self.temp_selectedComboIndex
                                    self.selectedComboName = self.temp_selectedComboName
                                }
                                self.isShowCombobox = false
                                self.isChangeColor = false
                            }) {
                                TextCustom(text: NSLocalizedString("project_ground_plan_popup_done", comment: ""), font: MEDIUM, size: 18, color: #colorLiteral(red: 0.4205850065, green: 0.1838403046, blue: 0.6598007083, alpha: 1))
                            }.buttonStyle(ButtonTapScale())
                                .animation(.easeInOut(duration: 0.1))
                        }
                    }.padding(.top, H(isParticipate ? 16 : 12))
                        .padding(.horizontal, 30)
                    Rectangle()
                        .frame(width: isParticipate ? FULL_W - 40: nil, height: 1)
                        .foregroundColor(.init(isParticipate ? #colorLiteral(red: 0.5293536186, green: 0.5294462442, blue: 0.5293406844, alpha: 1): #colorLiteral(red: 0.8077571988, green: 0.8078939915, blue: 0.8077381253, alpha: 1)))
                        .padding(.top, H(isParticipate ? 19 : 14))
                    ScrollView {
                        VStack (spacing: 0) {
                            ForEach(data, id: \.self) { value in
                                ComboboxCustomView(
                                    isParticipate: self.$isParticipate,
                                    selectedComboIndex: self.$temp_selectedComboIndex,
                                    selectedComboName: self.$temp_selectedComboName,
                                    value: value
                                )
                            }
                        }.padding(.top, H(21))
                    }.offset(y: isShowCombobox ? 0 : H(500))
                }.frame(width: FULL_W, height:
                        isParticipate ?
                    data.count == 0 || data.count == 1 ? H(
                        FULL_H == H_SE && FULL_W == W_SE ? 110: // iPhone SE 1st generation
                        FULL_H == H_8 && FULL_W == W_8 ? 110: // iPhone 8 && iPhone SE 2nd generation
                        FULL_H == H_8Plus && FULL_W == W_8Plus ? 100: // iPhone 8 Plus
                        FULL_H == H_11 && FULL_W == W_11 ? 165: // iPhone 11 && iPhone 11 Pro Max
                        FULL_H == H_11Pro && FULL_W == W_11Pro ? 165 : 0 // iPhone 11 Pro
                    ) + 2 + W(24):
                        data.count == 2 ? H(
                            FULL_H == H_SE && FULL_W == W_SE ? 144: // iPhone SE 1st generation
                            FULL_H == H_8 && FULL_W == W_8 ? 144: // iPhone 8 && iPhone SE 2nd generation
                            FULL_H == H_8Plus && FULL_W == W_8Plus ? 134: // iPhone 8 Plus
                            FULL_H == H_11 && FULL_W == W_11 ? 199: // iPhone 11 && iPhone 11 Pro Max
                            FULL_H == H_11Pro && FULL_W == W_11Pro ? 199 : 0 // iPhone 11 Pro
                        ) + 3 + W(48):
                        data.count == 3 ? H(
                            FULL_H == H_SE && FULL_W == W_SE ? 182: // iPhone SE 1st generation
                            FULL_H == H_8 && FULL_W == W_8 ? 182: // iPhone 8 && iPhone SE 2nd generation
                            FULL_H == H_8Plus && FULL_W == W_8Plus ? 172: // iPhone 8 Plus
                            FULL_H == H_11 && FULL_W == W_11 ? 237: // iPhone 11 && iPhone 11 Pro Max
                            FULL_H == H_11Pro && FULL_W == W_11Pro ? 237 : 0 // iPhone 11 Pro
                        ) + 4 + W(72): H(344)
                        :
                        data.count == 0 || data.count == 1 ? H(
                            FULL_H == H_SE && FULL_W == W_SE ? 101: // iPhone SE 1st generation
                            FULL_H == H_8 && FULL_W == W_8 ? 101: // iPhone 8 && iPhone SE 2nd generation
                            FULL_H == H_8Plus && FULL_W == W_8Plus ? 101: // iPhone 8 Plus
                            FULL_H == H_11 && FULL_W == W_11 ? 121: // iPhone 11 && iPhone 11 Pro Max
                            FULL_H == H_11Pro && FULL_W == W_11Pro ? 121 : 0 // iPhone 11 Pro
                        ) + 2 + W(28):
                        data.count == 2 ? H(
                            FULL_H == H_SE && FULL_W == W_SE ? 135: // iPhone SE 1st generation
                            FULL_H == H_8 && FULL_W == W_8 ? 135: // iPhone 8 && iPhone SE 2nd generation
                            FULL_H == H_8Plus && FULL_W == W_8Plus ? 135: // iPhone 8 Plus
                            FULL_H == H_11 && FULL_W == W_11 ? 155: // iPhone 11 && iPhone 11 Pro Max
                            FULL_H == H_11Pro && FULL_W == W_11Pro ? 155 : 0 // iPhone 11 Pro
                        ) + 3 + W(52):
                        data.count == 3 ? H(
                            FULL_H == H_SE && FULL_W == W_SE ? 173: // iPhone SE 1st generation
                            FULL_H == H_8 && FULL_W == W_8 ? 173: // iPhone 8 && iPhone SE 2nd generation
                            FULL_H == H_8Plus && FULL_W == W_8Plus ? 173: // iPhone 8 Plus
                            FULL_H == H_11 && FULL_W == W_11 ? 193: // iPhone 11 && iPhone 11 Pro Max
                            FULL_H == H_11Pro && FULL_W == W_11Pro ? 193 : 0 // iPhone 11 Pro
                        ) + 4 + W(76): H(344)
                ).background(Color.white)
                    .cornerRadius(5)
                    .shadow(color: .init(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2016802226)), radius: 5, y: -5)
            }.edgesIgnoringSafeArea(.bottom)
                .offset(y: isShowCombobox ? 0 : H(500)
                ).animation(.easeInOut(duration: 0.2))
        }
    }
}

struct ComboboxCustomView: View {
    @Binding var isParticipate: Bool
    @Binding var selectedComboIndex: Int
    @Binding var selectedComboName: String
    @State var value = typeCombobox(id: 0, name: "")

    var body: some View {
        VStack (spacing: 0) {
            Button(action: {
                if self.selectedComboIndex == self.value.id {
                    self.selectedComboIndex = -1
                    self.selectedComboName = ""
                } else {
                    self.selectedComboIndex = self.value.id
                    self.selectedComboName = self.value.name
                }
            }) {
                HStack {
                    TextCustom(text: value.name, font: REGULAR, size: 18, color: #colorLiteral(red: 0.05096982419, green: 0.0509866029, blue: 0.05096747726, alpha: 1))
                        .padding(.leading, 30)
                    Spacer()
                    ZStack {
                        Rectangle()
                            .frame(width: W(24), height: W(24))
                            .foregroundColor(.init(isParticipate ? #colorLiteral(red: 0.4282599092, green: 0.1879977882, blue: 0.6717798114, alpha: 1): #colorLiteral(red: 0.5590858459, green: 0.3960000873, blue: 0.9303051829, alpha: 1)))
                            .clipShape(Circle())
                        ImageCustom(name: "check", w: 11.7, h: 8.7)
                    }.padding(.trailing, 28)
                        .opacity(self.selectedComboIndex == self.value.id ? 1 : 0)
                }.background(Color.white)
            }.buttonStyle(ButtonTapScale())
                .animation(.easeInOut(duration: 0.1))
                .background(Color.white)
            Rectangle()
                .frame(width: FULL_W - 40, height: 1)
                .foregroundColor(.init(#colorLiteral(red: 0.9175502658, green: 0.9177044034, blue: 0.9175286889, alpha: 1)))
                .padding(.vertical, H(17))
        }.background(Color.init(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)))
    }
}
