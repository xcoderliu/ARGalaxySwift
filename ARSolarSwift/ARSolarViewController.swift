//
//  ARSolarViewController.swift
//  ARSolarSwift
//
//  Created by 刘智民 on 25/11/2017.
//  Copyright © 2017 刘智民. All rights reserved.
//

import UIKit
import ARKit
import SceneKit

class ARSolarViewController: UIViewController,ARSCNViewDelegate,ARSessionDelegate {
    let arSCNView = ARSCNView()
    let arSession = ARSession()
    let sessionconfig = ARWorldTrackingConfiguration()
    let baseNode = SCNNode()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        arSession.delegate = self
        self.arSCNView.session = arSession
        arSCNView.automaticallyUpdatesLighting = true
        arSCNView.delegate = self
        arSCNView.frame = self.view.frame
        if !self.view.subviews.contains(arSCNView) {
            self.view.addSubview(arSCNView)
        }
        
        baseNode.position = SCNVector3Make(0, 0, 0)
        let scene = SCNScene()
        self.arSCNView.scene = scene
        scene.rootNode.addChildNode(baseNode)
        self.initSolar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        arSession.run(self.sessionconfig)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.arSCNView.session.pause()
    }
    
    func initSolar() {
        let sun = createPlanet(radius: 0.25, image: "sun")
        sun.position = SCNVector3Make(0, -0.2, -1.6)
        self.rotateObject(rotation: -0.4, node: sun, duration: 1)
        baseNode.addChildNode(sun)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createPlanet(radius: Float,image: String) -> SCNNode {
        let planet = SCNSphere(radius: CGFloat(radius))
        let material = SCNMaterial()
        material.diffuse.contents = UIImage(named: "art.scnassets/earth/\(image).jpg")
        planet.materials = [material]
        let planetNode = SCNNode(geometry: planet)
        return planetNode
    }
    
    func rotateObject(rotation: Float,node :SCNNode,duration: Float) {
        let rotation = SCNAction.rotateBy(x: 0, y: CGFloat(rotation), z: 0, duration: TimeInterval(duration))
        node.runAction(.repeatForever(rotation))
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        
    }

}
