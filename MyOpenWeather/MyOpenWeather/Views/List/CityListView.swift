//
//  CityListView.swift
//  MyOpenWeather
//
//  Created by herongjin on 2022/3/27.
//

import SwiftUI

struct CityListView : View {
    
    @EnvironmentObject var cityStore: CityStore
    
    @State var isPresentingModal: Bool = false
    @State var isEditMode: EditMode = .inactive
    
    var body: some View {
        NavigationView {
            List {
                ForEach(cityStore.cities, id: \.name) { city in
                    CityRow(city: city, isEditing: isEditMode == .active)
                        .frame(height: 60)
                }
                .onDelete(perform: delete)
                .onMove(perform: move)
                .listRowBackground(Color(hex: "F9F9F9"))
            }
            .environment(\.editMode, $isEditMode)
            .navigationBarItems(leading: editButton, trailing: addButton)
            .navigationBarTitle("Cities", displayMode: .inline)
        }
        .onAppear(perform: {
            // cache the current background color
            UITableView.appearance().backgroundColor = UIColor("CDF0EA")
        })
        .onDisappear(perform: {
            // reset the background color to the cached value
            UITableView.appearance().backgroundColor = UIColor.systemBackground
        })
    }
    
    private var editButton: some View {
        Button(isEditMode.isEditing ? "Done": "Edit") {
            switch isEditMode {
                case .active:
                    self.isEditMode = .inactive
                case .inactive:
                    self.isEditMode = .active
                default:
                    break
            }
        }
        .foregroundColor(Color(hex: "51C4D3"))
    }
    
    private var addButton: some View {
        Button(action: {
            self.isPresentingModal = true
        }) {
            Image(systemName: "plus")
                .resizable()
                .frame(width: 20, height: 20)
                .foregroundColor(Color(hex: "51C4D3"))
        }.sheet(isPresented: $isPresentingModal) {
            NewCityView().environmentObject(self.cityStore)
        }
    }
    
    private func delete(at offsets: IndexSet) {
        cityStore.cities.remove(atOffsets: offsets)
    }

    private func move(from source: IndexSet, to destination: Int) {
        cityStore.cities.move(fromOffsets: source, toOffset: destination)
    }
    
}

//#if DEBUG
struct CityListView_Previews : PreviewProvider {
    static var previews: some View {
        CityListView()
            .environmentObject(CityStore())
    }
}
//#endif
