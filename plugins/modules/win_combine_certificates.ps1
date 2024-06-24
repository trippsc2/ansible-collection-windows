#!powershell

#AnsibleRequires -CSharpUtil Ansible.Basic

$spec = @{
  options = @{
    certificates = @{
      type = 'list'
      elements = 'str'
      required = $true
    }
    path = @{
      type = 'str'
      required = $true
    }
  }
  supports_check_mode = $true
}

$module = [Ansible.Basic.AnsibleModule]::Create($args, $spec)

$expectedContent = ''

foreach ($certificate in $module.Params['certificates']) {
  
  if (-not ($expectedContent -eq '')) {

    $expectedContent += "`n"
  }

  if (-not (Test-Path -LiteralPath $certificate -PathType Leaf)) {

    $module.FailJson("Certificate file '$certificate' does not exist.")
  }

  $content = [System.IO.File]::ReadAllText($certificate)

  $expectedContent += $content
}

if (Test-Path -LiteralPath $module.Params['path'] -PathType Container) {

  $module.FailJson("Path '{$($module.Params['path'])}' is a directory.")
}

if (-not (Test-Path -LiteralPath $module.Params['path'])) {

  $actualContent = $null
}
else {

  $actualContent = [System.IO.File]::ReadAllText($module.Params['path'])
}

if ($actualContent -ne $expectedContent) {

  $module.Result["changed"] = $true

  if (-not $module.CheckMode) {

    [System.IO.File]::WriteAllText($module.Params['path'], $expectedContent)
  }
}

$module.ExitJson()
