# ファイルを読み込む
do ("Read from file...", "/Users/katouryuusei/Downloads/analysis/FAOMFUN01.TextGrid")
selectObject ("TextGrid FAOMFUN01")

# 書きだすファイルを初期化
filedelete ("/Users/katouryuusei/Downloads/analysis/FAOMFUN01.TextGrid.txt")

# item[1]（word層）の intervals の総数（word要素の総数）を得る
number_of_intervals = Get number of intervals... 1

# intervals（各要素）を順番に処理していく
for i from 1 to number_of_intervals
     selectObject ("TextGrid FAOMFUN01")
     # item[1] の intervals[i] の text を得る
     interval_label$ = Get label of interval... 1 'i'
     # item[1] の intervals[i] の xmin を得る
     begin_time = Get starting point... 1 'i'
     # item[1] の intervals[i] の xmax を得る
     end_time = Get end point... 1 'i'

     # ファイルに書き出す
     fileappend "/Users/katouryuusei/Downloads/analysis/FAOMFUN01.TextGrid.txt" 'interval_label$''tab$''begin_time:3''tab$''end_time:3''newline$'
endfor

selectObject ("TextGrid FAOMFUN01")
Remove