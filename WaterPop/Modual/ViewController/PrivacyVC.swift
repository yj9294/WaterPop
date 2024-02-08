//
//  PrivacyVC.swift
//  WaterPop
//
//  Created by yangjian on 2024/2/1.
//

import UIKit

class PrivacyVC: BaseVC {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.title = "Privacy Policy"
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "back")?.withRenderingMode(.alwaysOriginal), style: .plain, target: self, action: #selector(back))
    }
    
}

extension PrivacyVC {
    
    override func setupUI() {
        super.setupUI()
        
        let textView = UITextView()
        textView.isEditable = false
        textView.showsHorizontalScrollIndicator = false
        textView.showsVerticalScrollIndicator = false
        textView.textColor = UIColor(hex: 0x040404)
        textView.font = .systemFont(ofSize: 16)
        textView.contentInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        view.addSubview(textView)
        textView.snp.makeConstraints { make in
            make.top.leading.right.bottom.equalToSuperview()
        }
        textView.text = """
Thank you for choosing to use the Water POP drinking App (the "App"). We understand the importance of personal privacy, and in order to protect your privacy, we have developed the following privacy policy that describes how we collect, use, store and protect your personal information.

1. Information collection and use
1.1 Types of Information collected: We may collect the following information that you provide in the course of using the Application:
Basic information: including but not limited to the user's device information and operation records.
Personal health information: including but not limited to the amount of water, drinking time and other personal health-related information.
1.2 Purpose of Information use: The main purpose of collecting the above information is to provide better services and ensure the normal operation of the application. Specific uses include but are not limited to:
Provide personalized drinking plan and regular reminder service.
Analyze users' drinking habits and provide health advice and reports to users.
Optimize application functions to improve user experience.

2. Information protection and storage
2.1 Information Protection: We take reasonable technical measures to protect your personal information from loss, misuse, unauthorized access or disclosure.
2.2 Storage of Information: Your personal information will be stored on a secure server and will only be retained for the time necessary to provide the service. We will take all reasonably practicable steps to ensure that your personal information is protected from misuse or unauthorised access.

3. Information sharing and disclosure
3.1 Sharing Principles: We will not share your personal information with third parties unless we obtain your explicit consent or are required by laws and regulations.
3.2 Disclosure Circumstances: We may disclose your personal information under the following circumstances:
In accordance with laws and regulations;
In case of emergency, in order to protect the interests of users and the public;
To protect our legitimate rights and interests, including but not limited to preventing fraud, cyber attacks, etc.

4. Changes to privacy policy
We may modify this privacy policy according to the needs of laws and regulations and service changes. The updated privacy policy will take effect in the App, and we encourage you to review the latest privacy policy when using the App.
If you have any questions about our privacy policy or the handling of personal information, you can contact us:support@guangpeng.link.
Thank you for using Water POP drinking App, we will be happy to provide you with better service!
"""
    }
    
}
