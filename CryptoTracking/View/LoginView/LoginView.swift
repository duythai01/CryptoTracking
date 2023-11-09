//
//  LoginView.swift
//  CryptoTracking
//
//  Created by DuyThai on 07/11/2023.
//

import SwiftUI
import LocalAuthentication

struct LoginView: View {
    @EnvironmentObject var coordinator: Coordinator<AppRouter>

    @State var phoneNumber: String = ""
    @State var pin: String = ""
    @State var isLogin: Bool = true
    @State var userName: String = ""
    @State var heightSwitchButton: CGFloat = 0
    @State var isShowAlertEnableBiometric: Bool = false
    var body: some View {
        ZStack {
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
                                       placeHolder: "Phone number",
                                       image: Image(systemName: "phone.circle.fill"),
                                       textView: TextField("", text: $phoneNumber) {
                            UIApplication.shared.dismissKeyboard()
                        })

                        //Enter password
                        TextFieldLogin(text: $pin,
                                       placeHolder: isLogin ? "Pin" : "Create your Pin",
                                       image: Image(systemName: "lock.circle.fill"),
                                       textView: TextField("", text: $pin) {
                            UIApplication.shared.dismissKeyboard()
                        })

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
                            TextFieldLogin(text: $userName, placeHolder: "Enter user name", image: Image(systemName: "person.circle.fill"), textView:  TextField("", text: $phoneNumber) {
                                UIApplication.shared.dismissKeyboard()
                            })
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
                    checkFaceID()
                }, label: {
                    HStack{
                        Spacer()
                        Text("LOGIN")
                            .font(.system(size: 20, weight: .bold))
                            .foregroundColor(.white)
                        Spacer()
                    }
                })
                .padding(.all, 16)
                .background(RoundedCorner(radius: 8).foregroundColor(.purple))

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
    }

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
}
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
struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

struct TextFieldLogin<Label>: View where Label: View  {
    @Binding var text: String
    let placeHolder: String
    let image: Image
    let textView: TextField<Label>
    var body: some View {
        HStack {
                image
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(.purple)
                .background(Circle().foregroundColor(.white).padding(.all, 3))
            VStack {
                ZStack(alignment: .leading) {
                    if text == "" {

                        Text(placeHolder)
                            .font(.system(size: 16, weight: .medium))
                            .foregroundColor(Color.gray.opacity(0.7))
                    }


                    textView
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(.white)
                    .accentColor(.white)

                    HStack {
                        Spacer()
                        if text != "" {
                            Button(action: {
                                text = ""
                            }, label: {
                                Image(systemName: "multiply.circle.fill")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(.purple)

                            })
                            .padding(.horizontal, 16)

                        }

                    }


                }
                Color.white.frame(height: 2 / UIScreen.main.scale)
            }
            .padding(.horizontal, 6)
        }
    }
}
