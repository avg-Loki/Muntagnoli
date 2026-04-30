$csvPath = "INSCRITS_TOUS.csv"
$encoding = [System.Text.Encoding]::UTF8

# Lire le fichier
$lines = [System.IO.File]::ReadAllLines($csvPath, $encoding)

$newLines = @()

# Traiter ligne par ligne
for ($i = 0; $i -lt $lines.Count; $i++) {
    $line = $lines[$i]
    
    if ($i -eq 0) {
        # Garder l'en-tête
        $newLines += $line
    }
    else {
        # Traiter les données
        $parts = $line -split ';'
        if ($parts.Count -ge 8) {
            $sexe = $parts[4].Trim()
            $categorie = $parts[7].Trim()
            
            # Ajouter M ou D si manquant
            if ($categorie -and -not ($categorie -match '[MD]$')) {
                if ($sexe -eq 'H') {
                    $categorie = "$categorie M"
                }
                elseif ($sexe -eq 'F') {
                    $categorie = "$categorie D"
                }
            }
            
            $parts[7] = $categorie
            $newLine = $parts -join ';'
            $newLines += $newLine
        }
        else {
            $newLines += $line
        }
    }
}

# Écrire le fichier
[System.IO.File]::WriteAllLines($csvPath, $newLines, $encoding)

Write-Host "Fichier modifie avec succes!"
Write-Host "Categories: M pour Hommes, D pour Dames"
