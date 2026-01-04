#Requires -Version 5.1

# Masquer la console PowerShell
Add-Type -Name Window -Namespace Console -MemberDefinition '
[DllImport("Kernel32.dll")]
public static extern IntPtr GetConsoleWindow();
[DllImport("user32.dll")]
public static extern bool ShowWindow(IntPtr hWnd, Int32 nCmdShow);
'
$consolePtr = [Console.Window]::GetConsoleWindow()
[Console.Window]::ShowWindow($consolePtr, 0) | Out-Null

# Configuration UTF-8
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Fonction pour créer des boutons modernes
function New-ModernButton($text, $x, $y, $width, $height, $color) {
    $btn = New-Object System.Windows.Forms.Button
    $btn.Location = New-Object System.Drawing.Point($x, $y)
    $btn.Size = New-Object System.Drawing.Size($width, $height)
    $btn.Text = $text
    $btn.BackColor = $color
    $btn.ForeColor = [System.Drawing.Color]::White
    $btn.FlatStyle = "Flat"
    $btn.FlatAppearance.BorderSize = 0
    $btn.Font = New-Object System.Drawing.Font("Segoe UI", 9, [System.Drawing.FontStyle]::Bold)
    $btn.Cursor = [System.Windows.Forms.Cursors]::Hand
    return $btn
}

# Fenêtre de configuration
$configForm = New-Object System.Windows.Forms.Form
$configForm.Text = "Arrêt Programmé"
$configForm.Size = New-Object System.Drawing.Size(420, 260)
$configForm.StartPosition = "CenterScreen"
$configForm.FormBorderStyle = "FixedDialog"
$configForm.MaximizeBox = $false
$configForm.MinimizeBox = $false
$configForm.BackColor = [System.Drawing.Color]::FromArgb(32, 33, 36)
$configForm.Icon = [System.Drawing.SystemIcons]::Information

# Titre avec icône
$titleLabel = New-Object System.Windows.Forms.Label
$titleLabel.Location = New-Object System.Drawing.Point(0, 15)
$titleLabel.Size = New-Object System.Drawing.Size(420, 45)
$titleLabel.Text = "Arrêt Programmé"
$titleLabel.Font = New-Object System.Drawing.Font("Segoe UI", 18, [System.Drawing.FontStyle]::Bold)
$titleLabel.ForeColor = [System.Drawing.Color]::White
$titleLabel.TextAlign = "MiddleCenter"

# Panel temps
$timePanel = New-Object System.Windows.Forms.Panel
$timePanel.Location = New-Object System.Drawing.Point(40, 75)
$timePanel.Size = New-Object System.Drawing.Size(340, 90)
$timePanel.BackColor = [System.Drawing.Color]::FromArgb(48, 49, 54)

# Label temps
$timeLabel = New-Object System.Windows.Forms.Label
$timeLabel.Location = New-Object System.Drawing.Point(15, 12)
$timeLabel.Size = New-Object System.Drawing.Size(140, 25)
$timeLabel.Text = "Délai d'arrêt :"
$timeLabel.Font = New-Object System.Drawing.Font("Segoe UI", 11)
$timeLabel.ForeColor = [System.Drawing.Color]::White

# Input minutes
$minutesInput = New-Object System.Windows.Forms.NumericUpDown
$minutesInput.Location = New-Object System.Drawing.Point(160, 10)
$minutesInput.Size = New-Object System.Drawing.Size(70, 25)
$minutesInput.Minimum = 1
$minutesInput.Maximum = 999
$minutesInput.Value = 5
$minutesInput.BackColor = [System.Drawing.Color]::FromArgb(66, 66, 66)
$minutesInput.ForeColor = [System.Drawing.Color]::White
$minutesInput.Font = New-Object System.Drawing.Font("Segoe UI", 11, [System.Drawing.FontStyle]::Bold)
$minutesInput.BorderStyle = "None"

# Label "min"
$minLabel = New-Object System.Windows.Forms.Label
$minLabel.Location = New-Object System.Drawing.Point(235, 12)
$minLabel.Size = New-Object System.Drawing.Size(40, 25)
$minLabel.Text = "min"
$minLabel.Font = New-Object System.Drawing.Font("Segoe UI", 10)
$minLabel.ForeColor = [System.Drawing.Color]::LightGray

# Séparateur
$separator = New-Object System.Windows.Forms.Label
$separator.Location = New-Object System.Drawing.Point(15, 42)
$separator.Size = New-Object System.Drawing.Size(310, 1)
$separator.BackColor = [System.Drawing.Color]::FromArgb(80, 80, 80)

# Label raccourcis
$quickLabel = New-Object System.Windows.Forms.Label
$quickLabel.Location = New-Object System.Drawing.Point(15, 50)
$quickLabel.Size = New-Object System.Drawing.Size(80, 20)
$quickLabel.Text = "Raccourcis"
$quickLabel.Font = New-Object System.Drawing.Font("Segoe UI", 9)
$quickLabel.ForeColor = [System.Drawing.Color]::LightGray

# Boutons rapides
$btn1min = New-ModernButton "1m" 100 48 45 28 ([System.Drawing.Color]::FromArgb(88, 101, 242))
$btn5min = New-ModernButton "5m" 150 48 45 28 ([System.Drawing.Color]::FromArgb(88, 101, 242))
$btn10min = New-ModernButton "10m" 200 48 45 28 ([System.Drawing.Color]::FromArgb(88, 101, 242))
$btn30min = New-ModernButton "30m" 250 48 45 28 ([System.Drawing.Color]::FromArgb(88, 101, 242))

# Événements boutons rapides
$btn1min.Add_Click({ $minutesInput.Value = 1 })
$btn5min.Add_Click({ $minutesInput.Value = 5 })
$btn10min.Add_Click({ $minutesInput.Value = 10 })
$btn30min.Add_Click({ $minutesInput.Value = 30 })

# Bouton démarrer
$startButton = New-ModernButton "Démarrer l'arrêt" 100 185 140 38 ([System.Drawing.Color]::FromArgb(67, 181, 129))
$startButton.Font = New-Object System.Drawing.Font("Segoe UI", 11, [System.Drawing.FontStyle]::Bold)

# Bouton quitter
$cancelButton = New-ModernButton "Quitter" 250 185 90 38 ([System.Drawing.Color]::FromArgb(237, 66, 69))

# Variables
$script:shutdownMinutes = 0
$script:startShutdown = $false

# Événements
$startButton.Add_Click({
    $script:shutdownMinutes = [int]$minutesInput.Value
    $script:startShutdown = $true
    $configForm.Close()
})

$cancelButton.Add_Click({
    $script:startShutdown = $false
    $configForm.Close()
})

# Ajout contrôles
$timePanel.Controls.AddRange(@($timeLabel, $minutesInput, $minLabel, $separator, $quickLabel, $btn1min, $btn5min, $btn10min, $btn30min))
$configForm.Controls.AddRange(@($titleLabel, $timePanel, $startButton, $cancelButton))

# Affichage
$configForm.Add_Shown({ $configForm.Activate() })
[void]$configForm.ShowDialog()

# Countdown
if ($script:startShutdown) {
    $totalSeconds = $script:shutdownMinutes * 60
    
    $countdownForm = New-Object System.Windows.Forms.Form
    $countdownForm.Text = "Arrêt en cours"
    $countdownForm.Size = New-Object System.Drawing.Size(380, 210)
    $countdownForm.StartPosition = "Manual"
    $countdownForm.Location = New-Object System.Drawing.Point(40, ([System.Windows.Forms.Screen]::PrimaryScreen.WorkingArea.Height - 260))
    $countdownForm.FormBorderStyle = "FixedSingle"
    $countdownForm.MaximizeBox = $false
    $countdownForm.MinimizeBox = $false
    $countdownForm.TopMost = $true
    $countdownForm.BackColor = [System.Drawing.Color]::FromArgb(32, 33, 36)
    $countdownForm.Icon = [System.Drawing.SystemIcons]::Warning
    
    # Titre
    $countdownTitle = New-Object System.Windows.Forms.Label
    $countdownTitle.Location = New-Object System.Drawing.Point(0, 10)
    $countdownTitle.Size = New-Object System.Drawing.Size(380, 35)
    $countdownTitle.Text = "Arrêt imminent"
    $countdownTitle.Font = New-Object System.Drawing.Font("Segoe UI", 15, [System.Drawing.FontStyle]::Bold)
    $countdownTitle.ForeColor = [System.Drawing.Color]::FromArgb(250, 166, 26)
    $countdownTitle.TextAlign = "MiddleCenter"
    
    # Panel timer
    $timerPanel = New-Object System.Windows.Forms.Panel
    $timerPanel.Location = New-Object System.Drawing.Point(30, 55)
    $timerPanel.Size = New-Object System.Drawing.Size(320, 70)
    $timerPanel.BackColor = [System.Drawing.Color]::FromArgb(48, 49, 54)
    
    # Timer label
    $timerLabel = New-Object System.Windows.Forms.Label
    $timerLabel.Location = New-Object System.Drawing.Point(0, 10)
    $timerLabel.Size = New-Object System.Drawing.Size(320, 50)
    $timerLabel.Font = New-Object System.Drawing.Font("Consolas", 28, [System.Drawing.FontStyle]::Bold)
    $timerLabel.ForeColor = [System.Drawing.Color]::FromArgb(88, 101, 242)
    $timerLabel.TextAlign = "MiddleCenter"
    
    # Boutons
    $btnCancel = New-ModernButton "Annuler" 40 140 120 35 ([System.Drawing.Color]::FromArgb(88, 101, 242))
    $btnShutdownNow = New-ModernButton "Arrêter maintenant" 170 140 160 35 ([System.Drawing.Color]::FromArgb(237, 66, 69))
    
    # Timer
    $timer = New-Object System.Windows.Forms.Timer
    $timer.Interval = 1000
    $remainingSeconds = $totalSeconds
    
    function Format-Time($seconds) {
        $minutes = [math]::Floor($seconds / 60)
        $secs = $seconds % 60
        return "{0:00}:{1:00}" -f $minutes, $secs
    }
    
    $timer.Add_Tick({
        $script:remainingSeconds--
        $timerLabel.Text = Format-Time $script:remainingSeconds
        
        if ($script:remainingSeconds -le 0) {
            $timer.Stop()
            $countdownForm.Close()
            Stop-Computer -Force
        }
        
        # Animation couleurs
        if ($script:remainingSeconds -le 10) {
            $timerLabel.ForeColor = [System.Drawing.Color]::FromArgb(237, 66, 69)
            $timerPanel.BackColor = [System.Drawing.Color]::FromArgb(60, 30, 30)
        } elseif ($script:remainingSeconds -le 30) {
            $timerLabel.ForeColor = [System.Drawing.Color]::FromArgb(250, 166, 26)
            $timerPanel.BackColor = [System.Drawing.Color]::FromArgb(55, 45, 35)
        }
    })
    
    $btnCancel.Add_Click({
        $timer.Stop()
        $countdownForm.Close()
    })
    
    $btnShutdownNow.Add_Click({
        $result = [System.Windows.Forms.MessageBox]::Show(
            "Voulez-vous vraiment arrêter le PC maintenant ?",
            "Confirmation",
            [System.Windows.Forms.MessageBoxButtons]::YesNo,
            [System.Windows.Forms.MessageBoxIcon]::Warning
        )
        
        if ($result -eq [System.Windows.Forms.DialogResult]::Yes) {
            $timer.Stop()
            $countdownForm.Close()
            Stop-Computer -Force
        }
    })
    
    # Ajout contrôles
    $timerPanel.Controls.Add($timerLabel)
    $countdownForm.Controls.AddRange(@($countdownTitle, $timerPanel, $btnCancel, $btnShutdownNow))
    
    # Démarrage
    $timerLabel.Text = Format-Time $remainingSeconds
    $timer.Start()
    
    $countdownForm.Add_Shown({ $countdownForm.Activate() })
    [void]$countdownForm.ShowDialog()
    
    $timer.Dispose()
    $countdownForm.Dispose()
}

$configForm.Dispose()