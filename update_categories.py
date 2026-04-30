#!/usr/bin/env python3
# -*- coding: utf-8 -*-

# Lire le fichier
with open('INSCRITS_TOUS.csv', 'r', encoding='utf-8') as f:
    lines = f.readlines()

# Traiter les lignes
new_lines = []
for i, line in enumerate(lines):
    if i == 0:
        # Garder l'en-tête tel quel
        new_lines.append(line)
    else:
        # Traiter les données
        parts = line.rstrip('\n').split(';')
        if len(parts) >= 8:
            sexe = parts[4].strip()  # Colonne SEXE
            categorie = parts[7].strip()  # Colonne CATEGORIE
            
            # Ajouter M ou D si la catégorie n'en a pas
            if categorie and not categorie.endswith('M') and not categorie.endswith('D'):
                if sexe == 'H':
                    categorie = categorie + ' M'
                elif sexe == 'F':
                    categorie = categorie + ' D'
            
            # Remplacer la catégorie
            parts[7] = categorie
            new_lines.append(';'.join(parts) + '\n')
        else:
            new_lines.append(line)

# Écrire le fichier modifié
with open('INSCRITS_TOUS.csv', 'w', encoding='utf-8') as f:
    f.writelines(new_lines)

print("✓ Fichier modifié avec succès!")
print("Les catégories ont été ajoutées avec M (Hommes) et D (Dames)")
