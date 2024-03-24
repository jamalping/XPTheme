//
//  ViewController.swift
//  XPTheme
//
//  Created by jamalping on 03/24/2024.
//  Copyright (c) 2024 jamalping. All rights reserved.
//
import UIKit
import XPTheme

class ViewController: UIViewController, UIGestureRecognizerDelegate {
    
    lazy var demoView :UILabel = {
        let view  = UILabel.init(frame: CGRect.init(x: 100, y: 100, width: 100, height: 100))
        view.isUserInteractionEnabled = true
        view.text = "hello world"
        view.xpBackgroundColor = themeColor{ ColorManager.remark_main }
        return view
    }()
    
    lazy var demoLabel: UILabel = {
        let view  = UILabel()
        view.xpTextColor = themeColor{ ColorManager.font1_main }
        view.textColor = .black
        
        return view
    }()
    
    lazy var riseLabel: UILabel = {
        let view  = UILabel()
        view.text = "涨"
        view.xpRiseFallColor = themeRiseFallColor {
            (ColorManager.data_up1, ColorManager.data_down1)
        }
        return view
    }()
    
    lazy var fallLabel: UILabel = {
        let view  = UILabel()
        view.text = "跌"
        view.xpRiseFallColor = themeRiseFallColor {
            (ColorManager.data_down1, ColorManager.data_up1)
        }
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        AAQCChartUIManager.shared.initWithFileName()
        
//        monitorUIStatusChange()
        addtap()
        
        view.addSubview(self.demoView)
        view.addSubview(self.demoLabel)
        self.demoLabel.frame = CGRect.init(x: 100, y: 200, width: 100, height: 100)
        
        demoLabel.gradientColors = themeGradientColors{ ([ColorManager.primary_colour1,ColorManager.primary_colour2], .topLeftToBottomRight) }
        
        self.view.addSubview(self.riseLabel)
        self.riseLabel.frame = CGRect.init(x: 100, y: self.demoLabel.frame.maxY+3, width: 100, height: 40)
        
        
        self.view.addSubview(self.fallLabel)
        self.fallLabel.frame = CGRect.init(x: 100, y: self.riseLabel.frame.maxY+3, width: 100, height: 40)
        
        let imageview = UIImageView.init(frame: CGRect.init(x: 250, y: 100, width: 30, height: 30))
        
        if let iconImage = UIImage.init(named:  "icArrow_rise_light", in: self.getResourceBundle(), compatibleWith: nil) {
            
            imageview.xpImageRiseFallColor = themeRiseFallImageColor{ (iconImage, [.red, .red], [.green, .green], .bottom) }
        }
        self.view.addSubview(imageview)
     
        
        ////
        let button = UIButton.init(frame: CGRect.init(x: 205, y: 150, width: 100, height: 40))
        button.setTitle("button", for: UIControlState.normal)
        button.xpTextColor = XPControlThemeColor.init(state: .normal, colorCallback: {
            ColorManager.fontColorGreen
        })
        button.xpTextColor = XPControlThemeColor.init(state: .selected, colorCallback: {
            ColorManager.fontColorRed
        })
        button.addTarget(self, action: #selector(buttonClick(button:)), for: .touchUpInside)
        self.view.addSubview(button)
    }
    
    @objc func buttonClick(button: UIButton) {
        button.isSelected = !button.isSelected
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    private func addtap() {
        let tapGR = UITapGestureRecognizer(target: self,action: #selector(handleTap(_:)))
        tapGR.delegate = self
//        tapGR.numberOfTapsRequired = 2
        self.demoView.addGestureRecognizer(tapGR)
    }
    //
    @objc func handleTap(_ gesture: UITapGestureRecognizer) {
        self.view.endEditing(true)
        let alter = UIAlertController(title: "温馨提示", message: "请根据偏好设置", preferredStyle: .actionSheet)
        let sets = ["深色模式", "浅色模式","颜色切换"] // ,"中文繁体"
        sets.forEach { setStr in
            let action = UIAlertAction(title: setStr, style: UIAlertAction.Style.default, handler: {_ in
                if setStr == "深色模式" {
                    AAQCChartUIManager.shared.switchTheme(type: .dark)
                } else if setStr == "浅色模式" {
                    AAQCChartUIManager.shared.switchTheme(type: .light)
                } else if setStr == "颜色切换" {
                    if case .redRise = AAQCChartUIManager.shared.lineColorStyle {
                        AAQCChartUIManager.shared.switchLineColorStyle(type: .greenRise)
                    }else {
                        AAQCChartUIManager.shared.switchLineColorStyle(type: .redRise)
                    }
                }else if setStr == "切换字体" {
                    
                }
            })
            alter.addAction(action)
        }
        let cancel = UIAlertAction(title: "取消", style: .cancel, handler: nil)
        alter.addAction(cancel)
        present(alter, animated: true, completion: nil)
    }
}



// MARK: - 监听主题、涨跌颜色风格、语言

extension ViewController: AAQCCharThemeChange {
    
    func userDidChangeTheme(theme: ThemeType) {
        self.demoView.backgroundColor = ColorManager.bg_1
    }

    func userDidChangeLineColorStyle(lineColorStyle: LineColorStyle) {
    }
}
