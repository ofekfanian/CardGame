import UIKit

// MARK: ViewController
class ViewController: UIViewController {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblSide: UILabel!
    @IBOutlet weak var btnStart: UIButton!

    private var playerName = ""
    private var playerSide = ""
    private let lm = LocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()

        print("Hi Menu!")

        navigationController?.setNavigationBarHidden(true, animated: false)

        applyBackground()
        setupUI()
        btnStart.isEnabled = false

        lm.callBackLM = self

        if let saved = UserDefaults.standard.string(forKey: "playerName"), !saved.isEmpty {
            playerName = saved
        } else {
            showNameAlert()
        }

        updateUI()
        lm.start()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        btnStart.layer.cornerRadius = btnStart.frame.height * 0.35  // C × R
    }

    private func setupUI() {
        lblName.font      = UIFont.systemFont(ofSize: 28, weight: .bold)
        lblName.textColor = .label

        lblSide.font      = UIFont.systemFont(ofSize: 14, weight: .medium)
        lblSide.textColor = .secondaryLabel

        styleButton(btnStart)
    }

    private func updateUI() {
        lblName.text = playerName.isEmpty ? "Hi!" : "Hi \(playerName)"
        lblSide.text = playerSide.isEmpty ? "Detecting location…" : playerSide
        btnStart.isEnabled = !playerName.isEmpty && !playerSide.isEmpty
    }

    @IBAction func btnInsertNameClicked(_ sender: UIButton) {
        showNameAlert()
    }

    @IBAction func btnStartClicked(_ sender: UIButton) {
        performSegue(withIdentifier: "toGame", sender: self)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toGame" {
            let dest = segue.destination as! GameController
            dest.playerName = playerName
            dest.playerSide = playerSide
        }
    }
}

// MARK: Alert
extension ViewController {

    func showNameAlert() {
        let alert = UIAlertController(title: "Insert Name", message: nil, preferredStyle: .alert)
        alert.addTextField { tf in
            tf.placeholder = "Enter your name"
            tf.autocapitalizationType = .words
        }
        let save = UIAlertAction(title: "Save", style: .default) { _ in
            let input = (alert.textFields![0].text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)
            guard !input.isEmptyOrWhitespace else { return }
            guard input.isEnglishAlphanumeric else {
                self.showToast(message: "English letters and numbers only")
                return
            }
            self.playerName = input
            UserDefaults.standard.set(input, forKey: "playerName")
            self.updateUI()
        }
        alert.addAction(save)
        present(alert, animated: true)
    }
}

// MARK: LocationCallBack
extension ViewController: LocationCallBack {

    func locationUpdated(longitude: Double) {
        let center = 34.817549168324334
        playerSide = longitude > center ? "East Side" : "West Side"
        lm.stop()
        updateUI()
    }
}
