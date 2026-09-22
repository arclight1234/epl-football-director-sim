param(
    [Parameter(Mandatory = $true)]
    [string]$SessionPath,

    [Parameter(Mandatory = $true)]
    [string]$OutputPath
)

$ErrorActionPreference = 'Stop'
$messages = [System.Collections.Generic.List[object]]::new()

Get-Content -LiteralPath $SessionPath -Encoding UTF8 | ForEach-Object {
    if ([string]::IsNullOrWhiteSpace($_)) { return }
    $record = $_ | ConvertFrom-Json
    if ($record.type -ne 'event_msg' -or $record.payload.type -ne 'item_completed') { return }

    $item = $record.payload.item
    if ($item.type -notin @('UserMessage', 'AgentMessage')) { return }

    $role = if ($item.type -eq 'UserMessage') { '사용자' } else { '어시스턴트' }
    $phase = if ($item.type -eq 'AgentMessage' -and $item.phase) { [string]$item.phase } else { '' }
    $parts = foreach ($content in $item.content) {
        if ($content.type -in @('text', 'Text') -and $content.text) { [string]$content.text }
    }
    $body = ($parts -join "`n").Trim()
    if ($body) {
        $messages.Add([pscustomobject]@{ Role = $role; Phase = $phase; Body = $body })
    }
}

$lines = [System.Collections.Generic.List[string]]::new()
$lines.Add('# 작업 대화 기록')
$lines.Add('')
$lines.Add('> Codex 세션에서 사용자와 어시스턴트에게 공개된 메시지만 추출했습니다. 내부 지침, 도구 호출, 비공개 추론 정보는 포함하지 않습니다.')
$lines.Add('')

foreach ($message in $messages) {
    $suffix = if ($message.Phase -and $message.Phase -ne 'final_answer') { " ($($message.Phase))" } else { '' }
    $lines.Add("## $($message.Role)$suffix")
    $lines.Add('')
    $lines.Add($message.Body)
    $lines.Add('')
}

$parent = Split-Path -Parent $OutputPath
if ($parent) { New-Item -ItemType Directory -Force -Path $parent | Out-Null }
[System.IO.File]::WriteAllLines($OutputPath, $lines, [System.Text.UTF8Encoding]::new($false))

