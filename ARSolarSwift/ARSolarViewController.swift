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
    let baseY:Float = -0.2
    let baseZ:Float = -1.6
    
    
    
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
        self.initAirplane()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        arSession.run(self.sessionconfig)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.arSCNView.session.pause()
    }
    
    func initSolar() {
        let sun = createPlanet(radius: 0.25, image: "sun")
        sun.position = SCNVector3Make(0, baseY, baseZ)
        rotateObject(rotation: -0.4, node: sun, duration: 1)
        baseNode.addChildNode(sun)
        
        //水星
        let mercury = createPlanet(radius: 0.03, image: "mercury")
        mercury.position = SCNVector3Make(0.3, 0, 0)
        let mercuryRing = createRing(ringSize: 0.3)
        mercuryRing.addChildNode(mercury)
        baseNode.addChildNode(mercuryRing)
        
    
        //金星
        let venus = createPlanet(radius: 0.04, image: "venus")
        venus.position = SCNVector3Make(0.5, 0, 0)
        let venusRing = createRing(ringSize: 0.5)
        venusRing.addChildNode(mercury)
        baseNode.addChildNode(venusRing)

        //地球
        let earth = createPlanet(radius: 0.05, image: "earth-diffuse")
        earth.position = SCNVector3Make(0.7, 0, 0)
        let earthRing = createRing(ringSize: 0.7)
        earthRing.addChildNode(earth)
        baseNode.addChildNode(earthRing)
        
        //月亮
        let moon = createPlanet(radius: 0.008, image: "moon")
        moon.position = SCNVector3Make(0.08, 0, 0)
        let moonRing = createRing(ringSize: 0.08)
        moonRing.position = SCNVector3Make(0, 0, 0)
        moonRing.addChildNode(moon)
        earth.addChildNode(moonRing)
        rotateObject(rotation: -0.3, node: moon, duration: 1)
        rotateObject(rotation: -0.4, node: moonRing, duration: 1)

        //火星
        let mars = createPlanet(radius: 0.03, image: "mars")
        mars.position = SCNVector3Make(0.8, 0, 0)
        let marsRing = createRing(ringSize: 0.8)
        marsRing.addChildNode(mars)
        baseNode.addChildNode(marsRing)

        //木星
        let jupiter = createPlanet(radius: 0.12, image: "jupiter")
        jupiter.position = SCNVector3Make(1, 0, 0)
        let jupiterRing = createRing(ringSize: 1)
        jupiterRing.addChildNode(jupiter)
        baseNode.addChildNode(jupiterRing)

        //土星
        let saturn = createPlanet(radius: 0.09, image: "saturn")
        saturn.position = SCNVector3Make(1.25, 0, 0)
        let saturnRing = createRing(ringSize: 1.25)
        saturnRing.addChildNode(saturn)
        baseNode.addChildNode(saturnRing)
        
        //土星环
        let saturnloop = SCNNode()
        saturnloop.position = SCNVector3Make(0, 0, 0)
        saturnloop.rotation = SCNVector4Make(-0.5, -1, 0, Float(CGFloat.pi));
        saturnloop.opacity = 0.4
        saturnloop.geometry = SCNBox(width: 0.6, height: 0, length: 0.6, chamferRadius: 0)
        saturnloop.geometry?.firstMaterial?.diffuse.contents = UIImage(named: "art.scnassets/earth/saturn_loop.png")
        saturnloop.geometry?.firstMaterial?.diffuse.mipFilter = .linear
        saturn.addChildNode(saturnloop)

        //水星
        let uranus = createPlanet(radius: 0.07, image: "uranus")
        uranus.position = SCNVector3Make(1.5, 0, 0)
        let uranusRing = createRing(ringSize: 1.5)
        uranusRing.addChildNode(uranus)
        baseNode.addChildNode(uranusRing)
        
        //海王星
        let neptune = createPlanet(radius: 0.08, image: "mercury")
        mercury.position = SCNVector3Make(1.7, 0, 0)
        let neptuneRing = createRing(ringSize: 1.7)
        neptuneRing.addChildNode(neptune)
        baseNode.addChildNode(neptuneRing)
        
        //添加文字
        let text = SCNText(string: "欢迎来到银河系!hello world!!", extrusionDepth: 0.01)
        text.font = UIFont.systemFont(ofSize: 0.1)
        let textNode = SCNNode(geometry: text)
        textNode.position = SCNVector3(-0.6, -0.6, baseZ)
        baseNode.addChildNode(textNode)
        
        
        let author = SCNText(string: "Author:xcoderliu@gmail.com", extrusionDepth: 0.01)
        author.font = UIFont.systemFont(ofSize: 0.1)
        let authorNode = SCNNode(geometry: author)
        authorNode.position = SCNVector3(-0.6, -0.8, baseZ)
        baseNode.addChildNode(authorNode)

        
        
        rotateObject(rotation: -0.6, node: mercuryRing, duration: 0.5)
        rotateObject(rotation: -0.4, node: venusRing, duration: 0.5)
        rotateObject(rotation: -0.25, node: earthRing, duration: 0.5)
        rotateObject(rotation: -0.8, node: marsRing, duration: 0.5)
        rotateObject(rotation: -0.2, node: jupiterRing, duration: 0.5)
        rotateObject(rotation: -0.3, node: saturnRing, duration: 0.5)
        rotateObject(rotation: -0.5, node: uranusRing, duration: 0.5)
        rotateObject(rotation: -0.9, node: neptuneRing, duration: 0.5)
        
        rotateObject(rotation: -0.3, node: mercury, duration: 0.5)
        rotateObject(rotation: -0.3, node: venus, duration: 0.5)
        rotateObject(rotation: -0.3, node: earth, duration: 0.5)
        rotateObject(rotation: -0.3, node: mars, duration: 0.5)
        rotateObject(rotation: -0.3, node: jupiter, duration: 0.5)
        rotateObject(rotation: -0.3, node: saturn, duration: 0.5)
        rotateObject(rotation: -0.3, node: uranus, duration: 0.5)
        rotateObject(rotation: -0.3, node: neptune, duration: 0.5)
    }
    
    func initAirplane() {
        let airplaneScene = SCNScene(named:"art.scnassets/shipc.scn")
        let airplaneNode = airplaneScene?.rootNode.childNode(withName: "ship", recursively: true)
        airplaneNode?.position = SCNVector3Make(1.8, baseY, baseZ + 1)
        airplaneNode?.scale = SCNVector3Make(0.1, 0.1, 0.1)
        let rotation = SCNAction.rotateBy(x: 0, y: CGFloat(-(CGFloat.pi/2)), z: 0, duration: TimeInterval(0.01))
        airplaneNode?.runAction(rotation)
        let forword = SCNAction.move(by: SCNVector3Make(-0.2, 0, -0.04), duration: 1)
        airplaneNode?.runAction(.repeatForever(forword))
        baseNode.addChildNode(airplaneNode!)
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
    
    func createRing(ringSize: Float) -> SCNNode {
        let ring = SCNTorus(ringRadius: CGFloat(ringSize), pipeRadius: 0.001)
        let materrial = SCNMaterial()
        materrial.diffuse.contents = UIColor.lightGray
        ring.materials = [materrial]
        let ringNode = SCNNode(geometry: ring)
        ringNode.position = SCNVector3Make(0, baseY, baseZ)
        return ringNode
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    func session(_ session: ARSession, didUpdate frame: ARFrame) {
        //近距离可放大 原理就是 坐标系后退相当于人前进 所以-值相乘 但是为了凸显效果所以 *3
        self.baseNode.position = SCNVector3Make(-3 * frame.camera.transform.columns.3.x, -3 * frame.camera.transform.columns.3.y, -3 * frame.camera.transform.columns.3.z)
    }
    
    func renderer(_ renderer: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        
    }

}
