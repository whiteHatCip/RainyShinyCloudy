//
//  WeatherVC
//  RainyShinyCloudy
//
//  Created by Fabio Cipriani on 21/08/16.
//  Copyright © 2016 Fabio Cipriani. All rights reserved.
//

import UIKit

class WeatherVC: UIViewController {
    
    // MARK: @IBOutlets
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var tempLbl: UILabel!
    @IBOutlet weak var locationLbl: UILabel!
    @IBOutlet weak var currentWeatherLbl: UILabel!
    @IBOutlet weak var currentWeatherImg: UIImageView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

}

