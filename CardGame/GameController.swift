import UIKit

// MARK: GameController
class GameController: UIViewController {

    @IBOutlet weak var lblPlayerName: UILabel!
    @IBOutlet weak var lblPCName: UILabel!
    @IBOutlet weak var lblPlayerScore: UILabel!
    @IBOutlet weak var lblPCScore: UILabel!
    @IBOutlet weak var imgPlayerCard: UIImageView!
    @IBOutlet weak var imgPCCard: UIImageView!
    @IBOutlet weak var lblTimer: UILabel!

    var playerName = ""
    var playerSide = ""

    private var playerScore = 0
    private var pcScore = 0
    private var roundCount = 0

    private var currentPlayerCard: Card?
    private var currentPCCard: Card?

    private let gm = GameManager()
    private var timer: Timer?
    private var timeLeft = 5

    private var playerDrawsRed = true

    private let redBack   = UIImage(named: "card_back_red")
    private let blackBack = UIImage(named: "card_back")

    override func viewDidLoad() {
        super.viewDidLoad()

        print("Hi Game!")

        applyBackground()
        setupUI()

        playerDrawsRed = (playerSide == "East Side")

        imgPlayerCard.contentMode = .scaleAspectFill
        imgPlayerCard.clipsToBounds = true
        imgPCCard.contentMode = .scaleAspectFill
        imgPCCard.clipsToBounds = true

        registerLifecycleObservers()

        updateUI()
        SoundManager.shared.playBackground()
        startRound()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        // card corner radius proportional to card width (C × R)
        let r = imgPlayerCard.frame.width * 0.07
        imgPlayerCard.layer.cornerRadius = r
        imgPCCard.layer.cornerRadius = r
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer?.invalidate()
        SoundManager.shared.stopBackground()
    }

    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    // MARK: Lifecycle observers
    private func registerLifecycleObservers() {
        NotificationCenter.default.addObserver(self,
            selector: #selector(appDidBackground),
            name: UIApplication.didEnterBackgroundNotification, object: nil)
        NotificationCenter.default.addObserver(self,
            selector: #selector(appWillForeground),
            name: UIApplication.willEnterForegroundNotification, object: nil)
    }

    @objc private func appDidBackground() {
        timer?.invalidate()
        SoundManager.shared.pauseBackground()
    }

    @objc private func appWillForeground() {
        SoundManager.shared.resumeBackground()
        startTimer()
    }

    private func setupUI() {
        lblPlayerName.font      = UIFont.systemFont(ofSize: 15, weight: .semibold)
        lblPlayerName.textColor = .secondaryLabel

        lblPCName.font      = UIFont.systemFont(ofSize: 15, weight: .semibold)
        lblPCName.textColor = .secondaryLabel

        lblPlayerScore.font      = UIFont.systemFont(ofSize: 52, weight: .heavy)
        lblPlayerScore.textColor = .label

        lblPCScore.font      = UIFont.systemFont(ofSize: 52, weight: .heavy)
        lblPCScore.textColor = .label

        lblTimer.font      = UIFont.monospacedDigitSystemFont(ofSize: 32, weight: .bold)
        lblTimer.textColor = UIColor(red: 0.22, green: 0.38, blue: 0.76, alpha: 1)

        lblPlayerName.text = playerName
        lblPCName.text     = "PC"
    }

    private func updateUI() {
        lblPlayerScore.text = "\(playerScore)"
        lblPCScore.text     = "\(pcScore)"
        lblTimer.text       = "\(timeLeft)"
    }

    // MARK: Card back helpers
    private var playerBack: UIImage? { playerDrawsRed ? redBack   : blackBack }
    private var pcBack:     UIImage? { playerDrawsRed ? blackBack : redBack   }

    private func flipToBack(_ imageView: UIImageView, back: UIImage?, flipDirection: UIView.AnimationOptions) {
        UIView.transition(with: imageView, duration: 0.35, options: flipDirection) {
            imageView.image = back
            imageView.backgroundColor = .clear
        }
    }

    private func flipToFace(_ imageView: UIImageView, card: Card, flipDirection: UIView.AnimationOptions) {
        UIView.transition(with: imageView, duration: 0.35, options: flipDirection) {
            imageView.image = UIImage(named: card.imageName)
            imageView.backgroundColor = .clear
        }
    }

    // MARK: Game Logic
    private func startRound() {
        if roundCount >= 10 {
            gameOver()
            return
        }

        let playerCard = playerDrawsRed ? gm.drawRedCard() : gm.drawBlackCard()
        let pcCard     = playerDrawsRed ? gm.drawBlackCard() : gm.drawRedCard()
        currentPlayerCard = playerCard
        currentPCCard = pcCard

        SoundManager.shared.playFlip()
        flipToBack(imgPlayerCard, back: playerBack, flipDirection: .transitionFlipFromRight)
        flipToBack(imgPCCard,     back: pcBack,     flipDirection: .transitionFlipFromLeft)

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            SoundManager.shared.playFlip()
            self.flipToFace(self.imgPlayerCard, card: playerCard, flipDirection: .transitionFlipFromLeft)
            self.flipToFace(self.imgPCCard,     card: pcCard,     flipDirection: .transitionFlipFromRight)
            self.timeLeft = 5
            self.updateUI()
            self.startTimer()
        }
    }

    private func startTimer() {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self,
                                     selector: #selector(timerTick), userInfo: nil, repeats: true)
    }

    @objc private func timerTick() {
        timeLeft -= 1
        lblTimer.text = "\(timeLeft)"

        if timeLeft == 0 {
            timer?.invalidate()
            calcRound()
        }
    }

    private func calcRound() {
        guard let playerCard = currentPlayerCard, let pcCard = currentPCCard else { return }
        let pVal  = playerCard.value
        let pcVal = pcCard.value

        if pVal > pcVal {
            playerScore += pVal
            animateScore(lblPlayerScore)
        } else if pcVal > pVal {
            pcScore += pcVal
            animateScore(lblPCScore)
        }
        // equal cards: no points awarded

        roundCount += 1
        updateUI()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.startRound()
        }
    }

    private func animateScore(_ label: UILabel) {
        UIView.animate(withDuration: 0.15, animations: {
            label.transform = CGAffineTransform(scaleX: 1.35, y: 1.35)
        }) { _ in
            UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 0.5,
                           initialSpringVelocity: 0.8) {
                label.transform = .identity
            }
        }
    }

    private func gameOver() {
        timer?.invalidate()
        SoundManager.shared.stopBackground()
        SoundManager.shared.playWin()
        performSegue(withIdentifier: "toSummary", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toSummary" {
            let dest = segue.destination as! SummaryController
            dest.playerName  = playerName
            dest.playerScore = playerScore
            dest.pcScore     = pcScore
        }
    }
}
