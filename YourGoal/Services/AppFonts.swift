import SwiftUI

struct AppFonts: ViewModifier {

    @Environment(\.sizeCategory) var sizeCategory

    public enum TextStyle {
        case largeTitle
        case title
        case title2
        case title3
        case button
        case body
        case small
        case journal
        case quote
        case quoteAuthor
        case smallQuote
        case fieldQuestion
        case fieldQuestion2
    }

    var textStyle: TextStyle

    func body(content: Content) -> some View {
       let scaledSize = UIFontMetrics.default.scaledValue(for: size)
       return content.font(.custom(fontName, size: scaledSize))
    }

    private var fontName: String {
        switch textStyle {
        case .title2, .title3, .button, .journal, .fieldQuestion:
            return "IndieFlower"
        case .quote, .quoteAuthor, .smallQuote:
            return "Caveat"
        default:
            return "Rubik"
        }
    }

    private var size: CGFloat {
        switch textStyle {
        case .largeTitle:
            return 26
        case .title:
            return 24
        case .title2:
            return 22
        case .title3:
            return 18
        case .button:
            return 25
        case .body:
            return 17
        case .small:
            return 14
        case .journal:
            return 25
        case .quote:
            return 40
        case .quoteAuthor:
            return 35
        case .smallQuote:
            return 22
        case .fieldQuestion:
            return 20
        case .fieldQuestion2:
            return 16
        }
    }

}

extension View {

    func applyFont(_ textStyle: AppFonts.TextStyle) -> some View {
        self.modifier(AppFonts(textStyle: textStyle))
    }

}

extension UIFont {

    static func regularFontOf(size: CGFloat) -> UIFont {
        return UIFont(name:"Rubik", size: size)!
    }

}
