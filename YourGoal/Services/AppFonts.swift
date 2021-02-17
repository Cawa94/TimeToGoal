import SwiftUI

struct AppFonts: ViewModifier {

    @Environment(\.sizeCategory) var sizeCategory

    public enum TextStyle {
        case navigationLargeTitle
        case largeTitle
        case title
        case title2
        case title3
        case title4
        case button
        case smallButton
        case body
        case small
        case journal
        case quote
        case quoteAuthor
        case smallQuote
        case smallQuoteAuthor
        case fieldQuestion
        case field
        case fieldLarge
    }

    var textStyle: TextStyle

    func body(content: Content) -> some View {
       let scaledSize = UIFontMetrics.default.scaledValue(for: size)
       return content.font(.custom(fontName, size: scaledSize))
    }

    private var fontName: String {
        switch textStyle {
        case .body :
            return "Rubik"
        case .quote, .quoteAuthor, .smallQuote, .smallQuoteAuthor:
            return "Caveat"
        default:
            return "IndieFlower"
        }
    }

    private var size: CGFloat {
        switch textStyle {
        case .navigationLargeTitle:
            return 36
        case .largeTitle:
            return 28
        case .title:
            return 25
        case .title2:
            return 22
        case .title3:
            return 20
        case .title4:
            return 18
        case .button:
            return 25
        case .smallButton:
            return 18
        case .body:
            return 17
        case .small:
            return 17
        case .journal:
            return 25
        case .quote:
            return 40
        case .quoteAuthor:
            return 35
        case .smallQuote:
            return 25
        case .smallQuoteAuthor:
            return 20
        case .fieldQuestion:
            return 20
        case .field:
            return 25
        case .fieldLarge:
            return 40
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
        return UIFont(name:"IndieFlower", size: size)!
    }

}
