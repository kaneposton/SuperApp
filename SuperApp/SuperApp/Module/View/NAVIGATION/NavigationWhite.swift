// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import SwiftUI

struct NavigationWhite: View {
    @Binding var isTapSearch: Bool
    @Binding var isLogin: Bool
    @Binding var isChangeColor: Bool
    @Binding var isOpenSideMenu: Bool
    @Binding var strSearch: String
    @Binding var isShowCalendar: Bool
    @Binding var isChooseValueDate: Bool
    @State var title = ""
    @State var title_2 = ""
    let backFunc: () -> Void
    let mapFunc: () -> Void
    let filterFunc: () -> Void
    let optionFunc: () -> Void
    let callFunc: () -> Void
    let textFunc: () -> Void
    @State var isHome = false
    @State var isSearchTapAppear = false
    @State var isSearchAlwaysAppear = false
    @State var isHaveOption = false
    @State var isHideIconFilter = false
    @State var isCallAndTextWhite = false
    @State var isCallAndTextBlack = false
    @State var noCallAndText = false
    @State var isBack = false
    @State var isSearch = false
    @State var isHideSearchIcon = false
    @State var isResponse = false
    @State var isAddQuestion = false

    var body: some View {
        ZStack (alignment: .top) {
            if isBack {
                HStack (spacing: 0) {
                    ZStack {
                        Color.clear.frame(width: W(40), height: W(40))
                        Button(action: {
                            self.backFunc()
                        }) {
                            HStack (alignment: .top, spacing: 14) {
                                ImageCustom(name: "backWhite", w: 20, h: 11)
                                    .offset(y: H(10))
                                TextCustom(text: NSLocalizedString(title, comment: ""), size: 24, lineLimit: 1, color: .white)
                            }
                        }.buttonStyle(ButtonTapScale())
                            .animation(.easeInOut(duration: 0.1))
                    }
                    Spacer()
                }.frame(height: H(45))
                    .padding(.leading, 16)
            }
            if isCallAndTextWhite || isCallAndTextBlack {
                HStack (spacing: 0) {
                    Button(action: {
                        self.backFunc()
                    }) {
                        VStack (alignment: .leading, spacing: H(3)) {
                            HStack (alignment: .top, spacing: 14) {
                                ImageCustom(name: isCallAndTextBlack ? isChangeColor || isOpenSideMenu ? "backWhite" : "backBlack": "backWhite", w: 20, h: 11)
                                    .offset(y: H(10))
                                TextCustom(text: NSLocalizedString(title, comment: ""), size: 24, lineLimit: 1, color: isCallAndTextBlack ? isChangeColor || isOpenSideMenu ? .white: #colorLiteral(red: 0.1422221363, green: 0.1236664429, blue: 0.1232500449, alpha: 1): .white)
                                    .frame(height: H(24))
                            }
                            if !title_2.isEmpty && !title_2.isBlank {
                                TextCustom(text: title_2, font: MEDIUM, size: 18, lineLimit: 1, color: isCallAndTextBlack ? isChangeColor || isOpenSideMenu ? .white: #colorLiteral(red: 0.1422221363, green: 0.1236664429, blue: 0.1232500449, alpha: 1): .white)
                                    .padding(.leading, W(20) + 14)
                                    .frame(height: H(18))
                            }
                        }.background(Image("EmptyPicture").resizable())
                    }.buttonStyle(ButtonTapScale())
                        .animation(.easeInOut(duration: 0.1))
                    Spacer()
                    Button(action: {
                        self.callFunc()
                    }) {
                        ImageCustom(name: "callGreen", w: 40, h: 40)
                    }.buttonStyle(ButtonTapScale())
                        .animation(.easeInOut(duration: 0.1))
                        .padding(.trailing, 22)
                        .opacity(noCallAndText ? 0 : 1)
                    Button(action: {
                        self.textFunc()
                    }) {
                        ImageCustom(name: "textBlue", w: 40, h: 40)
                    }.buttonStyle(ButtonTapScale())
                        .animation(.easeInOut(duration: 0.1))
                        .padding(.trailing, 20)
                        .opacity(noCallAndText ? 0 : 1)
                }.frame(height: H(45))
                    .padding(.leading, 16)
            }
            if isHome {
                HStack (spacing: 0) {
                    Button(action: {
                        self.mapFunc()
                    }) {
                        ImageCustom(name: "mapBlack", w: 26, h: 26)
                    }.buttonStyle(ButtonTapScale())
                        .padding(.trailing, 30)
                    Button(action: {
                        self.filterFunc()
                    }) {
                        ImageCustom(name: "filterBlack", w: 20, h: 18)
                    }.buttonStyle(ButtonTapScale())
                    Spacer()
                    if isLogin {
                        Button(action: {

                        }) {
                            ZStack (alignment: .topTrailing) {
                                ZStack {
                                    ImageCustom(name: "EmptyPicture", w: 26, h: 26)
                                    ImageCustom(name: "notificationBlue", w: 20, h: 20)
                                }
                                ZStack {
                                    Rectangle()
                                        .cornerRadius(.infinity)
                                        .frame(width: W(16), height: W(16))
                                        .foregroundColor(.init(#colorLiteral(red: 0.4282599092, green: 0.1879977882, blue: 0.6717798114, alpha: 1)))
                                    TextCustom(text: "9+", size: 9, lineLimit: 1, color: .white)
                                }.offset(x: 5, y: -5)
                                    .opacity(0)
                            }
                        }.buttonStyle(ButtonTapScale())
                            .padding(.trailing, 24)
                    }
                    Button(action: {

                    }) {
                        ZStack (alignment: .topTrailing) {
                            ImageCustom(name: "iconCart", w: 26, h: 26)
                            ZStack {
                                Rectangle()
                                    .cornerRadius(.infinity)
                                    .frame(width: W(16), height: W(16))
                                    .foregroundColor(.init(#colorLiteral(red: 0.9133259654, green: 0.297054708, blue: 0.2958536744, alpha: 1)))
                                TextCustom(text: "9+", size: 9, lineLimit: 1, color: .white)
                            }.offset(x: 5, y: -5)
                                .opacity(0)
                        }
                    }.buttonStyle(ButtonTapScale())
                }.animation(.easeInOut(duration: 0.1))
                    .padding(.horizontal, 20)
                    .padding(.bottom, H(16))
            }
            if isHaveOption {
                HStack (spacing: 0) {
                    TextCustom(text: NSLocalizedString(title, comment: ""), size: 24, lineLimit: 1, color: #colorLiteral(red: 0.1422221363, green: 0.1236664429, blue: 0.1232500449, alpha: 1))
                    Spacer()
                    if isLogin {
                        Button(action: {

                        }) {
                            ZStack (alignment: .topTrailing) {
                                ZStack {
                                    ImageCustom(name: "EmptyPicture", w: 26, h: 26)
                                    ImageCustom(name: "notificationBlue", w: 20, h: 20)
                                }
                                ZStack {
                                    Rectangle()
                                        .cornerRadius(.infinity)
                                        .frame(width: W(16), height: W(16))
                                        .foregroundColor(.init(#colorLiteral(red: 0.4282599092, green: 0.1879977882, blue: 0.6717798114, alpha: 1)))
                                    TextCustom(text: "9+", size: 9, lineLimit: 1, color: .white)
                                }.offset(x: 5, y: -5)
                                    .opacity(0)
                            }
                        }.buttonStyle(ButtonTapScale())
                            .animation(.easeInOut(duration: 0.1))
                            .padding(.trailing, 24)
                    }
                    Button(action: {

                    }) {
                        ZStack (alignment: .topTrailing) {
                            ImageCustom(name: "iconCart", w: 26, h: 26)
                            ZStack {
                                Rectangle()
                                    .cornerRadius(.infinity)
                                    .frame(width: W(16), height: W(16))
                                    .foregroundColor(.init(#colorLiteral(red: 0.9133259654, green: 0.297054708, blue: 0.2958536744, alpha: 1)))
                                TextCustom(text: "9+", size: 9, lineLimit: 1, color: .white)
                            }.offset(x: 5, y: -5)
                                .opacity(0)
                        }
                    }.buttonStyle(ButtonTapScale())
                        .animation(.easeInOut(duration: 0.1))
                }.frame(height: W(26))
                    .padding(.horizontal, 20)
            }
            if isSearchAlwaysAppear {
                VStack (alignment: .leading, spacing: 0) {
                    HStack {
                        Button(action: {
                            self.backFunc()
                        }) {
                            HStack (spacing: 14) {
                                ImageCustom(name: "backBlack", w: 20, h: 11)
                                TextCustom(text: NSLocalizedString(title, comment: ""), size: 24, lineLimit: 1, color: #colorLiteral(red: 0.1422221363, green: 0.1236664429, blue: 0.1232500449, alpha: 1))
                            }
                        }.buttonStyle(ButtonTapScale())
                            .animation(.easeInOut(duration: 0.1))
                            .padding(.leading, 20)
                        Spacer()
                    }.background(Color.white)
                    ZStack (alignment: .leading) {
                        ImageCustom(name: "searchWhite", w: 18, h: 18)
                            .padding(.horizontal, W(16))
                        ZStack (alignment: .leading) {
                            TextCustom(text: NSLocalizedString("filter_city_search", comment: ""), font: REGULAR, size: 16, color: #colorLiteral(red: 0.4117531478, green: 0.411806047, blue: 0.4117352366, alpha: 1))
                                .fixedSize(horizontal: true, vertical: false)
                                .opacity(strSearch.isEmpty ? 1 : 0)
                            TextField("", text: $strSearch)
                                .font(.custom(REGULAR, size: H(16)))
                                .foregroundColor(.init(#colorLiteral(red: 0.1422221363, green: 0.1236664429, blue: 0.1232500449, alpha: 1)))
                                .padding(.trailing, W(42))
                                .frame(height: H(16))
                            HStack {
                                Spacer()
                                Button(action: {
                                    self.strSearch = ""
                                }) {
                                    ZStack (alignment: .trailing) {
                                        ImageCustom(name: "EmptyPicture", w: 19, h: 13)
                                        ImageCustom(name: "deleteAll", w: 14, h: 14)
                                    }
                                }.buttonStyle(ButtonTapScale())
                                    .animation(.easeInOut(duration: 0.1))
                                    .offset(x: W(-3.5))
                                    .opacity(strSearch.isEmpty ? 0 : 1)
                            }.padding(.trailing, W(16))
                        }.padding(.leading, W(49.7))
                    }.frame(height: H(44))
                        .background(Color.init(#colorLiteral(red: 0.9755373597, green: 0.9661560655, blue: 0.9658148885, alpha: 1)))
                        .cornerRadius(4)
                        .shadow(color: .init(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)), radius: 3, x: 1, y: 3)
                        .padding(.horizontal, 20)
                        .padding(.top, H(16))
                        .padding(.bottom, H(10))
                }
            }
            if isSearchTapAppear {
                ZStack {
                    HStack {
                        Button(action: {
                            self.backFunc()
                        }) {
                            HStack (spacing: 14) {
                                ImageCustom(name: isChangeColor ? "backWhite" : "backBlack", w: 20, h: 11)
                                TextCustom(text: NSLocalizedString(title, comment: ""), size: 24, lineLimit: 1, color: isChangeColor ? .white: #colorLiteral(red: 0.1422221363, green: 0.1236664429, blue: 0.1232500449, alpha: 1))
                            }
                        }.buttonStyle(ButtonTapScale())
                            .animation(.easeInOut(duration: 0.1))
                            .padding(.leading, 20)
                        Spacer()
                    }.opacity(isSearch ? 0 : 1)
                    HStack (spacing: isResponse ? 20 : 10) {
                        Spacer()
                        Button(action: {
                            self.isTapSearch = true
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                self.isSearch = true
                            }
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                self.isTapSearch = false
                            }
                        }) {
                            ImageCustom(name: isResponse ? "searchBlack" : "iconSearch", w: isResponse ? 22 : 20, h: isResponse ? 22 : 20)
                        }.buttonStyle(ButtonTapScale())
                            .animation(.easeInOut(duration: 0.1))
                        if !isHideIconFilter {
                            Button(action: {
                                if !self.isResponse {
                                    self.filterFunc()
                                } else {
                                    self.isShowCalendar = true
                                }
                            }) {
                                ImageCustom(name: isResponse ? isChooseValueDate ? "calendarPurple" : "calendarBlack": "filterBlack", w: isResponse ? 22 : 20, h: isResponse ? 22 : 18)
                            }.buttonStyle(ButtonTapScale())
                                .animation(.easeInOut(duration: 0.1))
                        }
                    }.padding(.trailing, isResponse ? 20 : 24)
                        .opacity(isSearch ? 0 : 1)
                        .opacity(isHideSearchIcon ? 0 : 1)
                    ZStack {
                        HStack {
                            ZStack (alignment: .leading) {
                                ImageCustom(name: "searchWhite", w: 18, h: 18)
                                    .padding(.horizontal, W(16))
                                ZStack (alignment: .leading) {
                                    TextCustom(text: NSLocalizedString(isResponse ? "navigation_search_response" : "navigation_search_project", comment: ""), font: REGULAR, size: 16, color: #colorLiteral(red: 0.4117531478, green: 0.411806047, blue: 0.4117352366, alpha: 1))
                                        .fixedSize(horizontal: true, vertical: false)
                                        .opacity(strSearch.isEmpty ? 1 : 0)
                                    TextField("", text: $strSearch)
                                        .font(.custom(REGULAR, size: H(16)))
                                        .foregroundColor(.init(#colorLiteral(red: 0.1422221363, green: 0.1236664429, blue: 0.1232500449, alpha: 1)))
                                        .padding(.trailing, W(42))
                                        .frame(height: H(16))
                                    HStack {
                                        Spacer()
                                        Button(action: {
                                            self.strSearch = ""
                                        }) {
                                            ZStack (alignment: .trailing) {
                                                ImageCustom(name: "EmptyPicture", w: 19, h: 13)
                                                ImageCustom(name: "deleteAll", w: 14, h: 14)
                                            }
                                        }.buttonStyle(ButtonTapScale())
                                            .animation(.easeInOut(duration: 0.1))
                                            .offset(x: W(-3.5))
                                            .opacity(strSearch.isEmpty ? 0 : 1)
                                    }.padding(.trailing, W(16))
                                }.padding(.leading, W(49.7))
                            }.frame(width: isSearch ? FULL_W - W(89): 0, height: H(44))
                                .background(Color.init(#colorLiteral(red: 0.9755373597, green: 0.9661560655, blue: 0.9658148885, alpha: 1)))
                                .cornerRadius(5)
                                .shadow(color: .init(#colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)), radius: 3, x: 1, y: 3)
                                .padding(.leading, 20)
                            Spacer()
                        }
                        HStack {
                            Spacer()
                            Button(action: {
                                self.isTapSearch = true
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                    self.isSearch = false
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    self.isTapSearch = false
                                }
                                self.strSearch = ""
                                UIApplication.shared.endEditing()
                            }) {
                                TextCustom(text: NSLocalizedString("navigation_closeSearch", comment: ""), font: MEDIUM, size: 16, lineLimit: 1, color: #colorLiteral(red: 0.1422221363, green: 0.1236664429, blue: 0.1232500449, alpha: 1))
                            }.buttonStyle(ButtonTapScale())
                                .animation(.easeInOut(duration: 0.1))
                                .padding(.trailing, 20)
                        }
                    }.opacity(isSearch ? 1 : 0)
                        .opacity(isHideSearchIcon ? 0 : 1)
                    if isAddQuestion {
                        HStack {
                            Spacer()
                            Button(action: {

                            }) {
                                TextCustom(text: NSLocalizedString("login_send", comment: ""), font: MEDIUM, size: 18, color: #colorLiteral(red: 0.1448521614, green: 0.1207015738, blue: 0.1211380437, alpha: 1))
                            }.buttonStyle(ButtonTapScale())
                                .animation(.easeInOut(duration: 0.1))
                                .padding(.trailing, 20)
                        }
                    }
                }.animation(.easeInOut(duration: 0.4))
                    .padding(.top, FULL_H <= 667 || FULL_H == 736 ? H(isSearch ? 20 : 10) : H(isSearch ? 10 : 0))
                    .padding(.bottom, H(isSearch ? 20 : 10))
            }
        }
    }
}
