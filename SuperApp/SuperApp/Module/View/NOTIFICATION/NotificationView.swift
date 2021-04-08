// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import SwiftUI

struct NotificationModel {
    var id: Int
    var iconImage: String
    var titleNot: String
    var dayAndTime: String
    var isSeen: Bool
}

struct NotificationView: View {
    @Binding var isShowPopupNoti: Bool
    @Binding var contentNoti: String
    @Binding var selectedRowNoti: Int
    @Binding var deleteNotiID: Int
    @Binding var canUseArrNoti: Bool
    @Binding var imageNameNoti: String
    @State var isShowing = false
    @State var isShowData = true

    @State var ArrNotifica = [
        NotificationModel(id: 0, iconImage: "news2", titleNot: "Dự án Royal Garden đã cập nhật thêm Chính sách bán hàng", dayAndTime: "Thứ Tư, 4:36 pm ngày 12/3/2020", isSeen: false),
        NotificationModel(id: 1, iconImage: "news1", titleNot: "Dự án Royal Garden đã cập nhật thêm Chính sách bán hàng", dayAndTime: "Thứ Tư, 4:36 pm ngày 12/3/2020", isSeen: false),
        NotificationModel(id: 2, iconImage: "news2", titleNot: "Dự án Royal Garden đã cập nhật thêm Chính sách bán hàng", dayAndTime: "Thứ Tư, 4:36 pm ngày 12/3/2020", isSeen: true),
        NotificationModel(id: 3, iconImage: "news3", titleNot: "Căn hộ chung cư cao cấp của Dự án Royal Garden đang mở bán lần 1 ", dayAndTime: "Thứ Tư, 4:36 pm ngày 12/3/2020", isSeen: false),
        NotificationModel(id: 4, iconImage: "news4", titleNot: "Dự án Royal Garden đã cập nhật thêm Chính sách bán hàng", dayAndTime: "Thứ Tư, 4:36 pm ngày 12/3/2020", isSeen: false),
        NotificationModel(id: 5, iconImage: "news1", titleNot: "Dự án Royal Garden đã cập nhật thêm Chính sách bán hàng", dayAndTime: "Thứ Tư, 4:36 pm ngày 12/3/2020", isSeen: true),
        NotificationModel(id: 6, iconImage: "news2", titleNot: "Dự án Royal Garden đã cập nhật thêm Chính sách bán hàng", dayAndTime: "Thứ Tư, 4:36 pm ngày 12/3/2020", isSeen: true),
        NotificationModel(id: 7, iconImage: "news4", titleNot: "Dự án Royal Garden đã cập nhật thêm Chính sách bán hàng", dayAndTime: "Thứ Tư, 4:36 pm ngày 12/3/2020", isSeen: true),
        NotificationModel(id: 8, iconImage: "news1", titleNot: "Dự án Royal Garden đã cập nhật thêm Chính sách bán hàng", dayAndTime: "Thứ Tư, 4:36 pm ngày 12/3/2020", isSeen: false),
        NotificationModel(id: 9, iconImage: "news2", titleNot: "Dự án Royal Garden đã cập nhật thêm Chính sách bán hàng", dayAndTime: "Thứ Tư, 4:36 pm ngày 12/3/2020", isSeen: false),
        NotificationModel(id: 0, iconImage: "news4", titleNot: "Dự án Royal Garden đã cập nhật thêm Chính sách bán hàng", dayAndTime: "Thứ Tư, 4:36 pm ngày 12/3/2020", isSeen: true),
    ]

    var body: some View {
        NavigationView {
            ZStack (alignment: .top) {
                if !canUseArrNoti {
                    Text("").onAppear {
                        for i in 0 ..< self.ArrNotifica.count {
                            if self.ArrNotifica[i].id == self.deleteNotiID {
                                self.ArrNotifica.remove(at: i)
                                break
                            }
                        }
                        self.canUseArrNoti = true
                        self.deleteNotiID = -1
                    }
                }
                VStack (alignment: .leading, spacing: 0) {
                    // MARK: NAVIGATION BAR
                    NavigationWhite(
                        isTapSearch: Binding.constant(false),
                        isLogin: Binding.constant(false),
                        isChangeColor: Binding.constant(false),
                        isOpenSideMenu: Binding.constant(false),
                        strSearch: Binding.constant(""),
                        isShowCalendar: Binding.constant(false),
                        isChooseValueDate: Binding.constant(false),
                        title: "notification_notify",
                        backFunc: { },
                        mapFunc: { },
                        filterFunc: { },
                        optionFunc: { },
                        callFunc: { },
                        textFunc: { },
                        isHaveOption: true)

                    // MARK: BODY
                    List {
                        if canUseArrNoti {
                            VStack (spacing: 0) {
                                if isShowData {
                                    HStack {
                                        TextCustom(text: NSLocalizedString("notification_newest", comment: ""), font: MEDIUM, size: 20, color: #colorLiteral(red: 0.1400775909, green: 0.1216219291, blue: 0.1212796792, alpha: 1))
                                            .padding(.leading, 20)
                                            .padding(.bottom, H(16))
                                        Spacer()
                                    }
                                    ForEach(ArrNotifica, id: \.id) { list in
                                        NotificationMessage(
                                            list: list,
                                            selectedRowNoti: self.$selectedRowNoti,
                                            isShowPopupNoti: self.$isShowPopupNoti,
                                            contentNoti: self.$contentNoti,
                                            imageNameNoti: self.$imageNameNoti)
                                    }
                                }
                            }.listRowInsets(EdgeInsets())
                                .background(Color.white)
                                .padding(.bottom, H(
                                    FULL_H == H_SE && FULL_W == W_SE ? 110: // iPhone SE 1st generation
                                    FULL_H == H_8 && FULL_W == W_8 ? 95: // iPhone 8 && iPhone SE 2nd generation
                                    FULL_H == H_8Plus && FULL_W == W_8Plus ? 87: // iPhone 8 Plus
                                    FULL_H == H_11 && FULL_W == W_11 ? 47: // iPhone 11 && iPhone 11 Pro Max
                                    FULL_H == H_11Pro && FULL_W == W_11Pro ? 54 : 0 // iPhone 11 Pro
                                        ))
                        }
                    }.padding(.top, H(29))
                        .background(PullToRefresh(action: {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    self.isShowData = false
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                        self.isShowData = true
                                        self.isShowing = false
                                    }
                                }
                        }, isShowing: self.$isShowing))
                }
            }.onAppear {
                UITableViewCell.appearance().backgroundColor = .white
                UITableView.appearance().backgroundColor = .white
                UITableView.appearance().separatorStyle = .none
                UITableView.appearance().showsVerticalScrollIndicator = false
            }.navigationBarBackButtonHidden(true)
                .navigationBarTitle("")
                .navigationBarHidden(true)
        }.navigationBarBackButtonHidden(true)
            .navigationBarTitle("")
            .navigationBarHidden(true)
    }
}

struct NotificationMessage: View {
    @State var list = NotificationModel(id: 0, iconImage: "", titleNot: "", dayAndTime: "", isSeen: false)
    @Binding var selectedRowNoti: Int
    @Binding var isShowPopupNoti: Bool
    @Binding var contentNoti: String
    @Binding var imageNameNoti: String

    var body: some View {
        HStack(alignment: .top, spacing: 0) {
            Button(action: {
                self.list.isSeen = true
            }) {
                HStack (alignment: .top, spacing: 0) {
                    if !list.iconImage.isEmpty {
                        ImageCustom(name: list.iconImage, w: 60, h: 60)
                            .clipShape(Circle())
                            .padding(.leading, 20)
                    } else {
                        Rectangle()
                            .foregroundColor(.init(#colorLiteral(red: 0.9111830592, green: 0.9112924337, blue: 0.9111458659, alpha: 1)))
                            .frame(width: W(60), height: W(60))
                            .cornerRadius(.infinity)
                            .padding(.leading, 20)
                    }
                    VStack(alignment: .leading, spacing: 0) {
                        TextCustom(text: list.titleNot, size: 14, lineLimit: 2, color: #colorLiteral(red: 0.1400775909, green: 0.1216219291, blue: 0.1212796792, alpha: 1))
                        Spacer()
                        TextCustom(text: list.dayAndTime, font: REGULAR, size: 12, lineLimit: 1, color: #colorLiteral(red: 0.6469889283, green: 0.6471001506, blue: 0.6469733715, alpha: 1))
                    }.padding(.leading, 20)
                        .frame(height: W(60))
                }
            }.buttonStyle(ButtonTapScale())
                .animation(.easeInOut(duration: 0.1))
            Spacer()
            Button(action: {
                self.contentNoti = self.list.titleNot
                self.isShowPopupNoti = true
                self.selectedRowNoti = self.list.id
                self.imageNameNoti = self.list.iconImage
            }) {
                ZStack (alignment: .top) {
                    ImageCustom(name: "EmptyPicture", w: 20, h: 20)
                    ImageCustom(name: "More", w: 10, h: 1.5)
                }
            }.buttonStyle(ButtonTapScale())
                .animation(.easeInOut(duration: 0.1))
                .padding(.trailing, 20).offset(y: H(8))
        }.padding(.vertical, H(15))
            .background(Color.init(self.list.isSeen ? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1): #colorLiteral(red: 0.9560366273, green: 0.9455776811, blue: 0.9819197059, alpha: 1)))
    }
}

struct ShowPopUpView: View {
    @Binding var isShowPopupNoti: Bool
    @Binding var contentNoti: String
    @Binding var selectedRowNoti: Int
    @Binding var deleteNotiID: Int
    @Binding var canUseArrNoti: Bool
    @Binding var imageNameNoti: String

    var body: some View {
        ZStack (alignment: .bottom) {
            Rectangle()
                .foregroundColor(.init(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.1740689212)))
                .edgesIgnoringSafeArea(.all)
                .opacity(isShowPopupNoti ? 1 : 0)
                .animation(.easeInOut(duration: 0.2))
                .onTapGesture {
                    self.isShowPopupNoti = false
            }
            VStack (spacing: 0) {
                VStack (spacing: 0) {
                    ImageCustom(name: imageNameNoti.isEmpty ? "EmptyPicture" : imageNameNoti, w: 60, h: 60)
                        .clipShape(Circle())
                        .padding(.top, H(19))
                    TextCustom(text: contentNoti, font: REGULAR, size: 14, lineLimit: 1, color: #colorLiteral(red: 0.6548312902, green: 0.6549437642, blue: 0.654815495, alpha: 1))
                        .padding(.top, H(19))
                        .padding(.bottom, H(4))
                        .padding(.horizontal, 19)
                    TextCustom(text: NSLocalizedString("notification_clickToView", comment: ""), font: REGULAR, size: 14, color: #colorLiteral(red: 0.6548312902, green: 0.6549437642, blue: 0.654815495, alpha: 1))
                }.padding(.bottom, H(29))
                Button(action: {
                    self.isShowPopupNoti = false
                    self.deleteNotiID = self.selectedRowNoti
                    self.canUseArrNoti = false
                }) {
                    HStack(spacing: 20) {
                        ImageCustom(name: "closed", w: 16, h: 16)
                        TextCustom(text: NSLocalizedString("notification_deleteNoti", comment: ""), font: MEDIUM, size: 14, color: #colorLiteral(red: 0.1361579299, green: 0.1177002117, blue: 0.1173581257, alpha: 1))
                        Spacer()
                    }
                }.buttonStyle(ButtonTapScale())
                    .animation(.easeInOut(duration: 0.2))
                    .padding(.leading, 19)
                    .padding(.bottom, H(19))
                Button(action: {
                    self.isShowPopupNoti = false
                    self.deleteNotiID = self.selectedRowNoti
                    self.canUseArrNoti = false
                }) {
                    HStack(spacing: 20) {
                        ImageCustom(name: "closed", w: 16, h: 16)
                        TextCustom(text: NSLocalizedString("notification_offNoti", comment: ""), font: MEDIUM, size: 14, color: #colorLiteral(red: 0.1361579299, green: 0.1177002117, blue: 0.1173581257, alpha: 1))
                        Spacer()
                    }
                }.buttonStyle(ButtonTapScale())
                    .animation(.easeInOut(duration: 0.2))
                    .padding(.leading, 19)
                    .padding(.bottom, H(40))
            }.background(Color.white)
                .offset(y: isShowPopupNoti ? 0 : H(300))
                .animation(.easeInOut(duration: 0.2))
        }.cornerRadius(0)
            .edgesIgnoringSafeArea(.all)
            .shadow(color: .init(#colorLiteral(red: 0.3738895939, green: 0.3738895939, blue: 0.3738895939, alpha: 0.8889126712)), radius: 3)
    }
}
