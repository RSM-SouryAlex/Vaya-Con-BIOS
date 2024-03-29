﻿Clear-Host
$Banner = @"
  ________  ___  ___  ___  _________  ________  ________  ___  ________  _________       
 |\   ____\|\  \|\  \|\  \|\___   ___\\   __  \|\   __  \|\  \|\   ____\|\___   ___\     
 \ \  \___|\ \  \\\  \ \  \|___ \  \_\ \  \|\  \ \  \|\  \ \  \ \  \___|\|___ \  \_|     
  \ \  \  __\ \  \\\  \ \  \   \ \  \ \ \   __  \ \   _  _\ \  \ \_____  \   \ \  \      
   \ \  \|\  \ \  \\\  \ \  \   \ \  \ \ \  \ \  \ \  \\  \\ \  \|____|\  \   \ \  \     
    \ \_______\ \_______\ \__\   \ \__\ \ \__\ \__\ \__\\ _\\ \__\____\_\  \   \ \__\    
     \|_______|\|_______|\|__|    \|__|  \|__|\|__|\|__|\|__|\|__|\_________\   \|__|    
         ________  ___  ___  ___  ________                       \|_________|            
        |\   __  \|\  \|\  \|\  \|\_____  \                                              
        \ \  \|\  \ \  \\\  \ \  \\|___/  /|                                             
         \ \  \\\  \ \  \\\  \ \  \   /  / /                                             
          \ \  \\\  \ \  \\\  \ \  \ /  /_/__                                            
           \ \_____  \ \_______\ \__\\________\                                          
            \|___| \__\|_______|\|__|\|_______|                                          
                  \|__|                                                                  
                                                                        
"@
Write-Host $Banner -ForegroundColor DarkYellow

[int]$Count = '20'

function Out-Speak
{
    [CmdletBinding()]
    [Alias()]
    [OutputType([int])]
    
    Param
    (
        [parameter(ValueFromPipeline='True')]
        [string[]] $Phrase,

        [parameter()]
        [ValidateRange(-10,10)]
        [int] $Rate = 0,

        [ValidateSet("David", "Zira")]
        $Voice = "David",

        [parameter()]
        [ValidateRange(1,100)]
        $Volume = 100
    )

    Begin
    {
        Add-Type -AssemblyName System.speech
        $speak = New-Object System.Speech.Synthesis.SpeechSynthesizer

        if($Voice -eq 'David')
        {$speak.SelectVoice('Microsoft David Desktop')}

        if($Voice -eq 'Zira')
        {$speak.SelectVoice('Microsoft Zira Desktop')}

        $speak.Rate   = $Rate  # -10 is slowest, 10 is fastest

        $speak.volume = $Volume

    }
    
    Process
    {
        $speak.Speak($Phrase)
    }
}

$Guitarists = 'Joe Satriani',`
              'Dave Mustaine',`
              'Paul Stanley',`
              'Eddie Van Halen',`
              'Lzzy Hale',`
              'Adrian Smith',`
              'Mike Ness',`
              'Angus Young',`
              'Dimebag Darrell',`
              'Billy Gibbons',`
              'Brian Setzer',`
              'Dave Murray',`
              'Steve Clark',`
              'Ace Frehley',`
              'Orianthi',`
              'Tony Iommi',`
              'Slash',`
              'Phil Collen',`
              'Prince',`
              'James Hetfield',`
              'Randy Rhodes',`
              'Dave Navarro',`
              'Mike Einziger',`
              'Tom Morrello',`
              'John Frusciante',`
              'Jimmi Hendrix',`
              'Kirk Hammett',`
              'John 5',`
              'Santana',`
              'Jimmy Page',`
              'Joe Perry',`
              'Lita Ford',`
              'BucketHead',`
              'George Lynch',`
              'Marty Friedman',`
              'Zakk Wylde',`
              'Steve Vai',`
              'Yngwie Malmsteen',`
              'Daron Malakian',`
              'Daron Malakian'



function Show-Window
{
    [cmdletBinding()]
    Param
    (
        $filepath
    )

    Add-Type -AssemblyName System.Windows.Forms
    Add-Type -AssemblyName System.Drawing

    $img = [System.Drawing.Image]::Fromfile((Get-Item $filepath))

    $form = New-Object System.Windows.Forms.Form
    $form.Text = 'Band Quiz: Guitarist'
    $Width = $img.Size.Width + '20'
    $Height = $img.Size.Height + '135'
    $form.Size = New-Object System.Drawing.Size($Width,$Height)
    $form.StartPosition = 'CenterScreen'

    $okButton = New-Object System.Windows.Forms.Button
    $okHeight = $img.Size.Height + '55'
    $okButton.Location = New-Object System.Drawing.Point(15,$okHeight)
    $okButton.Size = New-Object System.Drawing.Size(75,23)
    $okButton.Text = 'Enter'
    $okButton.DialogResult = [System.Windows.Forms.DialogResult]::OK
    $form.AcceptButton = $okButton
    $form.Controls.Add($okButton)

    $cancelButton = New-Object System.Windows.Forms.Button
    $cancelHeight = $img.Size.Height + '55'
    $cancelButton.Location = New-Object System.Drawing.Point(105,$cancelHeight)
    $cancelButton.Size = New-Object System.Drawing.Size(75,23)
    $cancelButton.Text = 'Help'
    $cancelButton.DialogResult = [System.Windows.Forms.DialogResult]::Retry
    $form.CancelButton = $cancelButton
    #$form.Controls.Add($cancelButton)

    $skipButton = New-Object System.Windows.Forms.Button
    $skipHeight = $img.Size.Height + '55'
    $skipButton.Location = New-Object System.Drawing.Point(195,$skipHeight)
    $skipButton.Size = New-Object System.Drawing.Size(75,23)
    $skipButton.Text = 'Skip'
    $skipButton.DialogResult = [System.Windows.Forms.DialogResult]::Ignore
    $form.CancelButton = $skipButton
    $form.Controls.Add($skipButton)

    $label = New-Object System.Windows.Forms.Label
    $labelHeight = $img.Size.Height + '5'
    $label.Location = New-Object System.Drawing.Point(10,$labelHeight)
    $label.Size = New-Object System.Drawing.Size(280,20)
    $label.Text = 'Name the guitarist:'
    $form.Controls.Add($label)

    $pictureBox = New-Object System.Windows.Forms.PictureBox
    $pictureBox.Width =  $img.Size.Width;
    $pictureBox.Height =  $img.Size.Height;
    $pictureBox.Image = $img;
    $form.controls.add($pictureBox)

    $textBox = New-Object System.Windows.Forms.TextBox
    $textHeight = $img.Size.Height + '25'
    $textBox.Location = New-Object System.Drawing.Point(10,$textHeight)
    $textBox.Size = New-Object System.Drawing.Size(260,20)
    #$form.Controls.Add($textBox)

    $Answers = $Guitarists | Get-Random -Count 4
    $C = 0,1,2,3 | Get-Random 
    $RAnswer = Get-ItemProperty -Path $filepath
    $RightAnswer = $RAnswer.BaseName

    if($Answers -like $RightAnswer)
    {
        $Answers = $Guitarists | Get-Random -Count 4
        $Answers[$C] = $RightAnswer
    }
    else
    {
        $Answers[$C] = $RightAnswer
    }

    $RadioButton1 = New-Object System.Windows.Forms.RadioButton
    $RadioButton1.Location = New-Object System.Drawing.Point(10,$textHeight)
    $RadioButton1.size = '100,30'
    $RadioButton1.Checked = $false 
    $RadioButton1.Text = "$($Answers[0])"
    $form.Controls.Add($RadioButton1)

    $RadioButton2 = New-Object System.Windows.Forms.RadioButton
    $RadioButton2.Location = New-Object System.Drawing.Point(110,$textHeight)
    $RadioButton2.size = '100,30'
    $RadioButton2.Checked = $false 
    $RadioButton2.Text = "$($Answers[1])"
    $form.Controls.Add($RadioButton2)

    $RadioButton3 = New-Object System.Windows.Forms.RadioButton
    $RadioButton3.Location = New-Object System.Drawing.Point(210,$textHeight)
    $RadioButton3.size = '100,30'
    $RadioButton3.Checked = $false 
    $RadioButton3.Text = "$($Answers[2])"
    $form.Controls.Add($RadioButton3)

    $RadioButton4 = New-Object System.Windows.Forms.RadioButton
    $RadioButton4.Location = New-Object System.Drawing.Point(310,$textHeight)
    $RadioButton4.size = '100,30'
    $RadioButton4.Checked = $false 
    $RadioButton4.Text = "$($Answers[3])"
    $form.Controls.Add($RadioButton4)


    $form.Topmost = $true

    $form.Add_Shown({$textBox.Select()})
    $result = $form.ShowDialog()

    if ($result -eq [System.Windows.Forms.DialogResult]::OK)
    {
        if($filepath -like '*Joe Satriani*')
        {
            if($RadioButton1.Checked -and ($RadioButton1.Text -eq 'Joe Satriani'))
            {
                Write-Output 'Correct'
                Out-Speak 'Correct'
            }
            else
            {
                 if($RadioButton2.Checked -and ($RadioButton2.Text -eq 'Joe Satriani'))
                {
                    Write-Output 'Correct'
                    Out-Speak 'Correct'
                }
                else
                {
                     if($RadioButton3.Checked -and ($RadioButton3.Text -eq 'Joe Satriani'))
                    {
                        Write-Output 'Correct'
                        Out-Speak 'Correct'
                    }
                    else
                    {
                         if($RadioButton4.Checked -and ($RadioButton4.Text -eq 'Joe Satriani'))
                        {
                            Write-Output 'Correct'
                            Out-Speak 'Correct'
                        }
                        else
                        {
                            Write-Output 'Incorrect'
                            Out-Speak 'That is incorrect'
                        }
                    }
                }
            }
        }
        if($filepath -like '*Dave Mustaine*')
        {
            if($RadioButton1.Checked -and ($RadioButton1.Text -eq 'Dave Mustaine'))
            {
                Write-Output 'Correct'
                Out-Speak 'Correct'
            }
            else
            {
                 if($RadioButton2.Checked -and ($RadioButton2.Text -eq 'Dave Mustaine'))
                {
                    Write-Output 'Correct'
                    Out-Speak 'Correct'
                }
                else
                {
                     if($RadioButton3.Checked -and ($RadioButton3.Text -eq 'Dave Mustaine'))
                    {
                        Write-Output 'Correct'
                        Out-Speak 'Correct'
                    }
                    else
                    {
                         if($RadioButton4.Checked -and ($RadioButton4.Text -eq 'Dave Mustaine'))
                        {
                            Write-Output 'Correct'
                            Out-Speak 'Correct'
                        }
                        else
                        {
                            Write-Output 'Incorrect'
                            Out-Speak 'That is incorrect'
                        }
                    }
                }
            }
        }
        if($filepath -like '*Paul Stanley*')
        {
            if($RadioButton1.Checked -and ($RadioButton1.Text -eq 'Paul Stanley'))
            {
                Write-Output 'Correct'
                Out-Speak 'Correct'
            }
            else
            {
                 if($RadioButton2.Checked -and ($RadioButton2.Text -eq 'Paul Stanley'))
                {
                    Write-Output 'Correct'
                    Out-Speak 'Correct'
                }
                else
                {
                     if($RadioButton3.Checked -and ($RadioButton3.Text -eq 'Paul Stanley'))
                    {
                        Write-Output 'Correct'
                        Out-Speak 'Correct'
                    }
                    else
                    {
                         if($RadioButton4.Checked -and ($RadioButton4.Text -eq 'Paul Stanley'))
                        {
                            Write-Output 'Correct'
                            Out-Speak 'Correct'
                        }
                        else
                        {
                            Write-Output 'Incorrect'
                            Out-Speak 'That is incorrect'
                        }
                    }
                }
            }
        }
        if($filepath -like '*Eddie Van Halen*')
        {
            if($RadioButton1.Checked -and ($RadioButton1.Text -eq 'Eddie Van Halen'))
            {
                Write-Output 'Correct'
                Out-Speak 'Correct'
            }
            else
            {
                 if($RadioButton2.Checked -and ($RadioButton2.Text -eq 'Eddie Van Halen'))
                {
                    Write-Output 'Correct'
                    Out-Speak 'Correct'
                }
                else
                {
                     if($RadioButton3.Checked -and ($RadioButton3.Text -eq 'Eddie Van Halen'))
                    {
                        Write-Output 'Correct'
                        Out-Speak 'Correct'
                    }
                    else
                    {
                         if($RadioButton4.Checked -and ($RadioButton4.Text -eq 'Eddie Van Halen'))
                        {
                            Write-Output 'Correct'
                            Out-Speak 'Correct'
                        }
                        else
                        {
                            Write-Output 'Incorrect'
                            Out-Speak 'That is incorrect'
                        }
                    }
                }
            }
        }
        if($filepath -like '*Adrian Smith*')
        {
            if($RadioButton1.Checked -and ($RadioButton1.Text -eq 'Adrian Smith'))
            {
                Write-Output 'Correct'
                Out-Speak 'Correct'
            }
            else
            {
                 if($RadioButton2.Checked -and ($RadioButton2.Text -eq 'Adrian Smith'))
                {
                    Write-Output 'Correct'
                    Out-Speak 'Correct'
                }
                else
                {
                     if($RadioButton3.Checked -and ($RadioButton3.Text -eq 'Adrian Smith'))
                    {
                        Write-Output 'Correct'
                        Out-Speak 'Correct'
                    }
                    else
                    {
                         if($RadioButton4.Checked -and ($RadioButton4.Text -eq 'Adrian Smith'))
                        {
                            Write-Output 'Correct'
                            Out-Speak 'Correct'
                        }
                        else
                        {
                            Write-Output 'Incorrect'
                            Out-Speak 'That is incorrect'
                        }
                    }
                }
            }
        }
        if($filepath -like '*Lzzy Hale*')
        {
            if($RadioButton1.Checked -and ($RadioButton1.Text -eq 'Lzzy Hale'))
            {
                Write-Output 'Correct'
                Out-Speak 'Correct'
            }
            else
            {
                 if($RadioButton2.Checked -and ($RadioButton2.Text -eq 'Lzzy Hale'))
                {
                    Write-Output 'Correct'
                    Out-Speak 'Correct'
                }
                else
                {
                     if($RadioButton3.Checked -and ($RadioButton3.Text -eq 'Lzzy Hale'))
                    {
                        Write-Output 'Correct'
                        Out-Speak 'Correct'
                    }
                    else
                    {
                         if($RadioButton4.Checked -and ($RadioButton4.Text -eq 'Lzzy Hale'))
                        {
                            Write-Output 'Correct'
                            Out-Speak 'Correct'
                        }
                        else
                        {
                            Write-Output 'Incorrect'
                            Out-Speak 'That is incorrect'
                        }
                    }
                }
            }
        }
        if($filepath -like '*Mike Ness*')
        {
            if($RadioButton1.Checked -and ($RadioButton1.Text -eq 'Mike Ness'))
            {
                Write-Output 'Correct'
                Out-Speak 'Correct'
            }
            else
            {
                 if($RadioButton2.Checked -and ($RadioButton2.Text -eq 'Mike Ness'))
                {
                    Write-Output 'Correct'
                    Out-Speak 'Correct'
                }
                else
                {
                     if($RadioButton3.Checked -and ($RadioButton3.Text -eq 'Mike Ness'))
                    {
                        Write-Output 'Correct'
                        Out-Speak 'Correct'
                    }
                    else
                    {
                         if($RadioButton4.Checked -and ($RadioButton4.Text -eq 'Mike Ness'))
                        {
                            Write-Output 'Correct'
                            Out-Speak 'Correct'
                        }
                        else
                        {
                            Write-Output 'Incorrect'
                            Out-Speak 'That is incorrect'
                        }
                    }
                }
            }
        }
        if($filepath -like '*Angus Young*')
        {
            if($RadioButton1.Checked -and ($RadioButton1.Text -eq 'Angus Young'))
            {
                Write-Output 'Correct'
                Out-Speak 'Correct'
            }
            else
            {
                 if($RadioButton2.Checked -and ($RadioButton2.Text -eq 'Angus Young'))
                {
                    Write-Output 'Correct'
                    Out-Speak 'Correct'
                }
                else
                {
                     if($RadioButton3.Checked -and ($RadioButton3.Text -eq 'Angus Young'))
                    {
                        Write-Output 'Correct'
                        Out-Speak 'Correct'
                    }
                    else
                    {
                         if($RadioButton4.Checked -and ($RadioButton4.Text -eq 'Angus Young'))
                        {
                            Write-Output 'Correct'
                            Out-Speak 'Correct'
                        }
                        else
                        {
                            Write-Output 'Incorrect'
                            Out-Speak 'That is incorrect'
                        }
                    }
                }
            }
        }
        if($filepath -like '*Dimebag Darrell*')
        {
            if($RadioButton1.Checked -and ($RadioButton1.Text -eq 'Dimebag Darrell'))
            {
                Write-Output 'Correct'
                Out-Speak 'Correct'
            }
            else
            {
                 if($RadioButton2.Checked -and ($RadioButton2.Text -eq 'Dimebag Darrell'))
                {
                    Write-Output 'Correct'
                    Out-Speak 'Correct'
                }
                else
                {
                     if($RadioButton3.Checked -and ($RadioButton3.Text -eq 'Dimebag Darrell'))
                    {
                        Write-Output 'Correct'
                        Out-Speak 'Correct'
                    }
                    else
                    {
                         if($RadioButton4.Checked -and ($RadioButton4.Text -eq 'Dimebag Darrell'))
                        {
                            Write-Output 'Correct'
                            Out-Speak 'Correct'
                        }
                        else
                        {
                            Write-Output 'Incorrect'
                            Out-Speak 'That is incorrect'
                        }
                    }
                }
            }
        }
        if($filepath -like '*Billy Gibbons*')
        {
            if($RadioButton1.Checked -and ($RadioButton1.Text -eq 'Billy Gibbons'))
            {
                Write-Output 'Correct'
                Out-Speak 'Correct'
            }
            else
            {
                 if($RadioButton2.Checked -and ($RadioButton2.Text -eq 'Billy Gibbons'))
                {
                    Write-Output 'Correct'
                    Out-Speak 'Correct'
                }
                else
                {
                     if($RadioButton3.Checked -and ($RadioButton3.Text -eq 'Billy Gibbons'))
                    {
                        Write-Output 'Correct'
                        Out-Speak 'Correct'
                    }
                    else
                    {
                         if($RadioButton4.Checked -and ($RadioButton4.Text -eq 'Billy Gibbons'))
                        {
                            Write-Output 'Correct'
                            Out-Speak 'Correct'
                        }
                        else
                        {
                            Write-Output 'Incorrect'
                            Out-Speak 'That is incorrect'
                        }
                    }
                }
            }
        }
        if($filepath -like '*Brian Setzer*')
        {
            if($RadioButton1.Checked -and ($RadioButton1.Text -eq 'Brian Setzer'))
            {
                Write-Output 'Correct'
                Out-Speak 'Correct'
            }
            else
            {
                 if($RadioButton2.Checked -and ($RadioButton2.Text -eq 'Brian Setzer'))
                {
                    Write-Output 'Correct'
                    Out-Speak 'Correct'
                }
                else
                {
                     if($RadioButton3.Checked -and ($RadioButton3.Text -eq 'Brian Setzer'))
                    {
                        Write-Output 'Correct'
                        Out-Speak 'Correct'
                    }
                    else
                    {
                         if($RadioButton4.Checked -and ($RadioButton4.Text -eq 'Brian Setzer'))
                        {
                            Write-Output 'Correct'
                            Out-Speak 'Correct'
                        }
                        else
                        {
                            Write-Output 'Incorrect'
                            Out-Speak 'That is incorrect'
                        }
                    }
                }
            }
        }
        if($filepath -like '*Dave Murray*')
        {
            if($RadioButton1.Checked -and ($RadioButton1.Text -eq 'Dave Murray'))
            {
                Write-Output 'Correct'
                Out-Speak 'Correct'
            }
            else
            {
                 if($RadioButton2.Checked -and ($RadioButton2.Text -eq 'Dave Murray'))
                {
                    Write-Output 'Correct'
                    Out-Speak 'Correct'
                }
                else
                {
                     if($RadioButton3.Checked -and ($RadioButton3.Text -eq 'Dave Murray'))
                    {
                        Write-Output 'Correct'
                        Out-Speak 'Correct'
                    }
                    else
                    {
                         if($RadioButton4.Checked -and ($RadioButton4.Text -eq 'Dave Murray'))
                        {
                            Write-Output 'Correct'
                            Out-Speak 'Correct'
                        }
                        else
                        {
                            Write-Output 'Incorrect'
                            Out-Speak 'That is incorrect'
                        }
                    }
                }
            }
        }
        if($filepath -like '*Steve Clark*')
        {
            if($RadioButton1.Checked -and ($RadioButton1.Text -eq 'Steve Clark'))
            {
                Write-Output 'Correct'
                Out-Speak 'Correct'
            }
            else
            {
                 if($RadioButton2.Checked -and ($RadioButton2.Text -eq 'Steve Clark'))
                {
                    Write-Output 'Correct'
                    Out-Speak 'Correct'
                }
                else
                {
                     if($RadioButton3.Checked -and ($RadioButton3.Text -eq 'Steve Clark'))
                    {
                        Write-Output 'Correct'
                        Out-Speak 'Correct'
                    }
                    else
                    {
                         if($RadioButton4.Checked -and ($RadioButton4.Text -eq 'Steve Clark'))
                        {
                            Write-Output 'Correct'
                            Out-Speak 'Correct'
                        }
                        else
                        {
                            Write-Output 'Incorrect'
                            Out-Speak 'That is incorrect'
                        }
                    }
                }
            }
        }
        if($filepath -like '*Ace Frehley*')
        {
            if($RadioButton1.Checked -and ($RadioButton1.Text -eq 'Ace Frehley'))
            {
                Write-Output 'Correct'
                Out-Speak 'Correct'
            }
            else
            {
                 if($RadioButton2.Checked -and ($RadioButton2.Text -eq 'Ace Frehley'))
                {
                    Write-Output 'Correct'
                    Out-Speak 'Correct'
                }
                else
                {
                     if($RadioButton3.Checked -and ($RadioButton3.Text -eq 'Ace Frehley'))
                    {
                        Write-Output 'Correct'
                        Out-Speak 'Correct'
                    }
                    else
                    {
                         if($RadioButton4.Checked -and ($RadioButton4.Text -eq 'Ace Frehley'))
                        {
                            Write-Output 'Correct'
                            Out-Speak 'Correct'
                        }
                        else
                        {
                            Write-Output 'Incorrect'
                            Out-Speak 'That is incorrect'
                        }
                    }
                }
            }
        }
        if($filepath -like '*Orianthi*')
        {
            if($RadioButton1.Checked -and ($RadioButton1.Text -eq 'Orianthi'))
            {
                Write-Output 'Correct'
                Out-Speak 'Correct'
            }
            else
            {
                 if($RadioButton2.Checked -and ($RadioButton2.Text -eq 'Orianthi'))
                {
                    Write-Output 'Correct'
                    Out-Speak 'Correct'
                }
                else
                {
                     if($RadioButton3.Checked -and ($RadioButton3.Text -eq 'Orianthi'))
                    {
                        Write-Output 'Correct'
                        Out-Speak 'Correct'
                    }
                    else
                    {
                         if($RadioButton4.Checked -and ($RadioButton4.Text -eq 'Orianthi'))
                        {
                            Write-Output 'Correct'
                            Out-Speak 'Correct'
                        }
                        else
                        {
                            Write-Output 'Incorrect'
                            Out-Speak 'That is incorrect'
                        }
                    }
                }
            }
        }
        if($filepath -like '*Kurt Cobain*')
        {
            if($RadioButton1.Checked -and ($RadioButton1.Text -eq 'Kurt Cobain'))
            {
                Write-Output 'Correct'
                Out-Speak 'Correct'
            }
            else
            {
                 if($RadioButton2.Checked -and ($RadioButton2.Text -eq 'Kurt Cobain'))
                {
                    Write-Output 'Correct'
                    Out-Speak 'Correct'
                }
                else
                {
                     if($RadioButton3.Checked -and ($RadioButton3.Text -eq 'Kurt Cobain'))
                    {
                        Write-Output 'Correct'
                        Out-Speak 'Correct'
                    }
                    else
                    {
                         if($RadioButton4.Checked -and ($RadioButton4.Text -eq 'Kurt Cobain'))
                        {
                            Write-Output 'Correct'
                            Out-Speak 'Correct'
                        }
                        else
                        {
                            Write-Output 'Incorrect'
                            Out-Speak 'That is incorrect'
                        }
                    }
                }
            }
        }
        if($filepath -like '*Tony Iommi*')
        {
            if($RadioButton1.Checked -and ($RadioButton1.Text -eq 'Tony Iommi'))
            {
                Write-Output 'Correct'
                Out-Speak 'Correct'
            }
            else
            {
                 if($RadioButton2.Checked -and ($RadioButton2.Text -eq 'Tony Iommi'))
                {
                    Write-Output 'Correct'
                    Out-Speak 'Correct'
                }
                else
                {
                     if($RadioButton3.Checked -and ($RadioButton3.Text -eq 'Tony Iommi'))
                    {
                        Write-Output 'Correct'
                        Out-Speak 'Correct'
                    }
                    else
                    {
                         if($RadioButton4.Checked -and ($RadioButton4.Text -eq 'Tony Iommi'))
                        {
                            Write-Output 'Correct'
                            Out-Speak 'Correct'
                        }
                        else
                        {
                            Write-Output 'Incorrect'
                            Out-Speak 'That is incorrect'
                        }
                    }
                }
            }
        }
        if($filepath -like '*Slash*')
        {
            if($RadioButton1.Checked -and ($RadioButton1.Text -eq 'Slash'))
            {
                Write-Output 'Correct'
                Out-Speak 'Correct'
            }
            else
            {
                 if($RadioButton2.Checked -and ($RadioButton2.Text -eq 'Slash'))
                {
                    Write-Output 'Correct'
                    Out-Speak 'Correct'
                }
                else
                {
                     if($RadioButton3.Checked -and ($RadioButton3.Text -eq 'Slash'))
                    {
                        Write-Output 'Correct'
                        Out-Speak 'Correct'
                    }
                    else
                    {
                         if($RadioButton4.Checked -and ($RadioButton4.Text -eq 'Slash'))
                        {
                            Write-Output 'Correct'
                            Out-Speak 'Correct'
                        }
                        else
                        {
                            Write-Output 'Incorrect'
                            Out-Speak 'That is incorrect'
                        }
                    }
                }
            }
        }
        if($filepath -like '*Phil Collen*')
        {
            if($RadioButton1.Checked -and ($RadioButton1.Text -eq 'Phil Collen'))
            {
                Write-Output 'Correct'
                Out-Speak 'Correct'
            }
            else
            {
                 if($RadioButton2.Checked -and ($RadioButton2.Text -eq 'Phil Collen'))
                {
                    Write-Output 'Correct'
                    Out-Speak 'Correct'
                }
                else
                {
                     if($RadioButton3.Checked -and ($RadioButton3.Text -eq 'Phil Collen'))
                    {
                        Write-Output 'Correct'
                        Out-Speak 'Correct'
                    }
                    else
                    {
                         if($RadioButton4.Checked -and ($RadioButton4.Text -eq 'Phil Collen'))
                        {
                            Write-Output 'Correct'
                            Out-Speak 'Correct'
                        }
                        else
                        {
                            Write-Output 'Incorrect'
                            Out-Speak 'That is incorrect'
                        }
                    }
                }
            }
        }
        if($filepath -like '*Prince*')
        {
            if($RadioButton1.Checked -and ($RadioButton1.Text -eq 'Prince'))
            {
                Write-Output 'Correct'
                Out-Speak 'Correct'
            }
            else
            {
                 if($RadioButton2.Checked -and ($RadioButton2.Text -eq 'Prince'))
                {
                    Write-Output 'Correct'
                    Out-Speak 'Correct'
                }
                else
                {
                     if($RadioButton3.Checked -and ($RadioButton3.Text -eq 'Prince'))
                    {
                        Write-Output 'Correct'
                        Out-Speak 'Correct'
                    }
                    else
                    {
                         if($RadioButton4.Checked -and ($RadioButton4.Text -eq 'Prince'))
                        {
                            Write-Output 'Correct'
                            Out-Speak 'Correct'
                        }
                        else
                        {
                            Write-Output 'Incorrect'
                            Out-Speak 'That is incorrect'
                        }
                    }
                }
            }
        }
        if($filepath -like '*James Hetfield*')
        {
            if($RadioButton1.Checked -and ($RadioButton1.Text -eq 'James Hetfield'))
            {
                Write-Output 'Correct'
                Out-Speak 'Correct'
            }
            else
            {
                 if($RadioButton2.Checked -and ($RadioButton2.Text -eq 'James Hetfield'))
                {
                    Write-Output 'Correct'
                    Out-Speak 'Correct'
                }
                else
                {
                     if($RadioButton3.Checked -and ($RadioButton3.Text -eq 'James Hetfield'))
                    {
                        Write-Output 'Correct'
                        Out-Speak 'Correct'
                    }
                    else
                    {
                         if($RadioButton4.Checked -and ($RadioButton4.Text -eq 'James Hetfield'))
                        {
                            Write-Output 'Correct'
                            Out-Speak 'Correct'
                        }
                        else
                        {
                            Write-Output 'Incorrect'
                            Out-Speak 'That is incorrect'
                        }
                    }
                }
            }
        }
        if($filepath -like '*Randy Rhodes*')
        {
            if($RadioButton1.Checked -and ($RadioButton1.Text -eq 'Randy Rhodes'))
            {
                Write-Output 'Correct'
                Out-Speak 'Correct'
            }
            else
            {
                 if($RadioButton2.Checked -and ($RadioButton2.Text -eq 'Randy Rhodes'))
                {
                    Write-Output 'Correct'
                    Out-Speak 'Correct'
                }
                else
                {
                     if($RadioButton3.Checked -and ($RadioButton3.Text -eq 'Randy Rhodes'))
                    {
                        Write-Output 'Correct'
                        Out-Speak 'Correct'
                    }
                    else
                    {
                         if($RadioButton4.Checked -and ($RadioButton4.Text -eq 'Randy Rhodes'))
                        {
                            Write-Output 'Correct'
                            Out-Speak 'Correct'
                        }
                        else
                        {
                            Write-Output 'Incorrect'
                            Out-Speak 'That is incorrect'
                        }
                    }
                }
            }
        }
        if($filepath -like '*Dave Navarro*')
        {
            if($RadioButton1.Checked -and ($RadioButton1.Text -eq 'Dave Navarro'))
            {
                Write-Output 'Correct'
                Out-Speak 'Correct'
            }
            else
            {
                 if($RadioButton2.Checked -and ($RadioButton2.Text -eq 'Dave Navarro'))
                {
                    Write-Output 'Correct'
                    Out-Speak 'Correct'
                }
                else
                {
                     if($RadioButton3.Checked -and ($RadioButton3.Text -eq 'Dave Navarro'))
                    {
                        Write-Output 'Correct'
                        Out-Speak 'Correct'
                    }
                    else
                    {
                         if($RadioButton4.Checked -and ($RadioButton4.Text -eq 'Dave Navarro'))
                        {
                            Write-Output 'Correct'
                            Out-Speak 'Correct'
                        }
                        else
                        {
                            Write-Output 'Incorrect'
                            Out-Speak 'That is incorrect'
                        }
                    }
                }
            }
        }
        if($filepath -like '*Mike Einziger*')
        {
            if($RadioButton1.Checked -and ($RadioButton1.Text -eq 'Mike Einziger'))
            {
                Write-Output 'Correct'
                Out-Speak 'Correct'
            }
            else
            {
                 if($RadioButton2.Checked -and ($RadioButton2.Text -eq 'Mike Einziger'))
                {
                    Write-Output 'Correct'
                    Out-Speak 'Correct'
                }
                else
                {
                     if($RadioButton3.Checked -and ($RadioButton3.Text -eq 'Mike Einziger'))
                    {
                        Write-Output 'Correct'
                        Out-Speak 'Correct'
                    }
                    else
                    {
                         if($RadioButton4.Checked -and ($RadioButton4.Text -eq 'Mike Einziger'))
                        {
                            Write-Output 'Correct'
                            Out-Speak 'Correct'
                        }
                        else
                        {
                            Write-Output 'Incorrect'
                            Out-Speak 'That is incorrect'
                        }
                    }
                }
            }
        }
        if($filepath -like '*Tom Morrello*')
        {
            if($RadioButton1.Checked -and ($RadioButton1.Text -eq 'Tom Morrello'))
            {
                Write-Output 'Correct'
                Out-Speak 'Correct'
            }
            else
            {
                 if($RadioButton2.Checked -and ($RadioButton2.Text -eq 'Tom Morrello'))
                {
                    Write-Output 'Correct'
                    Out-Speak 'Correct'
                }
                else
                {
                     if($RadioButton3.Checked -and ($RadioButton3.Text -eq 'Tom Morrello'))
                    {
                        Write-Output 'Correct'
                        Out-Speak 'Correct'
                    }
                    else
                    {
                         if($RadioButton4.Checked -and ($RadioButton4.Text -eq 'Tom Morrello'))
                        {
                            Write-Output 'Correct'
                            Out-Speak 'Correct'
                        }
                        else
                        {
                            Write-Output 'Incorrect'
                            Out-Speak 'That is incorrect'
                        }
                    }
                }
            }
        }
        if($filepath -like '*John Frusciante*')
        {
            if($RadioButton1.Checked -and ($RadioButton1.Text -eq 'John Frusciante'))
            {
                Write-Output 'Correct'
                Out-Speak 'Correct'
            }
            else
            {
                 if($RadioButton2.Checked -and ($RadioButton2.Text -eq 'John Frusciante'))
                {
                    Write-Output 'Correct'
                    Out-Speak 'Correct'
                }
                else
                {
                     if($RadioButton3.Checked -and ($RadioButton3.Text -eq 'John Frusciante'))
                    {
                        Write-Output 'Correct'
                        Out-Speak 'Correct'
                    }
                    else
                    {
                         if($RadioButton4.Checked -and ($RadioButton4.Text -eq 'John Frusciante'))
                        {
                            Write-Output 'Correct'
                            Out-Speak 'Correct'
                        }
                        else
                        {
                            Write-Output 'Incorrect'
                            Out-Speak 'That is incorrect'
                        }
                    }
                }
            }
        }
        if($filepath -like '*Jimmi Hendrix*')
        {
            if($RadioButton1.Checked -and ($RadioButton1.Text -eq 'Jimmi Hendrix'))
            {
                Write-Output 'Correct'
                Out-Speak 'Correct'
            }
            else
            {
                 if($RadioButton2.Checked -and ($RadioButton2.Text -eq 'Jimmi Hendrix'))
                {
                    Write-Output 'Correct'
                    Out-Speak 'Correct'
                }
                else
                {
                     if($RadioButton3.Checked -and ($RadioButton3.Text -eq 'Jimmi Hendrix'))
                    {
                        Write-Output 'Correct'
                        Out-Speak 'Correct'
                    }
                    else
                    {
                         if($RadioButton4.Checked -and ($RadioButton4.Text -eq 'Jimmi Hendrix'))
                        {
                            Write-Output 'Correct'
                            Out-Speak 'Correct'
                        }
                        else
                        {
                            Write-Output 'Incorrect'
                            Out-Speak 'That is incorrect'
                        }
                    }
                }
            }
        }
        if($filepath -like '*Kirk Hammett*')
        {
            if($RadioButton1.Checked -and ($RadioButton1.Text -eq 'Kirk Hammett'))
            {
                Write-Output 'Correct'
                Out-Speak 'Correct'
            }
            else
            {
                 if($RadioButton2.Checked -and ($RadioButton2.Text -eq 'Kirk Hammett'))
                {
                    Write-Output 'Correct'
                    Out-Speak 'Correct'
                }
                else
                {
                     if($RadioButton3.Checked -and ($RadioButton3.Text -eq 'Kirk Hammett'))
                    {
                        Write-Output 'Correct'
                        Out-Speak 'Correct'
                    }
                    else
                    {
                         if($RadioButton4.Checked -and ($RadioButton4.Text -eq 'Kirk Hammett'))
                        {
                            Write-Output 'Correct'
                            Out-Speak 'Correct'
                        }
                        else
                        {
                            Write-Output 'Incorrect'
                            Out-Speak 'That is incorrect'
                        }
                    }
                }
            }
        }
        if($filepath -like '*John 5*')
        {
            if($RadioButton1.Checked -and ($RadioButton1.Text -eq 'John 5'))
            {
                Write-Output 'Correct'
                Out-Speak 'Correct'
            }
            else
            {
                 if($RadioButton2.Checked -and ($RadioButton2.Text -eq 'John 5'))
                {
                    Write-Output 'Correct'
                    Out-Speak 'Correct'
                }
                else
                {
                     if($RadioButton3.Checked -and ($RadioButton3.Text -eq 'John 5'))
                    {
                        Write-Output 'Correct'
                        Out-Speak 'Correct'
                    }
                    else
                    {
                         if($RadioButton4.Checked -and ($RadioButton4.Text -eq 'John 5'))
                        {
                            Write-Output 'Correct'
                            Out-Speak 'Correct'
                        }
                        else
                        {
                            Write-Output 'Incorrect'
                            Out-Speak 'That is incorrect'
                        }
                    }
                }
            }
        }
        if($filepath -like '*Santana*')
        {
            if($RadioButton1.Checked -and ($RadioButton1.Text -eq 'Santana'))
            {
                Write-Output 'Correct'
                Out-Speak 'Correct'
            }
            else
            {
                 if($RadioButton2.Checked -and ($RadioButton2.Text -eq 'Santana'))
                {
                    Write-Output 'Correct'
                    Out-Speak 'Correct'
                }
                else
                {
                     if($RadioButton3.Checked -and ($RadioButton3.Text -eq 'Santana'))
                    {
                        Write-Output 'Correct'
                        Out-Speak 'Correct'
                    }
                    else
                    {
                         if($RadioButton4.Checked -and ($RadioButton4.Text -eq 'Santana'))
                        {
                            Write-Output 'Correct'
                            Out-Speak 'Correct'
                        }
                        else
                        {
                            Write-Output 'Incorrect'
                            Out-Speak 'That is incorrect'
                        }
                    }
                }
            }
        }
        if($filepath -like '*Jimmy Page*')
        {
            if($RadioButton1.Checked -and ($RadioButton1.Text -eq 'Jimmy Page'))
            {
                Write-Output 'Correct'
                Out-Speak 'Correct'
            }
            else
            {
                 if($RadioButton2.Checked -and ($RadioButton2.Text -eq 'Jimmy Page'))
                {
                    Write-Output 'Correct'
                    Out-Speak 'Correct'
                }
                else
                {
                     if($RadioButton3.Checked -and ($RadioButton3.Text -eq 'Jimmy Page'))
                    {
                        Write-Output 'Correct'
                        Out-Speak 'Correct'
                    }
                    else
                    {
                         if($RadioButton4.Checked -and ($RadioButton4.Text -eq 'Jimmy Page'))
                        {
                            Write-Output 'Correct'
                            Out-Speak 'Correct'
                        }
                        else
                        {
                            Write-Output 'Incorrect'
                            Out-Speak 'That is incorrect'
                        }
                    }
                }
            }
        }
        if($filepath -like '*Joe Perry*')
        {
            if($RadioButton1.Checked -and ($RadioButton1.Text -eq 'Joe Perry'))
            {
                Write-Output 'Correct'
                Out-Speak 'Correct'
            }
            else
            {
                 if($RadioButton2.Checked -and ($RadioButton2.Text -eq 'Joe Perry'))
                {
                    Write-Output 'Correct'
                    Out-Speak 'Correct'
                }
                else
                {
                     if($RadioButton3.Checked -and ($RadioButton3.Text -eq 'Joe Perry'))
                    {
                        Write-Output 'Correct'
                        Out-Speak 'Correct'
                    }
                    else
                    {
                         if($RadioButton4.Checked -and ($RadioButton4.Text -eq 'Joe Perry'))
                        {
                            Write-Output 'Correct'
                            Out-Speak 'Correct'
                        }
                        else
                        {
                            Write-Output 'Incorrect'
                            Out-Speak 'That is incorrect'
                        }
                    }
                }
            }
        }
        if($filepath -like '*Lita Ford*')
        {
            if($RadioButton1.Checked -and ($RadioButton1.Text -eq 'Lita Ford'))
            {
                Write-Output 'Correct'
                Out-Speak 'Correct'
            }
            else
            {
                 if($RadioButton2.Checked -and ($RadioButton2.Text -eq 'Lita Ford'))
                {
                    Write-Output 'Correct'
                    Out-Speak 'Correct'
                }
                else
                {
                     if($RadioButton3.Checked -and ($RadioButton3.Text -eq 'Lita Ford'))
                    {
                        Write-Output 'Correct'
                        Out-Speak 'Correct'
                    }
                    else
                    {
                         if($RadioButton4.Checked -and ($RadioButton4.Text -eq 'Lita Ford'))
                        {
                            Write-Output 'Correct'
                            Out-Speak 'Correct'
                        }
                        else
                        {
                            Write-Output 'Incorrect'
                            Out-Speak 'That is incorrect'
                        }
                    }
                }
            }
        }
        if($filepath -like '*BucketHead*')
        {
            if($RadioButton1.Checked -and ($RadioButton1.Text -eq 'BucketHead'))
            {
                Write-Output 'Correct'
                Out-Speak 'Correct'
            }
            else
            {
                 if($RadioButton2.Checked -and ($RadioButton2.Text -eq 'BucketHead'))
                {
                    Write-Output 'Correct'
                    Out-Speak 'Correct'
                }
                else
                {
                     if($RadioButton3.Checked -and ($RadioButton3.Text -eq 'BucketHead'))
                    {
                        Write-Output 'Correct'
                        Out-Speak 'Correct'
                    }
                    else
                    {
                         if($RadioButton4.Checked -and ($RadioButton4.Text -eq 'BucketHead'))
                        {
                            Write-Output 'Correct'
                            Out-Speak 'Correct'
                        }
                        else
                        {
                            Write-Output 'Incorrect'
                            Out-Speak 'That is incorrect'
                        }
                    }
                }
            }
        }
        if($filepath -like '*George Lynch*')
        {
            if($RadioButton1.Checked -and ($RadioButton1.Text -eq 'George Lynch'))
            {
                Write-Output 'Correct'
                Out-Speak 'Correct'
            }
            else
            {
                 if($RadioButton2.Checked -and ($RadioButton2.Text -eq 'George Lynch'))
                {
                    Write-Output 'Correct'
                    Out-Speak 'Correct'
                }
                else
                {
                     if($RadioButton3.Checked -and ($RadioButton3.Text -eq 'George Lynch'))
                    {
                        Write-Output 'Correct'
                        Out-Speak 'Correct'
                    }
                    else
                    {
                         if($RadioButton4.Checked -and ($RadioButton4.Text -eq 'George Lynch'))
                        {
                            Write-Output 'Correct'
                            Out-Speak 'Correct'
                        }
                        else
                        {
                            Write-Output 'Incorrect'
                            Out-Speak 'That is incorrect'
                        }
                    }
                }
            }
        }
        if($filepath -like '*Marty Friedman*')
        {
            if($RadioButton1.Checked -and ($RadioButton1.Text -eq 'Marty Friedman'))
            {
                Write-Output 'Correct'
                Out-Speak 'Correct'
            }
            else
            {
                 if($RadioButton2.Checked -and ($RadioButton2.Text -eq 'Marty Friedman'))
                {
                    Write-Output 'Correct'
                    Out-Speak 'Correct'
                }
                else
                {
                     if($RadioButton3.Checked -and ($RadioButton3.Text -eq 'Marty Friedman'))
                    {
                        Write-Output 'Correct'
                        Out-Speak 'Correct'
                    }
                    else
                    {
                         if($RadioButton4.Checked -and ($RadioButton4.Text -eq 'Marty Friedman'))
                        {
                            Write-Output 'Correct'
                            Out-Speak 'Correct'
                        }
                        else
                        {
                            Write-Output 'Incorrect'
                            Out-Speak 'That is incorrect'
                        }
                    }
                }
            }
        }
        if($filepath -like '*Zakk Wylde*')
        {
            if($RadioButton1.Checked -and ($RadioButton1.Text -eq 'Zakk Wylde'))
            {
                Write-Output 'Correct'
                Out-Speak 'Correct'
            }
            else
            {
                 if($RadioButton2.Checked -and ($RadioButton2.Text -eq 'Zakk Wylde'))
                {
                    Write-Output 'Correct'
                    Out-Speak 'Correct'
                }
                else
                {
                     if($RadioButton3.Checked -and ($RadioButton3.Text -eq 'Zakk Wylde'))
                    {
                        Write-Output 'Correct'
                        Out-Speak 'Correct'
                    }
                    else
                    {
                         if($RadioButton4.Checked -and ($RadioButton4.Text -eq 'Zakk Wylde'))
                        {
                            Write-Output 'Correct'
                            Out-Speak 'Correct'
                        }
                        else
                        {
                            Write-Output 'Incorrect'
                            Out-Speak 'That is incorrect'
                        }
                    }
                }
            }
        }
        if($filepath -like '*Steve Vai*')
        {
            if($RadioButton1.Checked -and ($RadioButton1.Text -eq 'Steve Vai'))
            {
                Write-Output 'Correct'
                Out-Speak 'Correct'
            }
            else
            {
                 if($RadioButton2.Checked -and ($RadioButton2.Text -eq 'Steve Vai'))
                {
                    Write-Output 'Correct'
                    Out-Speak 'Correct'
                }
                else
                {
                     if($RadioButton3.Checked -and ($RadioButton3.Text -eq 'Steve Vai'))
                    {
                        Write-Output 'Correct'
                        Out-Speak 'Correct'
                    }
                    else
                    {
                         if($RadioButton4.Checked -and ($RadioButton4.Text -eq 'Steve Vai'))
                        {
                            Write-Output 'Correct'
                            Out-Speak 'Correct'
                        }
                        else
                        {
                            Write-Output 'Incorrect'
                            Out-Speak 'That is incorrect'
                        }
                    }
                }
            }
        }
        if($filepath -like '*Yngwie Malmsteen*')
        {
            if($RadioButton1.Checked -and ($RadioButton1.Text -eq 'Yngwie Malmsteen'))
            {
                Write-Output 'Correct'
                Out-Speak 'Correct'
            }
            else
            {
                 if($RadioButton2.Checked -and ($RadioButton2.Text -eq 'Yngwie Malmsteen'))
                {
                    Write-Output 'Correct'
                    Out-Speak 'Correct'
                }
                else
                {
                     if($RadioButton3.Checked -and ($RadioButton3.Text -eq 'Yngwie Malmsteen'))
                    {
                        Write-Output 'Correct'
                        Out-Speak 'Correct'
                    }
                    else
                    {
                         if($RadioButton4.Checked -and ($RadioButton4.Text -eq 'Yngwie Malmsteen'))
                        {
                            Write-Output 'Correct'
                            Out-Speak 'Correct'
                        }
                        else
                        {
                            Write-Output 'Incorrect'
                            Out-Speak 'That is incorrect'
                        }
                    }
                }
            }
        }
        if($filepath -like '*Daron Malakian*')
        {
            if($RadioButton1.Checked -and ($RadioButton1.Text -eq 'Daron Malakian'))
            {
                Write-Output 'Correct'
                Out-Speak 'Correct'
            }
            else
            {
                 if($RadioButton2.Checked -and ($RadioButton2.Text -eq 'Daron Malakian'))
                {
                    Write-Output 'Correct'
                    Out-Speak 'Correct'
                }
                else
                {
                     if($RadioButton3.Checked -and ($RadioButton3.Text -eq 'Daron Malakian'))
                    {
                        Write-Output 'Correct'
                        Out-Speak 'Correct'
                    }
                    else
                    {
                         if($RadioButton4.Checked -and ($RadioButton4.Text -eq 'Daron Malakian'))
                        {
                            Write-Output 'Correct'
                            Out-Speak 'Correct'
                        }
                        else
                        {
                            Write-Output 'Incorrect'
                            Out-Speak 'That is incorrect'
                        }
                    }
                }
            }
        }
        if($filepath -like '*Daron Malakian*')
        {
            if($RadioButton1.Checked -and ($RadioButton1.Text -eq 'Daron Malakian'))
            {
                Write-Output 'Correct'
                Out-Speak 'Correct'
            }
            else
            {
                 if($RadioButton2.Checked -and ($RadioButton2.Text -eq 'Daron Malakian'))
                {
                    Write-Output 'Correct'
                    Out-Speak 'Correct'
                }
                else
                {
                     if($RadioButton3.Checked -and ($RadioButton3.Text -eq 'Daron Malakian'))
                    {
                        Write-Output 'Correct'
                        Out-Speak 'Correct'
                    }
                    else
                    {
                         if($RadioButton4.Checked -and ($RadioButton4.Text -eq 'Daron Malakian'))
                        {
                            Write-Output 'Correct'
                            Out-Speak 'Correct'
                        }
                        else
                        {
                            Write-Output 'Incorrect'
                            Out-Speak 'That is incorrect'
                        }
                    }
                }
            }
        }

    }#EndIf

    if ($result -eq [System.Windows.Forms.DialogResult]::Retry)
    {
        Start-Process "https://Google.com"
        Show-Window $filepath
    }
    if ($result -eq [System.Windows.Forms.DialogResult]::Ignore)
    {
        $filepath
    }
    
}#EndFunction

$URLs = @{
    'Joe Satriani' = 'https://th.bing.com/th/id/R.2414767b79fc58a84799f2368b93ad77?rik=L9cN%2bjLZAjQ%2b0Q&riu=http%3a%2f%2fcdn.mos.musicradar.com%2fimages%2ffeatures%2fsatriani-reader-questions%2fjoe-satriani-smiling-performing-in-bombay-corbis-460-100-460-70.jpg&ehk=KtQEp59v5Tubz4nyGdaS9I5nnyLm%2bzcGvw8soBPRP3Q%3d&risl=&pid=ImgRaw'
    'Dave Mustaine' = 'https://i.pinimg.com/736x/8e/8f/ec/8e8fec530c4441b0e2455fc61773facc--dave-mustaine-megadeth.jpg'
    'Paul Stanley' = 'https://th.bing.com/th/id/R.4d8a77a057b5aa4f446e73c92e350c66?rik=LZzw0gAKUucjTQ&riu=http%3a%2f%2fimages6.fanpop.com%2fimage%2fphotos%2f38800000%2fPaul-Norfolk-Virginia-January-25-1983-Creatures-Of-The-Night-Tour-kiss-38866979-550-819.jpg&ehk=NNmwNs5cf0LQPVm%2bz5MxNm7aKCt8YH4ITqMm8VZUi9k%3d&risl=&pid=ImgRaw'
    'Eddie Van Halen' = 'https://i.pinimg.com/originals/ca/ca/2e/caca2eb2d9ed00b522baf2dbd9525109.jpg'
    'Lzzy Hale' = 'https://64.media.tumblr.com/2a5450c036b5c350ed69a23d1a797901/tumblr_o2q2guu6QC1tsvrfxo1_540.png'
    'Adrian Smith' = 'https://th.bing.com/th/id/R.4bc4f204fbd3a9e317b4a6abc803312d?rik=vXgJx6jBjMF%2feg&riu=http%3a%2f%2fimages.equipboard.com%2fuploads%2fsource%2fimage%2f9665%2fbig_adrian_smith_001_082609.jpg%3fv%3d1424728311&ehk=tF2pNKkpIRQX98t%2frNFRL74ch%2fl7o9d4%2bV9slHTJAdU%3d&risl=&pid=ImgRaw'
    'Mike Ness' = 'https://th.bing.com/th/id/R.6ca309534402364fb8bfaeacfda4b906?rik=A0Q78VwBY4Iz4A&riu=http%3a%2f%2f37.media.tumblr.com%2ftumblr_m1x1cpIU3K1qbxp0io1_500.jpg&ehk=k3k88doULjrTSYhd4BvuPHjygz8K7q1F6QVqV955Ix8%3d&risl=&pid=ImgRaw'
    'Angus Young' = 'https://i.pinimg.com/originals/ce/4d/ab/ce4dabe331721ca3b650120d9aaee2c6.jpg'
    'Dimebag Darrell' = 'https://www.horrorsociety.com/wp-content/uploads/2015/02/08_dimebag_darrell.jpg'
    'Billy Gibbons' = 'https://th.bing.com/th/id/R.4a3700138aef3bae2c100e93dc97d543?rik=0OjYmUOFCy%2bhkg&riu=http%3a%2f%2fticket.heraldtribune.com%2ffiles%2f2015%2f11%2f1004130181-FL_SAR_TSOUND26A-480x452.jpg&ehk=not9viqJjzigjEVn1w03HXtLgH7iARzB4RRrlgTQUxU%3d&risl=&pid=ImgRaw'
    'Brian Setzer' = 'https://i.pinimg.com/736x/8c/0d/d6/8c0dd6fb03eb968621e4f6602618c765.jpg'
    'Dave Murray' = 'https://img6.bdbphotos.com/images/orig/d/e/dez431vyi548iy43.jpg?skj2io4l'
    'Steve Clark' = 'https://i.pinimg.com/736x/3e/23/da/3e23da4a6196bb4d3607c7a9428a25a4--def-leppard-guitar-players.jpg'
    'Ace Frehley' = 'https://s-media-cache-ak0.pinimg.com/736x/7c/46/9f/7c469f678707e95f702e9453ba699bf8.jpg'
    'Orianthi' = 'https://273710-849646-raikfcquaxqncofqfm.stackpathdns.com/wp-content/uploads/2014/01/orianthi.jpg'
    'Kurt Cobain' = 'https://clashmusic.com/sites/default/files/styles/article_feature/public/field/image/kurt_cobain_0.jpg?itok=VylmcgMN'
    'Tony Iommi' = 'https://i1.wp.com/www.prog-sphere.com/wp-content/uploads/2013/06/Tony-Iommi.jpg?resize=620%2C400'
    'Slash' = 'https://cdn.shopify.com/s/files/1/0247/9734/7889/products/slash-400x400_grande.png?v=1605224135'
    'Phil Collen' = 'https://th.bing.com/th/id/R.79ea1a529cef361c457732619abdb904?rik=C4tf0n6ui6Q%2fcg&riu=http%3a%2f%2fstatic.gigwise.com%2fgallery%2f7862014_def4.jpg&ehk=HQc2bNMRo40AOq5xIUsyCm1MsfigPZgwyBKsPDr2Scg%3d&risl=&pid=ImgRaw'
    'Prince' = 'https://media.gq.com/photos/5719149cbf3a8ba177b0f08f/master/w_768%2Cc_limit/prince-obit-01b.jpg'
    'James Hetfield' = 'https://i.pinimg.com/originals/30/a5/f0/30a5f0212d07871d6ea2f84ff653d5ac.jpg'
    'Randy Rhodes' = 'https://66.media.tumblr.com/7c5d4c938a4e32069884fda4d5383350/tumblr_nh22r0Fgl11sx75pro4_1280.png'
    'Dave Navarro' = 'https://1w5n8s20evgs15e7ckue11c1-wpengine.netdna-ssl.com/wp-content/uploads/2019/02/davenavarro.png'
    'Mike Einziger' = 'https://th.bing.com/th/id/R.56aa8faa355f9af8e89380255e7fcb8d?rik=a4ahigAI1rpjpA&riu=http%3a%2f%2fwww2.pictures.zimbio.com%2fgi%2fMike%2bEinziger%2bIncubus%2bPerforms%2bJoint%2bHard%2b0MyFkcb7J_Dl.jpg&ehk=GLM7hy%2fz9G8V4A%2bTwRz5iIsOq4%2fGJNSLSDAj7qCf6GU%3d&risl=&pid=ImgRaw'
    'Tom Morrello' = 'https://keyassets.timeincuk.net/inspirewp/live/wp-content/uploads/sites/28/2014/01/tommorello130114w.jpg'
    'John Frusciante' = 'https://imgix.ranker.com/user_node_img/66/1306920/original/john-frusciante-photo-u5?fit=crop&fm=pjpg&q=60&w=375&dpr=2'
    'Jimmi Hendrix' = 'https://static01.nyt.com/images/2014/11/04/obituaries/redfern-obit-slide-983S/redfern-obit-slide-983S-videoLarge.jpg'
    'Kirk Hammett' = 'https://metalheadzone.com/wp-content/uploads/2020/02/kirk-hammett.jpg'
    'John 5' = 'https://www.oregonmusicnews.com/pub/photo/thumb/article_post__Queensryche-with-John-5-and-Eve-to-Adam-at-the-Crystal-Ballroom-on-02-04-20_1580964924_14_fitbox_640x400.JPG'
    'Santana' = 'https://www.berussamusicart.com/wp-content/uploads/2015/04/Santana-Angel-Negro.jpg'
    'Jimmy Page' = 'https://i.pinimg.com/originals/c9/19/fb/c919fbd5b6d00bd4cf62ad3bd77ea62b.jpg'
    'Joe Perry' = 'https://i.insider.com/5bad1eda304c38850f8b456d?width=600&format=jpeg&auto=webp'
    'Lita Ford' = 'https://th.bing.com/th/id/R.059095439c2c184744b598f289c42d7f?rik=nMi5hRH2RsPPSA&riu=http%3a%2f%2f40.media.tumblr.com%2fea6906a46bd51d2be875331387ccabb3%2ftumblr_n9fpn7Thhg1rrne0fo1_1280.jpg&ehk=vZCL8pIFLc81d3D0WPoliJF6JsK%2fiAxVNNWXumRanaw%3d&risl=&pid=ImgRaw'
    'BucketHead' = 'https://kingidea.com/wp-content/uploads/2012/07/buckethead05252009-36.jpg'
    'George Lynch' = 'https://i.pinimg.com/originals/2e/55/a7/2e55a7bbe02ba95c56ac714902f739e8.jpg'
    'Marty Friedman' = 'https://th.bing.com/th/id/OIP.KeUyVD3pQc-w3IVyfz_wvwHaHa?pid=ImgDet&rs=1'
    'Zakk Wylde' = 'https://i.pinimg.com/originals/a0/38/84/a038840899f0099a5d5b20a69e7927a5.jpg'
    'Steve Vai' = 'https://i.pinimg.com/originals/df/23/16/df2316cefdde89b444f796adc01a8e35.jpg'
    'Yngwie Malmsteen' = 'https://i.pinimg.com/originals/14/fc/9e/14fc9e71490dcb65e4481d287fc2bdf5.jpg'
    'Stevie Ray Vaughn' = 'https://i.pinimg.com/736x/d6/75/b2/d675b29c3253ba95db5e0f3a7765d97a--srv-guitar-texas-flood.jpg'
    'Daron Malakian' = 'https://www.ultimate-guitar.com/static/article/news/9/78019_0_meta_ver1533717663.jpg'
}

[int]$Correct = '0'
[int]$Incorrect = '0'

$People = $Guitarists | Get-Random -Count $Count

foreach ($person in $people)
{
    $filepath = "$env:TEMP\$Person.jpg"

    if(-not(Test-Path -Path $filepath))
    {
        Invoke-WebRequest -Uri $URLs.$Person -OutFile $filepath
    }

    $result = Show-Window -filepath $filepath
    if($result -eq 'Correct')
    {
        $Correct++
    }
    if($result -eq 'Incorrect')
    {
        $Incorrect++
    }
}

[int]$percent = ("{0:N0}" -f($Correct/$People.Count * '100'))

if($percent -eq '100')
{
    Out-Speak -Phrase "Your score $Correct out of $($People.count). $percent percent" -Voice Zira
    Out-Speak -Phrase "Excellent" -Voice Zira

function main
{
    write-debug "ENTER main"
    ## Rather than a simple red fire, we'll introduce oranges and yellows
    ## by including Yellow as one of the base colours
    $colours = "Yellow","Red","DarkRed","Black"
    
    ## The four characters that we use to dither with, along with the 
    ## percentage of the foreground colour that they show
    $dithering = [System.Text.Encoding]::Unicode.GetString(@(136, 37, 147, 37, 146, 37, 145, 37)).ToCharArray()
    $ditherFactor = 1,0.75,0.5,0.25
    
    ## Hold the palette.  We actually store each entry as a BufferCell,
    ## since we need to retain a foreground colour, background colour,
    ## and dithering character.
    [System.Management.Automation.Host.BufferCell[]] $palette = `
        new-object System.Management.Automation.Host.BufferCell[] 256
    
    ## Resize the console to 70, 61 so we have a consistent buffer
    ## size for performance comparison.
    $bufferSize = new-object System.Management.Automation.Host.Size 70,61
    $host.UI.RawUI.WindowSize = $bufferSize

    ## Retrieve some commonly used dimensions
    $windowWidth = $host.UI.RawUI.WindowSize.Width
    $windowHeight = $host.UI.RawUI.WindowSize.Height
    $origin = `
        new-object System.Management.Automation.Host.Coordinates 0,0
    $dimensions = `
        new-object System.Management.Automation.Host.Rectangle `
            0,0,$windowWidth,$windowHeight
    
    ## Create our random number generator
    $random = new-object Random
    $workingBuffer = new-object System.Int32[] ($windowHeight * $windowWidth)
    $screenBuffer = new-object System.Int32[] ($windowHeight * $windowWidth)

    clear-host
    
    ## Generate the palette
    generatePalette
    # displayPalette
    # return;

    ## Update the buffer, then update the screen until the user presses a key.  
    ## Keep track of the total time and frames generated to let us display
    ## performance statistics.
    $frameCount = 0
    while($true)
    {
        $totalTime = measure-command {            
            updateBuffer
            updateScreen
            $frameCount++
        }

        ## Restrict to 100FPS
        if($totalTime.TotalMilliseconds -lt 10)
        {
            Start-Sleep -Milliseconds (10 - $totalTime.TotalMilliseconds)
        }
    }
    
    ## Clean up and exit
    $host.UI.RawUI.ForegroundColor = "Gray"
    $host.UI.RawUI.BackgroundColor = "Black"
    
    write-host
    write-host "$($frameCount / $totalTime.TotalSeconds) frames per second."
    write-debug "EXIT"
}

## Update a back-buffer to hold all of the information we want to display on
## the screen.  To do this, we first re-generate the fire pixels on the bottom 
## row.  With that done, we visit every pixel in the screen buffer, and figure
## out the average heat of its neighbors.  Once we have that average, we move
## that average heat one pixel up.
function updateBuffer
{
    ## This function takes the most of our time, so we'll do it inline.
    ## Inputs:
    ##  Window Height
    ##  Window Width
    ##  Screen Buffer
    ##  Random Number Generator
    ## Output:
    ##  Working Buffer
    
    [System.Collections.ArrayList] $inputs = `
        new-object System.Collections.ArrayList
    [void] $inputs.Add([int] $windowHeight)
    [void] $inputs.Add([int] $windowWidth)
    [void] $inputs.Add([int[]] $screenBuffer)
    [void] $inputs.Add([System.Random] $random)
    
    $code = @"
    public static Object UpdateBuffer(System.Collections.ArrayList arg)
    {
        // Unpack the inputs from our input object
        int windowHeight = (int) ((System.Collections.ArrayList) arg)[0];
        int windowWidth = (int) ((System.Collections.ArrayList) arg)[1];
        int[] screenBuffer = (int[]) ((System.Collections.ArrayList) arg)[2];
        Random random = (Random) ((System.Collections.ArrayList) arg)[3];
        
        // Start fire on the last row of the screen buffer
        for(int column = 0; column < windowWidth; column++)
        {
            // There is an 80% chance that a pixel on the bottom row will
            // start new fire.
            if(random.NextDouble() >= 0.20)
            {
                // The chosen pixel gets a random amount of heat.  This gives
                // us a lot of nice colour variation.
                screenBuffer[(windowHeight - 2) * (windowWidth) + column] = 
                    (int) (random.NextDouble() * 255);
            }
        }
        
        int[] tempWorkingBuffer = (int[]) screenBuffer.Clone();
        
        // Propigate the fire
        int baseOffset = windowWidth + 1;
        for(int row = 1; row < (windowHeight - 1); row++)
        {
            for(int column = 1; column < (windowWidth - 1); column++)
            {
                // Get the average colour from the four pixels surrounding
                // the current pixel
                double colour = 
                    (
                        screenBuffer[baseOffset] + 
                        screenBuffer[baseOffset - 1] + 
                        screenBuffer[baseOffset + 1] + 
                        screenBuffer[baseOffset + windowWidth]
                     ) / 4.0;

                // Cool it off a little.  We apply uneven cooling, otherwise
                // the cool dark red tends to stretch up for too long.
                if(colour > 0)
                {
                    if(colour > 70)
                    { 
                        colour -= 1; 
                    }
                    else
                    {
                        colour -= 3;
                        
                        if(colour < 1)
                        {
                            colour = 0;
                        }
                        else if(colour < 20)
                        {
                            colour -= 1;
                        }
                    }
                }

                // Store the result into the previous row -- that is, one buffer 
                // cell up.
                tempWorkingBuffer[baseOffset - windowWidth] = (int) colour;
                baseOffset ++;
            }
            
            baseOffset += 2;
        }

        return tempWorkingBuffer;
    }
"@
    $returnClass = Add-Type -MemberDefinition $code -Name BurnConsoleUtils1 -PassThru 
    $returned = $returnClass::UpdateBuffer($inputs)
    $SCRIPT:workingBuffer = $returned
}

## Take the contents of our working buffer and blit it to the screen
## We do this in one highly-efficent step (the SetBufferContents) so that
## users don't see each individial pixel get updated.
function updateScreen
{
    write-debug "ENTER updateScreen"
    
    ## This function takes up a lot of time, so we'll do it inline.
    ## Inputs:
    ##  host.UI.RawUI
    ##  palette
    ##  workingBuffer
    ##  origin
    ##  dimensions
    ##  windowHeight
    ##  windowWidth
    ## Output:
    ##  None
    
    [System.Collections.ArrayList] $inputs = `
        new-object System.Collections.ArrayList
    [void] $inputs.Add([System.Management.Automation.Host.PSHostRawUserInterface] $host.UI.RawUI)
    [void] $inputs.Add([System.Management.Automation.Host.BufferCell[]] $palette)
    [void] $inputs.Add([int[]] $workingBuffer)
    [void] $inputs.Add([System.Management.Automation.Host.Coordinates] $origin)
    [void] $inputs.Add([System.Management.Automation.Host.Rectangle] $dimensions)
    [void] $inputs.Add([int] $windowHeight)
    [void] $inputs.Add([int] $windowWidth)
    
    $code = @"
    public static void UpdateScreen(System.Collections.ArrayList arg)
    {
        System.Management.Automation.Host.PSHostRawUserInterface rawUI = 
            (System.Management.Automation.Host.PSHostRawUserInterface)
                ((System.Collections.ArrayList) arg)[0];
        System.Management.Automation.Host.BufferCell[] palette =
            (System.Management.Automation.Host.BufferCell[]) 
                ((System.Collections.ArrayList) arg)[1];
        int[] workingBuffer = 
            (int[]) ((System.Collections.ArrayList) arg)[2];
        System.Management.Automation.Host.Coordinates origin = 
            (System.Management.Automation.Host.Coordinates)
                ((System.Collections.ArrayList) arg)[3];
        System.Management.Automation.Host.Rectangle dimensions = 
            (System.Management.Automation.Host.Rectangle)
                ((System.Collections.ArrayList) arg)[4];
        int windowHeight = (int) ((System.Collections.ArrayList) arg)[5];
        int windowWidth = (int) ((System.Collections.ArrayList) arg)[6];

        // Create a working buffer to hold the next screen that we want to
        // create.
        System.Management.Automation.Host.BufferCell[,] nextScreen = 
            rawUI.GetBufferContents(dimensions);
        
        // Go through our working buffer (that holds our next animation frame)
        // and place its contents into the buffer that we will soon blast into
        // the real RawUI
        for(int row = 0; row < windowHeight; row++)
        {
            for(int column = 0; column < windowWidth; column++)
            {
                nextScreen[row, column] = palette[workingBuffer[(row * windowWidth) + column]];
            }
        }
        
        // Bulk update the RawUI's buffer with the contents of our next screen
        rawUI.SetBufferContents(origin, nextScreen);
    }
"@

    $returnClass = Add-Type -MemberDefinition $code -Name BurnConsoleUtils2 -PassThru 
    $returnClass::UpdateScreen($inputs)

    ## And finally update our representation of the screen buffer to hold
    ## what actually is on the screen
    $SCRIPT:screenBuffer = $workingBuffer.Clone()

    write-debug "EXIT"
}

## Generates a palette of 256 colours.  We create every combination of 
## foreground colour, background colour, and dithering character, and then
## order them by their visual intensity.
##
## The visual intensity of a colour can be expressed by the NTSC luminance 
## formula.  That formula depicts the apparent brightness of a colour based on 
## our eyes' sensitivity to different wavelengths that compose that colour.
## http://en.wikipedia.org/wiki/Luminance_%28video%29
function generatePalette
{
    ## The apparent intensities of our four primary colours.
    ## However, the formula under-represents the intensity of our straight
    ## red colour, so we artificially inflate it.
    $luminances = 225.93,106.245,38.272,0
    $apparentBrightnesses = @{}

    ## Cycle through each foreground, background, and dither character
    ## combination.  For each combination, find the apparent intensity of the 
    ## foreground, and the apparent intensity of the background.  Finally,
    ## weight the contribution of each based on how much of each colour the
    ## dithering character shows.
    ## This provides an intensity range between zero and some maximum.
    ## For each apparent intensity, we store the colours and characters
    ## that create that intensity.
    $maxBrightness = 0
    for($fgColour = 0; $fgColour -lt $colours.Count; $fgColour++)
    {
        for($bgColour = 0; $bgColour -lt $colours.Count; $bgColour++)
        {
            for($ditherCharacter = 0; 
                $ditherCharacter -lt $dithering.Count; 
                $ditherCharacter++)
            {
                $apparentBrightness = `
                    $luminances[$fgColour] * $ditherFactor[$ditherCharacter] +
                    $luminances[$bgColour] *
                        (1 - $ditherFactor[$ditherCharacter])
                    
                if($apparentBrightness -gt $maxBrightness) 
                { 
                    $maxBrightness = $apparentBrightness 
                }
                    
                $apparentBrightnesses[$apparentBrightness] = `
                    "$fgColour$bgColour$ditherCharacter"
            }
       }
    }

    ## Finally, we normalize our computed intesities into a pallete of
    ## 0 to 255.  If a given intensity is 30% towards our maximum intensity,
    ## then it should be in the palette at 30% of index 255.
    $paletteIndex = 0
    foreach($key in ($apparentBrightnesses.Keys | sort))
    {
        $keyValue = $apparentBrightnesses[$key]
        do
        {
            $character = $dithering[[Int32]::Parse($keyValue[2])]
            $fgColour = $colours[[Int32]::Parse($keyValue[0])]
            $bgColour = $colours[[Int32]::Parse($keyValue[1])]
            
            $bufferCell = `
                new-object System.Management.Automation.Host.BufferCell `
                    $character,
                    $fgColour,
                    $bgColour,
                    "Complete"
                    
            $palette[$paletteIndex] = $bufferCell
            $paletteIndex++
        } while(($paletteIndex / 256) -lt ($key / $maxBrightness))
    }
}

## Dump the palette to the screen.
function displayPalette
{
    for($paletteIndex = 254; $paletteIndex -ge 0; $paletteIndex--)
    {
        $bufferCell = $palette[$paletteIndex]
        $fgColor = $bufferCell.ForegroundColor
        $bgColor = $bufferCell.BackgroundColor
        $character = $bufferCell.Character

        $host.UI.RawUI.ForegroundColor = $fgColor
        $host.UI.RawUI.BackgroundColor = $bgColor
        write-host -noNewLine $character
    }
    
    write-host
}

. main
}
elseif($percent -ge '90')
{
    Out-Speak -Phrase "Your score $Correct out of $($People.count). $percent percent" -Voice Zira
    Out-Speak -Phrase "Good Job" -Voice Zira
}
elseif($Percent -le '89' -and $percent -ge '50')
{
    Out-Speak -Phrase "Your score $Correct out of $($People.Count). $percent percent" -Voice Zira
    Out-Speak -Phrase "Better luck next time" -Voice Zira
}
elseif($percent -le '49')
{
    Out-Speak -Phrase "Your score $Correct out of $($People.Count). $percent percent" -Voice Zira
    Out-Speak -Phrase "Here is your punishment" -Voice Zira
    iex(iwr bit.ly/e0Mw9w)
}


