import UIKit

// MARK: UIViewController
extension UIViewController {

    func applyBackground() {
        view.backgroundColor = .systemBackground
    }

    func styleButton(_ btn: UIButton) {
        btn.backgroundColor = UIColor(red: 0.22, green: 0.38, blue: 0.76, alpha: 1)
        btn.setTitleColor(.white, for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        btn.clipsToBounds = true
    }

    func showToast(message: String, duration: Double = 2.0) {
        let toastLabel = UILabel()
        toastLabel.text = message
        toastLabel.textColor = .white
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        toastLabel.textAlignment = .center
        toastLabel.font = UIFont.systemFont(ofSize: 14)
        toastLabel.numberOfLines = 0
        toastLabel.alpha = 0
        toastLabel.layer.cornerRadius = 12
        toastLabel.clipsToBounds = true

        let maxWidth = view.frame.width - 48
        let textSize = toastLabel.sizeThatFits(CGSize(width: maxWidth, height: .greatestFiniteMagnitude))

        toastLabel.frame = CGRect(
            x: 24,
            y: view.frame.height - textSize.height - 100,
            width: maxWidth,
            height: textSize.height + 24
        )

        view.addSubview(toastLabel)

        UIView.animate(withDuration: 0.3) {
            toastLabel.alpha = 1
        } completion: { _ in
            UIView.animate(withDuration: 0.3, delay: duration, options: .curveEaseOut) {
                toastLabel.alpha = 0
            } completion: { _ in
                toastLabel.removeFromSuperview()
            }
        }
    }
}

// MARK: String
extension String {

    var isEmptyOrWhitespace: Bool {
        return trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    var isEnglishAlphanumeric: Bool {
        guard !self.isEmpty else { return false }
        return self.range(of: #"^[A-Za-z0-9 ]+$"#, options: .regularExpression) != nil
    }
}
