//
//  LoginView.swift
//  SavingimgCoreData
//
//  Created by A on 4/23/22.
//

import SwiftUI
import CoreData
import FirebaseAuth

class AppViewModel: ObservableObject {
    let auth = Auth.auth()
    @Published var signedIn = false

    var isSignedIn: Bool {
        return auth.currentUser != nil
    }
    func singIn(email: String, password: String) {
        auth.signIn(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil, error == nil else {
                return
            }
            DispatchQueue.main.async {
                self?.signedIn = true
            }
        }
    }
    
    func singUp(email: String, password: String) {
        auth.createUser(withEmail: email, password: password) { [weak self] result, error in
            guard result != nil, error == nil
            else {
                return
            }
            DispatchQueue.main.async {
                self?.signedIn = true
            }
        }
    }
    func singOut() {
        try? auth.signOut()
        self.signedIn = false
    }
}

struct LoginView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(entity:Saving.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Saving.username, ascending: true),
        NSSortDescriptor(keyPath: \Saving.imageD, ascending: true),
        NSSortDescriptor(keyPath: \Saving.favo, ascending: false),
        NSSortDescriptor(keyPath: \Saving.descriptions, ascending: true)]) var savings : FetchedResults<Saving>

    @State var image : Data = .init(count: 0)
    @State var show = false
    
    @EnvironmentObject var viewModel: AppViewModel

    var body: some View {
        NavigationView {
            if viewModel.signedIn {
                    ScrollView(.vertical, showsIndicators: false) {
                    ForEach(savings, id: \.self) { save in
                        VStack(alignment: .leading) {
                            Image(uiImage: UIImage(data: save.imageD ?? self.image)!)
                                .resizable()
                                .frame(width: UIScreen.main.bounds.width - 34, height: 370)
                                .cornerRadius(15)
                            HStack {
                                Text("\(save.descriptions ?? "")")
                                Spacer()
                                Button(action: {
                                    save.favo.toggle()
                                    try? self.moc.save()
                                }) { Image(systemName: save.favo ? "heart.fill": "heart") }
                            }
                            Text("\(save.username ?? "")")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            }
                    }.padding()
                    }.navigationBarTitle("Gallery", displayMode: . inline)
                    .navigationBarItems(leading:
                                            Button(action: { viewModel.singOut() }, label: {
                                                Text("Sign Out")
                                                    .foregroundColor(.blue)
                                            }),
                                        trailing:
                                                Button(action: { self.show.toggle() })
                                            { Image(systemName: "folder.badge.plus") })
                
                .sheet(isPresented: self.$show) {
                    SenderView().environment(\.managedObjectContext, self.moc)
                }
            } else {
                SingInView()
            }
        }
        .onAppear {
            viewModel.signedIn = viewModel.isSignedIn
        }
    }
}

struct SingInView: View {
    @State var email = ""
    @State var password = ""
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
            VStack{
                Image("img")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                VStack {
                    TextField("Email Address", text: $email)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                    SecureField("Email Password", text: $password)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                    Button(action: {
                        guard !email.isEmpty, !password.isEmpty else {
                            return
                        }
                        viewModel.singIn(email: email, password: password)
                    }, label: {
                        Text("Sign In")
                            .foregroundColor(Color.white)
                            .frame(width: 200, height: 50)
                            .cornerRadius(8)
                            .background(Color.blue)
                    })
                    NavigationLink("Create Account", destination: SingUpView())
                        .padding()
                }
                .padding()
                Spacer()
            }
            .navigationTitle("Sing in")
    }
}

struct SingUpView: View {
    @State var email = ""
    @State var password = ""
    @EnvironmentObject var viewModel: AppViewModel
    
    var body: some View {
            VStack{
                Image("img")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                VStack {
                    TextField("Email Address", text: $email)
                        .disableAutocorrection(false)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                    SecureField("Email Password", text: $password)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                        .padding()
                        .background(Color(.secondarySystemBackground))
                    Button(action: {
                        guard !email.isEmpty, !password.isEmpty else {
                            return
                        }
                        viewModel.singUp(email: email, password: password)
                    }, label: {
                        Text("Create Account")
                            .foregroundColor(Color.white)
                            .frame(width: 200, height: 50)
                            .cornerRadius(8)
                            .background(Color.blue)
                    })
                }
                .padding()
                Spacer()
            }
            .navigationTitle("Create Account")
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
    }
}

