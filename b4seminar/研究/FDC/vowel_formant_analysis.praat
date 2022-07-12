# ファイルを読み込む
do ("Read from file...", "/Users/katouryuusei/Downloads/analysis/FAOMFUN01.TextGrid")
selectObject ("TextGrid FAOMFUN01")
#出力ファイル名
output$ = "FAOMFUN01_vowel_formant.txt"
#Number of Formants
number_of_formants = 4


# 書きだすファイルを初期化
filedelete ("/Users/katouryuusei/Downloads/analysis/FAOMFUN01.TextGrid.txt")



# item[1]（word層）の intervals の総数（word要素の総数）を得る
number_of_intervals = Get number of intervals... 1

do ("Read from file...", "/Users/katouryuusei/Downloads/analysis/FAOMFUN01.wav")
# intervals（各要素）を順番に処理していく
for i from 1 to number_of_intervals
     selectObject ("TextGrid FAOMFUN01")
     # item[1] の intervals[i] の text を得る
     interval_label$ = Get label of interval... 1 'i'

     # item[1] の intervals[i] の xmin を得る
     begin_time = Get starting point... 1 'i'
     # item[1] の intervals[i] の xmax を得る
     end_time = Get end point... 1 'i'

#	母音の開始時間と終了時間を得る

	if index_regex(interval_label$, "a|i|u|e|o") 
		vowel_label$ = Get label of interval... 1 'i'
		vowel_begin_time = Get starting point... 1 'i'
		vowel_end_time = Get end point... 1 'i'
		selectObject ("Sound FAOMFUN01")
		start_time = vowel_begin_time
    	end_time = vowel_end_time
		center_time = (end_time - start_time) / 2
    	# フォルマント解析
    	do ("To Formant (burg)...", 0.01, 'number_of_formants', 5500, 0.02, 50)
    	# 時間的中心点の第一・第二フォルマントを得る
    	formant_one = Get value at time: 1, center_time, "Hertz", "Linear"
    	formant_two = Get value at time: 2, center_time, "Hertz", "Linear"
    	# 情報ウインドウに表示する
    	print 'vowel_label$','center_time','formant_one','formant_two''newline$'
    	# ファイルに出力する
    	fileappend 'output$' 'vowel_label$','center_time','formant_one','formant_two''newline$'
    
    #オブジェクトを削除する
	endif

endfor


selectObject ("TextGrid FAOMFUN01")
Remove
selectObject ("Sound FAOMFUN01")
Remove




selectObject ("TextGrid FAOMFUN01")
Remove