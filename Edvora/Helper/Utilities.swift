//
//  TextBox.swift
//  Edvora
//
//  Created by TeCh_SavVy on 18/04/22.
//

import SwiftUI
import UIKit




extension Double{
    private static var numberFormatter: NumberFormatter = {
          let numberFormatter = NumberFormatter()
          numberFormatter.numberStyle = .decimal

          return numberFormatter
      }()

      var priceString: String {
          return  "AED " + (Double.numberFormatter.string(from: NSNumber(value: self)) ?? "-")
      }
    
    var ratingSring: String {
        return self > 4 ? "Excellent" : "Good"
    }
    
}

extension Int{
    enum PluralRules:String{
        case s
        case es
        case ren
    }
    
    func plural(_ word:String,rule:PluralRules = .s)->String{
        return "\(self) \(word)\(self>1 ? rule.rawValue : "")"
    }
    
    var abbreviated: String {
          let abbrev = "KMBTPE"
          return abbrev.enumerated().reversed().reduce(nil as String?) { accum, tuple in
              let factor = Double(self) / pow(10, Double(tuple.0 + 1) * 3)
              let format = (factor.truncatingRemainder(dividingBy: 1)  == 0 ? "%.0f%@" : "%.1f%@")
              return accum ?? (factor > 1 ? String(format: format, factor, String(tuple.1)) : nil)
              } ?? String(self)
      }
}


extension String{
    var isValidEmail:Bool{
           let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
           let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
           return emailPred.evaluate(with: self)
       }
    
    var priceString: String {
        return  "AED " + self
    }
    var isValidPassword: Bool {
        // least one uppercase,
        // least one digit
        // least one lowercase
        // least one symbol
        //  min 8 characters total
        let password = self.trimmingCharacters(in: CharacterSet.whitespaces)
        let passwordRegx = "^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&<>*~:`-]).{8,}$"
        let passwordCheck = NSPredicate(format: "SELF MATCHES %@",passwordRegx)
        return passwordCheck.evaluate(with: password)

    }
}

extension Date {
   static var tomorrow:  Date { return Date().dayAfter }
   static var today: Date {return Date()}
   var dayAfter: Date {
      return Calendar.current.date(byAdding: .day, value: 1, to: Date())!
   }
}


extension View {
    func underlineTextField() -> some View {
        self
            .padding(.top, 10)
            .overlay(Rectangle().frame(height: 2).padding(.top, 35))
            .foregroundColor(.primaryBlue)
            .padding([.top, .horizontal],10)
    }
}


struct TextView: UIViewRepresentable {
    @Binding var text: String

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> UITextView {

        let myTextView = UITextView()
        myTextView.delegate = context.coordinator

        myTextView.font = UIFont(name: "HelveticaNeue", size: 15)
        myTextView.isScrollEnabled = true
        myTextView.isEditable = true
        myTextView.isUserInteractionEnabled = true
        myTextView.backgroundColor = UIColor(white: 0.0, alpha: 0.05)

        return myTextView
    }

    func updateUIView(_ uiView: UITextView, context: Context) {
        uiView.text = text
    }

    class Coordinator : NSObject, UITextViewDelegate {

        var parent: TextView

        init(_ uiTextView: TextView) {
            self.parent = uiTextView
        }

        func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            return true
        }

        func textViewDidChange(_ textView: UITextView) {
            print("text now: \(String(describing: textView.text!))")
            self.parent.text = textView.text
        }
    }
}

struct CheckboxFieldView : View {
    @Binding var checkState: Bool
    var title: String
    var body: some View {

         Button(action:
            {
                //1. Save state
             self.checkState.toggle()
                print("State : \(self.checkState)")


        }) {
            HStack(alignment: .top, spacing: 10) {

                        //2. Will update according to state
                   Rectangle()
                    .fill(self.checkState ? Color.green : Color.primaryGray)
                            .frame(width:20, height:20, alignment: .center)
                            .cornerRadius(5)

                Text(title).Inter(.interRegular)
                    .foregroundColor(.black)

            }
        }
        .foregroundColor(Color.white)

    }

}

struct DateUtils {
    public static func unitDistance(meter: Double?) -> String {
        let formatter = MeasurementFormatter()
        return formatter.string(from: Measurement(value: meter ?? 0, unit: UnitLength.meters)) // 0.621 mi
    }
    public static func unitTime(sec: Int, style: DateComponentsFormatter.UnitsStyle = .short) -> String {
        let formatter = DateComponentsFormatter()
        formatter.allowedUnits = [.hour, .minute]
        formatter.unitsStyle = style
        return formatter.string(from: Double(sec)) ?? ""
    }
    // MARK: - Date
    public static func formattedDate(_ dateString: String?, from: DateFormat, to: DateFormat) -> String {
        let date = extractDate(date: dateString ?? "", from: from)
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.dateFormat = to.rawValue
        return formatter.string(from: date)
    }
    public static func extractDate(date: String?, from: DateFormat) -> Date {
        let formatter = DateFormatter()
        formatter.dateFormat = from.rawValue
        return formatter.date(from: date ?? "") ?? Date()
    }
    public static func extractDateString(_ date: Date, to: DateFormat) -> String {
        let formatter = DateFormatter()
        formatter.locale = .current
        formatter.dateFormat = to.rawValue
        return formatter.string(from: date)
    }
}


enum DateFormat: String {
    case EEEddMMM = "EEE, dd MMM"
    case EEEddMMMyyyy = "EEEE, dd MMMM yyyy"
    case eddMMyy = "EE, dd MMM, yy"
    case eddMMyy_ = "EE, dd MMM yy"
    case HHmmss = "HH:mm:ss"
    case hmma = "h:mm a"
    case yyyyMMddTHHmmss = "yyyy-MM-dd'T'HH:mm:ss"
    case dMMMMyyyyhmma = "d MMMM yyyy - h:mm a"
    case yyyyMMdd = "yyyy-MM-dd"
    case mmmddyyy = "MMM dd, yyyy"
    case mDDyy = "EEE, dd yyyy"
    case MMMDDYYY = "MMM dd yyyy"
    case utcFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
    case ddmmmyyyy = "dd-MMM-yyyy"
    case ddMMMyyyy = "dd MMM yyyy"
    case ddMMM = "dd MMM"
    case dd = "dd"
    case ddMMyyyy = "dd/MM/yyyy"
    case ddmmmyyy = "dd MMM, yyyy"
    case ddmmmyyyT = "MM/dd/yyyy h:mm a"
}

struct CardButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        return configuration.label
            .scaleEffect(configuration.isPressed ? 0.96 : 1)
            .animation(/*@START_MENU_TOKEN@*/ .easeIn/*@END_MENU_TOKEN@*/, value: configuration.isPressed)
    }
}

