// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
internal enum L10n {
  internal enum Button {
    /// Add
    internal static let add = L10n.tr("Localizable", "button.add", fallback: "Add")
    /// Added
    internal static let added = L10n.tr("Localizable", "button.added", fallback: "Added")
    /// All
    internal static let all = L10n.tr("Localizable", "button.all", fallback: "All")
    /// Cancel
    internal static let cancel = L10n.tr("Localizable", "button.cancel", fallback: "Cancel")
    /// Filte
    internal static let filter = L10n.tr("Localizable", "button.filter", fallback: "Filte")
  }
  internal enum Main {
    /// Localizable.strings
    ///   Kitchen Buddy
    /// 
    ///   Created by Nikita Marin on 07.06.2023.
    internal static let lastRecipeSection = L10n.tr("Localizable", "main.lastRecipeSection", fallback: "Hello")
    /// Other Wines
    internal static let otherWineSection = L10n.tr("Localizable", "main.otherWineSection", fallback: "Other Wines")
    /// Red Wines
    internal static let redWineSection = L10n.tr("Localizable", "main.redWineSection", fallback: "Red Wines")
    /// Try this
    internal static let selectionRecipeSection = L10n.tr("Localizable", "main.selectionRecipeSection", fallback: "Try this")
    /// White Wines
    internal static let whiteWineSection = L10n.tr("Localizable", "main.whiteWineSection", fallback: "White Wines")
  }
  internal enum PlaceHolder {
    /// Search ingredients
    internal static let ingredients = L10n.tr("Localizable", "placeHolder.ingredients", fallback: "Search ingredients")
    /// Search recipes
    internal static let recipes = L10n.tr("Localizable", "placeHolder.recipes", fallback: "Search recipes")
  }
  internal enum Search {
    /// ▼ Included ingredients
    internal static let ingredients = L10n.tr("Localizable", "search.ingredients", fallback: "▼ Included ingredients")
  }
  internal enum Tabbar {
    /// Favourite
    internal static let favourite = L10n.tr("Localizable", "tabbar.favourite", fallback: "Favourite")
    /// Main
    internal static let main = L10n.tr("Localizable", "tabbar.main", fallback: "Main")
    /// Search
    internal static let search = L10n.tr("Localizable", "tabbar.search", fallback: "Search")
  }
  internal enum Title {
    /// Favourite
    internal static let favourite = L10n.tr("Localizable", "title.favourite", fallback: "Favourite")
    /// Filters
    internal static let filter = L10n.tr("Localizable", "title.filter", fallback: "Filters")
    /// Recipes
    internal static let selection = L10n.tr("Localizable", "title.selection", fallback: "Recipes")
  }
  internal enum Wine {
    /// There is no description
    internal static let noDescription = L10n.tr("Localizable", "wine.noDescription", fallback: "There is no description")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension L10n {
  private static func tr(_ table: String, _ key: String, _ args: CVarArg..., fallback value: String) -> String {
    let format = BundleToken.bundle.localizedString(forKey: key, value: value, table: table)
    return String(format: format, locale: Locale.current, arguments: args)
  }
}

// swiftlint:disable convenience_type
private final class BundleToken {
  static let bundle: Bundle = {
    #if SWIFT_PACKAGE
    return Bundle.module
    #else
    return Bundle(for: BundleToken.self)
    #endif
  }()
}
// swiftlint:enable convenience_type
