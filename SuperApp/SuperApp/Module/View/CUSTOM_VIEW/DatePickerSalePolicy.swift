// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import SwiftUI

struct ShowDatePickerView: View {
    @Binding var indexForEach: Int
    @Binding var selectedIndexPage: Int
    @Binding var selectedIndexTab: Int
    @Binding var dataTab_4: [TypeVehicle]
    @Binding var date: Date
    @Binding var valueIndex: Int
    @Binding var valueName: String
    @Binding var labelDatePicker: String
    @Binding var isChangeColor: Bool
    @Binding var isShowDatePicker: Bool
    @Binding var initValue: Int

    @State var temp_date = Date()
    @State var temp_valueIndex = 0
    @State var yearAmount = ["1 năm", "2 năm", "3 năm", "4 năm", "5 năm", "6 năm", "7 năm", "8 năm", "9 năm", "10 năm"]

    var body: some View {
        ZStack {
            if isShowDatePicker {
                Text("").onAppear {
                    if self.selectedIndexPage == 7 {
                        self.temp_date = self.dataTab_4[self.indexForEach].date
                    } else {
                        self.temp_date = self.date
                        if self.selectedIndexPage == 2 && self.selectedIndexTab == 4 {
                            self.temp_valueIndex = self.valueIndex
                        }
                    }
                }
            } else {
                Text("").onAppear {
                    self.temp_date = Date()
                    self.temp_valueIndex = 0
                }
            }
            VStack {
                Spacer()
                ZStack (alignment: .top) {
                    if selectedIndexPage == 2 && selectedIndexTab == 4 {
                        Picker(selection: $temp_valueIndex, label: EmptyView()) {
                            ForEach(0 ..< yearAmount.count) {
                                TextCustom(text: self.yearAmount[$0], font: MEDIUM, size: 16, color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1))
                            }.labelsHidden()
                        }.frame(width: W(
                            FULL_H == H_SE && FULL_W == W_SE ? 110: // iPhone SE 1st generation
                            FULL_H == H_8 && FULL_W == W_8 ? 110: // iPhone 8 && iPhone SE 2nd generation
                            FULL_H == H_8Plus && FULL_W == W_8Plus ? 110: // iPhone 8 Plus
                            FULL_H == H_11 && FULL_W == W_11 ? 110: // iPhone 11 && iPhone 11 Pro Max
                            FULL_H == H_11Pro && FULL_W == W_11Pro ? 110 : 0 // iPhone 11 Pro
                            ), height: H(
                                FULL_H == H_SE && FULL_W == W_SE ? 110: // iPhone SE 1st generation
                                FULL_H == H_8 && FULL_W == W_8 ? 110: // iPhone 8 && iPhone SE 2nd generation
                                FULL_H == H_8Plus && FULL_W == W_8Plus ? 110: // iPhone 8 Plus
                                FULL_H == H_11 && FULL_W == W_11 ? 110: // iPhone 11 && iPhone 11 Pro Max
                                FULL_H == H_11Pro && FULL_W == W_11Pro ? 110 : 0 // iPhone 11 Pro
                            )).background(Color.white)
                            .scaleEffect(
                                FULL_H == H_SE && FULL_W == W_SE ? 0.8: // iPhone SE 1st generation
                                FULL_H == H_8 && FULL_W == W_8 ? 1.15: // iPhone 8 && iPhone SE 2nd generation
                                FULL_H == H_8Plus && FULL_W == W_8Plus ? 1: // iPhone 8 Plus
                                FULL_H == H_11 && FULL_W == W_11 ? 1.4: // iPhone 11 && iPhone 11 Pro Max
                                FULL_H == H_11Pro && FULL_W == W_11Pro ? 1 : 0 // iPhone 11 Pro
                            ).offset(y: H(
                                FULL_H == H_SE && FULL_W == W_SE ? 145: // iPhone SE 1st generation
                                FULL_H == H_8 && FULL_W == W_8 ? 145: // iPhone 8 && iPhone SE 2nd generation
                                FULL_H == H_8Plus && FULL_W == W_8Plus ? 145: // iPhone 8 Plus
                                FULL_H == H_11 && FULL_W == W_11 ? 145: // iPhone 11 && iPhone 11 Pro Max
                                FULL_H == H_11Pro && FULL_W == W_11Pro ? 145 : 0 // iPhone 11 Pro
                                    ))
                    } else {
                        DatePicker(selection: $temp_date, displayedComponents: .date) {
                            EmptyView()
                        }.environment(\.locale, Locale.init(identifier: "vi_VN"))
                            .frame(width: W(
                                FULL_H == H_SE && FULL_W == W_SE ? 110: // iPhone SE 1st generation
                                FULL_H == H_8 && FULL_W == W_8 ? 110: // iPhone 8 && iPhone SE 2nd generation
                                FULL_H == H_8Plus && FULL_W == W_8Plus ? 110: // iPhone 8 Plus
                                FULL_H == H_11 && FULL_W == W_11 ? 110: // iPhone 11 && iPhone 11 Pro Max
                                FULL_H == H_11Pro && FULL_W == W_11Pro ? 110 : 0 // iPhone 11 Pro
                                    ), height: H(
                                    FULL_H == H_SE && FULL_W == W_SE ? 110: // iPhone SE 1st generation
                                    FULL_H == H_8 && FULL_W == W_8 ? 110: // iPhone 8 && iPhone SE 2nd generation
                                    FULL_H == H_8Plus && FULL_W == W_8Plus ? 110: // iPhone 8 Plus
                                    FULL_H == H_11 && FULL_W == W_11 ? 110: // iPhone 11 && iPhone 11 Pro Max
                                    FULL_H == H_11Pro && FULL_W == W_11Pro ? 110 : 0 // iPhone 11 Pro
                                    )).background(Color.white)
                            .scaleEffect(
                                FULL_H == H_SE && FULL_W == W_SE ? 0.8: // iPhone SE 1st generation
                                FULL_H == H_8 && FULL_W == W_8 ? 1: // iPhone 8 && iPhone SE 2nd generation
                                FULL_H == H_8Plus && FULL_W == W_8Plus ? 1: // iPhone 8 Plus
                                FULL_H == H_11 && FULL_W == W_11 ? 1.1: // iPhone 11 && iPhone 11 Pro Max
                                FULL_H == H_11Pro && FULL_W == W_11Pro ? 1 : 0 // iPhone 11 Pro
                            ).offset(y: H(
                                FULL_H == H_SE && FULL_W == W_SE ? 145: // iPhone SE 1st generation
                                FULL_H == H_8 && FULL_W == W_8 ? 145: // iPhone 8 && iPhone SE 2nd generation
                                FULL_H == H_8Plus && FULL_W == W_8Plus ? 145: // iPhone 8 Plus
                                FULL_H == H_11 && FULL_W == W_11 ? 145: // iPhone 11 && iPhone 11 Pro Max
                                FULL_H == H_11Pro && FULL_W == W_11Pro ? 145 : 0 // iPhone 11 Pro
                                    ))
                    }
                    VStack(spacing: 0) {
                        Rectangle()
                            .frame(width: W(74), height: W(4))
                            .foregroundColor(.init(#colorLiteral(red: 0.5111798048, green: 0.3070217371, blue: 0.7141162753, alpha: 1)))
                            .padding(.top, H(8))
                        ZStack {
                            HStack {
                                Button(action: {
                                    self.isShowDatePicker = false
                                    self.isChangeColor = false
                                }) {
                                    TextCustom(text: NSLocalizedString("project_ground_plan_popup_cancel", comment: ""), font: REGULAR, size: 18, color: #colorLiteral(red: 0.4038758278, green: 0.4039486051, blue: 0.403865695, alpha: 1))
                                }.buttonStyle(ButtonTapScale())
                                Spacer()
                            }
                            TextCustom(text: NSLocalizedString(labelDatePicker, comment: "").lowercased().firstUppercased, font: MEDIUM, size: 22, lineLimit: 1, color: #colorLiteral(red: 0.1363612413, green: 0.1216128543, blue: 0.1213363782, alpha: 1))
                                .frame(width: FULL_W - 60 - 30 - 60)
                            HStack {
                                Spacer()
                                Button(action: {
                                    if self.selectedIndexPage == 2 && self.selectedIndexTab == 4 {
                                        self.valueIndex = self.temp_valueIndex
                                        self.valueName = self.yearAmount[self.temp_valueIndex]
                                        self.initValue += 1
                                    } else {
                                        if self.selectedIndexPage == 7 {
                                            self.dataTab_4[self.indexForEach].date = self.temp_date
                                            self.dataTab_4[self.indexForEach].initValueDate += 1
                                        } else {
                                            self.date = self.temp_date
                                            self.initValue += 1
                                        }
                                    }
                                    self.isShowDatePicker = false
                                    self.isChangeColor = false
                                }) {
                                    TextCustom(text: NSLocalizedString("project_ground_plan_popup_done", comment: ""), font: MEDIUM, size: 18, color: #colorLiteral(red: 0.4205850065, green: 0.1838403046, blue: 0.6598007083, alpha: 1))
                                }.buttonStyle(ButtonTapScale())
                            }
                        }.padding(.top, H(12))
                            .padding(.horizontal, 30)
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.init(#colorLiteral(red: 0.8077571988, green: 0.8078939915, blue: 0.8077381253, alpha: 1)))
                            .padding(.top, H(14))
                        Spacer()
                    }
                }.frame(width: FULL_W, height: H(344))
                    .background(Color.white.cornerRadius(5))
            }.edgesIgnoringSafeArea(.bottom)
                .offset(y: isShowDatePicker ? 0 : H(500))
                .animation(.easeInOut(duration: 0.2))
        }
    }
}
