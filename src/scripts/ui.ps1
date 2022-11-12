#echo "... Starting Configuration GUI ..."

Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

$form = New-Object System.Windows.Forms.Form
$form.Text = 'Configure Project'
$form.Size = New-Object System.Drawing.Size(400,460)
$form.StartPosition = 'CenterScreen'

$okButton = New-Object System.Windows.Forms.Button
$okButton.Location = New-Object System.Drawing.Point(100,360)
$okButton.Size = New-Object System.Drawing.Size(80,30)
$okButton.Text = 'Start Project'
$okButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
$form.AcceptButton = $okButton
$form.Controls.Add($okButton)

$cancelButton = New-Object System.Windows.Forms.Button
$cancelButton.Location = New-Object System.Drawing.Point(220,360)
$cancelButton.Size = New-Object System.Drawing.Size(80,30)
$cancelButton.Text = 'Cancel'
$cancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Cancel
$form.CancelButton = $cancelButton
$form.Controls.Add($cancelButton)

$layoutLabel = New-Object System.Windows.Forms.Label
$layoutLabel.Location = New-Object System.Drawing.Point(10,20)
$layoutLabel.Size = New-Object System.Drawing.Size(300,30)
$layoutLabel.Text = 'Select App Layout:'
$form.Controls.Add($layoutLabel)

$layoutListBox = New-Object System.Windows.Forms.ListBox
$layoutListBox.Location = New-Object System.Drawing.Point(10,50)
$layoutListBox.Size = New-Object System.Drawing.Size(280,20)
$layoutListBox.Height = 80

$availableLayouts = C:\Users\Ahmed-Galai\Desktop\Development\Sandbox\pshell\django/scripts/getLayouts.ps1

for ($idx=0; $idx -le $availableLayouts.length-1; $idx++) {
	[void] $layoutListBox.Items.Add(($availableLayouts | Select-Object -index $idx))
}

$themeLabel = New-Object System.Windows.Forms.Label
$themeLabel.Location = New-Object System.Drawing.Point(10,140)
$themeLabel.Size = New-Object System.Drawing.Size(300,30)
$themeLabel.Text = 'Select App Theme:'
$form.Controls.Add($themeLabel)

$themeListBox = New-Object System.Windows.Forms.ListBox
$themeListBox.Location = New-Object System.Drawing.Point(10,180)
$themeListBox.Size = New-Object System.Drawing.Size(280,20)
$themeListBox.Height = 80

$availableThemes = C:\Users\Ahmed-Galai\Desktop\Development\Sandbox\pshell\django/scripts/getThemes.ps1

for ($idx=0; $idx -le $availableThemes.length-1; $idx++) {
	[void] $themeListBox.Items.Add(($availableThemes | Select-Object -index $idx))
}

$label = New-Object System.Windows.Forms.Label
$label.Location = New-Object System.Drawing.Point(10,290)
$label.Size = New-Object System.Drawing.Size(280,20)
$label.Text = 'Enter App name:'
$form.Controls.Add($label)

$textBox = New-Object System.Windows.Forms.TextBox
$textBox.Location = New-Object System.Drawing.Point(10,320)
$textBox.Size = New-Object System.Drawing.Size(260,20)
$form.Controls.Add($textBox)

$form.Controls.Add($layoutListBox)
$form.Controls.Add($themeListBox)
$layoutListBox.SetSelected(0,$true)
$themeListBox.SetSelected(0,$true)
$form.Topmost = $true

$result = $form.ShowDialog()

if ($result -eq [System.Windows.Forms.DialogResult]::OK)
{
	$layout = $layoutListBox.SelectedItem
	$theme = $themeListBox.SelectedItem
	$name = $textBox.Text
	if ($name -eq ""){$name="test"}
	#if ($theme -eq ""){$theme="default"}
	#if ($layout -eq ""){$layout="default"}
	#echo "... Configuration Selected: ..."
	#write-Host "$layout,$theme"
	return "$layout,$theme,$name"
}
