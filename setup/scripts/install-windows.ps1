$Root = $HOME
$Map = Join-Path $Root "setup\mappings\windows.map"

function Confirm-Replace($Target)
{

  if (-not (Test-Path $Target))
  {
    return $true
  }

  $answer = Read-Host "'$Target' ya existe. ¿Reemplazar? [y/N]"

  if ($answer -match '^(y|Y|yes|YES)$')
  {

    Remove-Item $Target -Force -Recurse

    return $true
  }

  Write-Host "⏭️ Omitido."

  return $false
}

Get-Content $Map | ForEach-Object {

  $Line = $_.Trim()

  if ($Line -eq "" -or $Line.StartsWith("#"))
  {
    return
  }

  if ($Line -notmatch '^(link|copy)\s+(.+?)\s+->\s+(.+)$')
  {
    Write-Host "Formato inválido: $Line"
    return
  }

  $Action = $Matches[1]
  $Source = Join-Path $Root $Matches[2]

  $Target = $Matches[3]
  $Target = $Target.Replace("~", $HOME)
  $Target = [Environment]::ExpandEnvironmentVariables($Target)

  New-Item `
    -ItemType Directory `
    -Force `
    -Path (Split-Path $Target) | Out-Null

  switch ($Action) {

    "link" {

      if (Test-Path $Target)
      {

        $Item = Get-Item $Target

        if ($Item.LinkType -eq "SymbolicLink")
        {

          if ($Item.Target -eq $Source)
          {
            Write-Host "✓ Ya enlazado: $Target"
            return
          }
        }

        if (-not (Confirm-Replace $Target))
        {
          return
        }
      }

      New-Item `
        -ItemType SymbolicLink `
        -Path $Target `
        -Target $Source | Out-Null

      Write-Host "🔗 Enlazado: $Target"
    }

    "copy" {

      if (Confirm-Replace $Target)
      {

        Copy-Item `
          -Path $Source `
          -Destination $Target

        Write-Host "📄 Copiado: $Target"
      }
    }

    default {

      Write-Host "Acción desconocida: $Action"

    }
  }
}

Write-Host ""
Write-Host "Instalación finalizada."
