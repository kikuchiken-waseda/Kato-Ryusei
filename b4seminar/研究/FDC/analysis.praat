clearinfo
#フォルダのパス
directory$ = "/Users/katouryuusei/Downloads/analysis"
#出力ファイル名
output$ = "test.txt"
#Number of Formants
number_of_formants = 4
#フォルダ内の全ての.wav形式のファイル名を取得
Create Strings as file list:  "list", directory$ +"/*.wav"
number_files = Get number of strings
#各ファイルを順番に処理
for i from 1 to number_files
    #今回のファイルの名前を取得
    selectObject ("Strings list")
    current_token$ = Get string... 'i'
    #拡張子を除去したファイル名（オブジェクト名）を得る
    objname$ = current_token$ - ".wav"

    #.wavファイルを読み込む
    do ("Read from file...", "'directory$'/'current_token$'")
    
    # 開始時間・終了時間を得る
    start_time = Get start time
    end_time = Get end time
    # 時間的中心点の時間を得る
    center_time = (end_time - start_time) / 2
    
    # フォルマント解析
    do ("To Formant (burg)...", 0.01, 'number_of_formants', 5500, 0.02, 50)
    # 時間的中心点の第一・第二フォルマントを得る
    formant_one = Get value at time: 1, center_time, "Hertz", "Linear"
    formant_two = Get value at time: 2, center_time, "Hertz", "Linear"
    # 情報ウインドウに表示する
    print 'objname$','center_time','formant_one','formant_two''newline$'
    # ファイルに出力する
    fileappend 'output$' 'objname$','center_time','formant_one','formant_two''newline$'
    
    #オブジェクトを削除する
    Remove
    selectObject ("Sound 'objname$'")
    Remove
endfor
selectObject ("Strings list")
Remove
