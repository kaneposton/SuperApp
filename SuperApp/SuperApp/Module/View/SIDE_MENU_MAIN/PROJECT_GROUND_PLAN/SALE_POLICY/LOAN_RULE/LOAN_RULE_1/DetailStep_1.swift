// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import SwiftUI

struct DetailStep_1: View {
    @Binding var selectedMethod: CGFloat
    @Binding var isNext: Bool

    @State var bankIndex: CGFloat = 0
    @State var bankIndexSelect: CGFloat = 0
    @State var viewStatePictureBank = CGSize.zero
    @State var viewStatePictureLoan = CGSize.zero
    @State var saveWidthBank: CGFloat = 0
    @State var saveWidthLoan: CGFloat = 0
    @State var flagInfoProduct = false
    @State var loanIndexSelect: CGFloat = 0

    @State var spaceBank: CGFloat =
        FULL_H == H_SE && FULL_W == W_SE ? 215: // iPhone SE 1st generation
    FULL_H == H_8 && FULL_W == W_8 ? 255: // iPhone 8 && iPhone SE 2nd generation
    FULL_H == H_8Plus && FULL_W == W_8Plus ? 265: // iPhone 8 Plus
    FULL_H == H_11 && FULL_W == W_11 ? 265: // iPhone 11 && iPhone 11 Pro Max
    FULL_H == H_11Pro && FULL_W == W_11Pro ? 265 : 0 // iPhone 11 Pro

    @State var spaceMethod: CGFloat =
        FULL_H == H_SE && FULL_W == W_SE ? 122: // iPhone SE 1st generation
    FULL_H == H_8 && FULL_W == W_8 ? 142: // iPhone 8 && iPhone SE 2nd generation
    FULL_H == H_8Plus && FULL_W == W_8Plus ? 162: // iPhone 8 Plus
    FULL_H == H_11 && FULL_W == W_11 ? 162: // iPhone 11 && iPhone 11 Pro Max
    FULL_H == H_11Pro && FULL_W == W_11Pro ? 142 : 0 // iPhone 11 Pro

    @State var arrImageBankDetail = [
        imageListArrDetail(imageName: "thiet-ke-lo-go-sao-kim-13", index: 0),
        imageListArrDetail(imageName: "thiet-ke-lo-go-sao-kim-13", index: 1),
        imageListArrDetail(imageName: "thiet-ke-lo-go-sao-kim-13", index: 2),
        imageListArrDetail(imageName: "thiet-ke-lo-go-sao-kim-13", index: 3)
    ]

    @State var arrImageLoanDetail = [
        imageLoanListArrDetail(index: 0, text: "sale_policy_loan_text_image1"),
        imageLoanListArrDetail(index: 1, text: "sale_policy_loan_text_image2"),
        imageLoanListArrDetail(index: 2, text: "sale_policy_loan_text_image3")
    ]

    var body: some View {
        VStack (spacing: 0) {
            VStack(spacing: 0) {
                //MARK: LIST BANK
                VStack(alignment: .leading, spacing: 0) {
                    TextCustom(text: NSLocalizedString("sale_policy_list_bank", comment: ""), size: 16, color: #colorLiteral(red: 0.4263509512, green: 0.1872772872, blue: 0.6715394855, alpha: 1))
                        .padding(.top, H(20))
                        .padding(.leading, 14)
                    HStack {
                        Spacer()
                        ZStack {
                            ForEach(arrImageBankDetail, id: \.self) { data in
                                ImageScrollBank(data: data, pictureIndex: self.$bankIndexSelect)
                            }
                        }.animation(.easeInOut(duration: 0.2))
                            .frame(height:
                                    FULL_H == H_SE && FULL_W == W_SE ? 138: // iPhone SE 1st generation
                                FULL_H == H_8 && FULL_W == W_8 ? 168: // iPhone 8 && iPhone SE 2nd generation
                                FULL_H == H_8Plus && FULL_W == W_8Plus ? 178: // iPhone 8 Plus
                                FULL_H == H_11 && FULL_W == W_11 ? 178: // iPhone 11 && iPhone 11 Pro Max
                                FULL_H == H_11Pro && FULL_W == W_11Pro ? 178 : 0 // iPhone 11 Pro
                            ).offset(x: self.viewStatePictureBank.width)
                            .gesture(
                                DragGesture()
                                    .onChanged({ Value in
                                        self.viewStatePictureBank.width = Value.translation.width + self.saveWidthBank
                                    })
                                    .onEnded({ Value in
                                        // MARK: SWIPE <-
                                        if self.viewStatePictureBank.width < -self.spaceBank * self.bankIndexSelect {
                                            if self.bankIndexSelect <
                                                CGFloat(integerLiteral: self.arrImageBankDetail.count - 1) {
                                                self.viewStatePictureBank.width = (-self.spaceBank * self.bankIndexSelect) - self.spaceBank
                                                self.bankIndexSelect += 1
                                            } else {
                                                self.viewStatePictureBank.width = (-self.spaceBank * self.bankIndexSelect)
                                            }
                                        }
                                        // MARK: SWIPE ->
                                        if self.viewStatePictureBank.width > (0 + (-self.spaceBank * self.bankIndexSelect)) {
                                            if self.bankIndexSelect > 0 {
                                                self.viewStatePictureBank.width = (-self.spaceBank * self.bankIndexSelect) + self.spaceBank
                                                self.bankIndexSelect -= 1
                                            } else {
                                                self.viewStatePictureBank.width = (-self.spaceBank * self.bankIndexSelect)
                                            }
                                        }
                                        self.saveWidthBank = self.viewStatePictureBank.width
                                    })
                            )
                        Spacer()
                    }.frame(width: FULL_W - 32)
                    HStack (spacing: 2) {
                        Spacer()
                        ForEach(arrImageBankDetail, id: \.self) { data in
                            rectangelSelected(
                                index: data.index,
                                indexSelected: self.$bankIndexSelect)
                        }
                        Spacer()
                    }.frame(width: FULL_W - 32)
                        .padding(.top, H(5.5))
                        .padding(.bottom, H(19.5))
                        .animation(.easeInOut(duration: 0.2))
                    HStack {
                        TextCustom(text: NSLocalizedString("sale_policy_info_product_buy", comment: ""), size: 16, color: #colorLiteral(red: 0.4263509512, green: 0.1872772872, blue: 0.6715394855, alpha: 1))
                            .padding(.leading, 14)
                        Spacer()
                        ZStack {
                            Button(action: {
                                self.flagInfoProduct.toggle()
                            }) {
                                ZStack {
                                    ZStack {
                                        Rectangle()
                                            .frame(width: W(18), height: W(16))
                                            .foregroundColor(.init(#colorLiteral(red: 0.9999127984, green: 1, blue: 0.9998814464, alpha: 1)))
                                            .cornerRadius(.infinity)
                                        ImageCustom(name: "backBlackMini", w: 15.3, h: 14)
                                    }.opacity(self.flagInfoProduct ? 1 : 0)
                                    ZStack {
                                        Rectangle()
                                            .frame(width: W(18), height: W(18))
                                            .foregroundColor(.init(#colorLiteral(red: 0.2501918972, green: 0.2942900062, blue: 0.4129446149, alpha: 1)))
                                            .cornerRadius(.infinity)
                                        TextCustom(text: "i", size: 14, color: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1))
                                    }.opacity(self.flagInfoProduct ? 0 : 1)
                                }
                            }.buttonStyle(ButtonTapScale())
                                .animation(.easeInOut(duration: 0.1))
                                .padding(.trailing, W(14))
                        }
                    }.padding(.bottom, H(17))
                        .frame(width: FULL_W - 32)
                    // MARK: INFOR PRODUCT LOAN
                    if flagInfoProduct { InforLoan() }
                }.background(Color.white)
                    .cornerRadius(0)
                    .shadow(color: Color.init(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.1574878961)), radius: 6, x: 0, y: 3)

                //MARK: METHOD LOAN
                VStack(alignment: .leading, spacing: 0) {
                    VStack (alignment: .leading, spacing: H(2)) {
                        TextCustom(text: NSLocalizedString("sale_policy_method_loan", comment: ""), size: 16, color: #colorLiteral(red: 0.4263509512, green: 0.1872772872, blue: 0.6715394855, alpha: 1))
                        TextCustom(text: NSLocalizedString("sale_policy_chose_loan", comment: ""), font: ITALIC, size: 14, color: #colorLiteral(red: 0.4835856557, green: 0.483658731, blue: 0.4835696816, alpha: 1))
                    }.padding(.top, H(20))
                        .padding(.leading, 14)
                    ZStack {
                        ForEach(arrImageLoanDetail, id: \.self) { data in
                            ImageScrollLoan(
                                data: data,
                                pictureIndex: self.$loanIndexSelect,
                                viewStatePictureLoan: self.$viewStatePictureLoan,
                                saveWidthLoan: self.$saveWidthLoan,
                                selectedMethod: self.$selectedMethod
                            )
                        }
                    }.animation(.easeInOut(duration: 0.2))
                        .frame(height:
                                FULL_H == H_SE && FULL_W == W_SE ? 73: // iPhone SE 1st generation
                            FULL_H == H_8 && FULL_W == W_8 ? 73: // iPhone 8 && iPhone SE 2nd generation
                            FULL_H == H_8Plus && FULL_W == W_8Plus ? 83: // iPhone 8 Plus
                            FULL_H == H_11 && FULL_W == W_11 ? 83: // iPhone 11 && iPhone 11 Pro Max
                            FULL_H == H_11Pro && FULL_W == W_11Pro ? 83 : 0 // iPhone 11 Pro
                        ).padding(.top, H(3))
                        .padding(.leading, 14)
                        .offset(x: self.viewStatePictureLoan.width)
                        .gesture(
                            DragGesture()
                                .onChanged({ Value in
                                    self.viewStatePictureLoan.width = Value.translation.width + self.saveWidthLoan
                                })
                                .onEnded({ Value in
                                    // MARK: SWIPE <-
                                    if self.viewStatePictureLoan.width < -self.spaceMethod * self.loanIndexSelect {
                                        if self.loanIndexSelect <
                                            CGFloat(integerLiteral: self.arrImageLoanDetail.count - 1) {
                                            self.viewStatePictureLoan.width = (-self.spaceMethod * self.loanIndexSelect) - self.spaceMethod
                                            self.loanIndexSelect += 1
                                        } else {
                                            self.viewStatePictureLoan.width = -self.spaceMethod * self.loanIndexSelect
                                        }
                                    }
                                    // MARK: SWIPE ->
                                    if self.viewStatePictureLoan.width > -self.spaceMethod * self.loanIndexSelect {
                                        if self.loanIndexSelect > 0 {
                                            self.viewStatePictureLoan.width = (-self.spaceMethod * self.loanIndexSelect) + self.spaceMethod
                                            self.loanIndexSelect -= 1
                                        } else {
                                            self.viewStatePictureLoan.width = -self.spaceMethod * self.loanIndexSelect
                                        }
                                    }
                                    self.saveWidthLoan = self.viewStatePictureLoan.width
                                })
                        )
                    HStack (spacing: 2) {
                        Spacer()
                        ForEach(arrImageLoanDetail, id: \.self) { data in
                            rectangelSelected(index: data.index, indexSelected: self.$loanIndexSelect)
                        }
                        Spacer()
                    }.frame(width: FULL_W - 32)
                        .padding(.bottom, H(20.5))
                        .animation(.easeInOut(duration: 0.2))
                    if selectedMethod != -1 {
                        VStack(alignment: .leading, spacing: H(14)) {
                            TextCustom(text: NSLocalizedString("sale_policy_interest", comment: ""), size: 18, color: #colorLiteral(red: 0.4263509512, green: 0.1872772872, blue: 0.6715394855, alpha: 1))
                            TextCustom(text: NSLocalizedString("sale_policy_text", comment: ""), font: REGULAR, size: 14, color: #colorLiteral(red: 0.1415808201, green: 0.1235596463, blue: 0.1233097687, alpha: 1))
                                .fixedSize(horizontal: false, vertical: true)
                                .lineSpacing(5)
                        }.padding(.horizontal, 14)
                            .padding(.bottom, H(16))
                    }
                }.background(Color.init(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                    .cornerRadius(0)
                    .shadow(color: Color.init(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.1574878961)), radius: 6, x: 0, y: 3)
                    .padding(.top, H(30))
            }.padding(.vertical, H(30))
                .padding(.horizontal, 16)
                .animation(.easeInOut(duration: 0.1))
            Button(action: {
                self.isNext = true
            }) {
                ZStack {
                    TextCustom(text: NSLocalizedString("sale_policy_next", comment: ""), font: MEDIUM, size: 16, color: .white)
                }.frame(width: FULL_W - 32, height: H(40))
                    .background(Color.init(#colorLiteral(red: 0.4281106591, green: 0.1894766092, blue: 0.6721540093, alpha: 1)))
                    .cornerRadius(4)
                    .shadow(color: Color.init(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.4005511558)), radius: 6, x: 3, y: 3)
            }.buttonStyle(ButtonTapScale())
                .animation(.easeInOut(duration: 0.1))
                .padding(.bottom, H(35))
        }
    }
}

struct InforLoan: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            TextCustom(text: NSLocalizedString("sale_policy_info_header", comment: ""), size: 16, color: #colorLiteral(red: 0.1415808201, green: 0.1235596463, blue: 0.1233097687, alpha: 1))
                .padding(.bottom, H(16))
            VStack(alignment: .leading, spacing: H(8)) {
                TextCustom(text: NSLocalizedString("sale_policy_info_text1", comment: ""), font: REGULAR, size: 16, color: #colorLiteral(red: 0.1415808201, green: 0.1235596463, blue: 0.1233097687, alpha: 1))
                    .padding(.leading, W(14))
                TextCustom(text: NSLocalizedString("sale_policy_info_text2", comment: ""), font: REGULAR, size: 16, color: #colorLiteral(red: 0.1415808201, green: 0.1235596463, blue: 0.1233097687, alpha: 1))
                    .padding(.leading, W(14))
                HStack (spacing: 14) {
                    Rectangle()
                        .foregroundColor(.init(#colorLiteral(red: 0.2501918972, green: 0.2942900062, blue: 0.4129446149, alpha: 1)))
                        .frame(width: W(6), height: W(6))
                        .cornerRadius(.infinity)
                    TextCustom(text: NSLocalizedString("sale_policy_info_text3", comment: ""), font: REGULAR, size: 16, color: #colorLiteral(red: 0.1415808201, green: 0.1235596463, blue: 0.1233097687, alpha: 1))
                }.padding(.leading, 11)
                HStack (spacing: 14) {
                    Rectangle()
                        .foregroundColor(.init(#colorLiteral(red: 0.2501918972, green: 0.2942900062, blue: 0.4129446149, alpha: 1)))
                        .frame(width: W(6), height: W(6))
                        .cornerRadius(.infinity)
                    TextCustom(text: NSLocalizedString("sale_policy_info_text4", comment: ""), font: REGULAR, size: 16, color: #colorLiteral(red: 0.1415808201, green: 0.1235596463, blue: 0.1233097687, alpha: 1))
                }.padding(.leading, 11)
                HStack (alignment: .top, spacing: 14) {
                    Rectangle()
                        .foregroundColor(.init(#colorLiteral(red: 0.2501918972, green: 0.2942900062, blue: 0.4129446149, alpha: 1)))
                        .frame(width: W(6), height: W(6))
                        .cornerRadius(.infinity)
                        .offset(y: H(4))
                    TextCustom(text: NSLocalizedString("sale_policy_info_text5", comment: ""), font: REGULAR, size: 16, color: #colorLiteral(red: 0.1415808201, green: 0.1235596463, blue: 0.1233097687, alpha: 1))
                        .fixedSize(horizontal: false, vertical: true)
                }.padding(.leading, 11)
                HStack (spacing: 14) {
                    Rectangle()
                        .foregroundColor(.init(#colorLiteral(red: 0.2501918972, green: 0.2942900062, blue: 0.4129446149, alpha: 1)))
                        .frame(width: W(6), height: W(6))
                        .cornerRadius(.infinity)
                    TextCustom(text: NSLocalizedString("sale_policy_info_text6", comment: ""), font: REGULAR, size: 16, color: #colorLiteral(red: 0.1415808201, green: 0.1235596463, blue: 0.1233097687, alpha: 1))
                }.padding(.leading, 11)
            }
        }.padding(.horizontal, 14)
            .padding(.bottom, H(27))
    }
}

struct SalePolicyCustomImage: View {
    @State var step = 1
    var imageName: String
    var index = 1

    var body: some View {
        ZStack {
            Rectangle()
                .frame(width: W(44), height: W(44))
                .foregroundColor(.init(step >= index ? #colorLiteral(red: 0.4281106591, green: 0.1894766092, blue: 0.6721540093, alpha: 1): .white))
                .cornerRadius(.infinity)
                .overlay(RoundedRectangle(cornerRadius: .infinity).stroke(Color.init(step >= index ? #colorLiteral(red: 0.4281106591, green: 0.1894766092, blue: 0.6721540093, alpha: 1): #colorLiteral(red: 0.8494536281, green: 0.7708377838, blue: 0.9335261583, alpha: 1)), lineWidth: 1.5))
            ImageCustom(name: imageName.isEmpty ? "EmptyPicture" : imageName,
                w: imageName == "stepCheck" ? 45 : index == 1 ? 22.5 : index == 2 ? 19.7 : 27,
                h: imageName == "stepCheck" ? 45 : index == 1 ? 17.5 : index == 2 ? 22.5 : 18)
        }
    }
}

struct ImageScrollBank: View {
    @State var data = imageListArrDetail(imageName: "", index: 0)
    @Binding var pictureIndex: CGFloat

    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(.init(#colorLiteral(red: 0.9379842281, green: 0.9319354296, blue: 0.9317016006, alpha: 1)))
                .frame(
                    width:
                        FULL_H == H_SE && FULL_W == W_SE ? 210: // iPhone SE 1st generation
                    FULL_H == H_8 && FULL_W == W_8 ? 250: // iPhone 8 && iPhone SE 2nd generation
                    FULL_H == H_8Plus && FULL_W == W_8Plus ? 260: // iPhone 8 Plus
                    FULL_H == H_11 && FULL_W == W_11 ? 260: // iPhone 11 && iPhone 11 Pro Max
                    FULL_H == H_11Pro && FULL_W == W_11Pro ? 260 : 0 // iPhone 11 Pro
                    , height:
                        FULL_H == H_SE && FULL_W == W_SE ? 110: // iPhone SE 1st generation
                    FULL_H == H_8 && FULL_W == W_8 ? 140: // iPhone 8 && iPhone SE 2nd generation
                    FULL_H == H_8Plus && FULL_W == W_8Plus ? 150: // iPhone 8 Plus
                    FULL_H == H_11 && FULL_W == W_11 ? 150: // iPhone 11 && iPhone 11 Pro Max
                    FULL_H == H_11Pro && FULL_W == W_11Pro ? 150 : 0 // iPhone 11 Pro
                )
        }.cornerRadius(4)
            .offset(y: pictureIndex == data.index ? 0:
                    FULL_H == H_SE && FULL_W == W_SE ? 6: // iPhone SE 1st generation
                FULL_H == H_8 && FULL_W == W_8 ? 8: // iPhone 8 && iPhone SE 2nd generation
                FULL_H == H_8Plus && FULL_W == W_8Plus ? 8: // iPhone 8 Plus
                FULL_H == H_11 && FULL_W == W_11 ? 8: // iPhone 11 && iPhone 11 Pro Max
                FULL_H == H_11Pro && FULL_W == W_11Pro ? 8 : 0 // iPhone 11 Pro
            )
            .scaleEffect(pictureIndex == data.index ? 1 : 0.9)
            .offset(x:
                    FULL_H == H_SE && FULL_W == W_SE ? 215 * data.index: // iPhone SE 1st generation
                FULL_H == H_8 && FULL_W == W_8 ? 255 * data.index: // iPhone 8 && iPhone SE 2nd generation
                FULL_H == H_8Plus && FULL_W == W_8Plus ? 265 * data.index: // iPhone 8 Plus
                FULL_H == H_11 && FULL_W == W_11 ? 265 * data.index: // iPhone 11 && iPhone 11 Pro Max
                FULL_H == H_11Pro && FULL_W == W_11Pro ? 265 * data.index : 0 // iPhone 11 Pro
            )
    }
}

struct ImageScrollLoan: View {
    @State var data = imageLoanListArrDetail(index: 0, text: "")
    @Binding var pictureIndex: CGFloat
    @Binding var viewStatePictureLoan: CGSize
    @Binding var saveWidthLoan: CGFloat
    @Binding var selectedMethod: CGFloat

    var body: some View {
        ZStack {
            ZStack {
                Rectangle()
                    .foregroundColor(.clear)
                    .background(LinearGradient(gradient: Gradient(colors: [.init(#colorLiteral(red: 0.4274509804, green: 0.1882352941, blue: 0.6705882353, alpha: 1)), .init(#colorLiteral(red: 0.2901960784, green: 0.231372549, blue: 0.8, alpha: 1))]), startPoint: .top, endPoint: .bottom))
                    .opacity(selectedMethod == data.index ? 1 : 0)
                Rectangle()
                    .foregroundColor(.clear)
                    .background(Color.white)
                    .opacity(selectedMethod == data.index ? 0 : 1)
            }
            ZStack {
                HStack (alignment: .bottom) {
                    TextCustom(text: NSLocalizedString(data.text, comment: ""), font: MEDIUM, size: 15, color: .white)
                        .opacity(selectedMethod == data.index ? 1 : 0)
                        .padding(.leading, 10)
                    Spacer()
                    ImageCustom(name: "moneyBagWhite", w: 30, h: 28)
                        .padding(.trailing, 10)
                }.opacity(selectedMethod == data.index ? 1 : 0)
                HStack (alignment: .bottom) {
                    TextCustom(text: NSLocalizedString(data.text, comment: ""), font: MEDIUM, size: 15, color: #colorLiteral(red: 0.4281106591, green: 0.1894766092, blue: 0.6721540093, alpha: 1))
                        .padding(.leading, 10)
                    Spacer()
                    ImageCustom(name: "moneyBagPurple", w: 30, h: 28)
                        .padding(.trailing, 10)
                }.opacity(selectedMethod == data.index ? 0 : 1)
            }
        }.cornerRadius(4)
            .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.init(selectedMethod == data.index ? #colorLiteral(red: 0.4281106591, green: 0.1894766092, blue: 0.6721540093, alpha: 1): #colorLiteral(red: 0.9200527072, green: 0.8800705075, blue: 0.9638360143, alpha: 1)), lineWidth: 1))
            .frame(width:
                    FULL_H == H_SE && FULL_W == W_SE ? 110: // iPhone SE 1st generation
                FULL_H == H_8 && FULL_W == W_8 ? 130: // iPhone 8 && iPhone SE 2nd generation
                FULL_H == H_8Plus && FULL_W == W_8Plus ? 150: // iPhone 8 Plus
                FULL_H == H_11 && FULL_W == W_11 ? 150: // iPhone 11 && iPhone 11 Pro Max
                FULL_H == H_11Pro && FULL_W == W_11Pro ? 130 : 0 // iPhone 11 Pro
                , height:
                    FULL_H == H_SE && FULL_W == W_SE ? 53: // iPhone SE 1st generation
                FULL_H == H_8 && FULL_W == W_8 ? 53: // iPhone 8 && iPhone SE 2nd generation
                FULL_H == H_8Plus && FULL_W == W_8Plus ? 63: // iPhone 8 Plus
                FULL_H == H_11 && FULL_W == W_11 ? 63: // iPhone 11 && iPhone 11 Pro Max
                FULL_H == H_11Pro && FULL_W == W_11Pro ? 63 : 0 // iPhone 11 Pro
            ).offset(x:
                    FULL_H == H_SE && FULL_W == W_SE ? 122 * data.index: // iPhone SE 1st generation
                FULL_H == H_8 && FULL_W == W_8 ? 142 * data.index: // iPhone 8 && iPhone SE 2nd generation
                FULL_H == H_8Plus && FULL_W == W_8Plus ? 162 * data.index: // iPhone 8 Plus
                FULL_H == H_11 && FULL_W == W_11 ? 162 * data.index: // iPhone 11 && iPhone 11 Pro Max
                FULL_H == H_11Pro && FULL_W == W_11Pro ? 142 * data.index : 0 // iPhone 11 Pro
            ).onTapGesture {
                if self.selectedMethod != self.data.index {
                    if (self.selectedMethod == 0 || self.selectedMethod == 1) && self.pictureIndex == 0 && self.data.index >= 2 {
                        self.selectedMethod = self.data.index
                        self.pictureIndex = self.data.index

                        self.viewStatePictureLoan.width =
                            FULL_H == H_SE && FULL_W == W_SE ? -122 * self.pictureIndex: // iPhone SE 1st generation
                        FULL_H == H_8 && FULL_W == W_8 ? -142 * self.pictureIndex: // iPhone 8 && iPhone 2nd generation
                        FULL_H == H_8Plus && FULL_W == W_8Plus ? -162 * self.pictureIndex: // iPhone 8 Plus
                        FULL_H == H_11 && FULL_W == W_11 ? -162 * self.pictureIndex: // iPhone 11 && iPhone 11 Pro Max
                        FULL_H == H_11Pro && FULL_W == W_11Pro ? -142 * self.pictureIndex : 0 // iPhone 11 Pro

                        self.saveWidthLoan = self.viewStatePictureLoan.width
                    } else {
                        self.selectedMethod = self.data.index
                    }
                }
        }
    }
}

struct rectangelSelected: View {
    @State var index: CGFloat
    @Binding var indexSelected: CGFloat

    var body: some View {
        Rectangle()
            .frame(width: indexSelected == index ? W(20) : W(6), height: W(6), alignment: .leading)
            .foregroundColor(.init(indexSelected == index ? #colorLiteral(red: 0.4263509512, green: 0.1872772872, blue: 0.6715394855, alpha: 1): #colorLiteral(red: 0.6705882353, green: 0.6705882353, blue: 0.6705882353, alpha: 1)))
            .cornerRadius(W(6) / 2)
    }
}

struct imageLoanListArrDetail: Identifiable, Hashable {
    var id = UUID()
    var index: CGFloat
    var text: String
}

struct ShowNextFailed: View {
    @Binding var isChangeColor: Bool
    @Binding var showNextFailed: Bool
    @Binding var typeAlert: Int

    var body: some View {
        VStack {
            Spacer()
            ZStack (alignment: .topTrailing) {
                VStack(spacing: 0) {
                    Rectangle()
                        .foregroundColor(.clear)
                        .frame(width: 1, height: H(
                            FULL_H == H_SE && FULL_W == W_SE ? 13: // iPhone SE 1st generation
                            FULL_H == H_8 && FULL_W == W_8 ? 13: // iPhone 8 && iPhone SE 2nd generation
                            FULL_H == H_8Plus && FULL_W == W_8Plus ? 14: // iPhone 8 Plus
                            FULL_H == H_11 && FULL_W == W_11 ? 11: // iPhone 11 && iPhone 11 Pro Max
                            FULL_H == H_11Pro && FULL_W == W_11Pro ? 11 : 0)// iPhone 11 Pro
                        )
                    ImageCustom(name: "iconIonicIosCloseCircle", w: 65, h: 65)
                        .padding(.bottom, H(9))
                        .offset(x: -0.5)
                    TextCustom(text: NSLocalizedString(typeAlert == 0 ? "sale_policy_step2_youNeedRefill" : "sale_policy_step2_requireMinRent", comment: ""), font: REGULAR, size: 14, color: #colorLiteral(red: 0.3842699528, green: 0.384339571, blue: 0.3842601776, alpha: 1))
                        .lineSpacing(5)
                        .multilineTextAlignment(.center)
                        .fixedSize(horizontal: false, vertical: true)
                        .padding(.horizontal, 33)
                        .padding(.bottom, H(24))
                    Button(action: {
                        self.isChangeColor = false
                        self.showNextFailed = false
                    }) {
                        ZStack {
                            Rectangle()
                                .cornerRadius(4)
                                .foregroundColor(.init(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)))
                                .frame(width: FULL_W - 72, height: H(40))
                                .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.init(#colorLiteral(red: 0.4282599092, green: 0.1879977882, blue: 0.6717798114, alpha: 1)), lineWidth: 1))
                            TextCustom(text: NSLocalizedString("login_close", comment: ""), font: MEDIUM, size: 16, color: #colorLiteral(red: 0.4282599092, green: 0.1879977882, blue: 0.6717798114, alpha: 1))
                        }
                    }.buttonStyle(ButtonTapScale())
                        .animation(.easeInOut(duration: 0.1))
                }.padding(.bottom, H(26))
                    .background(
                        Image("union150")
                            .resizable()
                            .frame(width: FULL_W - 42)
                            .shadow(color: .init(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.2016802226)), radius: 6)
                    )
            }
            Spacer()
        }.opacity(showNextFailed ? 1 : 0)
            .scaleEffect(showNextFailed ? 1 : 0.1)
            .animation(.easeInOut(duration: 0.2))
    }
}
