// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import SwiftUI

struct TextCustom: View {
    var text = ""
    var font = BOLD
    var size: CGFloat = 12
    var lineLimit: Int? = nil
    var color = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)

    var body: some View {
        Text(text)
            .foregroundColor(.init(color))
            .font(.custom(font, size: H(size)))
            .lineLimit(lineLimit != nil ? lineLimit : nil)
    }
}

struct TextCustomUnderLine: View {
    var text = ""
    var font = BOLD
    var size: CGFloat = 12
    var lineLimit: Int? = nil
    var color = #colorLiteral(red: 0.2, green: 0.2, blue: 0.2, alpha: 1)

    var body: some View {
        Text(text)
            .underline()
            .foregroundColor(.init(color))
            .font(.custom(font, size: H(size)))
            .lineLimit(lineLimit != nil ? lineLimit : nil)
    }
}

extension StringProtocol {
    var firstUppercased: String { prefix(1).uppercased() + dropFirst() }
    var firstCapitalized: String { prefix(1).capitalized + dropFirst() }
}

func formattedNumberPhone(number: String) -> String {
    let cleanPhoneNumber = number.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
    let mask = "XXXX XXX XXX"

    var result = ""
    var index = cleanPhoneNumber.startIndex
    for ch in mask where index < cleanPhoneNumber.endIndex {
        if ch == "X" {
            result.append(cleanPhoneNumber[index])
            index = cleanPhoneNumber.index(after: index)
        } else {
            result.append(ch)
        }
    }
    return result
}

class TextFieldPhone: UITextField, UITextFieldDelegate {
    var textFieldChangedHandler: ((String) -> Void)?
    var textFieldDidBeginEditing: ((Bool) -> Void)?
    var textFieldDidEndEditing: ((Bool) -> Void)?

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newString = ((textField.text)! as NSString).replacingCharacters(in: range, with: string)

        if newString.count <= 12 {
            textFieldChangedHandler?(newString as String)
            textFieldShouldReturnSingle(textField, newString: newString)
            return false

        }
        return newString.count <= 12 || string == ""
    }

    func textFieldDidBeginEditing(_ textField: UITextField) {
        textFieldDidBeginEditing!(true)
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        textFieldDidEndEditing!(true)
    }

    func textFieldShouldReturnSingle(_ textField: UITextField, newString: String) {
        textField.text = formattedNumberPhone(number: newString)
    }
}

struct TFPhoneNumner: UIViewRepresentable {
    var tf = TextFieldPhone()
    var align = ""
    var font = ""
    var size: CGFloat = 16
    var color = #colorLiteral(red: 0.1422221363, green: 0.1236664429, blue: 0.1232500449, alpha: 1)
    var changeHandler: ((String) -> Void)?
    var didBeginEditing: ((Bool) -> Void)?
    var didEndEditing: ((Bool) -> Void)?
    var onCommitHandler: (() -> Void)?
    @Binding var isClear: Bool
    @Binding var value: String
    @Binding var isEnableEdit: Bool

    func makeUIView(context: UIViewRepresentableContext<TFPhoneNumner>) -> TextFieldPhone {
        tf.text = value
        tf.textColor = .init(color)
        tf.font = UIFont(name: font, size: H(size))
        tf.textAlignment = align == "right" ? .right : .left
        tf.textContentType = .oneTimeCode
        tf.keyboardType = .numberPad
        tf.delegate = tf
        tf.tag = 1
        tf.textFieldDidBeginEditing = didBeginEditing
        tf.textFieldChangedHandler = changeHandler
        tf.textFieldDidEndEditing = didEndEditing

        return tf
    }

    func updateUIView(_ uiView: TextFieldPhone, context: UIViewRepresentableContext<TFPhoneNumner>) {
        uiView.setContentHuggingPriority(.defaultHigh, for: .vertical)
        uiView.setContentHuggingPriority(.defaultLow, for: .horizontal)

        if isClear {
            let tf = uiView.viewWithTag(1) as? UITextField
            tf?.text = ""
        }
        if isEnableEdit {
            let tf = uiView.viewWithTag(1) as? UITextField
            tf?.isUserInteractionEnabled = true
        } else {
            let tf = uiView.viewWithTag(1) as? UITextField
            tf?.isUserInteractionEnabled = false
        }
    }
}
