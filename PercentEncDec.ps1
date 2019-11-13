<# License>------------------------------------------------------------

 Copyright (c) 2019 Shinnosuke Yakenohara

 This program is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.

 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.

 You should have received a copy of the GNU General Public License
 along with this program.  If not, see <http://www.gnu.org/licenses/>

-----------------------------------------------------------</License #>


#変数宣言
$opEncode = "/e"
$opDebug = "/d" #デバッグモード指定文字列 

# Option 確認ループ
$isEncode = $FALSE
$isDebug = $FALSE
$mxOfArgs = $Args.count
for ($idx = 0 ; $idx -lt $mxOfArgs ; $idx++){
    
    if    ($Args[$idx] -eq $opEncode){ #Encode処理指定の場合
        $isEncode = $TRUE
    }
    elseif($Args[$idx] -eq $opDebug){ #Recursive処理指定文字列の場合
        $isDebug = $TRUE
    }
}

#クリップボードからテキストを取得
$clipText = Get-Clipboard -Format Text

# 取得したモノがTextかどうかチェック
$nullOrEmpty = [String]::IsNullOrEmpty($clipText)
if($nullOrEmpty){ #Text でない場合
    exit #終了
}

if($isDebug){
    Write-Host "Before:"
    Write-Host $clipText
}

# HttpUtilityクラス の有効化
Add-Type -AssemblyName System.Web

if ($isEncode) { # Encode 指定の場合
    $convertedText = [System.Web.HttpUtility]::UrlEncode($clipText)
}else { # Decode 指定の場合
    $convertedText = [System.Web.HttpUtility]::UrlDecode($clipText)
}

if($isDebug){
    Write-Host "After:"
    Write-Host $convertedText
}

#変換結果をクリップボードに保存
Set-Clipboard $convertedText

if($isDebug){
    Read-Host "Press Enter key to continue..."
}