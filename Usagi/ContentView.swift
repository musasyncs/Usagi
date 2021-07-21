//
//  ContentView.swift
//  Usagi
//
//  Created by Ewen on 2021/7/21.
//

import SwiftUI

struct DrawView: UIViewRepresentable {
    func makeUIView(context: Context) -> UIView {
        
        let view = UIView()
        
        let containerView = UIView()
        //淡淡的底圖參考
//        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 390, height: 495))
//        imageView.image = UIImage(named: "rabbit")
//        imageView.alpha = 0.3
//        view.addSubview(imageView)
        
        //頭
        containerView.layer.addSublayer(addHead())
        //身體白色部分
        containerView.layer.addSublayer(addBodyPaint())
        //臉白色部分
        containerView.layer.addSublayer(addFacePaint())
        //左邊腮紅
        containerView.layer.addSublayer(addLeftPaint())
        //右邊腮紅
        containerView.layer.addSublayer(addRightPaint())
        //嘴下部
        containerView.layer.addSublayer(addMouthBottom())
        //嘴上部
        containerView.layer.addSublayer(addMouthUpper())
        //下巴
        containerView.layer.addSublayer(addChin())
        //鼻
        containerView.layer.addSublayer(addNose())
        //眼
        containerView.layer.addSublayer(addEyes())
        
        //桌
        containerView.layer.addSublayer(addTable())
        //盤子
        containerView.layer.addSublayer(addPlate())
        //蛋糕
        containerView.layer.addSublayer(addCake())
        //草莓
        containerView.layer.addSublayer(addStrawBerry())
        //蛋糕餡
        containerView.layer.addSublayer(addFill())
        //蓋掉跑到蛋糕邊界的餡料
        containerView.layer.addSublayer(cakeCorrection())
        
        //叉子
//        containerView.layer.addSublayer(addFork())
        //湯匙
//        containerView.layer.addSublayer(addSpoon())
        //左邊的手
//        containerView.layer.addSublayer(addLeftHand())
        //右邊的手
//        containerView.layer.addSublayer(addRightHand())

        
        //把Usagi平移、縮放、旋轉到想要位置，兩方法選一
        //法一：transform containerView
        containerView.transform = CGAffineTransform.identity.translatedBy(x: 17, y: 30).scaledBy(x: 1, y: 1).rotated(by: CGFloat.pi/180*0)
        //法二：transform containerView 裡的 layer
        containerView.layer.setAffineTransform(CGAffineTransform(scaleX: 1, y: 1).translatedBy(x: 17, y: 30).rotated(by: CGFloat.pi/180*0))
        
        
        //左邊手跟叉子獨立成一個 leftMoveView
        let leftMoveView = UIView(frame: CGRect(x: -2, y: -15, width: 0, height: 0))
        leftMoveView.layer.addSublayer(addLeftHand())
        leftMoveView.layer.addSublayer(addFork())
        containerView.addSubview(leftMoveView)

        //右邊手跟湯匙獨立成一個 rightMoveView
        let rightMoveView = UIView(frame: CGRect(x: 0, y: -8, width: 0, height: 0))
        rightMoveView.layer.addSublayer(addRightHand())
        rightMoveView.layer.addSublayer(addSpoon())
        containerView.addSubview(rightMoveView)

        //動畫
        UIView.animate(withDuration: 0.2, delay: 0, options: .repeat) {
            leftMoveView.frame = CGRect(x: 5, y: 0, width: 0, height: 0)
            rightMoveView.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        }

        view.addSubview(containerView)
        return view
    }
    
    func addHead() -> CAShapeLayer {
        let path = UIBezierPath()
        //左上
        path.move(to: CGPoint(x: 18, y: 279))
        path.addQuadCurve(to: CGPoint(x: 123, y: 135), controlPoint: CGPoint(x: 11, y: 172))
        //左耳
        path.addQuadCurve(to: CGPoint(x: 148, y: 44), controlPoint: CGPoint(x: 118, y: 42))
        path.addQuadCurve(to: CGPoint(x: 172, y: 133), controlPoint: CGPoint(x: 179, y: 39))
        //頭頂
        path.addQuadCurve(to: CGPoint(x: 218, y: 131), controlPoint: CGPoint(x: 194, y: 123))
        //右耳
        path.addQuadCurve(to: CGPoint(x: 247, y: 43), controlPoint: CGPoint(x: 216, y: 43))
        path.addQuadCurve(to: CGPoint(x: 266, y: 137), controlPoint: CGPoint(x: 282, y: 43))
        //右上
        path.addQuadCurve(to: CGPoint(x: 371, y: 274), controlPoint: CGPoint(x: 379, y: 176))
        //頭的下半部（反正會被蓋掉，所以用直線連）
        path.addLine(to: CGPoint(x: 296, y: 393))
        path.addLine(to: CGPoint(x: 96, y: 393))
        path.close()
        
        let headLayer = CAShapeLayer()
        headLayer.path = path.cgPath
        headLayer.fillColor = UIColor(red: 246/255, green: 189/255, blue: 200/255, alpha: 1).cgColor
        headLayer.strokeColor = UIColor(named: "outlineColor")?.cgColor
        headLayer.lineWidth = 13

        return headLayer
    }
    
    func addBodyPaint() -> CAShapeLayer {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 152, y: 394))
        path.addQuadCurve(to: CGPoint(x: 197, y: 334), controlPoint: CGPoint(x: 148, y: 342))
        path.addQuadCurve(to: CGPoint(x: 240, y: 394), controlPoint: CGPoint(x: 231, y: 339))
        path.close()
        
        let bodyPaintLayer = CAShapeLayer()
        bodyPaintLayer.path = path.cgPath
        bodyPaintLayer.fillColor = UIColor.white.cgColor
        bodyPaintLayer.strokeColor = UIColor.white.cgColor
        bodyPaintLayer.lineWidth = 7
        
        return bodyPaintLayer
    }
    
    func addFacePaint() -> CAShapeLayer {
        let path = UIBezierPath(ovalIn: CGRect(x: 144, y: 184, width: 99, height: 116))
        
        let facePaintLayer = CAShapeLayer()
        facePaintLayer.path = path.cgPath
        facePaintLayer.fillColor = UIColor.white.cgColor
        facePaintLayer.strokeColor = UIColor.white.cgColor
        facePaintLayer.lineWidth = 4
        return facePaintLayer
    }
    
    func addLeftPaint() -> CAShapeLayer {
        let path = UIBezierPath(ovalIn: CGRect(x: 38, y: 195, width: 88, height: 73))
        
        let leftPaintLayer = CAShapeLayer()
        leftPaintLayer.path = path.cgPath
        leftPaintLayer.fillColor = UIColor(red: 244/255, green: 166/255, blue: 179/255, alpha: 1).cgColor
        leftPaintLayer.strokeColor = UIColor(red: 244/255, green: 166/255, blue: 179/255, alpha: 1).cgColor
        leftPaintLayer.lineWidth = 3
        return leftPaintLayer
    }
    
    func addRightPaint() -> CAShapeLayer {
        let path = UIBezierPath(ovalIn: CGRect(x: 257, y: 191, width: 91, height: 79))
        
        let rightPaintLayer = CAShapeLayer()
        rightPaintLayer.path = path.cgPath
        rightPaintLayer.fillColor = UIColor(red: 244/255, green: 166/255, blue: 179/255, alpha: 1).cgColor
        rightPaintLayer.strokeColor = UIColor(red: 244/255, green: 166/255, blue: 179/255, alpha: 1).cgColor
        rightPaintLayer.lineWidth = 3
        return rightPaintLayer
    }
    
    func addMouthBottom() -> CAShapeLayer {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 181, y: 236))
        path.addQuadCurve(to: CGPoint(x: 196, y: 273), controlPoint: CGPoint(x: 183, y: 266))
        path.addQuadCurve(to: CGPoint(x: 210, y: 237), controlPoint: CGPoint(x: 209, y: 267))
        path.addLine(to: CGPoint(x: 195, y: 219))
        path.close()
        
        let mouthBottomLayer = CAShapeLayer()
        mouthBottomLayer.path = path.cgPath
        mouthBottomLayer.fillColor = UIColor(red: 244/255, green: 166/255, blue: 179/255, alpha: 1).cgColor
        mouthBottomLayer.strokeColor = UIColor(named: "outlineColor")?.cgColor
        mouthBottomLayer.lineWidth = 12
        
        return mouthBottomLayer
    }
    
    func addMouthUpper() -> CAShapeLayer {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 163, y: 221))
        path.addQuadCurve(to: CGPoint(x: 194, y: 210), controlPoint: CGPoint(x: 180, y: 259))
        path.addQuadCurve(to: CGPoint(x: 225, y: 225), controlPoint: CGPoint(x: 209, y: 253))
        
        let mouthUpperLayer = CAShapeLayer()
        mouthUpperLayer.path = path.cgPath
        mouthUpperLayer.fillColor = UIColor.clear.cgColor
        mouthUpperLayer.strokeColor = UIColor(named: "outlineColor")?.cgColor
        mouthUpperLayer.lineWidth = 12
        return mouthUpperLayer
    }
    
    func addChin() -> CAShapeLayer {
        let path = UIBezierPath(ovalIn: CGRect(x: 186, y: 284, width: 20, height: 12))
        
        let chinLayer = CAShapeLayer()
        chinLayer.path = path.cgPath
        chinLayer.fillColor = UIColor(red: 86/255, green: 35/255, blue: 2/255, alpha: 1).cgColor
        chinLayer.strokeColor = UIColor(named: "outlineColor")?.cgColor
        chinLayer.lineWidth = 1
        return chinLayer
    }
    
    func addNose() -> CAShapeLayer {
        let path = UIBezierPath(ovalIn: CGRect(x: 184, y: 188, width: 20, height: 15))
        
        let noseLayer = CAShapeLayer()
        noseLayer.path = path.cgPath
        noseLayer.fillColor = UIColor(red: 86/255, green: 35/255, blue: 2/255, alpha: 1).cgColor
        noseLayer.strokeColor = UIColor(named: "outlineColor")?.cgColor
        noseLayer.lineWidth = 3
        
        return noseLayer
    }
    
    func addEyes() -> CAShapeLayer {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 146, y: 199))
        path.addQuadCurve(to: CGPoint(x: 163, y: 187), controlPoint: CGPoint(x: 143, y: 182))
        path.addQuadCurve(to: CGPoint(x: 164, y: 196), controlPoint: CGPoint(x: 169, y: 190))
        path.addQuadCurve(to: CGPoint(x: 146, y: 199), controlPoint: CGPoint(x: 151, y: 204))
        path.move(to: CGPoint(x: 221, y: 192))
        path.addQuadCurve(to: CGPoint(x: 243, y: 195), controlPoint: CGPoint(x: 232, y: 180))
        path.addQuadCurve(to: CGPoint(x: 235, y: 202), controlPoint: CGPoint(x: 245, y: 202))
        path.addQuadCurve(to: CGPoint(x: 221, y: 192), controlPoint: CGPoint(x: 227, y: 200))
        
        let eyesLayer = CAShapeLayer()
        eyesLayer.path = path.cgPath
        eyesLayer.fillColor = UIColor(red: 86/255, green: 35/255, blue: 2/255, alpha: 1).cgColor
        eyesLayer.strokeColor = UIColor(named: "outlineColor")?.cgColor
        eyesLayer.lineWidth = 2
        return eyesLayer
    }
    
    
    func addTable() -> CAShapeLayer {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: 393))
        path.addLine(to: CGPoint(x: 393, y: 393))
        path.addLine(to: CGPoint(x: 393, y: 498))
        path.addLine(to: CGPoint(x: 0, y: 498))
        path.close()
        
        let tableLayer = CAShapeLayer()
        tableLayer.path = path.cgPath
        tableLayer.fillColor = UIColor(red: 244/255, green: 166/255, blue: 179/255, alpha: 1).cgColor
        tableLayer.strokeColor = UIColor(named: "outlineColor")?.cgColor
        tableLayer.lineWidth = 13
        
        return tableLayer
    }
   
    func addPlate() -> CAShapeLayer {
        let path = UIBezierPath(ovalIn: CGRect(x: 99, y: 410, width: 200, height: 70))
        
        let plateLayer = CAShapeLayer()
        plateLayer.path = path.cgPath
        plateLayer.fillColor = UIColor(red: 250/255, green: 251/255, blue: 227/255, alpha: 1).cgColor
        plateLayer.strokeColor = UIColor(named: "outlineColor")?.cgColor
        plateLayer.lineWidth = 10
        
        return plateLayer
    }
    
    func addCake() -> CAShapeLayer {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 158, y: 449))
        path.addQuadCurve(to: CGPoint(x: 205, y: 387), controlPoint: CGPoint(x: 140, y: 385))
        path.addQuadCurve(to: CGPoint(x: 249, y: 449), controlPoint: CGPoint(x: 257, y: 386))
        path.addQuadCurve(to: CGPoint(x: 158, y: 449), controlPoint: CGPoint(x: 204, y: 476))
        path.close()

        let cakeLayer = CAShapeLayer()
        cakeLayer.path = path.cgPath
        cakeLayer.fillColor = UIColor(red: 254/255, green: 232/255, blue: 168/255, alpha: 1).cgColor
        cakeLayer.strokeColor = UIColor(named: "outlineColor")?.cgColor
        cakeLayer.lineWidth = 10
        
        return cakeLayer
    }
    
    func addStrawBerry() -> CAShapeLayer {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 183, y: 386))
        path.addQuadCurve(to: CGPoint(x: 205, y: 360), controlPoint: CGPoint(x: 187, y: 361))
        path.addQuadCurve(to: CGPoint(x: 217, y: 389), controlPoint: CGPoint(x: 222, y: 371))
        path.addQuadCurve(to: CGPoint(x: 183, y: 386), controlPoint: CGPoint(x: 204, y: 396))
        
        let strawBerryLayer = CAShapeLayer()
        strawBerryLayer.path = path.cgPath
        strawBerryLayer.fillColor = UIColor(red: 234/255, green: 84/255, blue: 72/255, alpha: 1).cgColor
        strawBerryLayer.strokeColor = UIColor(named: "outlineColor")?.cgColor
        strawBerryLayer.lineWidth = 10
        
        return strawBerryLayer
    }
    
    func addFill() -> CAShapeLayer {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 196, y: 424))
        path.addQuadCurve(to: CGPoint(x: 216, y: 439), controlPoint: CGPoint(x: 189, y: 441))
        path.addQuadCurve(to: CGPoint(x: 218, y: 415), controlPoint: CGPoint(x: 231, y: 426))
        path.addQuadCurve(to: CGPoint(x: 186, y: 409), controlPoint: CGPoint(x: 209, y: 405))
        path.addQuadCurve(to: CGPoint(x: 172, y: 435), controlPoint: CGPoint(x: 170, y: 411))
        path.addQuadCurve(to: CGPoint(x: 204, y: 462), controlPoint: CGPoint(x: 172, y: 453))
        
        let fillLayer = CAShapeLayer()
        fillLayer.path = path.cgPath
        fillLayer.fillColor = UIColor.clear.cgColor
        fillLayer.strokeColor = UIColor(red: 237/255, green: 121/255, blue: 147/255, alpha: 1).cgColor
        fillLayer.lineWidth = 10
        
        return fillLayer
    }
    
    func cakeCorrection() -> CAShapeLayer {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 249, y: 449))
        path.addQuadCurve(to: CGPoint(x: 158, y: 449), controlPoint: CGPoint(x: 204, y: 476))
        
        let correctionLayer = CAShapeLayer()
        correctionLayer.path = path.cgPath
        correctionLayer.fillColor = UIColor.clear.cgColor
        correctionLayer.strokeColor = UIColor(named: "outlineColor")?.cgColor
        correctionLayer.lineWidth = 10
        correctionLayer.lineWidth = 10
        
        return correctionLayer
    }
    
    
    func addFork() -> CAShapeLayer {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 45, y: 360))
        path.addLine(to: CGPoint(x: 43, y: 327))
        path.addQuadCurve(to: CGPoint(x: 16, y: 289), controlPoint: CGPoint(x: 12, y: 326))
        path.addQuadCurve(to: CGPoint(x: 42, y: 309), controlPoint: CGPoint(x: 37, y: 258))
        path.addQuadCurve(to: CGPoint(x: 53, y: 276), controlPoint: CGPoint(x: 43, y: 277))
        path.addQuadCurve(to: CGPoint(x: 65, y: 309), controlPoint: CGPoint(x: 65, y: 279))
        path.addQuadCurve(to: CGPoint(x: 89, y: 294), controlPoint: CGPoint(x: 70, y: 253))
        path.addQuadCurve(to: CGPoint(x: 72, y: 326), controlPoint: CGPoint(x: 93, y: 322))
        path.addLine(to: CGPoint(x: 71, y: 360))
        path.close()
        
        let forkLayer = CAShapeLayer()
        forkLayer.path = path.cgPath
        forkLayer.fillColor = UIColor(red: 255/255, green: 243/255, blue: 55/255, alpha: 1).cgColor
        forkLayer.strokeColor = UIColor(named: "outlineColor")?.cgColor
        forkLayer.lineWidth = 13
        
        return forkLayer
    }
    
    func addSpoon() -> CAShapeLayer {
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 325, y: 356))
        path.addLine(to: CGPoint(x: 325, y: 331))
        path.addQuadCurve(to: CGPoint(x: 305, y: 275), controlPoint: CGPoint(x: 288, y: 317))
        path.addQuadCurve(to: CGPoint(x: 368, y: 276), controlPoint: CGPoint(x: 336, y: 243))
        path.addQuadCurve(to: CGPoint(x: 352, y: 332), controlPoint: CGPoint(x: 386, y: 316))
        path.addLine(to: CGPoint(x: 350, y: 357))
        path.close()
        
        //中間
        path.move(to: CGPoint(x: 339, y: 311))
        path.addQuadCurve(to: CGPoint(x: 319, y: 287), controlPoint: CGPoint(x: 314, y: 314))
        
        let spoonLayer = CAShapeLayer()
        spoonLayer.path = path.cgPath
        spoonLayer.fillColor = UIColor(red: 237/255, green: 121/255, blue: 147/255, alpha: 1).cgColor
        spoonLayer.strokeColor = UIColor(named: "outlineColor")?.cgColor
        spoonLayer.lineWidth = 13
        
        return spoonLayer
    }
    
    func addLeftHand() -> CAShapeLayer {
        let path = UIBezierPath(ovalIn: CGRect(x: 25, y: 358, width: 63, height: 50))
        
        let leftHandLayer = CAShapeLayer()
        leftHandLayer.path = path.cgPath
        leftHandLayer.fillColor = UIColor(red: 246/255, green: 189/255, blue: 200/255, alpha: 1).cgColor
        leftHandLayer.strokeColor = UIColor(named: "outlineColor")?.cgColor
        leftHandLayer.lineWidth = 13
        return leftHandLayer
    }

    func addRightHand() -> CAShapeLayer {
        let path = UIBezierPath(ovalIn: CGRect(x: 300, y: 355, width: 66, height: 50))
        
        let rightHandLayer = CAShapeLayer()
        rightHandLayer.path = path.cgPath
        rightHandLayer.fillColor = UIColor(red: 246/255, green: 189/255, blue: 200/255, alpha: 1).cgColor
        rightHandLayer.strokeColor = UIColor(named: "outlineColor")?.cgColor
        rightHandLayer.lineWidth = 13
        
        return rightHandLayer
    }
    
    
    func updateUIView(_ uiView: UIView, context: Context) {
    }
    
}
struct ContentView: View {
    var body: some View {
        DrawView()
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ContentView()
        }
    }
}
