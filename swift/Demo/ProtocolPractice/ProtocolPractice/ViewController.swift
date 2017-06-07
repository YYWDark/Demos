//
//  ViewController.swift
//  ProtocolPractice
//
//  Created by wyy on 2017/6/7.
//  Copyright © 2017年 wyy. All rights reserved.
//

import UIKit
//http://www.jianshu.com/p/80bd6633ec7c?utm_campaign=hugo&utm_medium=reader_share&utm_content=note

protocol RandomNumberGenerator {
    func random() -> Double
}

class LinearCongruentialGenerator: RandomNumberGenerator {
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    func random() -> Double {
        lastRandom = ((lastRandom * a + c).truncatingRemainder(dividingBy: m))
        return lastRandom / m
    }
}


class Dice {
    let sides: Int
    let generator: RandomNumberGenerator
    init (sides: Int, generator: RandomNumberGenerator) {
        self.sides = sides
        self.generator = generator
    }
    func roll() -> Int {
        return Int(generator.random() * Double(sides)) + 1
    }
}

protocol DiceGame {
    var dice: Dice{ get }
    func play()
}

protocol DiceGameDelegate {
    func gameDidStart(_ game: DiceGame)
    func game(_ game: DiceGame, _ diceRoll: Int)
    func gameDidEnd(_ game: DiceGame)
}

class SnakesAndLAdders: DiceGame {
    let finalSquare = 25
    let dice = Dice(sides: 6, generator: LinearCongruentialGenerator())
//    var board: [Int]
    
    init() {
//        board = [Int](count: finalSquare + 1, repeatedValue: 0)
//        board[03] = 08; board[06] = 11; board[09] = 09; board[10] = +02
//        board[14] = -10; board[19] = -11; board[22] = -02; board[24] = -08
    }
    
    var delegate: DiceGameDelegate?
    internal func play() {
      delegate?.gameDidStart(self)
        var squre = 0
        gameLoop: while squre != finalSquare {
            let diceRoll = dice.roll()
             delegate?.game(self, didStartNewTurnWithDiceRoll: diceRoll)
        }
    }
}

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        let vc = VC()
        vc.methodThatHasAnError("呵呵哒")
        */
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
/*
protocol ErrorPopovertRender {
    func presentError(_ errorMsg: NSString)
}

class BaseViewController: ErrorPopovertRender{
    internal func presentError(_ errorMsg: NSString) {
        let code = "-1001"
        print("baseViewController 错误信息 = \(errorMsg), code == \(code)")
    }
}

class VC: BaseViewController {
    func methodThatHasAnError(_ errorMsg: NSString) {
        presentError(errorMsg)
    }
}

*/
