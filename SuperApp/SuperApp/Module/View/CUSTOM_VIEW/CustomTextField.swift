// MARK: Tạo bởi TRẦN THIỆN PHÚ (Liên hệ : 0901018940 || phu.tt15081995@gmail.com)
import SwiftUI

struct CustomTextField2Number: UIViewRepresentable {
    @Binding var textDefault: String
    var tf = TextField2Number()
    var changeHandler: ((String) -> Void)?
    var onCommitHandler: (() -> Void)?

    func makeUIView(context: UIViewRepresentableContext<CustomTextField2Number>) -> TextField2Number {
        tf.textColor = #colorLiteral(red: 0.1422221363, green: 0.1236664429, blue: 0.1232500449, alpha: 1)
        tf.font = UIFont.init(name: MEDIUM, size: H(14))
        tf.textAlignment = .left
        tf.textContentType = .oneTimeCode
        tf.keyboardType = .numberPad
        tf.delegate = tf
        tf.text = textDefault
        tf.textFieldChangedHandler = changeHandler

        return tf
    }

    func updateUIView(_ uiView: TextField2Number, context: UIViewRepresentableContext<CustomTextField2Number>) {
        uiView.setContentHuggingPriority(.defaultHigh, for: .vertical)
        uiView.setContentHuggingPriority(.defaultLow, for: .horizontal)
        uiView.text = formatted2Number(number: textDefault)
    }
}

class TextField2Number: UITextField, UITextFieldDelegate {
    var textFieldChangedHandler: ((String) -> Void)?
    var isClear = false
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        let newString = ((textField.text)! as NSString).replacingCharacters(in: range, with: string)

        if newString.count <= 2 {
            textFieldChangedHandler?(newString as String)
            textFieldShouldReturnSingle(textField, newString: newString)
            return false

        }
        return newString.count <= 2 || string == ""

    }
    func textFieldDidEndEditing(_ textField: UITextField) {

    }

    func textFieldShouldReturnSingle(_ textField: UITextField, newString: String) {
        textField.text = formatted2Number(number: newString)
    }
}

func formatted2Number(number: String) -> String {
    let cleanPhoneNumber = number.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()
    let mask = "XX"

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
