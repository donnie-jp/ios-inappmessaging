import UIKit

internal class OptOutMessageView: UIView {

    private enum Constants {
        static let fontSize: CGFloat = 12
        static let checkboxSize: CGFloat = 12
        static let spacing: CGFloat = 5
    }

    private let checkbox = Checkbox()
    var isChecked: Bool {
        return checkbox.isChecked
    }

    override init(frame: CGRect) {
        super.init(frame: .zero)
        commonInit()
    }

    convenience init() {
        self.init(frame: .zero)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        let optOutMessage = UILabel()
        optOutMessage.text = "optOut_message".localized
        optOutMessage.font = .systemFont(ofSize: Constants.fontSize)
        optOutMessage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapAction)))
        optOutMessage.isUserInteractionEnabled = true
        optOutMessage.sizeToFit()
        optOutMessage.translatesAutoresizingMaskIntoConstraints = false
        optOutMessage.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)

        checkbox.borderStyle = .square
        checkbox.uncheckedBorderColor = .black
        checkbox.checkedBorderColor = .black
        checkbox.checkmarkColor = .black
        checkbox.checkmarkStyle = .tick
        checkbox.borderWidth = 1
        checkbox.useHapticFeedback = false
        checkbox.accessibilityIdentifier = "optOutCheckbox"
        checkbox.translatesAutoresizingMaskIntoConstraints = false

        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        container.backgroundColor = .clear
        container.addSubview(optOutMessage)
        container.addSubview(checkbox)
        addSubview(container)

        let constraints = [
            checkbox.heightAnchor.constraint(equalToConstant: Constants.checkboxSize),
            checkbox.widthAnchor.constraint(equalToConstant: Constants.checkboxSize),
            checkbox.leadingAnchor.constraint(equalTo: container.leadingAnchor),
            checkbox.centerYAnchor.constraint(equalTo: optOutMessage.centerYAnchor),
            optOutMessage.leadingAnchor.constraint(equalTo: checkbox.trailingAnchor, constant: Constants.spacing),
            optOutMessage.topAnchor.constraint(equalTo: container.topAnchor),
            optOutMessage.bottomAnchor.constraint(equalTo: container.bottomAnchor),
            optOutMessage.trailingAnchor.constraint(equalTo: container.trailingAnchor),

            container.centerXAnchor.constraint(equalTo: centerXAnchor),
            container.topAnchor.constraint(equalTo: topAnchor),
            container.bottomAnchor.constraint(equalTo: bottomAnchor),
            trailingAnchor.constraint(greaterThanOrEqualTo: trailingAnchor),
            leadingAnchor.constraint(greaterThanOrEqualTo: leadingAnchor)
        ]
        NSLayoutConstraint.activate(constraints)
    }

    @objc private func tapAction() {
        checkbox.isChecked.toggle()
    }
}
