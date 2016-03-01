
import UIKit
import GameplayKit

class ViewController: UIViewController {

    var pokemonList = [String]()
    var score = 0
    var correctAnswer = 0

    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var myScoreLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
 
        myScoreLabel.text = "Score: \(score)"
        // Collect all resources from local filesystem.
        let fm = NSFileManager.defaultManager()
        let path = NSBundle.mainBundle().resourcePath!
        let images = try! fm.contentsOfDirectoryAtPath(path)
        
        // Accumulate reference to images in pokemonList.
        for image in images {
            if image.hasSuffix("png") {
                let imageTitle = image.stringByReplacingOccurrencesOfString(".png", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
                pokemonList.append(imageTitle)
            }
        }
        askQuestion()
    }
    
    func askQuestion(action: UIAlertAction! = nil) {

        // Shuffle pokemonList so the first three indexes are truly random.
        pokemonList = GKRandomSource.sharedRandom().arrayByShufflingObjectsInArray(pokemonList) as! [String]

        // Assign (the now random) strings at index 1..2 to UIImage buttons.
        button1.setImage(UIImage(named: pokemonList[0]), forState: .Normal)


        
        // Generate random number to reference the display title and correct index in pokemonList.
        correctAnswer = GKRandomSource.sharedRandom().nextIntWithUpperBound(3)
        title = pokemonList[correctAnswer].uppercaseString
    }
    
    @IBAction func buttonTapped(sender: UIButton) {
        var title: String
        if sender.tag == correctAnswer {
            title = "That's correct!"
            ++score
        } else {
            title = "Nope. Sorry."
            --score
        }
        let ac = UIAlertController(title: title, message: "Your score is \(score).", preferredStyle: .Alert)
        ac.addAction(UIAlertAction(title: "Continue", style: .Default, handler: askQuestion))
        presentViewController(ac, animated: true, completion: nil)
        myScoreLabel.text = "Score: \(score)"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

