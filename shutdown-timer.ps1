Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Configuration par défaut
$defaultMinutes = 5

# Création de la fenêtre de configuration
$configForm = New-Object System.Windows.Forms.Form
$configForm.Text = "Configuration de l'arrêt"
$configForm.Size = New-Object System.Drawing.Size(450, 280)
$configForm.StartPosition = "CenterScreen"
$configForm.FormBorderStyle = "FixedDialog"
$configForm.MaximizeBox = $false
$configForm.MinimizeBox = $false
$configForm.BackColor = [System.Drawing.Color]::FromArgb(45, 45, 48)
$configForm.ForeColor = [System.Drawing.Color]::White

# Titre moderne
$titleLabel = New-Object System.Windows.Forms.Label
$titleLabel.Location = New-Object System.Drawing.Point(20, 20)
$titleLabel.Size = New-Object System.Drawing.Size(400, 40)
$titleLabel.Text = "🕒 Arrêt Programmé du PC"
$titleLabel.Font = New-Object System.Drawing.Font("Segoe UI", 16, [System.Drawing.FontStyle]::Bold)
$titleLabel.ForeColor = [System.Drawing.Color]::FromArgb(0, 174, 219)
$titleLabel.TextAlign = "MiddleCenter"

# Panel pour le temps
$timePanel = New-Object System.Windows.Forms.Panel
$timePanel.Location = New-Object System.Drawing.Point(50, 80)
$timePanel.Size = New-Object System.Drawing.Size(350, 80)
$timePanel.BackColor = [System.Drawing.Color]::FromArgb(60, 60, 63)
$timePanel.BorderStyle = "None"

# Label pour "Temps avant arrêt"
$timeLabel = New-Object System.Windows.Forms.Label
$timeLabel.Location = New-Object System.Drawing.Point(10, 10)
$timeLabel.Size = New-Object System.Drawing.Size(150, 25)
$timeLabel.Text = "Temps avant arrêt :"
$timeLabel.Font = New-Object System.Drawing.Font("Segoe UI", 10)
$timeLabel.ForeColor = [System.Drawing.Color]::White

# NumericUpDown pour les minutes
$minutesInput = New-Object System.Windows.Forms.NumericUpDown
$minutesInput.Location = New-Object System.Drawing.Point(170, 8)
$minutesInput.Size = New-Object System.Drawing.Size(80, 25)
$minutesInput.Minimum = 1
$minutesInput.Maximum = 999
$minutesInput.Value = $defaultMinutes
$minutesInput.BackColor = [System.Drawing.Color]::FromArgb(80, 80, 83)
$minutesInput.ForeColor = [System.Drawing.Color]::White
$minutesInput.Font = New-Object System.Drawing.Font("Segoe UI", 10)

# Label "minutes"
$minLabel = New-Object System.Windows.Forms.Label
$minLabel.Location = New-Object System.Drawing.Point(260, 10)
$minLabel.Size = New-Object System.Drawing.Size(60, 25)
$minLabel.Text = "minutes"
$minLabel.Font = New-Object System.Drawing.Font("Segoe UI", 10)
$minLabel.ForeColor = [System.Drawing.Color]::White

# Boutons rapides
$quickLabel = New-Object System.Windows.Forms.Label
$quickLabel.Location = New-Object System.Drawing.Point(10, 40)
$quickLabel.Size = New-Object System.Drawing.Size(100, 20)
$quickLabel.Text = "Raccourcis :"
$quickLabel.Font = New-Object System.Drawing.Font("Segoe UI", 9)
$quickLabel.ForeColor = [System.Drawing.Color]::LightGray

$btn1min = New-Object System.Windows.Forms.Button
$btn1min.Location = New-Object System.Drawing.Point(110, 38)
$btn1min.Size = New-Object System.Drawing.Size(40, 24)
$btn1min.Text = "1m"
$btn1min.BackColor = [System.Drawing.Color]::FromArgb(0, 122, 204)
$btn1min.ForeColor = [System.Drawing.Color]::White
$btn1min.FlatStyle = "Flat"
$btn1min.Font = New-Object System.Drawing.Font("Segoe UI", 8)

$btn5min = New-Object System.Windows.Forms.Button
$btn5min.Location = New-Object System.Drawing.Point(155, 38)
$btn5min.Size = New-Object System.Drawing.Size(40, 24)
$btn5min.Text = "5m"
$btn5min.BackColor = [System.Drawing.Color]::FromArgb(0, 122, 204)
$btn5min.ForeColor = [System.Drawing.Color]::White
$btn5min.FlatStyle = "Flat"
$btn5min.Font = New-Object System.Drawing.Font("Segoe UI", 8)

$btn10min = New-Object System.Windows.Forms.Button
$btn10min.Location = New-Object System.Drawing.Point(200, 38)
$btn10min.Size = New-Object System.Drawing.Size(40, 24)
$btn10min.Text = "10m"
$btn10min.BackColor = [System.Drawing.Color]::FromArgb(0, 122, 204)
$btn10min.ForeColor = [System.Drawing.Color]::White
$btn10min.FlatStyle = "Flat"
$btn10min.Font = New-Object System.Drawing.Font("Segoe UI", 8)

$btn30min = New-Object System.Windows.Forms.Button
$btn30min.Location = New-Object System.Drawing.Point(245, 38)
$btn30min.Size = New-Object System.Drawing.Size(40, 24)
$btn30min.Text = "30m"
$btn30min.BackColor = [System.Drawing.Color]::FromArgb(0, 122, 204)
$btn30min.ForeColor = [System.Drawing.Color]::White
$btn30min.FlatStyle = "Flat"
$btn30min.Font = New-Object System.Drawing.Font("Segoe UI", 8)

# Boutons principaux
$startButton = New-Object System.Windows.Forms.Button
$startButton.Location = New-Object System.Drawing.Point(120, 190)
$startButton.Size = New-Object System.Drawing.Size(120, 35)
$startButton.Text = "▶ Démarrer"
$startButton.BackColor = [System.Drawing.Color]::FromArgb(46, 204, 113)
$startButton.ForeColor = [System.Drawing.Color]::White
$startButton.FlatStyle = "Flat"
$startButton.Font = New-Object System.Drawing.Font("Segoe UI", 11, [System.Drawing.FontStyle]::Bold)

$cancelButton = New-Object System.Windows.Forms.Button
$cancelButton.Location = New-Object System.Drawing.Point(260, 190)
$cancelButton.Size = New-Object System.Drawing.Size(80, 35)
$cancelButton.Text = "✕ Annuler"
$cancelButton.BackColor = [System.Drawing.Color]::FromArgb(231, 76, 60)
$cancelButton.ForeColor = [System.Drawing.Color]::White
$cancelButton.FlatStyle = "Flat"
$cancelButton.Font = New-Object System.Drawing.Font("Segoe UI", 10)

# Événements boutons rapides
$btn1min.Add_Click({ $minutesInput.Value = 1 })
$btn5min.Add_Click({ $minutesInput.Value = 5 })
$btn10min.Add_Click({ $minutesInput.Value = 10 })
$btn30min.Add_Click({ $minutesInput.Value = 30 })

# Variables globales
$script:shutdownMinutes = 0
$script:startShutdown = $false

# Événements boutons principaux
$startButton.Add_Click({
    $script:shutdownMinutes = [int]$minutesInput.Value
    $script:startShutdown = $true
    $configForm.Close()
})

$cancelButton.Add_Click({
    $script:startShutdown = $false
    $configForm.Close()
})

# Ajout des contrôles
$timePanel.Controls.Add($timeLabel)
$timePanel.Controls.Add($minutesInput)
$timePanel.Controls.Add($minLabel)
$timePanel.Controls.Add($quickLabel)
$timePanel.Controls.Add($btn1min)
$timePanel.Controls.Add($btn5min)
$timePanel.Controls.Add($btn10min)
$timePanel.Controls.Add($btn30min)

$configForm.Controls.Add($titleLabel)
$configForm.Controls.Add($timePanel)
$configForm.Controls.Add($startButton)
$configForm.Controls.Add($cancelButton)

# Affichage de la fenêtre de configuration
$configForm.ShowDialog()

# Si l'utilisateur a démarré le timer
if ($script:startShutdown) {
    $totalSeconds = $script:shutdownMinutes * 60
    
    # Création de la fenêtre de compte à rebours
    $countdownForm = New-Object System.Windows.Forms.Form
    $countdownForm.Text = "Arrêt en cours..."
    $countdownForm.Size = New-Object System.Drawing.Size(400, 200)
    $countdownForm.StartPosition = "Manual"
    $countdownForm.Location = New-Object System.Drawing.Point(50, ([System.Windows.Forms.Screen]::PrimaryScreen.WorkingArea.Height - 250))
    $countdownForm.FormBorderStyle = "FixedDialog"
    $countdownForm.MaximizeBox = $false
    $countdownForm.MinimizeBox = $false
    $countdownForm.TopMost = $true
    $countdownForm.BackColor = [System.Drawing.Color]::FromArgb(30, 30, 30)
    
    # Titre du countdown
    $countdownTitle = New-Object System.Windows.Forms.Label
    $countdownTitle.Location = New-Object System.Drawing.Point(10, 10)
    $countdownTitle.Size = New-Object System.Drawing.Size(370, 30)
    $countdownTitle.Text = "⚠️ Arrêt Programmé"
    $countdownTitle.Font = New-Object System.Drawing.Font("Segoe UI", 14, [System.Drawing.FontStyle]::Bold)
    $countdownTitle.ForeColor = [System.Drawing.Color]::FromArgb(255, 193, 7)
    $countdownTitle.TextAlign = "MiddleCenter"
    
    # Panel pour le timer
    $timerPanel = New-Object System.Windows.Forms.Panel
    $timerPanel.Location = New-Object System.Drawing.Point(20, 50)
    $timerPanel.Size = New-Object System.Drawing.Size(350, 60)
    $timerPanel.BackColor = [System.Drawing.Color]::FromArgb(40, 40, 40)
    
    # Label du timer
    $timerLabel = New-Object System.Windows.Forms.Label
    $timerLabel.Location = New-Object System.Drawing.Point(0, 10)
    $timerLabel.Size = New-Object System.Drawing.Size(350, 40)
    $timerLabel.Font = New-Object System.Drawing.Font("Consolas", 24, [System.Drawing.FontStyle]::Bold)
    $timerLabel.ForeColor = [System.Drawing.Color]::FromArgb(255, 87, 87)
    $timerLabel.TextAlign = "MiddleCenter"
    
    # Boutons modernes
    $btnCancel = New-Object System.Windows.Forms.Button
    $btnCancel.Location = New-Object System.Drawing.Point(40, 130)
    $btnCancel.Size = New-Object System.Drawing.Size(120, 30)
    $btnCancel.Text = "🚫 Annuler"
    $btnCancel.BackColor = [System.Drawing.Color]::FromArgb(52, 152, 219)
    $btnCancel.ForeColor = [System.Drawing.Color]::White
    $btnCancel.FlatStyle = "Flat"
    $btnCancel.Font = New-Object System.Drawing.Font("Segoe UI", 9, [System.Drawing.FontStyle]::Bold)
    
    $btnShutdownNow = New-Object System.Windows.Forms.Button
    $btnShutdownNow.Location = New-Object System.Drawing.Point(230, 130)
    $btnShutdownNow.Size = New-Object System.Drawing.Size(120, 30)
    $btnShutdownNow.Text = "🔴 Arrêter maintenant"
    $btnShutdownNow.BackColor = [System.Drawing.Color]::FromArgb(231, 76, 60)
    $btnShutdownNow.ForeColor = [System.Drawing.Color]::White
    $btnShutdownNow.FlatStyle = "Flat"
    $btnShutdownNow.Font = New-Object System.Drawing.Font("Segoe UI", 9, [System.Drawing.FontStyle]::Bold)
    
    # Timer
    $timer = New-Object System.Windows.Forms.Timer
    $timer.Interval = 1000
    $remainingSeconds = $totalSeconds
    
    # Fonction pour formater le temps
    function Format-Time($seconds) {
        $minutes = [math]::Floor($seconds / 60)
        $secs = $seconds % 60
        return "{0:00}:{1:00}" -f $minutes, $secs
    }
    
    # Événement du timer
    $timer.Add_Tick({
        $script:remainingSeconds--
        $timerLabel.Text = Format-Time $script:remainingSeconds
        
        if ($script:remainingSeconds -le 0) {
            $timer.Stop()
            $countdownForm.Close()
            shutdown /s /t 0 /f
        }
        
        # Changement de couleur selon le temps
        if ($script:remainingSeconds -le 10) {
            $timerLabel.ForeColor = [System.Drawing.Color]::FromArgb(255, 0, 0)
            $timerPanel.BackColor = [System.Drawing.Color]::FromArgb(60, 20, 20)
        } elseif ($script:remainingSeconds -le 30) {
            $timerLabel.ForeColor = [System.Drawing.Color]::FromArgb(255, 100, 100)
            $timerPanel.BackColor = [System.Drawing.Color]::FromArgb(50, 25, 25)
        } elseif ($script:remainingSeconds -le 60) {
            $timerLabel.ForeColor = [System.Drawing.Color]::FromArgb(255, 165, 0)
        }
    })
    
    # Événements boutons
    $btnCancel.Add_Click({
        $timer.Stop()
        $countdownForm.Close()
        [System.Windows.Forms.MessageBox]::Show("Arrêt annulé !", "Information", "OK", "Information")
    })
    
    $btnShutdownNow.Add_Click({
        $result = [System.Windows.Forms.MessageBox]::Show(
            "Voulez-vous vraiment arrêter le PC maintenant ?",
            "Confirmation d'arrêt",
            [System.Windows.Forms.MessageBoxButtons]::YesNo,
            [System.Windows.Forms.MessageBoxIcon]::Warning
        )
        
        if ($result -eq [System.Windows.Forms.DialogResult]::Yes) {
            $timer.Stop()
            $countdownForm.Close()
            shutdown /s /t 0 /f
        }
    })
    
    # Ajout des contrôles
    $timerPanel.Controls.Add($timerLabel)
    $countdownForm.Controls.Add($countdownTitle)
    $countdownForm.Controls.Add($timerPanel)
    $countdownForm.Controls.Add($btnCancel)
    $countdownForm.Controls.Add($btnShutdownNow)
    
    # Initialisation et démarrage
    $timerLabel.Text = Format-Time $remainingSeconds
    $timer.Start()
    
    # Affichage
    $countdownForm.ShowDialog()
    
    # Nettoyage
    $timer.Dispose()
    $countdownForm.Dispose()
}

# Nettoyage final
$configForm.Dispose()