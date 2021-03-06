//
//  SceneViewController.swift
//  MUT20XX
//
//  Copyright © 2017 iDevGames. All rights reserved.
//

import Cocoa
import SpriteKit
import GameplayKit

class SceneViewController: NSViewController {

    @IBOutlet var skView: SKView!
    
	
	override var nibName: String? {
		return "SceneView"
	}
	
	
    override func viewDidLoad() {
        super.viewDidLoad()
        
		//view.ignoresSiblingOrder = true
		skView.showsFPS = true
		skView.showsNodeCount = true
    }
	
	
	
	func showMainMenu() {
		let scene = GKScene(fileNamed: "MainMenuScene")!
		let sceneNode = scene.rootNode as! MainMenuScene
		
		// Copy gameplay related content over to the scene
//		sceneNode.entities = scene.entities
//		sceneNode.graphs = scene.graphs
		
		sceneNode.scaleMode = .aspectFill
		skView.presentScene(sceneNode)
	}
}

