function createSpriteObjects(obj, parent, behavior = 0) {
    var component;
    var sprite;
        component = Qt.createComponent(obj);
        if (behavior)
            sprite = component.createObject(parent, behavior);
        else
            sprite = component.createObject(parent);

        if (sprite == null) {
            console.log("Error creating object");
        }
         return sprite
    }
