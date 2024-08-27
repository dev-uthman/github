// swiftlint:disable all
// Generated using SwiftGen — https://github.com/SwiftGen/SwiftGen

import Foundation

// swiftlint:disable superfluous_disable_command file_length implicit_return prefer_self_in_static_references

// MARK: - Strings

// swiftlint:disable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:disable nesting type_body_length type_name vertical_whitespace_opening_braces
public enum Strings {
  public enum Details {
    /// Voltar
    public static let backButtonTile = Strings.tr("Details", "backButtonTile", fallback: "Voltar")
    /// Repositórios
    public static let repos = Strings.tr("Details", "repos", fallback: "Repositórios")
    /// Detalhes do usuário
    public static let title = Strings.tr("Details", "title", fallback: "Detalhes do usuário")
  }
  public enum List {
    /// file
    public static let fileDesc = Strings.tr("List", "fileDesc", fallback: "file")
    /// files
    public static let filesDesc = Strings.tr("List", "filesDesc", fallback: "files")
    /// Lista de usuários
    public static let title = Strings.tr("List", "title", fallback: "Lista de usuários")
  }
}
// swiftlint:enable explicit_type_interface function_parameter_count identifier_name line_length
// swiftlint:enable nesting type_body_length type_name vertical_whitespace_opening_braces

// MARK: - Implementation Details

extension Strings {
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
