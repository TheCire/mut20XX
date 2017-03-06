//
//  GameSinglePlayerScene.swift
//  MUT20XX
//
//  Copyright © 2017 iDevGames. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameSinglePlayerScene: SKScene {
	
	
	private var bgNode: SKNode!
	private var boardNode: BoardNode!
	private var game = Game.shared
//	private var nextPieceDisplay = PieceDisplay!
	
	private var pausedLabel:SKLabelNode!
	
	private var hasLoadedScene = false
	override func sceneDidLoad() {
		guard hasLoadedScene == false else { return }
		hasLoadedScene = true
		
		bgNode = childNode(withName: "background")!
		boardNode = bgNode.childNode(withName: "PlayerBoard") as! BoardNode
		
		//initialize the paused label then assign it to the instance property
		let label = SKLabelNode(text: "Paused")
		label.fontSize = 188
		label.toggleBold()
		label.position = CGPoint(x: self.size.width / 2,
		                         y: self.size.height / 2)
		pausedLabel = label
		
		lastUpdateTime = 0
		game.newGame()
		game.start()
	}
	
	
	
	
	
	// MARK: - Events
	
	override func keyDown(with event: NSEvent) {
		switch event.keyCode {
		case Keycode.a: //ANSI A
			game.localPlayerInputMap[.rotateLeft].activated = !(game.state.paused)
		case Keycode.d: //ANSI D
			game.localPlayerInputMap[.rotateRight].activated = !(game.state.paused)
		case Keycode.space:
			game.localPlayerInputMap[.drop].activated = !(game.state.paused)
		case Keycode.downArrow:
			game.localPlayerInputMap[.moveDown].activated = !(game.state.paused)
		case Keycode.leftArrow:
			game.localPlayerInputMap[.moveLeft].activated = !(game.state.paused)
		case Keycode.rightArrow:
			game.localPlayerInputMap[.moveRight].activated = !(game.state.paused)
		case Keycode.p:
			game.pause()
			if game.state.paused {
				bgNode.addChild(pausedLabel)
			} else {
				bgNode.removeChildren(in: [pausedLabel])
				
			}
		default:
			break
		}
//		switch event.keyCode {
//		default:
//			print("keyDown: \(event.characters!) keyCode: \(event.keyCode)")
//		}
	}
	
	
	
	
	
	
	// MARK: - Updating
	private var lastUpdateTime : TimeInterval = 0
	private var lastRotationTime : TimeInterval = 0

	override func update(_ currentTime: TimeInterval) {
		if lastUpdateTime == 0 {
			lastUpdateTime = currentTime
		}
		defer { lastUpdateTime = currentTime }
		
		
		let timing = Game.UpdateTiming(now: currentTime, delta: currentTime - lastUpdateTime)
		game.update(timing: timing)
		
		
		boardNode.board = game.state.localPlayer.state.board
		boardNode.fallingPiece = game.state.localPlayer.state.currentPiece
	}
}


//add a bold computed property to the SKLabelNode

extension SKLabelNode {
	func toggleBold()
	{
		guard (fontName != nil) else {
			print("SKLabelNode attempting to set fontName when fontName isn't set")
			return
		}
		if isBold {
			self.fontName = self.fontName?.replacingOccurrences(of: "-Bold", with: "")
		} else {
			self.fontName = self.fontName! + "-Bold"
		}
	}
	var isBold:Bool {
		get {
			guard (fontName != nil) else { return false }
			return (fontName?.contains("-Bold"))!
		}
	}
}
