// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import SwiftUI

struct AddQuestionView: View {
    @Binding var isNextOld: Bool

    @State var dynamicHeight1: CGFloat = 100
    @State var dynamicHeight2: CGFloat = 100
    @State var strTitle = ""
    @State var strContent = ""

    var body: some View {
        ZStack (alignment: .top) {
            Color.init(#colorLiteral(red: 0.999904573, green: 1, blue: 0.9998808503, alpha: 1)).edgesIgnoringSafeArea(.all)
            VStack (alignment: .leading, spacing: 0) {
                NavigationWhite(
                    isTapSearch: Binding.constant(false),
                    isLogin: Binding.constant(false),
                    isChangeColor: Binding.constant(false),
                    isOpenSideMenu: Binding.constant(false),
                    strSearch: Binding.constant(""),
                    isShowCalendar: Binding.constant(false),
                    isChooseValueDate: Binding.constant(false),
                    title: "response_addQuestion",
                    backFunc: {
                        UIApplication.shared.endEditing()
                        self.isNextOld = false
                    },
                    mapFunc: { },
                    filterFunc: { },
                    optionFunc: { },
                    callFunc: { },
                    textFunc: { },
                    isSearchTapAppear: true,
                    isHideIconFilter: true,
                    isHideSearchIcon: true,
                    isAddQuestion: true
                )
                ScrollView (showsIndicators: false) {
                    VStack (alignment: .leading, spacing: 0) {
                        HStack (spacing: 0) {
                            TextCustom(text: "\(NSLocalizedString("response_topicName", comment: "").uppercased()) ", font: MEDIUM, size: 16, color: #colorLiteral(red: 0.4248631895, green: 0.1841947138, blue: 0.6712480187, alpha: 1))
                            TextCustom(text: "*", font: MEDIUM, size: 16, color: #colorLiteral(red: 0.9142238498, green: 0.2997378707, blue: 0.2964345217, alpha: 1))
                        }.padding(.leading, 20)
                            .padding(.bottom, 11)
                        ZStack (alignment: .topLeading) {
                            TextCustom(text: NSLocalizedString("response_topicName", comment: ""), font: LIGHT_ITALIC, size: 16, color: #colorLiteral(red: 0.1402389705, green: 0.1208877638, blue: 0.1212251261, alpha: 1))
                                .opacity(strTitle.isEmpty ? 1 : 0)
                                .padding(.leading, 20)
                            UITextViewWrapper(
                                text: self.$strTitle,
                                calculatedHeight: $dynamicHeight1,
                                isFocus: Binding.constant(false),
                                font: MEDIUM,
                                size: 16,
                                color: #colorLiteral(red: 0.1395131052, green: 0.1250283718, blue: 0.1209059432, alpha: 1),
                                paddingLeft: 0,
                                paddingRight: 0,
                                paddingTop: 0,
                                paddingBottom: 0,
                                infinityHeight: true
                            ).frame(minHeight: dynamicHeight1, maxHeight: dynamicHeight1)
                                .padding(.leading, 15)
                                .padding(.trailing, 13)
                        }
                        Rectangle()
                            .frame(height: H(10))
                            .foregroundColor(.init(#colorLiteral(red: 0.9632954001, green: 0.948110044, blue: 1, alpha: 1)))
                            .padding(.vertical, H(16))
                        HStack (spacing: 0) {
                            TextCustom(text: "\(NSLocalizedString("response_topicContent", comment: "").uppercased()) ", font: MEDIUM, size: 16, color: #colorLiteral(red: 0.4248631895, green: 0.1841947138, blue: 0.6712480187, alpha: 1))
                            TextCustom(text: "*", font: MEDIUM, size: 16, color: #colorLiteral(red: 0.9142238498, green: 0.2997378707, blue: 0.2964345217, alpha: 1))
                        }.padding(.leading, 20)
                            .padding(.bottom, 11)
                        ZStack (alignment: .topLeading) {
                            TextCustom(text: NSLocalizedString("response_writeContent", comment: ""), font: LIGHT_ITALIC, size: 16, color: #colorLiteral(red: 0.1402389705, green: 0.1208877638, blue: 0.1212251261, alpha: 1))
                                .opacity(strContent.isEmpty ? 1 : 0)
                                .padding(.leading, 20)
                            UITextViewWrapper(
                                text: self.$strContent,
                                calculatedHeight: $dynamicHeight2,
                                isFocus: Binding.constant(false),
                                font: REGULAR,
                                size: 16,
                                color: #colorLiteral(red: 0.1395131052, green: 0.1250283718, blue: 0.1209059432, alpha: 1),
                                paddingLeft: 0,
                                paddingRight: 0,
                                paddingTop: 0,
                                paddingBottom: 0,
                                infinityHeight: true
                            ).frame(minHeight: dynamicHeight2, maxHeight: dynamicHeight2)
                                .padding(.leading, 15)
                                .padding(.trailing, 13)
                        }
                        Rectangle()
                            .frame(height: H(10))
                            .foregroundColor(.init(#colorLiteral(red: 0.9632954001, green: 0.948110044, blue: 1, alpha: 1)))
                            .padding(.vertical, H(16))
                        HStack {
                            TextCustom(text: "\(NSLocalizedString("response_files", comment: "").uppercased()) ", font: MEDIUM, size: 16, color: #colorLiteral(red: 0.4248631895, green: 0.1841947138, blue: 0.6712480187, alpha: 1))
                            Spacer()
                            Button(action: {

                            }) {
                                ImageCustom(name: "paperClip", w: 20.4, h: 19)
                            }.buttonStyle(ButtonTapScale())
                        }.padding(.horizontal, 20)
                        Spacer()
                    }
                }.resignKeyboardOnDragGesture()
            }
        }.onTapGesture {
            UIApplication.shared.endEditing()
        }.navigationBarBackButtonHidden(true)
            .navigationBarTitle("")
            .navigationBarHidden(true)
    }
}
