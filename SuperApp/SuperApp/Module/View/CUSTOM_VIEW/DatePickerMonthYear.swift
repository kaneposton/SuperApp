// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import SwiftUI

struct DatePickerMonthYear: View {
    @Binding var valueIndexMonth: Int
    @Binding var valueIndexYear: Int
    @Binding var valueName: String
    @Binding var isShowDatePicker: Bool
    @Binding var isChooseValueDate: Bool
    
    @State var temp_valueIndexMonth = 0
    @State var temp_valueIndexYear = 0

    @State var monthAmount = ["Một", "Hai", "Ba", "Bốn", "Năm", "Sáu", "Bảy", "Tám", "Chín", "Mười", "Mười một", "Mười hai"]
    @State var monthIntAmount = ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12"]
    @State var yearAmount = ["2000", "2001", "2002", "2003", "2004", "2005", "2006", "2007", "2008", "2009", "2010", "2011", "2012", "2013", "2014", "2015", "2016", "2017", "2018", "2019", "2020"]

    var body: some View {
        ZStack {
            if isShowDatePicker {
                Text("").onAppear {
                    self.temp_valueIndexMonth = self.valueIndexMonth
                    self.temp_valueIndexYear = self.valueIndexYear
                }
            } else {
                Text("").onAppear {
                    self.temp_valueIndexMonth = 0
                    self.temp_valueIndexYear = 0
                }
            }
            VStack {
                Spacer()
                ZStack (alignment: .top) {
                    ZStack {
                        HStack (spacing: 0) {
                            VStack (spacing: H(20)) {
                                TextCustom(text: NSLocalizedString("text_month", comment: ""), font: REGULAR, size: 17, color: #colorLiteral(red: 0.1999745965, green: 0.2000149786, blue: 0.1999689341, alpha: 1))
                                ZStack {
                                    Picker(selection: $temp_valueIndexMonth, label: EmptyView()) {
                                        ForEach(0 ..< monthAmount.count) {
                                            TextCustom(
                                                text: self.monthAmount[$0],
                                                font: Utils.getDateSelectFont(dataList: self.monthAmount, index: $0, selected: self.temp_valueIndexMonth),
                                                size: Utils.getDateSelectSize(dataList: self.monthAmount, index: $0, selected: self.temp_valueIndexMonth),
                                                color: Utils.getDateSelectColor(dataList: self.monthAmount, index: $0, selected: self.temp_valueIndexMonth)
                                            )
                                        }.labelsHidden()
                                    }
                                }.frame(width: FULL_W / 2 - 60, height: H(
                                    FULL_H == H_SE && FULL_W == W_SE ? 180: // iPhone SE 1st generation
                                    FULL_H == H_8 && FULL_W == W_8 ? 180: // iPhone 8 && iPhone SE 2nd generation
                                    FULL_H == H_8Plus && FULL_W == W_8Plus ? 170: // iPhone 8 Plus
                                    FULL_H == H_11 && FULL_W == W_11 ? 130: // iPhone 11 && iPhone 11 Pro Max
                                    FULL_H == H_11Pro && FULL_W == W_11Pro ? 130 : 0 // iPhone 11 Pro
                                    )).cornerRadius(0)
                                    .scaleEffect(1.1)
                            }
                            VStack (spacing: H(20)) {
                                TextCustom(text: NSLocalizedString("text_year", comment: ""), font: REGULAR, size: 17, color: #colorLiteral(red: 0.1999745965, green: 0.2000149786, blue: 0.1999689341, alpha: 1))
                                ZStack {
                                    Picker(selection: $temp_valueIndexYear, label: EmptyView()) {
                                        ForEach(0 ..< yearAmount.count) {
                                            TextCustom(
                                                text: self.yearAmount[$0],
                                                font: Utils.getDateSelectFont(dataList: self.yearAmount, index: $0, selected: self.temp_valueIndexYear),
                                                size: Utils.getDateSelectSize(dataList: self.yearAmount, index: $0, selected: self.temp_valueIndexYear),
                                                color: Utils.getDateSelectColor(dataList: self.yearAmount, index: $0, selected: self.temp_valueIndexYear)
                                            )
                                        }.labelsHidden()
                                    }
                                }.frame(width: FULL_W / 2 - 60, height: H(
                                    FULL_H == H_SE && FULL_W == W_SE ? 180: // iPhone SE 1st generation
                                    FULL_H == H_8 && FULL_W == W_8 ? 180: // iPhone 8 && iPhone SE 2nd generation
                                    FULL_H == H_8Plus && FULL_W == W_8Plus ? 170: // iPhone 8 Plus
                                    FULL_H == H_11 && FULL_W == W_11 ? 130: // iPhone 11 && iPhone 11 Pro Max
                                    FULL_H == H_11Pro && FULL_W == W_11Pro ? 130 : 0 // iPhone 11 Pro
                                    )).cornerRadius(0)
                                    .scaleEffect(1.1)
                            }
                        }
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.white)
                            .offset(y: H(
                                FULL_H == H_SE && FULL_W == W_SE ? -8: // iPhone SE 1st generation
                                FULL_H == H_8 && FULL_W == W_8 ? -4: // iPhone 8 && iPhone SE 2nd generation
                                FULL_H == H_8Plus && FULL_W == W_8Plus ? -2: // iPhone 8 Plus
                                FULL_H == H_11 && FULL_W == W_11 ? 2: // iPhone 11 && iPhone 11 Pro Max
                                FULL_H == H_11Pro && FULL_W == W_11Pro ? 0.5 : 0 // iPhone 11 Pro
                                    ))
                        Rectangle()
                            .frame(height: 1)
                            .foregroundColor(.white)
                            .offset(y: H(
                                FULL_H == H_SE && FULL_W == W_SE ? 48: // iPhone SE 1st generation
                                FULL_H == H_8 && FULL_W == W_8 ? 44: // iPhone 8 && iPhone SE 2nd generation
                                FULL_H == H_8Plus && FULL_W == W_8Plus ? 42: // iPhone 8 Plus
                                FULL_H == H_11 && FULL_W == W_11 ? 38: // iPhone 11 && iPhone 11 Pro Max
                                FULL_H == H_11Pro && FULL_W == W_11Pro ? 40 : 0 // iPhone 11 Pro
                                    ))
                    }.background(Color.white)
                        .offset(y: H(90))
                    VStack(spacing: 0) {
                        ZStack {
                            HStack {
                                Button(action: {
                                    self.isShowDatePicker = false
                                }) {
                                    TextCustom(text: NSLocalizedString("project_ground_plan_popup_cancel", comment: ""), font: REGULAR, size: 18, color: #colorLiteral(red: 0.4038758278, green: 0.4039486051, blue: 0.403865695, alpha: 1))
                                }.buttonStyle(ButtonTapScale())
                                Spacer()
                            }
                            TextCustom(text: NSLocalizedString("response_time", comment: "").lowercased().firstUppercased, font: MEDIUM, size: 22, lineLimit: 1, color: #colorLiteral(red: 0.1363612413, green: 0.1216128543, blue: 0.1213363782, alpha: 1))
                                .frame(width: FULL_W - 60 - 30 - 60)
                            HStack {
                                Spacer()
                                Button(action: {
                                    self.isChooseValueDate = true
                                    self.valueIndexMonth = self.temp_valueIndexMonth
                                    self.valueIndexYear = self.temp_valueIndexYear
                                    self.valueName = "\(self.monthIntAmount[self.temp_valueIndexMonth])/\(self.yearAmount[self.temp_valueIndexYear])"

                                    self.isShowDatePicker = false
                                }) {
                                    TextCustom(text: NSLocalizedString("repsonse_choose", comment: ""), font: MEDIUM, size: 18, color: #colorLiteral(red: 0.4205850065, green: 0.1838403046, blue: 0.6598007083, alpha: 1))
                                }.buttonStyle(ButtonTapScale())
                            }
                        }.padding(.top, H(20))
                            .padding(.horizontal, 30)
                        Rectangle()
                            .frame(width: FULL_W - 40, height: 1)
                            .foregroundColor(.init(#colorLiteral(red: 0.5293536186, green: 0.5294462442, blue: 0.5293406844, alpha: 1)))
                            .padding(.top, H(19))
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
