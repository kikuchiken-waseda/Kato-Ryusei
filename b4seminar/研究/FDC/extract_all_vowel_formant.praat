directory$ = "/Users/katouryuusei/Downloads/analysis"


# ファイルを読み込む


Create Strings as file list:  "list1", directory$ +"/*.TextGrid"
Create Strings as file list:  "list2", directory$ +"/*.wav"
number_files = Get number of strings

for i from 1 to number_files
	selectObject ("Strings list1")
    current_token1$ = Get string... 'i'
    objname1$ = current_token1$ - ".TextGrid"
	selectObject ("Strings list2")
    current_token2$ = Get string... 'i'
    objname2$ = current_token2$ - ".wav"
	#TextGridを読み込む
	do ("Read from file...", "'directory$'/'current_token1$'")
	number_of_intervals = Get number of intervals... 1
	for j from 1 to number_of_intervals
     	selectObject ("Strings list1")
     	# item[1] の intervals[i] の text を得る
     	interval_label$ = Get label of interval... 1 'j'

     	# item[1] の intervals[i] の xmin を得る
     	begin_time = Get starting point... 1 'j'
    	 # item[1] の intervals[i] の xmax を得る
     	end_time = Get end point... 1 'j'
	
#	母音の開始時間と終了時間を得る
		if index_regex(interval_label$, "a|i|u|e|o") 
			do ("Read from file...", "'directory$'/'current_token2$'")
			vowel_label$ = Get label of interval... 1 'j'
			vowel_begin_time = Get starting point... 1 'j'
			vowel_end_time = Get end point... 1 'j'
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
		endif   
	endfor
endfor


selectObject ("Strings list1")
Remove
selectObject ("Strings list2")
Remove