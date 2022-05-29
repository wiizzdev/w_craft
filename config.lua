Config = {
    Craft = {
        Objets = {
            {
                label = "Hot Dog",
                pos = vector3(-1249.5, -1474.35, 4.29),
                marker = {type = 20, r = 255, g = 210, b = 1, a = 100},
                blip = {activer = true, sprite = 403, scale = 0.8, color = 28, name = "Craft | Hot Dog"},
                color = "~y~",
                indication = "Fabriquer des Hot Dog",
                animation = {anim1 = 'mini@repair', anim2 = 'fixing_a_ped'},
                objets = {
                    {
                        label = "Hot Dog", 
                        name = 'hotdog',
                        ingredients1 = {label = "Pain", name = 'bread'},
                        ingredients2 = {label = "Saucisse", name = 'saucisse'},
                    },
                    {
                        label = "Frites", 
                        name = 'frites',
                        ingredients1 = {label = "Pomme de Terre", name = 'pommedeterre'},
                        ingredients2 = {label = "Ketchup", name = 'ketchup'},
                    },
                },
            },
        },
        Armes = {
            {
                label = "Armes",
                pos = vector3(-1259.27, -1481.91, 4.29),
                marker = {type = 20, r = 131, g = 131, b = 131, a = 100},
                blip = {activer = true, sprite = 156, scale = 0.8, color = 22, name = "Craft | Armes"},
                color = "~m~",
                indication = "Fabriquer des Armes",
                animation = {anim1 = 'mini@repair', anim2 = 'fixing_a_ped'},
                armes = {
                    {
                        label = "AK-47", 
                        name = 'weapon_assaultrifle',
                        ingredients1 = {label = "Acier", name = 'acier'},
                        ingredients2 = {label = "Métal", name = 'metal'},
                    },
                },
            },
        },
    },
}