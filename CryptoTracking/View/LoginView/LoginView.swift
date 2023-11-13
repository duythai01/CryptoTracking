//
//  LoginView.swift
//  CryptoTracking
//
//  Created by DuyThai on 07/11/2023.
//

import SwiftUI
import LocalAuthentication
import FirebaseCore
import FirebaseAuth

struct LoginView: View {
    @EnvironmentObject var coordinator: Coordinator<AppRouter>

    @State var phoneNumber: String = ""
    @State var pin: String = ""
    @State var isLogin: Bool = true
    @State var userName: String = ""
    @State var heightSwitchButton: CGFloat = 0
    @State var isShowAlertEnableBiometric: Bool = false
    @State var isHiddenPopupNotice: Bool = true

    private let userManager = UserManager.shared

    var body: some View {
        NoticeView(isHidden: $isHiddenPopupNotice, type: .warning, title: "Error", description: "This func is devloping") {
            Color.theme.mainColor.ignoresSafeArea()
            VStack(spacing: 32){
                Image("ic_launchscreen")
                    .resizable()
                    .scaledToFit()
                    .frame(width: UIScreen.main.bounds.width / 3.2, height: UIScreen.main.bounds.width / 3.2)
                    VStack() {
                        HStack{Spacer()}
                        //Switch to register and login
                        switchButton

                        // Enter phone number
                        TextFieldLogin(text: $phoneNumber,
                                       placeHolder: "Phone number or mail",
                                       image: Image(systemName: "phone.circle.fill"),
                                       textView:
                                        TextField("", text: $phoneNumber)
                                        .font(.system(size: 16, weight: .medium))
                                        .foregroundColor(.white)
                                        .accentColor(.white)
                        )

                        //Enter password
                        TextFieldLogin(text: $pin,
                                       placeHolder: isLogin ? "Pin" : "Create your Pin",
                                       image: Image(systemName: "lock.circle.fill"),
                                       textView:
                                        SecureField("", text: $pin)
                                        .font(.system(size: 16, weight: .medium))
                                        .foregroundColor(.white)
                                        .accentColor(.white).keyboardType(.numberPad)
                        )
                        if isLogin {
                            // Reset password
                            Button(action: {}, label: {
                                Text("Reset Pin")
                                    .font(.system(size: 20, weight: .medium))
                                    .foregroundColor(.purple)
                            })
                            .padding(.all, 8)

                        } else {
                            //Enter username
                            TextFieldLogin(text: $userName, placeHolder: "Enter user name", image: Image(systemName: "person.circle.fill"), textView:
                                            TextField("", text: $userName) {
                                UIApplication.shared.dismissKeyboard()
                            }
                                .font(.system(size: 16, weight: .medium))
                                .foregroundColor(.white)
                                .accentColor(.white)
                            )
                            
                                .padding(.bottom, 32)
                        }



                    }
                    .padding([.horizontal], 16)
                    .background(
                        RoundedRectangle(cornerRadius: 12)
                        .foregroundColor(Color.black.opacity(0.8))
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                            .foregroundColor(Color.black.opacity(0.8))
                                .shadow(color: .white ,radius: 2
                                       ))
                        )


                Button(action: {
                    if isLogin {
                        checkFaceID()
                        login()
                    } else {
                        register()
                    }
                }, label: {
                    HStack{
                        Spacer()
                        Text(isLogin ? "LOGIN" : "REGISTER")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.white)
                        Spacer()
                    }
                })
                .padding(.all, 16)
                .background(RoundedCorner(radius: 8).foregroundColor(.purple))
                if isLogin {
                    VStack(spacing: 16){
                        Button(action: {
                            authenticateFaceID()
                        }, label: {
                            Image(systemName: "faceid")
                                .font(.system(size: 32))
                                .foregroundColor(.purple)
                        })
                        Text("Or sign in with fingerprint/FaceID")
                            .font(.system(size: 16))
                            .foregroundColor(.white)
                    }
                }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 32)

        }
        .alert(isPresented: $isShowAlertEnableBiometric, content: {
            Alert(
                title: Text("Do you want to enable biometric login at the next login"),
                primaryButton: .default(Text("Agree")) {
                    authenticateFaceID()

                },
                secondaryButton: .cancel()
            )
    })
        .onTapGesture {
            UIApplication.shared.dismissKeyboard()
        }
    }
}


// View
extension LoginView {
    var switchButton: some View {
        GeometryReader { geometryH in
            HStack {
                HStack {
                    Text("LOGIN")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(!isLogin ? .purple : .white)
                }
                .frame(width: geometryH.size.width / 2 - 12)
                .padding(.vertical, 12)
                .onTapGesture {
                    withAnimation(.easeOut(duration: 0.1)) {
                        isLogin = true
                    }
                }
                Spacer()
                HStack {
                    Text("REGISTER")
                        .font(.system(size: 18, weight: .bold))
                        .foregroundColor(!isLogin ? .white : .purple)
                }
                .frame(width: geometryH.size.width / 2 - 12)
                .padding(.vertical, 12)
                .onTapGesture {
                    withAnimation(.easeOut(duration: 0.2)) {
                        isLogin = false
                    }
                }
            }
            .background(
                GeometryReader{ backgroundGeometry in
                    Color.white.opacity(0.0)
                        .cornerRadius(12)
                        .background(HStack{
                            if !isLogin {
                                Spacer()
                            }
                            Color.purple
                                .frame(width: geometryH.size.width / 2 - 6)
                                .cornerRadius(6)
                                .padding(.all, 5)
                            if isLogin {
                                Spacer()
                            }
                    })
                        .onAppear {
                            DispatchQueue.main.async {
                                heightSwitchButton = backgroundGeometry.size.height
                            }
                        }

                }

            )
        }
        .frame(height: heightSwitchButton)
    }
}


// Auth
extension LoginView {
    func authenticateFaceID() {
        let context = LAContext()
        var error: NSError?
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            let reason = "We need your FaceID to unlock"
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, authenticError in
                if success {

                    DispatchQueue.main.async {
                        coordinator.show(.appView)

                    }
                } else {
                    print("@@@ERRor in evlate")
                }
            }
        } else {
        }
    }

    func checkFaceID() {
            let context = LAContext()

            if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: nil) {
                // Biometric authentication is available
                if context.biometryType == .faceID || context.biometryType == .touchID {
                    isShowAlertEnableBiometric = false
                } else {
                    isShowAlertEnableBiometric = true
                }
            } else {
                // Biometric authentication is not available
                isShowAlertEnableBiometric = true
            }
        }

    func register() {

        Auth.auth().createUser(withEmail: phoneNumber, password: pin) { result, error in
            if let error = error {
                print("Notice loi: \(error.localizedDescription)")
                return
            }
            if let result = result {
                print(result)
                isLogin = true

            }
        }
    }

    func login() {
        Auth.auth().signIn(withEmail: phoneNumber, password: pin) { result, error in
            if let error = error {
                print("Notice loi: \(error.localizedDescription)")
                return
            }
            if let result = result {
                userManager.saveLoggedInUser(currentUser: result)
                coordinator.show(.appView)
                print(result)
            }
        }

    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

enum NoticeType {
    case success
    case warning
    case error
}

struct NoticeView<Content>: View where Content: View   {
    let type: NoticeType
    let color: Color
    let title: String
    let description: String
    let content: Content

    @Binding var isHiddenNotice: Bool

    init( isHidden: Binding<Bool>, type: NoticeType, title: String, description: String, @ViewBuilder content: @escaping () -> Content) {
        self._isHiddenNotice = isHidden

        self.type = type
        switch type {
        case .success:
            self.color = Color(#colorLiteral(red: 0.2536941767, green: 0.779199183, blue: 0.003175185528, alpha: 1))
        case .warning:
            self.color = Color(#colorLiteral(red: 0.9903402925, green: 0.6474537253, blue: 0.01725636609, alpha: 1))
        case .error:
            self.color = Color(#colorLiteral(red: 0.8449876904, green: 0.3313968182, blue: 0.4077254534, alpha: 1))
        }
        self.title = title
        self.description = description
        self.content = content()
    }

    var body: some View {
        ZStack{
            content
            if !isHiddenNotice {
                Color.black.opacity(0.3).ignoresSafeArea()
                VStack {
                    HStack {
                        Spacer()
                        Image(systemName: type == .error ? "exclamationmark.triangle.fill" : (type == .success ?  "checkmark.circle.fill" : "exclamationmark.triangle.fill"))
                            .font(.system(size: 22, weight: .bold))
                            .foregroundColor(.white)
                            .padding(.vertical, 8)
                        Text("Error!")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.white)
                            .padding(.vertical, 8)

                        Spacer()
                    }
                    .background(
                        Color(#colorLiteral(red: 0.8449876904, green: 0.3313968182, blue: 0.4077254534, alpha: 1))
                            .cornerRadius(8, corners: [.topLeft, .topRight])
                    )
                    HStack {
                        Text("This func is not support")
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(.black)
                            .padding(.leading, 8)
                        Spacer()
                    }
                    .padding(.vertical, 8)

                    Button(action: {
                        isHiddenNotice = true
                    }, label: {
                        Text("CLOSE")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.white)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 4)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .foregroundColor(Color(#colorLiteral(red: 0.8449876904, green: 0.3313968182, blue: 0.4077254534, alpha: 1)))
                            )

                    })
                    .padding(.vertical, 8)
                }
                .background(RoundedRectangle(cornerRadius: 8)
                    .foregroundColor(Color.white))
                .padding(.horizontal, 32)
            }
        }
    }


}
