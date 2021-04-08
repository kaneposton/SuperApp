// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import SwiftUI

struct ResponseDetailView: View {
    @Binding var isNextOld: Bool
    @Binding var dataResponse: [TypeResponse]
    @Binding var idTopicSelected: String

    @State var isFocus = false
    @State var tempPullScreen = false
    @State var isShowing = false
    @State var isPull = false
    @State var currentHeight: CGFloat = 0
    @State var countTag = 0
    @State var isAppearTagTemp = true
    @State var isAppearTagMain = true
    @State var strPost = ""
    @State var dynamicHeight: CGFloat = 100
    @State var indexSelected: Int = -1
    @State var isDoneFor = false
    @State var replyUser = ""
    @State var isReply = false
    @State var commentReplyIndex = -1
    @State var keyboardHeight: CGFloat = 0

    var body: some View {
        ZStack (alignment: .top) {
            if keyboardHeight > 0 {
                Text("").onAppear {
                    self.isFocus = true
                }
            } else {
                Text("").onAppear {
                    self.closeKeyboard()
                }
            }
            if tempPullScreen { Text("") }
            if isDoneFor {
                if countTag == dataResponse[indexSelected].file.count {
                    Text("").onAppear {
                        self.isPull = true
                        self.isAppearTagTemp = false
                        self.isAppearTagMain = true
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            self.isPull = false
                        }
                    }
                }
                Color.init(#colorLiteral(red: 0.999894917, green: 1, blue: 0.999871552, alpha: 1)).edgesIgnoringSafeArea(.all)
                VStack (alignment: .leading, spacing: 0) {
                    NavigationWhite(
                        isTapSearch: Binding.constant(false),
                        isLogin: Binding.constant(false),
                        isChangeColor: Binding.constant(false),
                        isOpenSideMenu: Binding.constant(false),
                        strSearch: Binding.constant(""),
                        isShowCalendar: Binding.constant(false),
                        isChooseValueDate: Binding.constant(false),
                        title: dataResponse[indexSelected].title,
                        backFunc: {
                            self.strPost = ""
                            self.closeKeyboard()
                            self.isNextOld = false
                        },
                        mapFunc: { },
                        filterFunc: { },
                        optionFunc: { },
                        callFunc: { },
                        textFunc: { },
                        isSearchTapAppear: true,
                        isHideIconFilter: true,
                        isHideSearchIcon: true
                    )
                    List {
                        VStack (spacing: 0) {
                            if !isPull {
                                VStack (spacing: 0) {
                                    ZStack (alignment: .topTrailing) {
                                        HStack {
                                            VStack (alignment: .leading, spacing: H(10)) {
                                                TextCustom(text: dataResponse[indexSelected].title, size: 16, color: #colorLiteral(red: 0.1400775909, green: 0.1216219291, blue: 0.1212796792, alpha: 1))
                                                    .fixedSize(horizontal: false, vertical: true)
                                                HStack (spacing: 14) {
                                                    HStack (spacing: 7) {
                                                        ZStack {
                                                            ImageCustom(name: "timePurple", w: 13, h: 13)
                                                        }.frame(width: W(16), height: W(16))
                                                        TextCustom(text: dataResponse[indexSelected].time, font: REGULAR, size: 12, lineLimit: 1, color: #colorLiteral(red: 0.1400775909, green: 0.1216219291, blue: 0.1212796792, alpha: 1))
                                                    }
                                                    Rectangle()
                                                        .frame(width: 1, height: H(11))
                                                        .foregroundColor(.init(#colorLiteral(red: 0.6534755826, green: 0.6314619184, blue: 0.6309846044, alpha: 1)))
                                                    HStack (spacing: 7) {
                                                        ImageCustom(name: "ticketPurple", w: 16, h: 16)
                                                        HStack (spacing: 0) {
                                                            TextCustom(text: "\(NSLocalizedString("response_maCau", comment: "")): ", font: REGULAR, size: 12, lineLimit: 1, color: #colorLiteral(red: 0.1400775909, green: 0.1216219291, blue: 0.1212796792, alpha: 1))
                                                            TextCustom(text: idTopicSelected, font: REGULAR, size: 12, lineLimit: 1, color: #colorLiteral(red: 0.9328963161, green: 0.2516918182, blue: 0.2457951307, alpha: 1))
                                                        }
                                                    }
                                                }
                                            }.padding(.leading, 20)
                                                .frame(width: FULL_W - 78.5, alignment: .leading)
                                            Spacer()
                                        }
                                        HStack (spacing: 0) {
                                            Button(action: {

                                            }) {
                                                ZStack {
                                                    ImageCustom(name: "EmptyPicture", w: 33, h: 32)
                                                    ImageCustom(name: "sharePurple", w: 18, h: 18)
                                                }
                                            }.buttonStyle(ButtonTapScale())
                                                .animation(.easeInOut(duration: 0.1))
                                            Button(action: {
                                                self.dataResponse[self.indexSelected].isFlag.toggle()
                                            }) {
                                                ZStack {
                                                    ImageCustom(name: "EmptyPicture", w: 33, h: 32)
                                                    ImageCustom(name: "flagGray", w: 18, h: 18).opacity(dataResponse[indexSelected].isFlag ? 0 : 1)
                                                    ImageCustom(name: "flagGreen", w: 18, h: 18).opacity(dataResponse[indexSelected].isFlag ? 1 : 0)
                                                }
                                            }.buttonStyle(ButtonTapScale())
                                                .animation(.easeInOut(duration: 0.1))
                                        }.padding(.trailing, 12.5)
                                    }
                                        .padding(.bottom, H(15))
                                    TextCustom(text: dataResponse[indexSelected].detail, font: REGULAR, size: 14, color: #colorLiteral(red: 0.1400775909, green: 0.1216219291, blue: 0.1212796792, alpha: 1))
                                        .fixedSize(horizontal: false, vertical: true)
                                        .padding(.horizontal, 20)
                                        .padding(.bottom, H(15))
                                    if isAppearTagTemp {
                                        ZStack {
                                            ASCollectionView(
                                                section: ASCollectionViewSection(id: 0, data: dataResponse[indexSelected].file) { item, _ in
                                                    HStack (spacing: 6) {
                                                        Rectangle().frame(width: W(16), height: W(16))
                                                        TextCustom(text: item.name, font: REGULAR, size: 14, color: #colorLiteral(red: 0.05096982419, green: 0.0509866029, blue: 0.05096747726, alpha: 1))
                                                            .fixedSize(horizontal: false, vertical: true)
                                                    }.padding(.leading, 12)
                                                        .padding(.trailing, 18)
                                                        .frame(height: H(30))
                                                        .onAppear {
                                                            self.countTag += 1
                                                        }.background(
                                                            Rectangle()
                                                                .padding(1)
                                                                .background(Rectangle())
                                                        )
                                                }.selfSizingConfig { _ in
                                                    ASSelfSizingConfig(canExceedCollectionWidth: false)
                                                }
                                            ).layout {
                                                let fl = AlignedFlowLayout()
                                                fl.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
                                                return fl
                                            }.fitContentSize(dimension: .vertical)
                                                .padding(.horizontal, 20)
                                        }.background(
                                            GeometryReader { geometry in
                                                if self.countTag == self.dataResponse[self.indexSelected].file.count {
                                                    Image("EmptyPicture")
                                                        .resizable()
                                                        .onAppear {
                                                            self.currentHeight = geometry.size.height
                                                    }
                                                }
                                            }
                                        )
                                    }
                                    if isAppearTagMain {
                                        ASCollectionView(
                                            section: ASCollectionViewSection(id: 0, data: dataResponse[indexSelected].file) { item, _ in
                                                Button(action: {

                                                }) {
                                                    HStack (spacing: 6) {
                                                        ImageCustom(name: item.type == "xls" ? "excelGreen" : "pdfRed", w: 16, h: 16)
                                                        TextCustom(text: item.name, font: REGULAR, size: 14, color: #colorLiteral(red: 0.05096982419, green: 0.0509866029, blue: 0.05096747726, alpha: 1))
                                                            .fixedSize(horizontal: false, vertical: true)
                                                    }.padding(.leading, 12)
                                                        .padding(.trailing, 18)
                                                        .frame(height: H(30))
                                                        .onAppear {
                                                            self.countTag += 1
                                                        }.background(
                                                            Rectangle()
                                                                .foregroundColor(.white)
                                                                .cornerRadius(.infinity)
                                                                .padding(1)
                                                                .background(
                                                                    Rectangle()
                                                                        .foregroundColor(.init(#colorLiteral(red: 0.8783384562, green: 0.8784863353, blue: 0.8783177137, alpha: 1)))
                                                                        .cornerRadius(.infinity)
                                                                )
                                                        )
                                                }.buttonStyle(ButtonTapScale())
                                                    .animation(.easeInOut(duration: 0.1))
                                            }.selfSizingConfig { _ in
                                                ASSelfSizingConfig(canExceedCollectionWidth: false)
                                            }
                                        ).layout {
                                            let fl = AlignedFlowLayout()
                                            fl.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
                                            return fl
                                        }.frame(height: currentHeight)
                                            .padding(.horizontal, 20)
                                    }
                                }.onTapGesture { self.closeKeyboard() }
                                VStack (spacing: H(16)) {
                                    ForEach(0 ..< dataResponse[indexSelected].comment.count) { i in
                                        commentInTopic(
                                            strPost: self.$strPost,
                                            isFocus: self.$isFocus,
                                            replyUser: self.$replyUser,
                                            isReply: self.$isReply,
                                            commentReplyIndex: self.$commentReplyIndex,
                                            data: self.$dataResponse[self.indexSelected].comment[i],
                                            index: i
                                        )
                                    }
                                }.padding(.top, H(
                                    FULL_H == H_SE && FULL_W == W_SE ? 17: // iPhone SE 1st generation
                                    FULL_H == H_8 && FULL_W == W_8 ? 0: // iPhone 8 && iPhone SE 2nd generation
                                    FULL_H == H_8Plus && FULL_W == W_8Plus ? 0: // iPhone 8 Plus
                                    FULL_H == H_11 && FULL_W == W_11 ? 0: // iPhone 11 && iPhone 11 Pro Max
                                    FULL_H == H_11Pro && FULL_W == W_11Pro ? 1 : 0 // iPhone 11 Pro
                                    ))
                            }
                        }.listRowInsets(EdgeInsets())
                            .background(Color.init(#colorLiteral(red: 0.999894917, green: 1, blue: 0.999871552, alpha: 1)).onTapGesture { self.closeKeyboard() })
                            .padding(.bottom, isReply ? keyboardHeight + H(62) + 24 + dynamicHeight: keyboardHeight + H(35) + 24 + dynamicHeight)
                    }.resignKeyboardOnDragGesture()
                        .background(PullToRefresh(action: {
                                DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                    self.isPull = true
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                        self.isShowing = false
                                        self.isPull = false
                                    }
                                }
                        }, isShowing: self.$isShowing))
                        .opacity(isAppearTagTemp ? 0 : 1)
                }
                VStack (spacing: 0) {
                    Spacer()
                    VStack (spacing: 0) {
                        VStack (alignment: .leading, spacing: H(11)) {
                            if isReply {
                                HStack (spacing: 0) {
                                    TextCustom(text: "\(NSLocalizedString("response_reply", comment: "")) ", font: REGULAR, size: 16, lineLimit: 1, color: #colorLiteral(red: 0.1395283043, green: 0.1249907091, blue: 0.1252310872, alpha: 1))
                                    TextCustom(text: replyUser, font: MEDIUM, size: 16, lineLimit: 1, color: #colorLiteral(red: 0.4288418591, green: 0.1884974539, blue: 0.6711325049, alpha: 1))
                                    Spacer()
                                    Button(action: {
                                        self.closeKeyboard()
                                        self.strPost = ""
                                    }) {
                                        TextCustom(text: NSLocalizedString("project_ground_plan_popup_cancel", comment: ""), font: REGULAR, size: 16, lineLimit: 1, color: #colorLiteral(red: 0.4125239849, green: 0.4077047408, blue: 0.4077146351, alpha: 1))
                                    }.buttonStyle(ButtonTapScale())
                                        .animation(.easeInOut(duration: 0.1))
                                }.frame(width: FULL_W - 32)
                            }
                            HStack (alignment: .bottom, spacing: 16) {
                                ZStack (alignment: .leading) {
                                    TextCustom(text: NSLocalizedString("response_addMoreComment", comment: ""), font: LIGHT_ITALIC, size: 16, color: #colorLiteral(red: 0.1400775909, green: 0.1216219291, blue: 0.1212796792, alpha: 1))
                                        .padding(.leading, 13)
                                        .opacity(strPost.isEmpty ? 1 : 0)
                                    UITextViewWrapper(
                                        text: self.$strPost,
                                        calculatedHeight: $dynamicHeight,
                                        isFocus: self.$isFocus,
                                        isUseFocus: true,
                                        font: REGULAR,
                                        size: 16,
                                        color: #colorLiteral(red: 0.1400775909, green: 0.1216219291, blue: 0.1212796792, alpha: 1),
                                        paddingLeft: 7
                                    ).frame(minHeight: dynamicHeight, maxHeight: dynamicHeight)
                                }.background(Color.init(#colorLiteral(red: 0.9489197135, green: 0.9490787387, blue: 0.9488974214, alpha: 1)))
                                    .cornerRadius(4)
                                Button(action: {
                                    if !self.strPost.isBlank && !self.strPost.isEmpty {
                                        if self.isReply {
                                            self.dataResponse[self.indexSelected].comment[self.commentReplyIndex].reply.append(
                                                ReplyComment(
                                                    userName: NSLocalizedString("response_myself", comment: ""),
                                                    urlImage: "",
                                                    date: "\(Date())".components(separatedBy: " ").count == 3 ?
                                                        "\(Date())".formatDate(from: "yyyy-MM-dd HH:mm:ss Z", to: "H:mm - dd/MM/yyyy"):
                                                        "\(Date())".formatDate(from: "yyyy-MM-dd hh:mm:ss a Z", to: "h:mm - dd/MM/yyyy"),
                                                    content: self.strPost,
                                                    isQTV: false
                                                )
                                            )
                                        } else {
                                            self.dataResponse[self.indexSelected].comment.append(
                                                CommentTopic(
                                                    userName: NSLocalizedString("response_myself", comment: ""),
                                                    urlImage: "",
                                                    date: "\(Date())".components(separatedBy: " ").count == 3 ?
                                                        "\(Date())".formatDate(from: "yyyy-MM-dd HH:mm:ss Z", to: "H:mm - dd/MM/yyyy"):
                                                        "\(Date())".formatDate(from: "yyyy-MM-dd hh:mm:ss a Z", to: "h:mm - dd/MM/yyyy"),
                                                    content: self.strPost,
                                                    isQTV: false,
                                                    isLiked: -1,
                                                    reply: []
                                                )
                                            )
                                        }
                                        self.strPost = ""
                                        self.isPull = true
                                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                                            self.isPull = false
                                        }
                                    }
                                    self.closeKeyboard()
                                    if self.strPost.isBlank || self.strPost.isEmpty {
                                        self.strPost = ""
                                    }
                                }) {
                                    ImageCustom(name: !self.strPost.isBlank || !self.strPost.isEmpty ? "sendSolidPurple" : "sendSolidGrey", w: 24, h: 24)
                                }.buttonStyle(ButtonTapScale())
                                    .animation(.easeInOut(duration: 0.1))
                                    .offset(y: H(
                                        FULL_H == H_SE && FULL_W == W_SE ? -13: // iPhone SE 1st generation
                                        FULL_H == H_8 && FULL_W == W_8 ? -10: // iPhone 8 && iPhone 2nd generation
                                        FULL_H == H_8Plus && FULL_W == W_8Plus ? -8: // iPhone 8 Plus
                                        FULL_H == H_11 && FULL_W == W_11 ? -8: // iPhone 11 && iPhone 11 Pro Max
                                        FULL_H == H_11Pro && FULL_W == W_11Pro ? -9 : 0) // iPhone 11 Pro
                                    )
                            }
                        }.padding(.leading, 20)
                            .padding(.trailing, 12)
                            .padding(.vertical, 12)
                            .background(Color.white)
                        Rectangle()
                            .foregroundColor(.white)
                            .frame(height: keyboardHeight > 0 ?
                                FULL_H == H_SE && FULL_W == W_SE ? keyboardHeight: // iPhone SE 1st generation
                                FULL_H == H_8 && FULL_W == W_8 ? keyboardHeight: // iPhone 8 && iPhone SE 2nd generation
                                FULL_H == H_8Plus && FULL_W == W_8Plus ? keyboardHeight: // iPhone 8 Plus
                                FULL_H == H_11 && FULL_W == W_11 ? H(35) + keyboardHeight: // iPhone 11 && iPhone 11 Pro Max
                                FULL_H == H_11Pro && FULL_W == W_11Pro ? H(35) + keyboardHeight : 0 // iPhone 11 Pro
                                :
                                    FULL_H == H_SE && FULL_W == W_SE ? 0: // iPhone SE 1st generation
                                FULL_H == H_8 && FULL_W == W_8 ? 0: // iPhone 8 && iPhone SE 2nd generation
                                FULL_H == H_8Plus && FULL_W == W_8Plus ? 0: // iPhone 8 Plus
                                FULL_H == H_11 && FULL_W == W_11 ? H(50): // iPhone 11 && iPhone 11 Pro Max
                                FULL_H == H_11Pro && FULL_W == W_11Pro ? H(50) : 0 // iPhone 11 Pro
                            )
                    }.cornerRadius(0)
                        .shadow(color: .init(#colorLiteral(red: 0.5813372462, green: 0.5813372462, blue: 0.5813372462, alpha: 0.2016802226)), radius: 3, y: -3)
                }.edgesIgnoringSafeArea(.bottom)
                    .animation(.easeInOut(duration: 0.1))
            }
        }.keyboardAppear(keyboardHeight: $keyboardHeight)
            .edgesIgnoringSafeArea(.bottom)
            .onAppear {
                if self.keyboardHeight > 0 {
                    self.closeKeyboard()
                }
                for i in 0 ..< self.dataResponse.count {
                    if self.dataResponse[i].idTopic == self.idTopicSelected {
                        self.indexSelected = i
                        self.isDoneFor = true
                    }
                }
                self.tempPullScreen = true
                UITableViewCell.appearance().backgroundColor = #colorLiteral(red: 0.999894917, green: 1, blue: 0.999871552, alpha: 1)
                UITableView.appearance().backgroundColor = #colorLiteral(red: 0.999894917, green: 1, blue: 0.999871552, alpha: 1)
                UITableView.appearance().separatorStyle = .none
                UITableView.appearance().showsVerticalScrollIndicator = false
            }.edgesIgnoringSafeArea(.bottom)
            .navigationBarBackButtonHidden(true)
            .navigationBarTitle("")
            .navigationBarHidden(true)
    }

    func closeKeyboard() {
        self.commentReplyIndex = -1
        self.replyUser = ""
        self.isReply = false
        self.isFocus = false
        UIApplication.shared.endEditing()
    }
}

struct commentInTopic: View {
    @Binding var strPost: String
    @Binding var isFocus: Bool
    @Binding var replyUser: String
    @Binding var isReply: Bool
    @Binding var commentReplyIndex: Int
    @Binding var data: CommentTopic
    @State var index = 0

    var body: some View {
        VStack (alignment: .leading, spacing: 0) {
            ZStack (alignment: .topTrailing) {
                HStack (spacing: 0) {
                    HStack (spacing: 0) {
                        ZStack {
                            if data.urlImage.isEmpty {
                                ZStack {
                                    Rectangle()
                                        .foregroundColor(.init(#colorLiteral(red: 0.8576380014, green: 0.8960043788, blue: 0.6692106128, alpha: 1)))
                                        .frame(width: W(40), height: W(40))
                                        .cornerRadius(.infinity)
                                    TextCustom(text: String.getLast2Charater(name: data.userName).uppercased(), font: MEDIUM, size: 15, lineLimit: 1, color: #colorLiteral(red: 0.6587457061, green: 0.7609593272, blue: 0.001229812857, alpha: 1))
                                }
                            } else {
                                Image(data.urlImage)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: W(40), height: W(40))
                                    .clipped()
                                    .cornerRadius(.infinity)
                            }
                        }.padding(.trailing, 13)
                            .onTapGesture { self.closeKeyboard() }
                        VStack (alignment: .leading, spacing: H(5)) {
                            HStack (spacing: 10) {
                                TextCustom(text: data.userName, font: MEDIUM, size: 16, lineLimit: 1, color: #colorLiteral(red: 0.1400775909, green: 0.1216219291, blue: 0.1212796792, alpha: 1))
                                ZStack {
                                    Rectangle()
                                        .frame(width: W(39), height: W(22))
                                        .foregroundColor(.init(#colorLiteral(red: 0.9328963161, green: 0.2516918182, blue: 0.2457951307, alpha: 1)))
                                        .cornerRadius(3)
                                    TextCustom(text: "QTV", font: MEDIUM, size: 12, color: .white)
                                }.opacity(data.isQTV ? 1 : 0)
                            }.frame(width: data.isQTV ? FULL_W - W(40) - 124: FULL_W - W(1) - 114, alignment: .leading)
                                .onTapGesture { self.closeKeyboard() }
                            HStack (spacing: 0) {
                                HStack (spacing: 7) {
                                    ZStack {
                                        ImageCustom(name: "timePurple", w: 13, h: 13)
                                    }.frame(width: W(16), height: W(16))
                                    TextCustom(text: data.date, font: REGULAR, size: 12, lineLimit: 1, color: #colorLiteral(red: 0.1400775909, green: 0.1216219291, blue: 0.1212796792, alpha: 1))
                                }.onTapGesture { self.closeKeyboard() }
                                Rectangle()
                                    .frame(width: 1, height: H(16))
                                    .foregroundColor(.init(#colorLiteral(red: 0.9226210713, green: 0.8795441985, blue: 0.9641619325, alpha: 1)))
                                    .padding(.leading, 14)
                                    .onTapGesture { self.closeKeyboard() }
                                Button(action: {
                                    self.reply()
                                }) {
                                    HStack (spacing: 0) {
                                        Color.init(commentReplyIndex == index ? #colorLiteral(red: 0.9293137789, green: 0.9294697642, blue: 0.929291904, alpha: 1): #colorLiteral(red: 0.9452131391, green: 0.9492447972, blue: 0.9654393792, alpha: 1))
                                            .frame(width: 14, height: W(16))
                                        HStack (spacing: 7) {
                                            ZStack {
                                                ImageCustom(name: "EmptyPicture", w: 16, h: 16)
                                                ImageCustom(name: "comment", w: 12.4, h: 10.9)
                                            }
                                            TextCustom(text: NSLocalizedString("response_discuss", comment: ""), font: MEDIUM, size: 12, lineLimit: 1, color: #colorLiteral(red: 0.4282599092, green: 0.1879977882, blue: 0.6717798114, alpha: 1))
                                        }
                                        Color.init(commentReplyIndex == index ? #colorLiteral(red: 0.9293137789, green: 0.9294697642, blue: 0.929291904, alpha: 1): #colorLiteral(red: 0.9452131391, green: 0.9492447972, blue: 0.9654393792, alpha: 1))
                                            .frame(width: 14, height: W(16))
                                    }.background(Color.init(commentReplyIndex == index ? #colorLiteral(red: 0.9293137789, green: 0.9294697642, blue: 0.929291904, alpha: 1): #colorLiteral(red: 0.9452131391, green: 0.9492447972, blue: 0.9654393792, alpha: 1)))
                                }.buttonStyle(ButtonTapScale())
                                    .animation(.easeInOut(duration: 0.1))
                            }
                        }
                    }.padding(.leading, 20)
                        .padding(.top, 16)
                    Spacer()
                }.frame(width: FULL_W - 22, alignment: .leading)
                HStack (spacing: 0) {
                    Button(action: {
                        if self.data.isLiked == 1 {
                            self.data.isLiked = -1
                        } else {
                            self.data.isLiked = 1
                        }
                    }) {
                        ZStack (alignment: .top) {
                            Image("EmptyPicture")
                                .resizable()
                                .frame(width: W(34.5), height: W(16) + 32)
                            ImageCustom(name: data.isLiked == 1 ? "likeGreen" : "likeGray", w: 16, h: 16)
                                .padding(.top, 16)
                        }
                    }.buttonStyle(ButtonTapScale())
                        .animation(.easeInOut(duration: 0.1))
                    Button(action: {
                        if self.data.isLiked == 0 {
                            self.data.isLiked = -1
                        } else {
                            self.data.isLiked = 0
                        }
                    }) {
                        ZStack (alignment: .top) {
                            Image("EmptyPicture")
                                .resizable()
                                .frame(width: W(34.5), height: W(16) + 32)
                            ImageCustom(name: data.isLiked == 0 ? "dislikeRed" : "dislikeGray", w: 16, h: 16)
                                .padding(.top, 16)
                        }
                    }.buttonStyle(ButtonTapScale())
                        .animation(.easeInOut(duration: 0.1))
                }.opacity(data.userName == NSLocalizedString("response_myself", comment: "") ? 0 : 1)
            }
            TextCustom(text: data.content, font: REGULAR, size: 14, color: #colorLiteral(red: 0.1400775909, green: 0.1216219291, blue: 0.1212796792, alpha: 1))
                .fixedSize(horizontal: false, vertical: true)
                .padding(.leading, 20)
                .padding(.trailing, 36)
                .padding(.top, H(17))
                .padding(.bottom, self.data.reply.count > 0 ? 0 : 16)
                .onTapGesture { self.closeKeyboard() }
            if data.reply.count > 0 {
                VStack (alignment: .leading, spacing: 0) {
                    VStack (alignment: .leading, spacing: 0) {
                        ForEach(0 ..< data.reply.count) { i in
                            ReplyCommentView(dataReply: self.data.reply[i])
                        }
                    }.onTapGesture { self.closeKeyboard() }
                    Rectangle()
                        .foregroundColor(.init(#colorLiteral(red: 0.831368506, green: 0.8312652111, blue: 0.8484933376, alpha: 1)))
                        .frame(width: FULL_W - 45, height: 1)
                        .padding(.vertical, H(12))
                        .padding(.leading, 23)
                        .onTapGesture { self.closeKeyboard() }
                    HStack (spacing: 0) {
                        ZStack {
                            Rectangle()
                                .foregroundColor(.init(#colorLiteral(red: 0.8576380014, green: 0.8960043788, blue: 0.6692106128, alpha: 1)))
                                .frame(width: W(40), height: W(40))
                                .cornerRadius(.infinity)
                            TextCustom(text: String.getLast2Charater(name: NSLocalizedString("response_myself", comment: "")).uppercased(), font: MEDIUM, size: 15, lineLimit: 1, color: #colorLiteral(red: 0.6587457061, green: 0.7609593272, blue: 0.001229812857, alpha: 1))
                        }.padding(.trailing, 13)
                            .padding(.leading, 40)
                            .onTapGesture { self.closeKeyboard() }
                        Button(action: {
                            self.reply()
                        }) {
                            ZStack (alignment: .leading) {
                                Rectangle()
                                    .foregroundColor(.white)
                                    .frame(width: FULL_W - 95 - W(40), height: W(37))
                                    .cornerRadius(4)
                                TextCustom(text: NSLocalizedString("response_addMoreComment", comment: ""), font: LIGHT_ITALIC, size: 16, color: #colorLiteral(red: 0.1402389705, green: 0.1208877638, blue: 0.1212251261, alpha: 1))
                                    .padding(.leading, 13)
                            }
                        }.buttonStyle(ButtonTapScale())
                            .animation(.easeInOut(duration: 0.1))
                    }.padding(.bottom, 16)
                }
            }
        }.frame(width: FULL_W - 22, alignment: .leading)
            .background(Color.init(commentReplyIndex == index ? #colorLiteral(red: 0.9293137789, green: 0.9294697642, blue: 0.929291904, alpha: 1): #colorLiteral(red: 0.9452131391, green: 0.9492447972, blue: 0.9654393792, alpha: 1)))
            .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.init(commentReplyIndex == index ? #colorLiteral(red: 0.9226210713, green: 0.8795441985, blue: 0.9641619325, alpha: 1): #colorLiteral(red: 0.9452131391, green: 0.9492447972, blue: 0.9654393792, alpha: 1)), lineWidth: 1))
    }

    func reply() {
        self.strPost = ""
        self.isReply = true
        self.replyUser = self.data.userName
        self.commentReplyIndex = self.index
        self.isFocus = true
    }

    func closeKeyboard() {
        self.strPost = ""
        self.commentReplyIndex = -1
        self.replyUser = ""
        self.isReply = false
        self.isFocus = false
        UIApplication.shared.endEditing()
    }
}

struct ReplyCommentView: View {
    @State var dataReply = ReplyComment(userName: "", urlImage: "", date: "", content: "", isQTV: false)

    var body: some View {
        VStack (alignment: .leading, spacing: 0) {
            Rectangle()
                .foregroundColor(.init(#colorLiteral(red: 0.831368506, green: 0.8312652111, blue: 0.8484933376, alpha: 1)))
                .frame(width: FULL_W - 43, height: 1)
                .padding(.vertical, H(12))
                .padding(.leading, 23)
            HStack (spacing: 0) {
                ZStack {
                    if dataReply.urlImage.isEmpty {
                        ZStack {
                            Rectangle()
                                .foregroundColor(.init(#colorLiteral(red: 0.8576380014, green: 0.8960043788, blue: 0.6692106128, alpha: 1)))
                                .frame(width: W(40), height: W(40))
                                .cornerRadius(.infinity)
                            TextCustom(text: String.getLast2Charater(name: dataReply.userName).uppercased(), font: MEDIUM, size: 15, lineLimit: 1, color: #colorLiteral(red: 0.6587457061, green: 0.7609593272, blue: 0.001229812857, alpha: 1))
                        }
                    } else {
                        Image(dataReply.urlImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: W(40), height: W(40))
                            .clipped()
                            .cornerRadius(.infinity)
                    }
                }.padding(.trailing, 13)
                VStack (alignment: .leading, spacing: H(5)) {
                    HStack (spacing: 10) {
                        TextCustom(text: dataReply.userName, font: MEDIUM, size: 16, lineLimit: 1, color: #colorLiteral(red: 0.1400775909, green: 0.1216219291, blue: 0.1212796792, alpha: 1))
                        ZStack {
                            Rectangle()
                                .frame(width: W(39), height: W(22))
                                .foregroundColor(.init(#colorLiteral(red: 0.9328963161, green: 0.2516918182, blue: 0.2457951307, alpha: 1)))
                                .cornerRadius(3)
                            TextCustom(text: "QTV", font: MEDIUM, size: 12, color: .white)
                        }.opacity(dataReply.isQTV ? 1 : 0)
                    }.frame(width: dataReply.isQTV ? FULL_W - W(40) - 122: FULL_W - W(1) - 112, alignment: .leading)
                    HStack (spacing: 7) {
                        ZStack {
                            ImageCustom(name: "timePurple", w: 13, h: 13)
                        }.frame(width: W(16), height: W(16))
                        TextCustom(text: dataReply.date, font: REGULAR, size: 12, lineLimit: 1, color: #colorLiteral(red: 0.1400775909, green: 0.1216219291, blue: 0.1212796792, alpha: 1))
                    }
                }
            }.padding(.leading, 40)
            TextCustom(text: dataReply.content, font: REGULAR, size: 14, color: #colorLiteral(red: 0.1400775909, green: 0.1216219291, blue: 0.1212796792, alpha: 1))
                .fixedSize(horizontal: false, vertical: true)
                .padding(.leading, 40)
                .padding(.trailing, 15)
                .padding(.top, H(17))
        }.background(Color.init(#colorLiteral(red: 0.9412961602, green: 0.945279181, blue: 0.9573968053, alpha: 1)))

    }
}
