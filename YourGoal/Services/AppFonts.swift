import SwiftUI

struct AppFonts: ViewModifier {

    @Environment(\.sizeCategory) var sizeCategory

    public enum TextStyle {
        case navigationLargeTitle
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
        case .body, .fieldQuestion2 :
            return "Rubik"
        case .quote, .quoteAuthor:
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
            return 18
        case .button:
            return 25
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
        return UIFont(name:"IndieFlower", size: size)!
    }

}
