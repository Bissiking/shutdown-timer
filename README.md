# ⏱️ Shutdown Timer GUI (PowerShell)

Petit script PowerShell avec interface graphique moderne permettant de **programmer l’arrêt automatique d’un PC Windows** après un délai défini.

Idéal pour :
- Lancer un arrêt après un téléchargement
- Éviter de laisser le PC allumé inutilement
- Avoir un compte à rebours visible et annulable

---

## ✨ Fonctionnalités

- Interface graphique moderne (Windows Forms)
- Choix du délai en minutes
- Boutons rapides : 1 / 5 / 10 / 30 minutes
- Fenêtre de **compte à rebours flottante**
- Annulation possible à tout moment
- Bouton **Arrêter maintenant**
- Changement de couleur quand le temps devient critique
- Toujours au premier plan (TopMost)

---

## 🖥️ Prérequis

- Windows
- PowerShell 5.1 ou plus
- Droits suffisants pour exécuter la commande `shutdown`

Aucune dépendance externe.

---

## ▶️ Utilisation

1. Télécharger le script `.ps1`
2. (Si nécessaire) Autoriser l’exécution des scripts :
   ```powershell Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned && .\shutdown-timer.ps1 ```

## ⚠️ Sécurité
Le script utilise la commande Powershell native :
```powershell Stop-Computer -Force```

➡️ Cela force la fermeture des applications ouvertes.
Assure-toi d’avoir sauvegardé ton travail.

## 📸 Aperçu
- Fenêtre de configuration avec raccourcis rapides
- Fenêtre de compte à rebours moderne, toujours visible

## 🧩 Personnalisation
- Modifier $defaultMinutes pour changer la valeur par défaut
- Ajuster les couleurs / polices dans le script
- Adapter les raccourcis rapides

## 📜 Licence
Libre d’utilisation pour usage personnel ou pro.
Aucune garantie – utilise à tes risques 😄
