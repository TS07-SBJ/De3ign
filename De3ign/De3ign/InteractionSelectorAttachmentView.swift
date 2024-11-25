//
//  InteractionSelectorView.swift
//  De3ign
//
//  Created by Lemocuber on 2024/11/24.
//

import SwiftUI
import RealityKit
import RealityKitContent

struct InteractionSelectorAttachmentView: View {
    
    var appModel: AppModel
    
    let itemNone = LibraryInteraction(.none)
    
    var items: [LibraryInteraction] = [
        .init(.disappear),
        .init(.zoom),
        .init(.chat),
        .init(.song)
    ]
    
    @State var selectedItem: LibraryInteraction = LibraryInteraction(.none)
    
    var target: Entity {
        return self.appModel.libraryEntities[self.id]
    }
    
    var id: Int
    
    var body: some View {
        HStack(spacing: 20) {
            HStack(spacing: 30) {
                ForEach(items) { item in
                    let isSelected = item.name == self.selectedItem.name
                    Button {
                        // clicking on a selected item should deselect
                        if (isSelected) {
                            self.selectedItem = itemNone
                            self.target.components.set(InteractionComponent(itemNone))
                        } else {
                            self.selectedItem = item
                            self.target.components.set(InteractionComponent(item))
                        }
                    } label: {
                        Text(item.name)
                        Image(item.iconName)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 24, height: 24)
                    }
                    .tint(isSelected ? .accentColor : .none)
                }
            }
            Divider()
                .frame(height: 30)
            Button {
                self.target.isEnabled = false
            } label: {
                Image("icon_trash")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
            }
        }
        .padding()
        .glassBackgroundEffect()
    }
}
