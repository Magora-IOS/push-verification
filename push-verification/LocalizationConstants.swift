import Foundation

enum L10n {
	case NotificationsTokenWait
	case NotificationsTokenError
	case NotificationsVCTitle
	case NotificationsVCTokenTitle
	case NotificationsVCNotificationsTitle
}


extension L10n: CustomStringConvertible {
	var description: String { return self.string }

	var string: String {
		switch self {
			case .NotificationsTokenWait:
				return L10n.tr(key: "Notifications.Token.Wait")
			case .NotificationsTokenError:
				return L10n.tr(key: "Notifications.Token.Error")
			case .NotificationsVCTitle:
				return L10n.tr(key: "NotificationsVC.Title")
			case .NotificationsVCTokenTitle:
				return L10n.tr(key: "NotificationsVC.Token.Title")
			case .NotificationsVCNotificationsTitle:
				return L10n.tr(key: "NotificationsVC.Notifications.Title")

		}
	}

	private static func tr(key: String, _ args: CVarArg...) -> String {
		let format = NSLocalizedString(key, bundle: Bundle(for: BundleToken.self), comment: "")
		return String(format: format, locale: Locale.current, arguments: args)
	}
}

func tr(_ key: L10n) -> String {
	return key.string
}

private final class BundleToken {}
