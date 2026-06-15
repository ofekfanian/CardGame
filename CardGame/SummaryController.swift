import UIKit

// MARK: SummaryController
class SummaryController: UIViewController {

    @IBOutlet weak var lblWinner: UILabel!
    @IBOutlet weak var lblScore: UILabel!

    var playerName = ""
    var playerScore = 0
    var pcScore = 0

    override func viewDidLoad() {
        super.viewDidLoad()

        print("Hi Summary!")

        applyBackground()
        setupUI()
        addCardDecorations()
        updateUI()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        for sv in view.subviews {
            if let btn = sv as? UIButton {
                btn.layer.cornerRadius = btn.frame.height * 0.35
            }
        }
    }

    private func setupUI() {
        lblWinner.font      = UIFont.systemFont(ofSize: 34, weight: .heavy)
        lblWinner.textColor = .label
        lblWinner.textAlignment = .center

        lblScore.font      = UIFont.systemFont(ofSize: 22, weight: .regular)
        lblScore.textColor = .secondaryLabel
        lblScore.textAlignment = .center

        for sv in view.subviews {
            if let btn = sv as? UIButton { styleButton(btn) }
        }
    }

    private func addCardDecorations() {
        let leftImg  = makeCardDeco("globe_west", angle: -0.18)
        let rightImg = makeCardDeco("globe_east", angle:  0.18)
        view.insertSubview(leftImg,  at: 1)
        view.insertSubview(rightImg, at: 1)

        NSLayoutConstraint.activate([
            leftImg.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.15),
            leftImg.heightAnchor.constraint(equalTo: leftImg.widthAnchor),
            leftImg.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16),
            leftImg.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),

            rightImg.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.15),
            rightImg.heightAnchor.constraint(equalTo: rightImg.widthAnchor),
            rightImg.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -16),
            rightImg.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16)
        ])
    }

    private func makeCardDeco(_ name: String, angle: CGFloat) -> UIImageView {
        let iv = UIImageView(image: UIImage(named: name))
        iv.contentMode = .scaleAspectFit
        iv.alpha = 0.45
        iv.transform = CGAffineTransform(rotationAngle: angle)
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }

    private func updateUI() {
        let winner: String
        let score: Int

        if playerScore > pcScore {
            winner = playerName
            score  = playerScore
        } else if pcScore > playerScore {
            winner = "PC"
            score  = pcScore
        } else {
            winner = "It's a Tie!"
            score  = playerScore
        }

        lblWinner.text = "Winner: \(winner)"
        lblScore.text  = "Score: \(score)"

        lblWinner.alpha = 0
        lblScore.alpha  = 0
        UIView.animate(withDuration: 0.5, delay: 0.1) { self.lblWinner.alpha = 1 }
        UIView.animate(withDuration: 0.5, delay: 0.3) { self.lblScore.alpha  = 1 }
    }

    @IBAction func btnBackClicked(_ sender: UIButton) {
        navigationController?.popToRootViewController(animated: true)
    }
}
